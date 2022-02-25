import 'package:ev_app/src/components/view_count.dart';
import 'package:ev_app/src/provider/count_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountHomeWidget extends StatelessWidget {
  CountHomeWidget({Key? key}) : super(key: key);

  late CountProvider _countProvider;

  @override
  Widget build(BuildContext context) {
    // Provider를 호출해 접근, listen: false를 통해 구독된 모든 위젯들에게 알림을 보내지 않게 한다.
    _countProvider = Provider.of<CountProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Count Provider"),
      ),
      body: ViewCountWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _countProvider.add(); // 클릭 되었을 때 add() 이벤트 처리
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              _countProvider.remove(); // 클릭 되었을 때 remove() 이벤트 처리
            },
          )
        ],
      ),
    );
  }
}
