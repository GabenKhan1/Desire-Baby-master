import 'package:custom_app/fifthpage/itemData.dart';
import 'package:custom_app/other/StringConstant.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../other/constant.dart';

class FifthRoute extends StatefulWidget {
  const FifthRoute({Key key}) : super(key: key);

  @override
  _FifthRouteState createState() => _FifthRouteState();
}

class _FifthRouteState extends State<FifthRoute> {
  ItemData selectedItem;

  int listType = 0;

  bool isShowListView = false;
  bool isShowDetailView = false;

  String listScreenToolbarText = "";
  String detailScreenToolbarText = "";

  List<ItemData> selectedList = [];
  List<ItemData> listItem1 = [
    ItemData("Phasen des Menstruationszyklus", StringConstant.Phasen_des,
        AssetImage('assets/artical_item_20.jpg')),
    ItemData("Vier wichtigsten Hormone des weiblichen Zyklus",
        StringConstant.weiblichen, AssetImage('assets/artical_item_14.jpg')),
    ItemData("Wissenswertes über den Eisprung", StringConstant.Wissenswertes,
        AssetImage('assets/artical_item_9.png')),
    ItemData(
        "Ovulationstests für Zuhause",
        StringConstant.Ovualtionstest_fur_Zuhause,
        AssetImage('assets/artical_item_17.jpg')),
    ItemData("Zervixschleim", StringConstant.Der_Zervixschleim,
        AssetImage('assets/artical_item_31.jpg')),
    ItemData("Basaltemperatur", StringConstant.Basaltemperatur,
        AssetImage('assets/artical_item_4.jpg')),
    ItemData("Binden, Tampons & Co.", StringConstant.Binden_Tampons,
        AssetImage('assets/artical_item_26.jpg')),
    ItemData(
        "Linderung von Periodenschmerzen",
        StringConstant.Linderung_von_Periodenschmerzen,
        AssetImage('assets/artical_item_19.jpg')),
    ItemData("Schmierblutungen", StringConstant.Schmierblutung,
        AssetImage('assets/artical_item_24.jpg')),
    ItemData(
        "Das toxische Schocksyndrom",
        StringConstant.Das_Toxische_Schocksyndrom,
        AssetImage('assets/artical_item_27.jpg')),
    ItemData("Folsäure & Co.", StringConstant.Folsaure,
        AssetImage('assets/artical_item_11.jpg')),
    ItemData("Gleitmittel", StringConstant.Gleitmittel,
        AssetImage('assets/artical_item_13.jpg')),
    ItemData(
        "Alkohol und Fruchtbarkeit",
        StringConstant.Alkohol_und_Fruchtbarkeit,
        AssetImage('assets/artical_item_2.jpg')),
    ItemData("Verspätete Periode", StringConstant.verspatete_Periode,
        AssetImage('assets/artical_item_28.jpg')),
  ];

  List<ItemData> listItem2 = [
    ItemData(
        "Arten der Kinderwunschbehandlungen",
        StringConstant.Art_der_Kinderwunschbehandlung,
        AssetImage('assets/artical_item_15.jpg')),
    ItemData("Was passiert in einer Kinderwunschklinik?",
        StringConstant.passiert, AssetImage('assets/artical_item_29.jpg')),
    ItemData(
        "Kostenübernahme von Kinderwunschbehandlungen",
        StringConstant.bei_kinderwunschbehandlung,
        AssetImage('assets/artical_item_5.jpg')),
    ItemData("Abkürzungen auf Social-Media", StringConstant.Abkurzungen,
        AssetImage('assets/artical_item_1.jpg'),
        isList: true),
    ItemData("Schwangerschaftstests", StringConstant.Schwangerschaftstest,
        AssetImage('assets/artical_item_25.jpg')),
    ItemData("Schilddrüsenstörung", StringConstant.Schilddrusenstorung,
        AssetImage('assets/artical_item_23.jpg')),
    ItemData("Blutgerinnungsstörung", StringConstant.Gerinnungsstrung,
        AssetImage('assets/artical_item_12.jpg')),
    ItemData("NK-Zellen und Plasmazellen", StringConstant.Plasmazellen,
        AssetImage('assets/artical_item_21.jpg')),
    ItemData("Eileiterblockade", StringConstant.Eileiterblockade,
        AssetImage('assets/artical_item_7.jpg')),
    ItemData("Eierstockzysten", StringConstant.eierstockzysten,
        AssetImage('assets/artical_item_6.jpg')),
    ItemData("Endometriose", StringConstant.Endometriose,
        AssetImage('assets/artical_item_10.jpg')),
    ItemData(
        "PCOS", StringConstant.pcos, AssetImage('assets/artical_item_18.jpg')),
    ItemData("Rhesus-Faktor", StringConstant.Schwangerschaft,
        AssetImage('assets/artical_item_22.jpg')),
    ItemData("Steigerung der Zeugungsfähigkeit", StringConstant.Steigerung,
        AssetImage('assets/artical_item_32.jpg')),
    ItemData("Einnistungsblutung", StringConstant.Einnistungsblutung,
        AssetImage('assets/artical_item_8.jpg')),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (isShowDetailView) {
            setState(() {
              isShowDetailView = false;
            });

            return Future.value(false);
          } else if (isShowListView) {
            setState(() {
              isShowListView = false;
            });

            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            appBar: isShowDetailView
                ? null
                : AppBar(
                    title: Text(
                      isShowListView
                          ? listScreenToolbarText
                          : isShowDetailView
                              ? detailScreenToolbarText
                              : 'Artikel',
                      style: TextStyle(
                          color: Color(Constant.toolbar_text_color),
                          fontFamily: Constant.font_name),
                    ),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Color(Constant.toolbar_color),
                    iconTheme: IconThemeData(
                      color: Color(
                          Constant.toolbar_text_color), //change your color here
                    )),
            body: Stack(
              children: [
                //main view
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {



                          selectedList = listItem1;
                          listScreenToolbarText = 'Weiblicher Zyklus';

                          setState(() {
                            isShowListView = true;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: 15, left: 15, right: 15, top: 8),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image(
                                    image: AssetImage('assets/item_1.jpg'),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "Weiblicher Zyklus",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: Constant.font_name),
                                        )))
                              ],
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {

                          selectedList = listItem2;
                          listScreenToolbarText = 'Kinderwunschbehandlung';

                          setState(() {
                            isShowListView = true;
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: 15, left: 15, right: 15, top: 8),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image(
                                    image: AssetImage('assets/item_2.jpg'),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "Kinderwunschbehandlung",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: Constant.font_name),
                                        )))
                              ],
                            )),
                      ),
                    )
                  ],
                ),
                //list view
                Visibility(
                  visible: isShowListView,
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListView.builder(
                      itemCount: selectedList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {

                            if(!Constant.isPurchased){
                              Constant.showPremierMessage(context);
                              return;
                            }
                            selectedItem = selectedList[index];
                            detailScreenToolbarText = selectedItem.title;

                            setState(() {
                              isShowDetailView = true;
                            });
                          },
                          child: Container(
                            height: 100,
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Stack(
                                children: [
                                  Image(
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    image: selectedList[index].image,
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  Center(
                                      child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      selectedList[index].title,
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize: 20,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                //detail view

                selectedItem == null
                    ? Container()
                    : Visibility(
                        visible: isShowDetailView,
                        child: selectedItem.isList!=null && selectedItem.isList
                            ? Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 25),
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Text(
                                        selectedItem.title,
                                        style: TextStyle(
                                            fontFamily: Constant.font_name,
                                            fontSize: 24,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child:
                                              Image(image: selectedItem.image)),
                                    ),
                                    Html(
                                      data: selectedItem.dec
                                          .replaceAll("\n", "<br />"),
                                      style: {
                                        "body": Style(
                                            fontFamily: Constant.font_name,
                                            fontSize: FontSize(
                                                Constant.subHeadingTextSize),
                                            color: Colors.black),
                                      },
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: StringConstant.ab.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex:2,
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    StringConstant.ab[index],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constant.font_name,
                                                        fontSize: Constant
                                                            .subHeadingTextSize),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  StringConstant.values[index],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Constant.font_name,
                                                      fontSize: Constant
                                                          .subHeadingTextSize),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 25),
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Text(
                                          selectedItem.title,
                                          style: TextStyle(
                                              fontFamily: Constant.font_name,
                                              fontSize: 24,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(15),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image(
                                                image: selectedItem.image)),
                                      ),
                                      Html(
                                        data: selectedItem.dec
                                            .replaceAll("\n", "<br />"),
                                        style: {
                                          "body": Style(
                                              fontFamily: Constant.font_name,
                                              fontSize: FontSize(
                                                  Constant.subHeadingTextSize),
                                              color: Colors.black),
                                        },
                                      ),
                                      /*Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 20, bottom: 5),
                                  child: Text(
                                    selectedItem.dec,
                                    style: TextStyle(
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.subHeadingTextSize,
                                        color: Colors.black),
                                  ),
                                ),*/
                                    ],
                                  ),
                                ),
                              ),
                      )
              ],
            )));
  }
}
