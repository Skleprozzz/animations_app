import 'package:flutter/material.dart';
import 'package:flutter_animations/player_screen.dart';
import 'package:flutter_circular_text/circular_text.dart';

class RoundedTextView extends StatefulWidget {
  const RoundedTextView({super.key});

  @override
  _RoundedTextViewState createState() => _RoundedTextViewState();
}

class _RoundedTextViewState extends State<RoundedTextView>  with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _textAnimationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(seconds: 20), 
        vsync: this
    )..repeat();

    _textAnimationController = AnimationController(
        duration: const Duration(seconds: 3), 
        vsync: this
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bounceOutTextAnimation = Tween<Offset>(
        begin: const Offset(0, 10), 
        end: Offset.zero
      ).animate(
          CurvedAnimation(
            parent: _textAnimationController,
            curve: const Interval(0.0, 1.0, curve: Curves.bounceOut),
          ),
    );

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PlayerScreen())
              );
            },
            child: Center(
                child: Stack(children: [
              Center(
                  child: SlideTransition(
                position: bounceOutTextAnimation,
                child: const Text('v90 Nilsson',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 172, 172, 172))),
              )),
              Center(
                  child: AnimatedBuilder(
                      animation: _animationController,
                      builder: ((context, child) => AnimatedBuilder(
                          animation: _animationController,
                          builder: ((context, child) => Transform.rotate(
                              angle: _animationController.value * -6,
                              child: CircularText(
                                  radius: 150,
                                  backgroundPaint: Paint()
                                    ..color = const Color.fromARGB(255, 0, 0, 0)
                                    ..strokeWidth = 20
                                    ..style = PaintingStyle.stroke,
                                  children: [
                                    TextItem(
                                        text: const Text(
                                            'Я хотел бы гонять на супре, но мне светит иной расклад'),
                                        space: 4,
                                        startAngle: 90)
                                  ])
                          ))
                      ))
                 )),
              Center(
                  child: AnimatedBuilder(
                      animation: _animationController,
                      builder: ((context, child) => Transform.rotate(
                          angle: _animationController.value * 10,
                          child: CircularText(
                              backgroundPaint: Paint()
                                ..color = const Color.fromARGB(255, 195, 0, 0)
                                ..strokeWidth = 20
                                ..style = PaintingStyle.stroke,
                              children: [
                                TextItem(
                                    text: const Text('Вольво в модификации Nillson – шведский стол, а не суперкар'),
                                    space: 4,
                                    startAngle: -120
                                )
                              ])
                      ))
                  ))
            ])
      )));
  }
}
