import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/animated_play_button.dart';
import 'package:just_audio/just_audio.dart';

class PlayerControl extends StatefulWidget {
  PlayerControl({Key? key, required this.audioPlayer}) : super(key: key);

  final AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  State<PlayerControl> createState() => _PlayerControlState();
}

class _PlayerControlState extends State<PlayerControl> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: widget.audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          ProcessingState? processingState = playerState?.processingState;

          return SizedBox(
              height: 106,
              width: 106,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isPlaying = (playerState?.playing == false);
                      widget.isPlaying
                        ? widget.audioPlayer.play()
                        : widget.audioPlayer.pause();
                    });
                  },
                  child: Center(
                      child: (processingState != ProcessingState.completed)
                          ? AnimatedPlayButton(isPlaying: widget.isPlaying)
                          : const AnimatedPlayButton(isPlaying: false)
                  )
              )
          );
        });
  }
}
