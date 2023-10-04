import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/heart_view.dart';
import 'package:flutter_animations/rounded_text_screen.dart';

class HeartArrowView extends StatefulWidget {
  const HeartArrowView({super.key});

  @override
  _HeartArrowViewState createState() => _HeartArrowViewState();
}

class _HeartArrowViewState extends State<HeartArrowView>
    with TickerProviderStateMixin {
  late AnimationController _motionController;
  late AnimationController _arrowController;
  Animation? _colorAnimation;
  late Animation<Offset> arrowMovingAnimation;

  double _beginX = Random().nextDouble() * (1 - (-1)) - 1;
  double _beginY = Random().nextDouble() * (1 - (-1)) - 1;

  double _endX = Random().nextDouble() * (1 - (-1)) - 1;
  double _endY = Random().nextDouble() * (1 - (-1)) - 1;

  double _size = 20;

  @override
  void initState() {
    super.initState();

    _motionController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
    );

    _arrowController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.pinkAccent)
        .animate(_motionController);

    _motionController.fling();
    _motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          _motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _colorAnimation = ColorTween(
                  begin: Color(Random().nextInt(0xffffffff)),
                  end: Color(Random().nextInt(0xffffffff)))
              .animate(_motionController);
          _motionController.fling();
        }
      });
    });

    arrowMovingAnimation = Tween<Offset>(
            begin: Offset(_beginX, _beginY), end: Offset(_endX, _endY))
        .animate(_arrowController);

    _motionController.addListener(() {
      setState(() {
        _size = _motionController.value * 200;
      });
    });

    _arrowController.addListener(() {
      setState(() {
        _beginX = Random().nextDouble() * (1 - (-1)) - 1;
        _beginY = Random().nextDouble() * (1 - (-1)) - 1;

        _endX = Random().nextDouble() * (1 - (-1)) - 1;
        _endY = Random().nextDouble() * (1 - (-1)) - 1;
      });
    });
  }

  @override
  void dispose() {
    _arrowController.dispose();
    _motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animations'),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
          onTap: () {
            Navigator.of(context).push(_createRoute());
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: SizedBox(
                    height: 300,
                    child: Stack(children: [
                      HeartView(
                          size: _size, heartColor: _colorAnimation?.value),
                    ]),
                  ),
                ),
                SlideTransition(
                    position: arrowMovingAnimation,
                    child: IconButton(
                        color: const Color.fromARGB(255, 232, 189, 189),
                        iconSize: 80,
                        onPressed: () {
                          arrowMovingAnimation = Tween<Offset>(
                                  begin: Offset(_beginX, _beginY),
                                  end: Offset(_endX, _endY))
                              .animate(_motionController);
                          _arrowController.reset();
                        },
                        icon: const Icon(Icons.arrow_upward_rounded)))
              ])),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, _) => const RoundedTextView(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var animationRoute = Tween<Offset>(
              begin: const Offset(0.0, 1.0), end: Offset.zero)
          .animate(CurvedAnimation(parent: animation, curve: Curves.bounceOut));

      return SlideTransition(
        position: animationRoute,
        child: child,
      );
    },
  );
}
