import 'package:flutter/material.dart';

class MyAnimationScreen extends StatefulWidget {
  const MyAnimationScreen({Key? key}) : super(key: key);

  @override
  State<MyAnimationScreen> createState() => _MyAnimationScreenState();
}

class _MyAnimationScreenState extends State<MyAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
            onPressed: (() {
              setState(() {
                _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward();
              });
            }),
            icon: AnimatedIcon(
              icon: AnimatedIcons.arrow_menu,
              progress: _animationController,
              size: 50,
            ),
          ),
          SizedBox(height: 40,),
          FutureBuilder(
            future: Future.delayed(
              Duration(milliseconds: 500),
            ),
            builder: ((context, snapshot) {
              final bool hasEnded =
                  snapshot.connectionState == ConnectionState.done;
              return Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: hasEnded ? 300 : 50,
                  width: hasEnded ? 300 : 50,
                  decoration: BoxDecoration(
                    color: hasEnded ? Colors.green : Colors.amber,
                    borderRadius: hasEnded
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(300),
                  ),
                ),
              );
              /*
              AnimatedCrossFade(
                  firstChild: Center(
                    child: CircularProgressIndicator(),
                  ),
                  secondChild: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.green,
                    ),
                  ),
                  crossFadeState: snapshot.connectionState == ConnectionState.done
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(seconds: 1));
                  */
            }),
          ),
        ],
      ),
    );
  }
}
/*
class MyAnimatonScreen extends StatelessWidget {
  const MyAnimatonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Future.delayed(
          Duration(seconds: 1),
        ),
        builder: ((context, snapshot) {
          final bool hasEnded =
              snapshot.connectionState == ConnectionState.done;
          return Center(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 2),
                  height: hasEnded ? 300 : 50,
                  width: hasEnded ? 300 : 50,
                  decoration: BoxDecoration(
                    color: hasEnded ? Colors.green : Colors.amber,
                    borderRadius: hasEnded
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(300),
                  ),
                ),

              ],
            ),
          );
          /*
          AnimatedCrossFade(
              firstChild: Center(
                child: CircularProgressIndicator(),
              ),
              secondChild: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.green,
                ),
              ),
              crossFadeState: snapshot.connectionState == ConnectionState.done
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(seconds: 1));
              */
        }),
      ),
    );
  }
}
*/
