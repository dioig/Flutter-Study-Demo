import 'package:flutter/material.dart';
import 'package:flutter_app_demo/utils/ImagesAnimation.dart';

/// 仿微信录制语音动画
class VoiceViewScreen extends StatefulWidget {
  VoiceViewScreen({Key key}) : super(key: key);

  @override
  _VoiceViewScreenState createState() => _VoiceViewScreenState();
}

class _VoiceViewScreenState extends State<VoiceViewScreen> {
  double start = 0.0;
  double offset = 0.0;
  double end = 0.0;
  bool isUp = false;
  String textShow = "按住说话";
  String toastShow = "手指上滑,取消发送";

  ///默认隐藏状态
  bool isVoiceState = true;

  ///是否进行了滑动
  bool isSlide = false;

  @override
  void initState() {
    super.initState();
  }

  showVoiceView() {
    isSlide = false;
    setState(() {
      textShow = "松开结束";
      isVoiceState = false;
    });
  }

  hideVoiceView() {
    setState(() {
      textShow = "按住说话";
      isVoiceState = true;
    });
    setState(() {
      isUp = start - offset > 100 && isSlide ? true : false;
      if (isUp) {
        textShow = "松开手指,取消发送";
        toastShow = textShow;
        print("取消发送");
      } else {
        textShow = "松开结束";
        toastShow = "手指上滑,取消发送";
        print("进行发送");
      }
    });
  }

  moveVoiceView() {
    isSlide = true;
    print("查看offset:$offset");
    print("start:$start");
    print("查看距离:${start - offset}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("仿微信录制语音动画"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Offstage(
                offstage: isVoiceState,
                child: Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Color(0xff77797A),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          ImagesAnimation(
                              w: 100,
                              h: 100,
                              entry: ImagesAnimationEntry(
                                  1, 7, "images/voice_volume_%s.png")),
//                          Container(
//                            margin: EdgeInsets.only(top: 10),
//                            child: new Image.asset(
//                              "images/voice_volume_7.png",
//                              width: 100,
//                              height: 100,
//                            ),
//                          ),
                          Container(
                            padding:
                                EdgeInsets.only(right: 20, left: 20, top: 0),
                            child: Text(
                              toastShow,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onVerticalDragStart: (details) {
                start = 0.0;
                start = details.globalPosition.dy;
                print("查看系统提供的开始距离:${details.globalPosition.dy}");
                showVoiceView();
              },
              onVerticalDragEnd: (details) {
                print("查看系统提供的结束距离:${details.primaryVelocity}");
                end = details.primaryVelocity;
                hideVoiceView();
              },
              onVerticalDragUpdate: (details) {
//                print("查看系统提供的更新距离:${details.globalPosition.dy}");
                offset = details.globalPosition.dy;
                moveVoiceView();
              },
              child: Container(
                height: 60,
                color: Colors.blue,
                margin: EdgeInsets.fromLTRB(50, 0, 50, 20),
                child: Center(
                  child: Text(
                    textShow,
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
