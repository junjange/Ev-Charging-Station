import 'package:ev_app/src/provider/ev_provider.dart';
import 'package:ev_app/src/ui/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EvInfo extends StatefulWidget {
  final String searchWrd;
  EvInfo(this.searchWrd);

  @override
  _EvInfoState createState() => _EvInfoState();
}

class _EvInfoState extends State<EvInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (BuildContext context) => EvProvider(),
      child: ListWidget(widget.searchWrd),
    ));
  }
}
