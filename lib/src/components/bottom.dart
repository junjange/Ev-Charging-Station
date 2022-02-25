import 'package:flutter/material.dart';
import 'package:ev_app/src/model/ev.dart';

class Bottom{

  static bottomSheet(Ev ev) {
    return Container(
      height: 300.0,
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 충전소 주소
          Text(
            ev.addr.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),

          // 충전기 타입
          Text(
            ev.chargeTp.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          SizedBox(
            height: 10,
          ),

          // 충전기 명칭
          Text(
            "충전기 명칭 : " + ev.cpNm.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          SizedBox(
            height: 10,
          ),

          // 충전기 상태 코드
          Text(
            ev.cpStat.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          SizedBox(
            height: 10,
          ),

          // 충전 방식
          Text(
            ev.cpTp.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          SizedBox(
            height: 10,
          ),

          // 충전소 명칭
          Text(
            "충전소 명칭 : " + ev.csNm.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          SizedBox(
            height: 10,
          ),

          // 위도
          Text(
            "위도 : " + ev.lat.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          SizedBox(
            height: 10,
          ),

          // 경도
          Text(
            "경도 : " + ev.longi.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}