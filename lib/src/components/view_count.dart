import 'package:ev_app/src/provider/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCountWidget extends StatelessWidget {
  const ViewCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          // Consumer를 활용해서 provider에 접근하여 데이터를 받아올 수 있다
          Consumer<CountProvider>(builder: (context, provider, child) {
        return Text(
          provider.count.toString(), // count를 화면에 출력
          style: TextStyle(fontSize: 40.0),
        );
      }),
    );
  }
}
