import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart'; //这个是一个拼接字符串的flutter库，主要是为了使用方便，你可以选择不使用，这样的话你需要自己拼接图片路径

class ImagesAnimation extends StatefulWidget {
  final double w;
  final double h;
  final ImagesAnimationEntry entry;
  final int durationSeconds;

  ImagesAnimation(
      {Key key, this.w: 80, this.h: 80, this.entry, this.durationSeconds: 2})
      : super(key: key);

  @override
  _InState createState() {
    return _InState();
  }
}

class _InState extends State<ImagesAnimation> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(seconds: widget.durationSeconds))
      ..repeat();
    _animation =
        new IntTween(begin: widget.entry.lowIndex, end: widget.entry.highIndex)
            .animate(_controller);
//widget.entry.lowIndex 表示从第几下标开始，如0；widget.entry.highIndex表示最大下标：如7
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        String frame = _animation.value.toString();
        return new Image.asset(
          sprintf(widget.entry.basePath, [frame]), //根据传进来的参数拼接路径
          gaplessPlayback: true, //避免图片闪烁
          width: widget.w,
          height: widget.h,
        );
      },
    );
  }
}

class ImagesAnimationEntry {
  int lowIndex = 0;
  int highIndex = 0;
  String basePath;

  ImagesAnimationEntry(this.lowIndex, this.highIndex, this.basePath);
}
