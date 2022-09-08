import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String? audioPath;
  final VoidCallback? onTappedDelete;
  const AudioPlayerWidget({Key? key, this.onTappedDelete, this.audioPath})
      : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _isPlaying = false;
  AudioPlayer? _audioPlayer;
  Duration? _duration;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer?.getDuration().then((value) => _duration = value);
  }

  playAudioFromLocalStorage(path) async {
    try {
      await _audioPlayer?.play(AssetSource(path));
    } catch (er) {
      debugPrint("Playing error: $er");
    }
  }

  pauseAudio() async {
    try {
      await _audioPlayer?.pause();
    } catch (er) {
      debugPrint("Pausing error: $er");
    }
  }

  stopAudio() async {
    try {
      await _audioPlayer?.stop();
    } catch (er) {
      debugPrint("Stopping error: $er");
    }
  }

  resumeAudio() async {
    try {
      await _audioPlayer?.resume();
    } catch (er) {
      debugPrint("Resuming error: $er");
    }
  }

  _showDuration() {
    int mins = _duration!.inSeconds ~/ 60;
    int secs = _duration!.inSeconds % 60;
    return '${mins > 10 ? mins : '0$mins'}:${secs > 10 ? secs : '0$secs'}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.lightOrange,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(width: 1, color: MyColors.orange)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                if (_isPlaying == true) {
                  stopAudio();
                  setState(() {
                    _isPlaying = false;
                  });
                } else {
                  if (widget.audioPath != '') {
                    playAudioFromLocalStorage(widget.audioPath);
                    setState(() {
                      _isPlaying = true;
                    });
                  }
                }
              },
              padding: EdgeInsets.zero,
              splashRadius: 15,
              icon: Icon(
                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 25,
                color: Colors.black,
              )),
          Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Row(
                children: [
                  Text(
                    _duration != null ? _showDuration() : '00:00',
                    style: Get.theme.textTheme.bodyText2,
                  ),
                  IconButton(
                      onPressed: widget.onTappedDelete,
                      padding: EdgeInsets.zero,
                      splashRadius: 15,
                      icon: const Icon(
                        IconlyFont.delete,
                        size: 20,
                        color: Colors.black,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
