# Device Token (FCM) — API Contract

Mobile app → Backend contract for push-notification device tokens.
Proposed by the app team on 2026-07-29. The app side is fully implemented and live on
`features/await-flow-member-approval`; both server behaviours below are **pending backend
implementation**. Until they ship, the app's calls fail silently and retry — the backend can be
deployed independently at any time.

---

## 1. Register / update a logged-in device

### `POST /api/notification/update-device-token`

New endpoint. Binds the calling member to this device's FCM token so the backend can push
transaction/account notifications to the phone.

**Auth:** `Authorization: Bearer <access token>` — required. Standard 401 semantics (the app
runs its usual refresh-token flow on 401).

**Request body:**

```json
{
  "app_member_code": 12345,
  "device_token": "fWk3…:APA91b…",
  "platform": "android",
  "lang": "en",
  "device_details": {
    "device_id": "9f1c2a7d3b8e4f50",
    "model": "Samsung SM-G991B",
    "o_s_version": "Android 14",
    "finger_print": "a3c9…64-hex-chars…f1"
  }
}
```

| Field | Type | Notes |
|---|---|---|
| `app_member_code` | int | The logged-in member (same value the app sends elsewhere). |
| `device_token` | string | FCM registration token — the push address. Opaque; can be long (150+ chars). |
| `platform` | string | `"android"` or `"ios"`. |
| `lang` | string | App UI language: `en`, `ar`, `ml`, `hi`, `fil`, `ms`. **Use it to localize push title/body.** Re-sent whenever the user changes language in the app. |
| `device_details` | object | Identical block the login/OTP/MPIN calls already send. `device_id` is the stable per-device identity. |

**Required server semantics:**

- **Idempotent upsert keyed on `device_details.device_id`** — one row per physical device.
  The same payload may arrive repeatedly (the app re-sends once per cold start and retries
  failures); this must be harmless.
- **Re-binding: last login wins.** If a device row already belongs to another member,
  overwrite the binding. One member may own several device rows (several phones).
- **Response:** any 2xx = success (body ignored by the app). Non-2xx is swallowed app-side
  and retried on the next trigger.

**When the app calls it** (fire-and-forget, self-deduplicating, never shown to the user):

1. After every login, when the user lands on the main screen.
2. When the app returns to the foreground (retry of a previously failed attempt).
3. When FCM rotates the token.
4. Immediately after an in-app language change (fresh `lang`).

---

## 2. Approval push for a pending registration

### `POST /api/auth/create-user` — two new optional top-level fields

A user awaiting back-office approval has never logged in, so endpoint #1 never runs for them.
Instead, the registration submit now carries the push address directly:

```json
{
  "...existing registration fields...": "unchanged",
  "device_details": { "...unchanged..." },

  "device_token": "fWk3…:APA91b…",
  "lang": "en"
}
```

**Required server semantics:**

- Store `device_token` + `lang` with the pending registration.
- When the back office **approves** the member: send the "account approved" push to that
  token, localized per `lang`.
- **Best-effort:** both fields are absent when the device has no Firebase config or no token
  yet. If absent, skip the push (or fall back to SMS).
- Known accepted limitation: if FCM rotates the token while the user waits, the stored token
  goes stale and the push is lost; it self-corrects at the user's first login (endpoint #1).

---

## 3. Sending pushes — notes for the backend

- Send standard FCM **notification** messages (title + body). The app displays them via the
  OS in background/terminated state and re-presents them itself in foreground; Android
  channel setup is already handled app-side (`high_importance_channel`).
- **Always include the iOS sound and the Android channel** — in background/terminated state
  the OS renders the payload as-is, and iOS stays silent unless the payload asks for sound:

  ```json
  {
    "message": {
      "token": "<device_token>",
      "notification": { "title": "…", "body": "…" },
      "apns":    { "payload": { "aps": { "sound": "default" } } },
      "android": { "notification": { "channel_id": "high_importance_channel" } }
    }
  }
  ```
- Localize `title`/`body` using the stored `lang`.
- **Token hygiene:** when FCM returns `NotRegistered` / `InvalidRegistration` for a token,
  delete that row — the app was uninstalled or the token rotated.
- A tap on a notification never deep-links past the app's MPIN/auth flow; no special payload
  is needed. (Data-only payloads are currently ignored by the app.)

## 4. Explicitly out of scope (product decisions)

- **No unregister on logout** — the binding stays until the next login overwrites it.
- **No anonymous/pre-login device registration** — only registrants (via #2) and logged-in
  users (via #1) are reachable. Devices that merely installed the app are not.
