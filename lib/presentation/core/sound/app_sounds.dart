import 'package:audioplayers/audioplayers.dart';

/// Context-free one-shot sound effects for terminal transaction results.
///
/// Assets live under `assets/music/` (registered in `pubspec.yaml`). Playback
/// is fire-and-forget and best-effort: audio is never critical, so any failure
/// (missing route to speaker, silent mode, decode error) is swallowed and must
/// never surface to the user or block the result screen.
class AppSounds {
  AppSounds._();

  // AssetSource resolves relative to the `assets/` prefix, so these paths map
  // to `assets/music/<file>`.
  static const _successAsset = 'music/success_chime.mp3';
  static const _failureAsset = 'music/failure_tone.mp3';

  // Single shared player reused across result screens. `ReleaseMode.stop`
  // frees native resources when a clip finishes but keeps the player alive.
  static final AudioPlayer _player = AudioPlayer(playerId: 'app_result_sfx')
    ..setReleaseMode(ReleaseMode.stop);

  /// Plays the success chime — call when a transaction completes successfully.
  static Future<void> success() => _play(_successAsset);

  /// Plays the failure tone — call when a transaction fails.
  static Future<void> failure() => _play(_failureAsset);

  static Future<void> _play(String asset) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(asset));
    } catch (_) {
      // SFX are non-critical — swallow so audio never affects the UI.
    }
  }
}