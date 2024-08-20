import 'package:audio_player/models/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: "So Sick",
      artistName: "Neyo",
      albumArtImagePath: "assets/images/albumcover2.jpg",
      audioPath: "audio/eminem.mp3",
    ),
    Song(
      songName: "Acid Rap",
      artistName: "Chance the Rapper",
      albumArtImagePath: "assets/images/albumcover2.jpg",
      audioPath: "audio/eminem.mp3",
    ),
    Song(
      songName: "Phoenix",
      artistName: "ASAP Rocky",
      albumArtImagePath: "assets/images/albumcover2.jpg",
      audioPath: "audio/eminem.mp3",
    ),
  ];

  int? _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        _currentSongIndex = 0;
      }
    }
    notifyListeners();
  }

  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        _currentSongIndex = _playlist.length - 1;
      }
    }
    notifyListeners();
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen(
      (newDuration) {
        _totalDuration = newDuration;
        notifyListeners();
      },
    );
    _audioPlayer.onPositionChanged.listen(
      (newPosition) {
        _currentDuration = newPosition;
        notifyListeners();
      },
    );
    _audioPlayer.onPlayerComplete.listen(
      (event) {
        playNextSong();
      },
    );
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex!;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isPlaying => _isPlaying;

  set setCurrentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (_currentSongIndex != null) {
      play();
    }
    notifyListeners();
  }
}
