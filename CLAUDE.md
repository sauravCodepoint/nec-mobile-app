# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter mobile remittance app (Oman, country code `968`). Dart SDK `^3.11.5`. Multi-locale via `easy_localization`. Supported locales are declared in `lib/presentation/core/global/app_global.dart` (`AppGlobal.supportedLocales`): `en-US`, `ar-OM`, `ml-IN`, `hi-IN`, `fil-PH`, `ms-MY`. Translation files use the `<lang>-<COUNTRY>.json` naming under `assets/translations/` (e.g. `en-US.json`, `ar-OM.json`). Note: only `en-US` and `ar-OM` translation files currently exist even though six locales are declared — the rest fall back to `supportedLocales.first` (`en-US`).

## Commands

```bash
# Install deps
flutter pub get

# Run (REQUIRES env injection — see "Build-time config" below)
flutter run --dart-define-from-file=env/uat.json        # preferred: values from git-ignored env/<name>.json
flutter run --dart-define=APP_BASE_URL=https://your.api

# Code generation (Freezed, Injectable, Chopper, JSON, auto_route). Run after touching:
#   *_bloc.dart / *_event.dart / *_state.dart, *_dto.dart, *_failure.dart, api_services.dart, app_injectable.dart, app_routes.dart
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs   # iterative dev

# Lint / analyze
flutter analyze

# Test
flutter test
flutter test test/path/to/file_test.dart      # single file
flutter test --plain-name "test name"          # single test by name

# Launcher icons
dart run flutter_launcher_icons -f flutter_launcher_icons.yaml

# Native splash (regenerate after editing flutter_native_splash.yaml)
dart run flutter_native_splash:create
```

Launcher-icon config lives in a standalone `flutter_launcher_icons.yaml` at the repo root (not inline in `pubspec.yaml`): single source image `assets/images/png/icon_launcher.png`, Android adaptive icon over background `#000000`, `remove_alpha_ios: true`; web/windows/macOS generation disabled.

### Splash screen

Two stages. The **native splash** (`flutter_native_splash`, configured in the
standalone `flutter_native_splash.yaml` at the repo root, not inline in
`pubspec.yaml`) is flat `#000000` on BOTH system themes (`color` and
`color_dark` are both black — the app is dark-only, so a white native splash
on a light-mode device would flash white before the black Dart canvas) with
**no icon**: `background_image` is deliberately disabled and
Android 12+ is fed a fully transparent `assets/images/png/splash_transparent.png`
so its mandatory centre icon renders as nothing (omitting `image` there would
fall back to the launcher icon). `fullscreen` must stay `false` — `true` writes
`UIStatusBarHidden=true` into the iOS `Info.plist` and hides the status bar for
the whole app session. Rerun `dart run flutter_native_splash:create` after any
edit; it rewrites `android/app/src/main/res/**` (`launch_background.xml`,
`android12splash` drawables, `values-v31`/`values-night-v31` styles) and
`ios/Runner/Assets.xcassets/LaunchBackground.imageset` — never hand-edit those.

`main.dart` holds the native splash across async init with
`FlutterNativeSplash.preserve(widgetsBinding: binding)` and drops it in a
post-frame callback after `runApp`, so the hand-off to Dart has no white flash.

The **Dart splash** is `SplashPage` (`presentation/splash/splash_page.dart`): the
brand Lottie (`AppImages.splashLottie`) painted over `AppScaffold`'s gradient. Its
`AnimationController` takes its duration from the composition in `onLoaded`, and
all navigation is gated on that controller completing — the animation's own
length *is* the minimum display time, so nothing here uses `Future.delayed`.

### Build-time config (`--dart-define`)

Preferred injection: `--dart-define-from-file=env/<name>.json`. Environment files live under `env/` and are git-ignored (per-client URLs never enter history); `env/env.example.json` is the committed placeholder template — copy it to e.g. `env/uat.json` and fill in real values. Android Studio users: a local run configuration ("main.dart (UAT)") passing the flag lives in `.idea/runConfigurations/` (also git-ignored).

Read in `lib/domain/core/config/app_config.dart`:

- `APP_BASE_URL` — backend base URL; used by Chopper and the raw token-refresh call. Must be set or networking is broken.
- `SECURITY_GATE_ENABLED` (default `true`) — set `false` during dev/QA to bypass root/jailbreak/emulator checks that otherwise block the app at launch.

### Android release signing (`android/key.properties`)

`android/app/build.gradle.kts` loads the release keystore from `android/key.properties` (git-ignored, alongside `*.keystore`; never committed — an earlier committed `keystore.properties` that leaked passwords was removed). Keys: `storeFile`, `storePassword`, `keyAlias`, `keyPassword`. **If the file is absent, release falls back to the debug key** so a fresh checkout and `flutter run --release` still work — real release signing only kicks in once the file exists locally.

## Ported from gulf_overseas_mobile_app — deliberate deltas

This app is a port of the `gulf_overseas_mobile_app` codebase. Firebase is still
stubbed out; everything else is a straight copy.

### Firebase — not configured yet

No `google-services.json`, `GoogleService-Info.plist`, or `firebase_options.dart`
is present, and `firebase.json` carries only the Firestore rules. Everything
Firebase-backed (audit log, FCM, Crashlytics) is already guarded and degrades to a
no-op, so the app runs. Two build files were adjusted so a missing config can't
break the build:

- `android/app/build.gradle.kts` applies the `google-services` and
  `firebase-crashlytics` plugins **only when `app/google-services.json` exists**.
- The Crashlytics dSYM-upload shell build phase was removed from
  `ios/Runner.xcodeproj/project.pbxproj`.

Running `flutterfire configure` for this app's own Firebase project restores all
of it (it regenerates the iOS build phase and the `firebase.json` flutter block).

### Backend URLs are placeholders

Every `env/*.json` file ships with placeholder hosts
(`https://your.backend.example`), not real infrastructure — the previous
client's URLs were deliberately stripped during the rebrand. Point
`env/uat.json`, `env/qc.json`, and `env/prod.json` at the NEC Exchange backend
before doing anything real with this app. `AppGlobal.termsAndConditionsUrl` is a
placeholder too, so leaving it unset means the T&C document will not load.

## Architecture

Clean-architecture layout. **Every feature exists in four parallel directories with the same folder name**. When adding or modifying a feature, expect to touch all four:

```
lib/
├── domain/<feature>/         # abstract facades (i_<feature>_facade.dart), DTOs (Freezed + JSON), failure unions, value objects/validators
├── infrastructure/<feature>/ # <feature>_repository.dart — @LazySingleton(as: I…Facade), calls ApiServices, maps to Either<Failure, Dto>
├── application/<feature>/    # <feature>_bloc.dart + _event.dart + _state.dart (Freezed unions, flutter_bloc)
└── presentation/<feature>/   # screens + widgets/ subfolder, consumes BLoC via BlocProvider in app_widget.dart
```

Shared cross-cutting code lives under `*/core/` in each layer (e.g. `domain/core/services/api_services.dart`, `presentation/core/<widgets|theme|dialog|…>`). Cross-feature DTOs shared by multiple features (e.g. `CommonSendMoneyDto`, `CommonSelectableDto`, `CommonTransactionDto`, `CommonFeeItem`) live in `lib/domain/common/` rather than under any one feature.

### Feature modules

Most features follow the full four-layer structure above:

`app_update`, `beneficiary`, `branches`, `change_mpin`, `company_info`, `complete_profile`, `forgot_mpin`, `home`, `login`, `member_approval`, `mpin`, `notification`, `otp`, `profile`, `rate_calculator`, `security`, `set_mpin`, `settings`, `summary`, `support`, `transaction_history`, `update_kyc`

`rate_calculator` is the standalone currency calculator reached from the main bottom-nav center action (`MainPage`'s `onRateCalculatorTap`). It reuses the shared `AppSendMoneyCard` by mapping results into `CommonSendMoneyDto`. Unlike `home`/`summary`, it is **deliberately indicative**: `calculate-amount` needs full corridor context (transfer type / product / bank / payment mode) for an accurate rate, but the calculator sends only the currency pair + amount, so it carries no corridor and the backend may return a placeholder rate.

Application-only features (no domain facade): `bio_metric`, `on_boarding`, `splash`.

#### Summary — payment methods

**Pay at branch is the only supported payment method.** `summary` branches on the
selected payment method's `titleCode`:

- **`PB` (pay at branch)** — pick a branch, confirm, `createPayAtBranchTransaction`, then the result page.
- **anything else** — rejected with the `validation.summary.paymentMethodUnsupported` toast. The payment-method list is backend-driven (`paymentModes`), so an unsupported mode can still be selected; confirming it must fail loudly rather than silently doing nothing.

The former **`OAB` online-gateway flow was removed** — `createGatewayTransaction`
(facade, repository, BLoC event/handler, `SummaryFailure.unableToCreateGatewayTransaction`),
`SummaryState.summaryGatewayTransactionFailureOrSuccessOption` / `isRoundOffFromGateway`,
the `SummaryOabPaymentWebView` route and widget, `AppConfig.oabPaymentGatewayUrl`
/ the `OAB_PAYMENT_GATEWAY_URL` dart-define, and the `summary.oabWebView` +
`summary.errors.payment` translation sections are all gone. Don't reintroduce a
gateway/WebView payment path.

The 409 round-off dialog now belongs to pay-at-branch alone: an *accepted*
round-off resumes straight into the result page.

`member_approval` ("awaiting member approval" screen — polls approval status) and `support` are now full four-layer features (facade + DTOs + BLoC + repository), not presentation-only.

#### No in-app sign-up

There is deliberately **no KYC or Registration feature** — the `kyc` and `registration` features (all four layers, their routes, BLoCs, `domain/registration`, `IKycFacade`/`KycFailure`, the `/auth/insert-kyc` and `/auth/create-user` endpoints and the `registration.*` translation section) were removed, and new members are onboarded outside the app. When verify-OTP returns `userIsNotRegistered`, `OtpPage` only shows the informational dialog: Cancel unwinds to Login and the second button just pops the dialog — there is nowhere to send the user. Don't reintroduce either flow.

What survives on purpose: `update_kyc` (the profile-driven KYC renewal) and `complete_profile` both still exist, so the shared pieces they use stay — `lib/presentation/core/kyc/` (document card, ID camera, OCR confirm sheet, progress stepper, `KycVideoCard`, …), `domain/kyc/kyc_ocr_result.dart`, `domain/kyc/value_validators.dart` and the whole `kyc.*` translation section. `PendingRegistration` is down to its single `completeProfile` variant.

Presentation-only screens (no BLoC/facade — pure UI, driven by args or other features' BLoCs): `main` (`MainPage`, the post-auth choke point — see push-notification note).

`app_update` is the force/soft update gate: `IAppUpdateFacade.checkForUpdate` posts the platform + installed `packageInfo.version` to the backend, which returns a server-authored, localized title/message and whether the update is mandatory.

### Key conventions

- **Functional error handling**: repositories return `Future<Either<Failure, Success>>` (`dartz`). BLoCs `.fold` over the result and emit Freezed state with an `Option<Either<Failure, T>>` for one-shot UI reactions.
- **Freezed everywhere** for DTOs, BLoC events/states, failure unions. `*.freezed.dart` and `*.g.dart` are generated — never edit by hand; rerun `build_runner`.
- **DI**: `get_it` + `injectable`. Annotate with `@injectable` / `@lazySingleton` / `@LazySingleton(as: IFacade)`. Cross-cutting third-party deps (SharedPreferences, ApiServices, LocalAuthentication) are registered in `lib/infrastructure/core/app_injectable/app_injectable.dart` (`@module`). `configureInjection(Environment.prod)` runs in `main.dart`; the generated registrar is `lib/domain/core/di/injection.config.dart`.
- **Routing**: `auto_route`. Declare pages in `lib/presentation/routes/app_routes.dart`, then run codegen to update `app_routes.gr.dart`. Use the generated `*Route` constants for navigation; the `AppRouter` singleton (registered in `configureInjection`) holds `navigatorKey` which non-widget code (e.g. `AuthHttpClient`) uses to show dialogs and trigger logout.
- **Navigating from an async result**: any navigation fired by a BLoC listener (or after an `await`) must go through the guard in `lib/presentation/routes/app_navigation_guard.dart` — `context.pushIfActive` / `replaceIfActive` / `popAndPushIfActive`, or an early `if (!context.isScreenActive) return;` when the whole one-shot reaction belongs to the screen. A loading overlay only covers its own screen's body, never the app bar, drawer or bottom nav, so the user can switch tab or open another screen while a request is in flight; without the guard the response lands its destination on top of wherever they went. "Active" means the screen's page is top-most (dialogs, sheets and toasts are pageless, so they don't cover it) and, for a `MainPage` tab, that its tab is selected — tabs publish that through `AppScreenVisibility`, which `_NavPages` wraps around each one. Stack-resetting navigation (`replaceAll`) is deliberately unguarded: its destination is absolute. `AppRouter.push` additionally drops a push that would stack a second copy of the page already on top within 700 ms, which is what a double-tap produces.
- **Responsive UI**: `flutter_screenutil` with design size `375x812` (see `app_widget.dart`). Use `.w` / `.h` / `.sp` on dimensions and font sizes.
- **All BLoCs are provided once at the top of the tree** in `lib/presentation/core/app_widget.dart` via `MultiBlocProvider`. New BLoCs must be added there.

### Networking — `lib/domain/core/services/api_services.dart`

All endpoints are declared in one `ApiServices` Chopper class (`api_services.chopper.dart` is generated). Custom `AuthHttpClient` wraps the HTTP client and handles:

- **Auth injection**: prepends `Bearer <token>` from `SharedPrefs` unless the endpoint sets the `x-skip-auth` sentinel header via Chopper `headers: {'x-skip-auth': 'true'}`. The sentinel is stripped before the wire.
- **401 → single refresh attempt**: serialized via `_ongoingRefresh` so concurrent 401s share one refresh call. On failure, navigates to `MpinRoute` (logout). Refresh endpoint is `POST /api/Auth/refresh-token` (hand-rolled, bypasses Chopper).
- **Retry dialog**: network/timeout/5xx (when body isn't valid JSON — JSON 5xx is treated as a backend-authored business error and passed through to the repo) opens a single shared retry dialog via `AppRouter.navigatorKey`; all pending requests await the user's decision and retry together. Only `GET/HEAD/OPTIONS` are retried on 5xx (POST/PUT/DELETE could double-execute).
- **Binary endpoints** (PDF, octet-stream): annotate with `@FactoryConverter(response: _binaryConverter)` and return `Response<List<int>>`. The buffering path skips JSON decoding.
- **Logging**: `HttpLogger` is `kDebugMode`-only. Sanitizes `Authorization` headers. Don't disable.
- **Cloud audit trail**: `IAuditLogFacade` (`domain/core/audit/`, implemented by `infrastructure/core/audit/audit_log_repository.dart`) persists the exact wire payload + SHA-256 hash, response, and exceptions of business-critical endpoints (allowlist constant in the repository: `pay-quick-transaction`, `calculate-amount`) to the `api_audit_logs` Firestore collection, per user (`member_code`), with `expire_at` set +28 days for the TTL policy. Audited requests carry an `X-Client-Request-Id` correlation header shared across retries. Hooks live at the `HttpLogger` call sites (all build modes, before the `kDebugMode` check); `AuthHttpClient.send` injects the header. Fire-and-forget — audit failures are swallowed and must never affect the observed call. Never audit endpoints carrying secrets (MPIN, OTP, tokens). No-op until Firebase is configured.

### Security gate — `lib/presentation/security/security_gate.dart`

Wraps the entire app inside `ScreenUtilInit`. On startup and lifecycle resume, `SecurityService` checks the `SecurityThreat` enum (`jailbreakOrRoot`, `developerMode`, `usbDebugging`, `emulator`); if any are present (and `AppConfig.securityGateEnabled` is true) the app shows `SecurityBlockedScreen` instead of the router. Disable via `--dart-define=SECURITY_GATE_ENABLED=false` for local dev on rooted/emulator devices. **No mock-location check** — it was removed with the location permissions (see below).

### App must stay location-free (Google Play Data safety)

The app reads no location. `safe_device` and `image_cropper`/uCrop transitively merge `ACCESS_FINE/COARSE_LOCATION` and `READ_MEDIA_IMAGES/VIDEO` into the manifest; all four are stripped in `android/app/src/main/AndroidManifest.xml` via `tools:node="remove"` so Play doesn't require a location/media Data-safety declaration. The mock-location threat was dropped accordingly. Don't reintroduce location access or these permissions.

### Storage

- `SharedPrefs` (wrapper around `shared_preferences`) for non-sensitive state (locale, flags).
- Tokens stored via `SharedPrefs.setToken` / `setRefreshToken` — referenced directly by `AuthHttpClient`. (`flutter_secure_storage` was removed 2026-07 — the only Keychain use is the native `DeviceIdentityChannel` bridge below.)

### iOS dependencies — Swift Package Manager only

The iOS build has **no CocoaPods integration**. There is no `Podfile`,
`Podfile.lock`, `Pods/`, or `.symlinks/` under `ios/`; every plugin, and the
Flutter framework itself, is resolved by Swift Package Manager through the
`FlutterGeneratedPluginSwiftPackage` local package that the flutter tool
regenerates into `ios/Flutter/ephemeral/Packages/` on each build. `Runner.xcodeproj`
carries the package as an `XCLocalSwiftPackageReference` plus an
`XCSwiftPackageProductDependency` on the Runner target, `ios/Flutter/Debug.xcconfig`
and `Release.xcconfig` include only `Generated.xcconfig`, `Runner.xcworkspace`
references only `Runner.xcodeproj`, and the `RunnerTests` build configurations have
no `baseConfigurationReference` — this matches a stock SPM-only Flutter template.
Never run `pod init`/`pod install` here and never reintroduce the `#include?` of
`Pods-Runner.*.xcconfig`; adding a plugin that ships only a podspec would drag
CocoaPods back in, so prefer an SPM-compatible plugin or a native channel
(see below).

### Native bridges — `lib/domain/core/native/`

`MethodChannel` wrappers over platform-native code (implemented in the Android/iOS host projects). Cross-cutting helpers like these live under `domain/core` (alongside `api_services.dart`, `AppConfig`, `AppPushNotification`), never under `infrastructure`. All bridge wrappers (including `DeviceIdentityService` below) are static, swallow platform errors, and degrade gracefully (return `false` / `null`) so a missing native impl never crashes Dart:

- `FaceDetectionService` (`general.face_detection`) — `detectFaceInBytes` runs on-device face detection over a raw `CameraImage` plane (`bgra8888` iOS / `nv21` Android). KYC / liveness flow.
- `VideoFrameService` (`general.video_frame`) — `extractFrame` pulls a scaled JPEG still from a recorded video at a given timestamp. KYC / liveness flow.
- `VideoCompressService` (`general.video_compress`) — `compress` transcodes a recorded clip to an H.264/AAC MP4 capped at 720 p, via `AVAssetExportSession` (iOS) and `androidx.media3` `Transformer` (Android, `media3-transformer`/`-effect`/`-common` in `android/app/build.gradle.kts`). Sole consumer is `MediaCompressor.compressVideo` (`domain/core/compressor/`), which falls back to the original file whenever the bridge returns null or the transcode comes out larger. Replaced the `video_compress` plugin, which never adopted Swift Package Manager and was the **last CocoaPods pod in the iOS build** — CocoaPods has since been fully deintegrated (see "iOS dependencies" below). Android caps the encoder bitrate explicitly, which is also what forces Transformer to re-encode rather than transmux; iOS takes its bitrate from the export preset. New native channels must also be added to `ios/Runner.xcodeproj/project.pbxproj` (PBXBuildFile + PBXFileReference + the Runner group + Sources phase) or the Swift file silently isn't compiled.
- `DeviceIdentityService` (`general.device_identity`) — `getOrCreateDeviceId` returns the iOS Keychain-persisted device id (seeded from `identifierForVendor` on first read, write-once, `ThisDeviceOnly`/non-syncing) so `AppDeviceHelper`'s `device_id`/`finger_print` survive uninstall/reinstall for device blocking. iOS-only (`DeviceIdentityChannel.swift`); Android relies on SSAID and returns null here. Sole consumer: `AppDeviceHelper` (`domain/core/device_helper/`).

### Firebase / push notifications

Firebase config is **git-ignored per client** — all four `flutterfire configure` outputs (`lib/firebase_options.dart`, `google-services.json`, `GoogleService-Info.plist`, and the Dart options file's import in `main.dart`) are ignored, so never reuse another client's config. `main.dart` imports `firebase_options.dart` and calls `Firebase.initializeApp()` in a try/catch: without local config files it fails silently and everything Firebase-backed (the API audit log, push notifications, Crashlytics) becomes a no-op, so the app runs fine from a fresh checkout. To activate: run `flutterfire configure` for this client's own Firebase project (generates `firebase_options.dart` + native config files locally).

Crash reporting is `lib/domain/core/crash_reporting/app_crash_reporting.dart` (`AppCrashReporting.init()`, called in `main.dart` right after `Firebase.initializeApp`). No-op when `Firebase.apps.isEmpty`; handlers (`FlutterError.onError`, `PlatformDispatcher.instance.onError`) install **only in non-debug builds** so local dev keeps the red error screen and console output. Every step is guarded so crash reporting can never break startup.

Push notifications live in `lib/domain/core/push_notification/app_push_notification.dart` (`AppPushNotification.init()` is called in `main.dart`; local notifications always initialize, FCM only when Firebase is configured). **Notification permission is asked at application start** via the soft-prompt in `presentation/core/notification_permission/notification_permission_primer.dart`: `SplashPage`'s `navigate()` fires `runAtAppStart` right after splash hands off to the first screen — the single entry point, covering every cold-start destination, once per session, with approval-specific wording when the destination is `MemberApprovalRoute`. The OS prompt itself stays protected: branded dialog first, system prompt only on agreement, Settings deep-link once permanently denied. The one-time welcome notification is decoupled: `MainPage` calls `AppPushNotification.showWelcomeNotification()` directly, and it self-guards on permission + a persistent shown-flag. Device-token registration (`AppPushNotification.syncDeviceToken`, fire-and-forget, self-deduping) posts member-bound to `POST /notification/update-device-token` only when logged in and unlocked (MainPage mount, app resume, token rotation, language change). Deliberately NO anonymous/at-app-start device registration (the pre-login "account approved" push used to ride on the registration submit payload, which went with the registration feature). Backend implementation of the endpoint is pending — calls fail silently until it ships. No persistent snooze — re-offered on every cold start until granted (`_shownThisSession` only de-dupes within one process). iOS permission macros no longer come from a Podfile `GCC_PREPROCESSOR_DEFINITIONS` block — `permission_handler_apple` resolves through Swift Package Manager and derives them in `Package.swift` from the app's `Info.plist` usage descriptions (builds started from Xcode.app can't auto-detect the plist and need `PERMISSION_HANDLER_INFO_PLIST`); recovering from an OS-level denial requires deleting/reinstalling the app (iOS won't re-prompt). Foreground FCM messages are re-presented via `flutter_local_notifications` on the `high_importance_channel` channel (mirrored in `AndroidManifest.xml` meta-data so background notifications use it too). Notification taps navigate to `NotificationRoute` **only when `MainRoute` is in the stack** — never deep-link past the MPIN/auth flow. Cold-start taps deliberately don't deep-link. Background handlers must stay top-level with `@pragma('vm:entry-point')`.

## Theme & color tokens

**One theme, dark only.** `appDarkTheme` in `lib/presentation/core/theme/app_theme.dart` is the app's single `ThemeData`, and `app_widget.dart` pins `MaterialApp.router` to it (`theme` and `darkTheme` both `appDarkTheme`, `themeMode: ThemeMode.dark`), so the app never follows the device setting. The brand is **black + yellow**: a black/charcoal canvas with `brandYellow` #FFD503 accents and near-black ink on solid yellow fills, exactly as the logo draws its own wordmark.

There is no light theme and no theme picker — the former `ThemeBloc` (`application/theme/`), `AppThemeDialog`, `ThemeSwitchAnimator`, the Settings → App Theme tile, `SharedPrefs.get/setThemeMode` and the light `AppColors`/`AppSemanticColors`/`AppGradient` values were all removed. **Do not reintroduce `Theme.of(context).brightness` branching** (`isLight`/`isDark`) in widgets: every widget may assume a dark surface. iOS additionally forces `UIUserInterfaceStyle = Dark` in `ios/Runner/Info.plist` so the keyboard, share sheets, alerts and the in-app web view match.

Never hard-code surface/fill hexes in widgets — always go through the tokens below. Key semantic mappings:

| Token | Semantic use |
|---|---|
| `colorScheme.onPrimary` | Primary text |
| `colorScheme.secondary` | **Same as scaffold bg — do NOT use for card fills** |
| `colorScheme.secondaryContainer` | Elevated cards / form containers (brandSurface #242424) |
| `colorScheme.tertiary` | Accent **text** (amounts, labels, links), focused borders, progress, small indicators, and the icon/label *inside* a pale `brandFill` tint (brandYellow #FFD503) |
| `context.appColors.brandFill` | Solid brand fill for FILLED buttons/CTAs, avatars, the nav centre disc, selected tiles — anything large enough to carry ink (brandYellow #FFD503). Also the source of every pale accent TINT (`brandFill.withValues(alpha: …)`). Pair solid fills with `onBrandFill` / `colorScheme.primary` ink |
| `context.appColors.onBrandFill` | Dark ink drawn ON `brandFill` |
| `colorScheme.outline` | Default thin borders |
| `context.appColors.muted` | Secondary / hint / placeholder text |
| `context.appColors.glass` | White ink behind translucent "glass" card fills / hairline borders / dividers. Use for every low-alpha (≤0.30) decoration tint; **never for text** — text stays `onSurface` |
| `context.appColors.shadowInk` | Base ink for `BoxShadow` colors — apply your own alpha at the call site (pure black). Never hard-code `Colors.black` in a BoxShadow |
| `context.appColors.containerBackground` | Dialogs / sheets / overlay backgrounds (brandDeep #0D0D0D) |
| `context.appGradient?.background` | Full-screen brand gradient (used by AppScaffold) |

`context.glassPanel(...)` (`theme/app_theme_ext.dart`) builds the standard elevated-card decoration from these: a low-alpha white gradient fill, a hairline border and a soft shadow.

Semantic status colors (`success`, `error`, `warning`, `info`, and their `*Subtle` variants) live on `context.appColors` (`AppSemanticColors` theme extension).

`AppScaffold`'s backdrop is the brand gradient plus two brand-yellow focal glows and `_SignalWavePainter` — concentric arcs radiating from just outside the top-left corner with a few node dots riding them. Its alphas are tuned for yellow on near-black.

## Shared presentation components

All live under `lib/presentation/core/`.

| Component | Path | Notes |
|---|---|---|
| `AppScaffold` | `scaffold/app_scaffold.dart` | Brand gradient bg, loading overlay with blur/animation, keyboard dismiss. Use instead of raw `Scaffold`. |
| `AppAppBar` | `app_bar/app_app_bar.dart` | Transparent bg, animated border, custom leading/actions. |
| `AppTextFormField` | `text_form_field/app_text_form_field.dart` | Hook-based, animated focus shadow, themed error row, disabled-state opacity. |
| `AppButton` | `button/app_button.dart` | Primary CTA; supports loading state, optional acknowledgement checkbox, side widget. |
| `AppSlideButton` | `button/app_slide_button.dart` | Swipe-to-confirm gesture button. |
| `AppNotify` | `notify/app_notify.dart` | Context-free API for toasts and confirmation dialogs (uses `AppRouter.navigatorKey`). |
| `AppDialog` | `dialog/app_dialog.dart` | 4 semantic types (warning/info/success/error), single or dual buttons. |
| `AppShowcase` / `useShowcaseTour` | `showcase/app_showcase.dart`, `showcase/app_showcase_tour.dart` | Branded one-time guided coach-mark tour (built on `showcaseview`). See note below. |

### Guided tours (coach marks)

Wrap each target widget with `AppShowcase(showcaseKey: key, title, description, icon, child)` and pass the same `GlobalKey`s **in visit order** to `useShowcaseTour(tourId, steps, ready)`. The tour runs once per device (gated by `tourId` via `SharedPrefs.hasSeenShowcase`/`setShowcaseSeen`) and starts only after `ready` is true (drive it from your "content loaded" flags so it never spotlights a shimmer/unmounted widget). **Conditionally-rendered targets must be gated in both places** — include the key in `steps` only when the target is actually visible (e.g. `if (hasBankOrAgentChoice) bankOrAgentShowcaseKey`), so the `n / m` progress count stays correct. `home_page.dart` is the reference implementation.

### Input formatters (`core/input_formatter/`)

- `WesternDigitsInputFormatter` — converts Arabic/Indian numerals to Western `0–9`; use on all numeric fields.
- `MaskedDigitController` — `TextEditingController` with mask-aware `rawValue`; use for ID/phone fields with fixed lengths. Pass `maskLength: 0` for variable-length IDs; call `resetMask(n)` when the type changes.
- `AppUpperCaseTextFormatter`, `DateInputFormatter`, `AppMaskedInputFormatter`.

### Translation keys

Keys follow `<feature>.<element>.<variant>`, e.g. `'forgotMpin.idType.label'.tr()`. Shared keys live under `buttons.*`, `errors.*`, `core.*`. Add new keys to **every** translation file under `assets/translations/` (currently `en-US.json` and `ar-OM.json`), keeping the nested key order consistent across files.

### Domain failure types

`lib/domain/core/failures.dart` — Freezed union used for form-field validation. Variants: `InvalidIdentityNumber`, `InvalidMobileNumber`, `InvalidOtp`, `InvalidEmailAddress`, `Empty`, `TooShort(minLength)`, `TooLong(maxLength)`, `InvalidFormat(regexPattern)`, `InvalidMpin`, `SameAsCurrentMpin`, `RepeatedDigits`, `SequentialDigits`, `InvalidDate`, `ExpiredDocument`, `FutureDate`, `Underage(minAge)`. Each feature's own network-failure union lives in `domain/<feature>/<feature>_failure.dart`.

## Linting

`analysis_options.yaml` includes `package:flutter_lints/flutter.yaml` with no custom rules.

## Notes for adding a feature

1. Create `domain/<feature>/` — facade interface, DTOs, failure union, validators.
2. Create `infrastructure/<feature>/<feature>_repository.dart` implementing the facade, annotated `@LazySingleton(as: IFacade)`.
3. If you need new endpoints, add them to `ApiServices` and rerun build_runner.
4. Create `application/<feature>/` — BLoC + Freezed event/state.
5. Create `presentation/<feature>/` — screen(s) and `widgets/`.
6. Register the route in `presentation/routes/app_routes.dart`.
7. Register the BLoC in `presentation/core/app_widget.dart`'s `MultiBlocProvider`.
8. Rerun `build_runner build --delete-conflicting-outputs`.