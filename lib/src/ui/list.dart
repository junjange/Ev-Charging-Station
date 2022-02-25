import 'dart:async';

import 'package:ev_app/src/components/ev_item.dart';
import 'package:ev_app/src/model/ev.dart';
import 'package:ev_app/src/provider/ev_provider.dart';
import 'package:ev_app/src/ui/map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatefulWidget {
  final String searchWrd;
  ListWidget(this.searchWrd);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late EvProvider _evProvider;

  @override
  Widget build(BuildContext context) {
    _evProvider = Provider.of<EvProvider>(context, listen: false);
    _evProvider.serachEvs(widget.searchWrd);

    return Scaffold(
        body: Consumer<EvProvider>(builder: (context, provider, wideget) {
      if (provider.evs != [] && provider.evs.length > 0) {
        return EvItem.makeListView(provider.evs);
      }
      // return Center(child: CircularProgressIndicator());
      return Center(
        child: Text("잘못된 이름이거나 데이터가 없습니다."),
      );
    }));
  }
}
