import 'package:ev_app/src/model/ev.dart';
import 'package:ev_app/src/repository/ev_repository.dart';
import 'package:flutter/material.dart';

class EvProvider extends ChangeNotifier {
  EvRepository _evRepository = EvRepository();

  List<Ev> _evs = [];
  List<Ev> get evs => _evs;

  loadEvs(x, y) async {
    List<Ev>? listEvs = await _evRepository.loadEvs(x, y);
    _evs = listEvs!;
    notifyListeners();
  }

  serachEvs(addr) async {
    print(addr);

    if (await _evRepository.searchEvs(addr) == null) {
      _evs = [];
    } else {
      List<Ev>? listEvs = await _evRepository.searchEvs(addr);
      _evs = listEvs!;
    }

    notifyListeners();
  }
}
