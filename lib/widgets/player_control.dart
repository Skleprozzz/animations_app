import 'package:flutter/material.dart';
import 'package:flutter_animations/entity/position_data.dart';
import 'package:flutter_animations/widgets/animated_play_button.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PlayerControl extends StatefulWidget {
  const PlayerControl({Key? key, required this.audioPlayer}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  State<PlayerControl> createState() => _PlayerControlState();
}

class _PlayerControlState extends State<PlayerControl> {
  bool isPlaying = false;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest2<Duration, PlayerState, PositionData>(
          widget.audioPlayer.positionStream,
          widget.audioPlayer.playerStateStream,
          (position, playerState) => PositionData(position, playerState));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
        stream: _positionDataStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data?.playerState;
          ProcessingState? processingState = playerState?.processingState;

          return SizedBox(
              height: 106,
              width: 106,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlaying = (playerState?.playing == false);
                      isPlaying
                          ? widget.audioPlayer.play()
                          : widget.audioPlayer.pause();
                    });
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          backgroundColor:
                              const Color.fromARGB(255, 24, 24, 24),
                          value: ((snapshot.data?.position.inSeconds ??
                                  0.0001) /
                              (widget.audioPlayer.duration?.inSeconds ?? 1)),
                          strokeWidth: 5,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      Positioned(
                        child: Center(
                            child: (processingState !=
                                    ProcessingState.completed)
                                ? AnimatedPlayButton(isPlaying: isPlaying)
                                : const AnimatedPlayButton(isPlaying: false)),
                      ),
                    ],
                  )));
        });
  }
}
