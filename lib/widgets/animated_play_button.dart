import 'package:flutter/material.dart';

class AnimatedPlayButton extends StatefulWidget {
  const AnimatedPlayButton({Key? key, required this.isPlaying})
      : super(key: key);

  final bool isPlaying;

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        width: widget.isPlaying ? 40 : 100,
        height: widget.isPlaying ? 40 : 100,
        foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(0.6, 1),
              colors: widget.isPlaying
                  ? const [
                      Color.fromARGB(255, 99, 99, 99),
                      Color.fromARGB(255, 57, 57, 57)
                    ]
                  : const [
                      Color.fromARGB(255, 79, 26, 255),
                      Color.fromARGB(255, 227, 13, 255)
                    ],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.circular(widget.isPlaying ? 8 : 50)),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}
