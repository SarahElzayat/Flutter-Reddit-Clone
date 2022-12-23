/// Flick Multi Manager is a class that manages multiple FlickManagers.
/// date: 16/12/2022
/// @Author: Ahmed Atta

import 'package:flick_video_player/flick_video_player.dart';

/// FlickMultiManager
///
/// this class is used to manage multiple FlickManagers
/// it can be used to play/pause multiple videos from different places
/// it can be used to mute/unmute multiple videos from different places
/// it can be used to dispose multiple videos from different places
class FlickMultiManager {
  /// list of all the controlled [FlickManager]s
  final List<FlickManager> _flickManagers = [];

  /// the active [FlickManager]
  FlickManager? _activeManager;

  /// is the active [FlickManager] muted
  bool _isMute = true;

  /// initialize the passed [FlickManager]
  /// if it is the first [FlickManager] to be initialized
  /// it will be played automatically
  init(FlickManager flickManager) {
    _flickManagers.add(flickManager);
    if (_isMute) {
      flickManager.flickControlManager?.mute();
    } else {
      flickManager.flickControlManager?.unmute();
    }
    if (_flickManagers.length == 1) {
      play(flickManager);
    }
  }

  /// dispose the passed [FlickManager]
  remove(FlickManager flickManager) {
    if (_activeManager == flickManager) {
      _activeManager = null;
    }
    flickManager.dispose();
    _flickManagers.remove(flickManager);
  }

  /// toggle play/pause for the passed [FlickManager]
  togglePlay(FlickManager flickManager) {
    if (_activeManager?.flickVideoManager?.isPlaying == true &&
        flickManager == _activeManager) {
      pause();
    } else {
      play(flickManager);
    }
  }

  /// pause the active [FlickManager]
  pause() {
    _activeManager?.flickControlManager?.pause();
  }

  /// play the passed [FlickManager]
  play([FlickManager? flickManager]) {
    if (flickManager != null) {
      _activeManager?.flickControlManager?.pause();
      _activeManager = flickManager;
    }

    if (_isMute) {
      _activeManager?.flickControlManager?.mute();
    } else {
      _activeManager?.flickControlManager?.unmute();
    }

    _activeManager?.flickControlManager?.play();
  }

  /// toggle mute/unmute for all [FlickManager]
  toggleMute() {
    _activeManager?.flickControlManager?.toggleMute();
    _isMute = _activeManager?.flickControlManager?.isMute ?? false;
    if (_isMute) {
      for (var manager in _flickManagers) {
        manager.flickControlManager?.mute();
      }
    } else {
      for (var manager in _flickManagers) {
        manager.flickControlManager?.unmute();
      }
    }
  }
}
