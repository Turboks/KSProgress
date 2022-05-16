import 'package:flutter/material.dart';

enum AnimationType {
  ///圆圈模式
  circular,

  ///横线模式
  Linear,

  ///刷新模式
  refresh
}

class KSProgressDialog extends StatelessWidget {
  ///是否显示
  final bool isShow;

  ///提醒内容
  final String? title;

  ///动画效果    默认圆圈模式
  final AnimationType? showType;

  ///背景透明度
  final double? alpha;

  ///字体颜色
  final Color? textColor;

  ///方块背景颜色
  final Color? itemColor;

  const KSProgressDialog(
      {Key? key,
      required this.isShow,
      this.title,
      this.showType = AnimationType.circular,
      this.alpha = 0.1,
      this.textColor = Colors.black,
      this.itemColor = Colors.black12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

    //1.设置动画效果
    var progressIndicator;
    var needWidth =
        0.0; //Linear 模式下需要设置宽度，不然的话就会占满全屏,传递文字过多的话需要传递一个宽度的参数过来，可自己完善
    switch (showType) {
      case AnimationType.circular:
        progressIndicator = CircularProgressIndicator(
          strokeWidth: 2, //线的宽度
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white), //线的颜色
          backgroundColor: Colors.grey, //圆圈的背景色
        );
        break;
      case AnimationType.Linear:
        title == null ? needWidth = 100 : needWidth = 150;
        progressIndicator = LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white), //线的颜色
          backgroundColor: Colors.grey, //圆圈的背景
        );
        break;
      case AnimationType.refresh:
        progressIndicator = RefreshProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white), //线的颜色
          backgroundColor: Colors.grey, //圆圈的背景色
        );
        break;
      default:
    }

    if (isShow) {
      Widget progressView;
      if (title == null) {
        progressView = Center(
          child: Container(
            width: needWidth > 0 ? needWidth : null,
            padding: needWidth > 0
                ? EdgeInsets.only(top: 40, bottom: 40, left: 10, right: 10)
                : EdgeInsets.all(30.0),
            decoration: BoxDecoration(
                color: itemColor, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                progressIndicator,
              ],
            ),
          ),
        );
      } else {
        progressView = Center(
          child: Container(
            width: needWidth > 0 ? needWidth : null,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: itemColor, borderRadius: BorderRadius.circular(4.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                progressIndicator,
                Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  child: Text(
                    title!,
                    style: TextStyle(color: textColor, fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
        );
      }
      widgetList.add(Opacity(
        opacity: alpha!,
        child: new ModalBarrier(color: Colors.black38),
      ));
      widgetList.add(progressView);
    }
    return Stack(
      children: widgetList,
    );
  }
}
