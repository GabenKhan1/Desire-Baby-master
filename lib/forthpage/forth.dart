import 'dart:io';

import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/forthpage/model/diary.dart';
import 'package:custom_app/forthpage/view_image.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ForthRoute extends StatefulWidget {
  @override
  _ForthRouteState createState() => _ForthRouteState();
}

class _ForthRouteState extends State<ForthRoute> {
  bool isFloatingClick = false;
  bool isShowImage = false;
  bool isDetailScreenShow = false;

  TextEditingController medikamentControler = TextEditingController();
  String date = "";
  List<Diary> list;

  Diary diary;

  double imageSize = 130;
  double imageSizes = 35;

  bool isEdit = false;

  Diary updateDiary;

  @override
  void initState() {
    super.initState();
    list = [];

    load();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isFloatingClick) {
          if (isEdit) {
            isEdit = false;
            updateDiary = null;
            date = "";
            _image = "";
            medikamentControler.text = "";
          }

          setState(() {
            isFloatingClick = false;
          });

          return Future.value(false);
        } else if (isDetailScreenShow) {
          setState(() {
            isDetailScreenShow = false;
          });

          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
              isEdit
                  ? 'Eintrag bearbeiten'
                  : isFloatingClick
                      ? 'Neuer Eintrag'
                      : isDetailScreenShow
                          ? 'Mein Tagebuch'
                          : 'Mein Tagebuch',
              style: TextStyle(
                  color: Color(Constant.toolbar_text_color),
                  fontFamily: Constant.font_name),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: <Widget>[
              Visibility(
                visible: isFloatingClick,
                child: IconButton(
                  icon: Image(
                    image: AssetImage('assets/tick_3.png'),
                  ),
                  onPressed: () {
                    if (date.isEmpty) {
                      showMessage("Datum auswählen");
                      return;
                    }
                    if (medikamentControler.text.isEmpty) {
                      showMessage("Geben Sie zuerst den Text ein");
                      return;
                    }

                    if (isEdit) {
                      updateDiary.date = date;
                      updateDiary.text = medikamentControler.text;
                      updateDiary.image = _image;
                      CustomDB.instance
                          .updateDiary(updateDiary)
                          .then((value) => {
                                CustomDB.instance
                                    .getDiary()
                                    .then((value) => list = value),
                                date = "",
                                _image = "",
                                medikamentControler.text = "",
                                isEdit = false,
                                setState(() {
                                  isFloatingClick = false;
                                }),
                              });
                    } else {
                      Diary diary = new Diary();
                      diary.date = date;
                      diary.text = medikamentControler.text;
                      diary.image = _image;
                      CustomDB.instance.addDiary(diary).then((value) => {
                            diary.id = value,
                            date = "",
                            _image = "",
                            medikamentControler.text = "",
                            isFloatingClick = false,
                            load(),
                          });
                    }
                  },
                ),
              ),
              Visibility(
                visible: isDetailScreenShow,
                child: IconButton(
                  icon: Image(
                    image: AssetImage('assets/edit.png'),
                  ),
                  onPressed: () {
                    updateDiary = diary;
                    isEdit = true;
                    isDetailScreenShow = false;

                    date = diary.date;
                    _image = diary.image;
                    medikamentControler.text = diary.text;

                    // when user want to edit we show the same layout;
                    setState(() {
                      isFloatingClick = true;
                    });
                  },
                ),
              ),
              Visibility(
                visible: isDetailScreenShow,
                child: IconButton(
                  icon: Image(
                    image: AssetImage('assets/delete.png'),
                  ),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                ),
              )
            ],
            backgroundColor: Color(Constant.toolbar_color),
            iconTheme: IconThemeData(
              color:
                  Color(Constant.toolbar_text_color), //change your color here
            )),
        body: Stack(
          children: [
            Visibility(
              visible: !isFloatingClick,
              child: (list == null || list.length == 0)
                  ? emptyList
                  : Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: ListView.builder(
                        itemCount: list.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(15),
                            margin:
                                EdgeInsets.only(top: 20, right: 20, left: 20),
                            decoration: BoxDecoration(
                                color: Constant.bar_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Image(
                                          image:
                                              AssetImage('assets/calander.png'),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 15),
                                            child: Text(
                                              list[index].date,
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  fontFamily:
                                                      Constant.font_name,
                                                  fontSize: Constant
                                                      .subHeadingTextSize),
                                            )),
                                      ],
                                    ),
                                    Visibility(
                                      visible: list[index].image != "",
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Image(
                                          image: FileImage(
                                              File(list[index].image)),
                                          width: imageSizes,
                                          height: imageSizes,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      list[index].text,
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize: Constant.subHeadingTextSize,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      diary = list[index];
                                      print(list[index].image);
                                      print(diary.id);
                                      print(diary.image.toString());
                                      print(diary.text);
                                      print(diary.date);
                                      setState(() {
                                        isDetailScreenShow = true;
                                      });
                                    },
                                    child: Text(
                                      "Mehr lesen",
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize: Constant.HeadingTextSize,
                                          color: Color(0xFF196319)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
            //Add diray
            Visibility(
              visible: isFloatingClick,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 15, bottom: 15),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/edit_calender.png'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Constant.getDate(context).then((picked) => {
                                  if (picked != null)
                                    {
                                      setState(() {
                                        date = Constant.formatTime(
                                                picked.day.toString()) +
                                            "." +
                                            Constant.formatTime(
                                                picked.month.toString()) +
                                            "." +
                                            picked.year.toString();
                                      })
                                    },
                                });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              date == "" ? 'Datum auswählen' : date,
                              style: TextStyle(
                                  fontFamily: Constant.font_name,
                                  fontSize: Constant.HeadingTextSize,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black.withOpacity(0.1),
                      child: TextField(
                        maxLines: 100,
                        controller: medikamentControler,
                        style: TextStyle(
                            fontFamily: Constant.font_name,
                            fontSize: Constant.subHeadingTextSize),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Hier schreiben'),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _image == "",
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowImage = !isShowImage;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                // _pickImage();
                                getImage();
                              },
                              child: Text(
                                "Bild hinzufügen",
                                style: TextStyle(
                                    fontFamily: Constant.font_name,
                                    fontSize: Constant.HeadingTextSize,
                                    color: Color(0xFF196319)),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Visibility(
                        visible: _image != "",
                        child: _image != ""
                            ? Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        File(_image),
                                        width: imageSize,
                                        height: imageSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image = "";
                                      });
                                    },
                                    child: Image(
                                      image: AssetImage('assets/cross.png'),
                                    ),
                                  )
                                ],
                              )
                            : Text(''),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Detail screen
            Visibility(
                visible: isDetailScreenShow,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/calander.png'),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  diary == null ? "" : diary.date,
                                  style: TextStyle(
                                      fontFamily: Constant.font_name,
                                      fontSize: Constant.HeadingTextSize),
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              color: Colors.black.withOpacity(0.1),
                              margin: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                diary == null || diary.text == null
                                    ? ""
                                    : diary.text.trim(),
                                style: TextStyle(
                                    fontSize: Constant.HeadingTextSize,
                                    fontFamily: Constant.font_name,
                                    fontWeight: FontWeight.w400),
                              ))),
                      Visibility(
                        visible: (diary != null && diary.image != ''),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: diary != null && diary.image != null
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewImage(diary.image)));
                                      },
                                      child: Image.file(
                                        File(diary.image),
                                        width: imageSize,
                                        height: imageSize,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Text(""),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
        floatingActionButton: Visibility(
          visible: (!isFloatingClick && !isDetailScreenShow),
          child: FloatingActionButton(
            onPressed: () {
              if (!Constant.isPurchased) {
                Constant.showPremierMessage(context);
                return;
              }

              setState(() {
                isFloatingClick = true;
              });
            },
            child: Image(
              image: AssetImage(
                'assets/add_white.png',
              ),
            ),
            backgroundColor: Color(0xFF196319),
          ),
        ),
      ),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  String _image = "";
  final picker = ImagePicker();

  Future getImage() async {
    Constant.isRequired = false;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile.path;
        Constant.isRequired = true;
      }
    });
  }

  Widget emptyList = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image(
          image: AssetImage(
        'assets/book.png',
      )),
      Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "Du hast noch keinen Eintrag in deinem Tagebuch. Tippe auf den “+”-Button rechts unten um einen Eintrag anzulegen.",
            style: TextStyle(fontFamily: Constant.font_name),
            textAlign: TextAlign.center,
          ))
    ],
  );

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Löschen"),
      onPressed: () {
        CustomDB.instance.deleteDiary(diary.id).then((value) => {
              Navigator.pop(context),
              list.remove(diary),
              setState(() {
                isDetailScreenShow = false;
              })
            });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Löschen"),
      content: Text("Möchten Sie wirklich diesen Eintrag löschen?"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void load() {
    list.clear();
    CustomDB.instance.getDiary().then((value) => {
          value.sort((a, b) {
            DateTime aDate = DateTime.parse(a.date.split(".")[2] +
                "-" +
                a.date.split(".")[1] +
                "-" +
                a.date.split(".")[0] +
                ' 00:00:00.000');
            DateTime bDate = DateTime.parse(b.date.split(".")[2] +
                "-" +
                b.date.split(".")[1] +
                "-" +
                b.date.split(".")[0] +
                ' 00:00:00.000');

            // return aDate.compareTo(bDate);
            return bDate.compareTo(aDate);
          }),
          setState(() {
            list.addAll(value);
          })
        });
  }
}
