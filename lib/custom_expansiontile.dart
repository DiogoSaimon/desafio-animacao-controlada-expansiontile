import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key? key,
    this.children = const <Widget>[],
    required this.title,
  }) : super(key: key);

  final List<Widget> children;
  final String title;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> colorAnimation;
  late Animation<double> rotationAnimation;
  late Animation<Alignment> alignAnimation;

  void isClicked() {
    if (controller.value == 0) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );

    colorAnimation = ColorTween(
      begin: null,
      end: Colors.blue,
    ).animate(controller);

    rotationAnimation = Tween(
      begin: 0.0,
      end: 3.15,
    ).animate(controller);

    alignAnimation = Tween(
      begin: Alignment.center,
      end: Alignment.center,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return InkWell(
          onTap: isClicked,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: colorAnimation.value,
                  ),
                ),
                trailing: Transform.rotate(
                  angle: rotationAnimation.value,
                  child: Icon(
                    Icons.expand_more_sharp,
                    color: colorAnimation.value,
                  ),
                ),
              ),
              ClipRect(
                child: Align(
                  heightFactor: controller.value,
                  alignment: alignAnimation.value,
                  child: Column(
                    children: widget.children,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
