import 'package:ev_app/src/ui/ev_info.dart';
import 'package:flutter/material.dart';

class EvSearch {
  static buildBottomSheet(BuildContext context) {
    final mycontroller = TextEditingController();

    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0), // 적절히 조절
                topRight: const Radius.circular(25.0), // 적절히 조절
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.cyan[50],
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0), // 적절히 조절
                      topRight: const Radius.circular(25.0), // 적절히 조절
                    ),
                  ),
                  // color: Colors.cyan[50],
                ),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: Center(child: Text("검색")),
                      color: Colors.cyan[50],
                    ),
                    Positioned(
                        left: 0.0,
                        top: 0.0,
                        child: IconButton(
                            icon: Icon(Icons.close), 
                            onPressed: () {
                              Navigator.of(context).pop();
                            }))
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 60,
                      color: Colors.cyan[50],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(15.0), // 적절히 조절
                            topRight: const Radius.circular(15.0), // 적절히 조절
                            bottomLeft: const Radius.circular(15.0),
                            bottomRight: const Radius.circular(15.0),
                          ),
                        ),

                        height: 60,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          autofocus : true,
                          cursorColor: Colors.cyan,
                          keyboardType: TextInputType.text,
                          controller: mycontroller,
                          onEditingComplete: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            prefixIcon: GestureDetector(
                              child: Icon(
                                Icons.search,
                                color: Colors.cyan,
                                size: 30,
                              ),
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            ),
                            hintText: "지역/충전소를 입력해주세요",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.cyan[50],
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(25.0), // 적절히 조절
                      bottomRight: const Radius.circular(25.0), // 적절히 조절
                    ),
                  ),
                ),
                mycontroller.text != ""
                    ? 
                    Expanded(child: EvInfo(mycontroller.text))
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 200.0,),
                          Container(
                              child: Text(
                                  "잘못된 이름이거나 데이터가 없습니다. ${mycontroller.text}"))
                        ],
                      )
              ],
            ),
          );
        });
  }
}
