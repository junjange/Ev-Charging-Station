import 'package:ev_app/src/ui/list.dart';
import 'package:ev_app/src/ui/map.dart';
import 'package:flutter/material.dart';
import 'package:ev_app/src/ui/count_home_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ev_app/src/provider/bottom_navigation_provider.dart';

class Home extends StatelessWidget {
  late BottomNavigationProvider _bottomNavigationProvider;

  // 네비게이션바 UI Widget
  Widget _navigationBody() {
    // 권한 허용
    permission();

    // switch를 통해 currentPage에 따라 네비게이션을 구동시킨다.
    switch (_bottomNavigationProvider.currentPage) {
      case 0:
        return CountHomeWidget();

      case 1:
        return ListWidget("asd");

      case 2:
        return MapWidget();
    }
    return Container();
  }

  // 네비게이션바 Widget
  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map")
      ],

      // 현재 페이지 : _bottomNavigationProvider의 currentPage
      currentIndex: _bottomNavigationProvider.currentPage,
      selectedItemColor: Colors.blue,

      // _bottomNavigationProvider에 updateCurrentPage를 통해 index를 전달
      onTap: (index) {
        _bottomNavigationProvider.updateCurrentPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provider를 호출해 접근
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}

Future<bool> permission() async {
  Map<Permission, PermissionStatus> status =
      await [Permission.location].request();

  if (await Permission.location.isGranted) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}
