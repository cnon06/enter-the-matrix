import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

enum Animvalues { forward, backward }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  // late Animation anime;

  // void animation_backward() {
  //   animationController.reset();
  //   animationController.value = 1;
  //   animationController.reverse();

  //   animationController.addListener(() {
  //     if (animationController.isCompleted) {
  //       animation_forward();
  //     }
  //     //  print('${animationController.value}');
  //     setState(() {});
  //   });
  // }

  // void animation_backward() {
  //   animationController.reset();
  //   animationController.value = 1;
  //   animationController.duration = const Duration(seconds: 5);
  //   animationController.reverse();

  //   animationController.addListener(() {
  //     if (animationController.isCompleted) {
  //       print("backward completed");
  //       animationController.value = 0;
  //       animation_forward();
  //       // animation_backward();
  //     }
  //     //  print('${animationController.value}');
  //     setState(() {});
  //   });
  // }

  void animation_forward(Animvalues a_values) {
    animationController.reset();
    animationController.duration = const Duration(seconds: 3);

    animationController.value = 0;

    animationController.forward();

    animationController.addListener(() {
      if (animationController.isCompleted) {
        print("forward completed");
        animationController.reverse();
      }
      if (animationController.isDismissed) {
        print("forward completed");
        animationController.forward();
      }
      //  print('${animationController.value}');
      setState(() {});
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
      value: 0,
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // anime =
    //     CurvedAnimation(parent: animationController, curve: Curves.elasticIn);

    super.initState();
  }


String rnd()
{
  String rnd1="";
  for(int i=0; i<10000 ;i++) {
    rnd1 += Random().nextInt(9).toString();
  }
  return rnd1;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Text(
              // "${new Random().}" * 10000,
              rnd(),
              style: const TextStyle(color: Colors.lightGreen),
            ),
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: animationController.value * 4, //2.0,

                      sigmaY: 1.0),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 250,
                    height: 250,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              animation_forward(Animvalues.forward);
                            },
                            child: const Text("Press")),
                        const Text(
                          "C-NON Software",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.lightGreenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
