import 'dart:async';

import 'package:flutter/material.dart';
import 'ks_loading.dart';

class KsTestPage extends StatefulWidget {
  const KsTestPage({Key? key}) : super(key: key);

  @override
  State<KsTestPage> createState() => _KsTestPageState();
}

class _KsTestPageState extends State<KsTestPage> {
  late Timer _timer;

  var isLoading = true;
  @override
  void initState() {
    super.initState();
    //模拟加载效果
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == false) {
      return Scaffold(
        appBar: AppBar(
          title: Text("测试"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return _orderItemView();
          },
          itemCount: 10,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("测试"),
        ),
        body: KSProgressDialog(isShow: true),
      );
    }
  }

  _orderItemView() {
    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  '店铺名称',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Expanded(
                    child: Container(
                  child: Text("已完成"),
                  alignment: Alignment.centerRight,
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(flex: 1, child: Image.asset('images/logo.jpg')),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 120,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("下单时间: 2022-01-01"),
                            alignment: Alignment.centerLeft,
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("订单编号: 5284632"),
                            alignment: Alignment.centerLeft,
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("共9件商品"),
                            alignment: Alignment.centerLeft,
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "合计:¥ 99.9 元",
                              style: TextStyle(color: Colors.red),
                            ),
                            alignment: Alignment.centerLeft,
                          )),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
