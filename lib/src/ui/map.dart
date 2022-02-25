import 'dart:async';
import 'dart:typed_data';
import 'package:ev_app/src/components/ev_search.dart';
import 'package:ev_app/src/model/ev.dart';
import 'package:ev_app/src/provider/ev_provider.dart';
import 'package:ev_app/src/components/bottom.dart';
import 'package:ev_app/src/ui/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

/*
*********해야할 것**********
1. 주변 전기차 충전소 => 영어로 현재 주소가 나옴.. 그냥 모든 전기차 주유소를 화면에 뿌려야 할지.. => 한글로 변환하여 해결!
2. 제일 가까운 거리에 전기차 충전소 정보 => 지도로 확인 가능
3. 전기차 충전소를 눌렀을 때 전기차 충전소에 대한 정보 제공
4. 길안내
5. 자주 가는 전기차 충전소 저장 기능
6. 초기 지도 위치 값 변경 불가능.. 가능할까?
*/

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late EvProvider _evProvider;

  // 텍스트
  final mycontroller = TextEditingController();

  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  late GoogleMapController _controller;

  // 이 값은 지도가 시작될 때 첫 번째 위치
  static LatLng _center = LatLng(37.5283169, 126.9294254);
  final CameraPosition _initialPosition =
      CameraPosition(target: _center, zoom: 16);

  // 지도 중간 좌표
  LatLng _lastMapPosition = _center;

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  // 지도가 움직일 때마다 중간 좌표를 확인
  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    print("asdasd${position.target}");
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  // 마커 추가
  addMarker(Ev ev) {
    print(ev.addr);
    markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(
            double.parse(ev.lat.toString()), double.parse(ev.longi.toString())),
        markerId: MarkerId(ev.csNm.toString()),

        // 마커를 눌렀을 때 주소명을 UI에 뿌려줌
        infoWindow: InfoWindow(
            title: ev.csNm,
            snippet: ev.addr,
            onTap: () {
              print("눌렀다");
            }),
        onTap: () {
          print(markers);
          print("눌렀다?");
          _controller.animateCamera(CameraUpdate.newLatLng(LatLng(
              double.parse(ev.lat.toString()),
              double.parse(ev.longi.toString()))));

          showBottomSheet(
              context: context,
              builder: (context) {
                return Bottom.bottomSheet(ev);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))));
        }));
  }

  // Google Map 생성
  Widget _makeMap(List<Ev> evs) {
    for (int i = 0; i < evs.length; i++) {
      addMarker(evs[i]);
    }

    return GoogleMap(
      /*
      initialCameraPosition : 초기 시작 시 지도 보기를 로드하는 데 사용되는 필수 매개변수입니다.
      myLocationEnabled : 지도에 파란색 점으로 현재 위치를 표시합니다.
      myLocationButtonEnabled : 사용자 위치를 카메라 뷰의 중앙으로 가져오는 데 사용되는 버튼입니다.
      mapType : 표시할 지도의 유형(일반, 위성, 하이브리드 및 지형)을 지정합니다.
      zoomGesturesEnabled : 지도 보기가 확대/축소 제스처에 응답해야 하는지 여부입니다.
      zoomControlsEnabled : 확대/축소 컨트롤을 표시할지 여부(Android 플랫폼에만 해당).
      onMapCreated : 지도를 사용할 준비가 되었을 때 콜백합니다. 
      */

      initialCameraPosition: _initialPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      tiltGesturesEnabled: false,
      // minMaxZoomPreference: MinMaxZoomPreference(13, 30), // zomm 최소/최대
      onMapCreated: (controller) {
        _controller = controller;
      },
      markers: markers.toSet(), // 화면 이동시 부드럽게 이동
      onCameraMove: _onCameraMove, // 카메라 이동 시 작동
      onTap: (cordinate) {}, // 맵을 클릭했을 때
    );
  }

  evList() async {
    var gps = await getCurrentLocation();
    _center = LatLng(gps.latitude, gps.longitude);
    _evProvider.loadEvs(gps.latitude, gps.longitude);

    print("asdasdads${_center}");
  }

  @override
  Widget build(BuildContext context) {
    _evProvider = Provider.of<EvProvider>(context, listen: false);
    // _evProvider.loadEvs(37.5283169, 126.9294254);
    evList();

    return Scaffold(
        body: SafeArea(
          child: Stack(children: [
            Consumer<EvProvider>(builder: (context, provider, wideget) {
              print("asdasd${provider.evs}");
              if (provider.evs != null && provider.evs.length > 0) {
                return _makeMap(provider.evs);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
            GestureDetector(
              onTap: () {
                print(11);
                
                var a = EvSearch.buildBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                height: 70,
                margin: EdgeInsets.only(left: 10, right: 10, top: 80),
                child: Material(
                  borderRadius: BorderRadius.circular(32.0),
                  elevation: 8,
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.cyan,
                          size: 30,
                        ),
                        Text(
                          "지역/충전소를 입력해주세요",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          // 현재 좌표에서 전기차 주유소 찾기 버튼
          FloatingActionButton(
            onPressed: () {
              _evProvider.loadEvs(
                  _lastMapPosition.latitude, _lastMapPosition.longitude);
            },
            child: Icon(
              Icons.autorenew_sharp,
              color: Colors.cyan,
            ),
            backgroundColor: Colors.white,
          ),

          SizedBox(
            height: 30.0,
          ),

          // 현재 위치 버튼
          FloatingActionButton(
            onPressed: () async {
              var gps = await getCurrentLocation();

              _controller.animateCamera(
                  CameraUpdate.newLatLng(LatLng(gps.latitude, gps.longitude)));

              await _evProvider.loadEvs(gps.latitude, gps.longitude);
            },
            child: Icon(
              Icons.my_location,
              color: Colors.cyan,
            ),
            backgroundColor: Colors.white,
          ),

          SizedBox(
            height: 30.0,
          ),

          FloatingActionButton(
            onPressed: () {
              _controller
                  .animateCamera(CameraUpdate.newLatLng(markers[0].position));
            },
            child: Icon(
              Icons.my_location,
              color: Colors.cyan,
            ),
            backgroundColor: Colors.white,
          ),
        ]));
  }
}

Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}

late Uint8List markerIcon;

// 마커 변경
void setCustomMapPin() async {
  markerIcon = await getBytesFromAsset('assets/customMarker.png', 100);
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
