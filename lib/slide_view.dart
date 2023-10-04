// import 'package:flutter/material.dart';

// class RelaxView extends StatelessWidget {
//   const RelaxView({required this.animationController, Key? key})
//       : super(key: key);
//   final AnimationController animationController;

//   @override
//   Widget build(BuildContext context) {
//     final firstHalfAnimation =
//         Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0,
//         0.2,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));

//     final secondHalfAnimation =
//         Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.2,
//         0.4,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));

//     final thirdHalfAnimation =
//         Tween<Offset>(begin: Offset.zero, end: const Offset(-2, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.2,
//         0.4,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));

//     return SlideTransition(
//         position: firstHalfAnimation,
//         child: SlideTransition(
//             position: secondHalfAnimation,
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const Text('I once had a heart Inside of me'),
//                   SlideTransition(
//                       position: secondHalfAnimation,
//                       child: const Text('But I heard thee devil speak')),
//                   SlideTransition(
//                       position: thirdHalfAnimation,
//                       child: const Text('And he laughed at me'))
//                 ])));
//   }
// }
