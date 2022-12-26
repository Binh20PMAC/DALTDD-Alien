import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screen/BatDauChoi.dart';
import 'package:flutter_application_2/Screen/HoSo.dart';
import 'package:flutter_application_2/Screen/TrangChu.dart';
import 'package:flutter_application_2/component/TrangChuTabBarGoogle.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../component/menu.dart';

class XepHang extends StatefulWidget {
  @override
  State<XepHang> createState() {
    return XepHangState();
  }
}

class XepHangState extends State<XepHang> {
  final _auth = FirebaseAuth.instance;
  var countuser;
  GlobalKey<ScaffoldState> _sKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final loginUser = _auth.currentUser;
    return Scaffold(
      key: _sKey,
      endDrawer: Menu(),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            //color: HexColor('0C205B')
            image: DecorationImage(
                image: AssetImage('assets/bgg.jpg'), fit: BoxFit.fill)),
        child: Stack(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where('email', isEqualTo: loginUser!.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!.docs[i];

                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              //color: HexColor('0C205B')
                              image: DecorationImage(
                                  image: AssetImage('assets/bgg.jpg'),
                                  fit: BoxFit.fill)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 50, top: 0),
                                      child: Image.asset(
                                        'assets/logo.png',
                                        width: 130,
                                      ),
                                    ),
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const TrangChuTabBarGoogle()),
                                              )
                                            },
                                            icon: Image.asset(
                                              'assets/close-option.png',
                                              color: HexColor('FFDE00'),
                                            ),
                                            iconSize: 40,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Stack(
                                          children: <Widget>[
                                            // Stroked text as border.
                                            Text(
                                              'BẢNG XẾP HẠNG',
                                              style: TextStyle(
                                                fontSize: 50,
                                                fontFamily: 'FSAriston',
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 5
                                                  ..color = HexColor('FFEE52'),
                                              ),
                                            ),
                                            // Solid text as fill.
                                            Text(
                                              'BẢNG XẾP HẠNG',
                                              style: TextStyle(
                                                fontSize: 50,
                                                fontFamily: 'FSAriston',
                                                color: HexColor('000000'),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 0, top: 30),
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontFamily: 'FSAriston',
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 35, top: 10),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/user.png'),
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 30,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor('FFFFFF'),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  height: 20,
                                                  width: 80,
                                                  child: Padding(
                                                      padding: EdgeInsets.zero,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Cấp ' +
                                                                data['cap']
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'LinotteBold'),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          top: 60,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 120, top: 20),
                                          child: Text(
                                            data['tendangnhap'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'LinotteBold',
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 120, top: 48),
                                          child: Text(
                                            data['diem'].toString() + ' điểm',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'LinotteBold',
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //SizedBox(height: 20,),
                              ]),
                        );
                      });
                } else if (snapshot.hasData) {
                  return Center(
                    child: Text('Có lỗi xảy ra'),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 220),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    width: MediaQuery.of(context).size.width / 1.0828,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bg-menu.png'),
                            fit: BoxFit.fill)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 291),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 2.07,
                      width: MediaQuery.of(context).size.width / 1.0828,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .orderBy('diem', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return Container(
                            child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 0),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, int index) {
                                  var data = snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                                  int count = index + 1;

                                  return Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 70, top: 0),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, top: 30),
                                            child: Text(
                                              count.toString() + '.',
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  fontFamily: 'FSAriston',
                                                  color: Color.fromARGB(
                                                      255, 252, 3, 3)),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 35, top: 20),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Image(
                                                        image: AssetImage(
                                                            'assets/user.png'),
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 30,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            HexColor('FFFFFF'),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    height: 20,
                                                    width: 70,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Cấp ' +
                                                                  data['cap']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'LinotteBold'),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            top: 60,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 120, top: 20),
                                            child: Text(
                                              data['tendangnhap'].toString(),
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontFamily: 'LinotteBold',
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 130, top: 48),
                                            child: Text(
                                              data['diem'].toString() + ' điểm',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'LinotteBold',
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        },
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
