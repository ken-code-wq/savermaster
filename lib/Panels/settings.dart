// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

var utils = Hive.box('futils');
List colorsName = [
  "Red",
  "Blue",
  "Teal",
  "Yellow",
  "Pink",
  "Amber",
  "Brown",
  "Cyan",
  "Purple",
  "Green",
  "Orange"
];
List emojiList = [
  "😀",
  "😁",
  "🤣",
  "😃",
  "😅",
  "😉",
  "😊",
  "😎",
  "😋",
  "🥰",
  "🙂",
  "🤗",
  "🤩",
  "😐",
  "😶",
  "😏",
  "🤐",
  "😜",
  "🙃",
  "🤑",
  "🤯",
  "🥶",
  "🥵",
  "😷",
  "🤒",
  "🤢",
  "🤮",
  "🤫",
  "🍤",
  "🍣",
  "🍚",
  "🍛",
  "🎂",
  "🍾",
  "🍷",
  "🍺",
  "🍇",
  "🌹",
  "🏍",
  "🪂",
  "✈",
  "🚀",
  "🏴‍☠️",
  "🗻",
  "🌋",
  "🕋",
  "🔥",
  "💧",
  "❄",
  "🌊",
  "⚡",
  "⛱",
  "💯",
  "💲",
  "💩",
  "🏎",
  "🤖",
  "🐱‍👤",
  "🦁",
  "🐱",
  "🐹",
  "🦊",
  "🐲",
  "🐔",
  "🦄",
  "🦮",
  "🐕‍🦺",
  "🐩",
  "🐕",
  "🐈",
  "🐅",
  "🐆",
  "🐎",
  "🦆",
  "🐓",
  "🦃",
  "🦅",
  "👅",
  "👄",
  "🧠",
  "🎈",
  "🎇",
  "✨",
  "🎨",
  "🎭",
  "🎁",
  "🎀",
  "🎞",
  "🎟",
  "🎠",
  "🧶",
  "👗",
  "🥽",
  "👞",
  "🥾",
  "💋",
  "🎓",
  "💄",
  "💍",
  "💎",
  "⚽",
  "🏀",
  "⛸",
  "⛳",
  "🏓",
  "🎯",
  "🏆",
  "🥇",
  "🥋",
  "🎮",
  "🎼",
  "♥",
  "🎹",
  "🎺",
  "🩸",
  "💉",
  "🍕",
  "🍟",
  "🍔",
  "🌭",
  "🍿",
  "🚗",
  "🚓",
  "🦽",
  "🚍",
  "🚲",
  "🛴",
  "🛵",
  "🌟",
  "🌕"
];
List colorsBox = [
  Colors.red,
  Colors.blue,
  Colors.teal,
  Colors.yellow,
  Colors.pink,
  Colors.amber,
  Colors.brown,
  Colors.cyan,
  Colors.deepPurple,
  Colors.green,
  Colors.orange,
];
List backgroundColors = [
  Colors.blueGrey.shade900,
  Colors.blue.shade900,
  Colors.cyan.shade900,
  Colors.brown.shade900,
  Colors.deepPurple.shade900,
  Colors.green.shade900,
  Colors.grey.shade900,
  Colors.pink.shade900,
  Colors.yellow.shade900,
];
String name = "";
int currentEmoji = 0;
int currentColor = 0;

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    bool isReady = utils.isNotEmpty;
    TextEditingController username = TextEditingController();
    update() {
      currentEmoji = utils.getAt(0)[2];
      currentColor = utils.getAt(0)[1];
    }

    @override
    void initState() {
      super.initState();
      update();
    }

    return Scaffold(
      backgroundColor: colorsBox[currentColor].shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              width: width,
              // color: Colors.red,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: (height * 0.1),
                      backgroundColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                          child: CircleAvatar(
                            radius: height * 0.1,
                            backgroundColor: colorsBox[currentColor],
                            child: Center(
                              child: Text(
                                emojiList[currentEmoji],
                                style: TextStyle(fontSize: 65),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "@$name",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade800,
                        fontFamily: 'HelveticaRoundedBold'),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: height,
                        width: width,
                        color: Colors.grey.shade900,
                        child: ListView.builder(
                            itemCount: colorsBox.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    currentColor = index;
                                    Navigator.pop(context);
                                  });
                                },
                                trailing: Icon(
                                    index == currentColor
                                        ? Icons.brush_outlined
                                        : null,
                                    color: Colors.white),
                                leading: CircleAvatar(
                                    backgroundColor: colorsBox[index],
                                    radius: 15),
                                title: Text(
                                  colorsName[index],
                                  style: TextStyle(
                                    fontFamily: 'HelveticaRoundedBold',
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            })),
                      );
                    });
              },
              trailing: Icon(CupertinoIcons.burst, color: Colors.grey.shade900),
              leading: CircleAvatar(
                  backgroundColor: colorsBox[currentColor], radius: 15),
              title: Text(
                "Select Color",
                style: TextStyle(
                  fontFamily: 'HelveticaRoundedBold',
                  color: Colors.grey.shade900,
                ),
              ),
              subtitle: Text(
                "Current color: ${colorsName[currentColor]}",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.emoji_emotions_sharp,
                color: Colors.grey.shade900,
              ),
              title: Text(
                "Select emoji",
                style: TextStyle(
                  fontFamily: 'HelveticaRoundedBold',
                  color: Colors.grey.shade900,
                ),
              ),
              leading: Text(
                emojiList[currentEmoji],
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: height,
                        width: width,
                        color: Colors.grey.shade900,
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 6,
                            children: List.generate(
                              emojiList.length,
                              (index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    currentEmoji = index;
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(emojiList[index],
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.person_4,
                color: Colors.grey.shade900,
              ),
              title: Text(
                "Change username",
                style: TextStyle(
                  fontFamily: 'HelveticaRoundedBold',
                  color: Colors.grey.shade900,
                ),
              ),
              subtitle: Text(
                "Current username: ${utils.getAt(0)[0]}",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.1, vertical: height * 0.35),
                        decoration: BoxDecoration(
                          color: colorsBox[
                                  isReady ? utils.getAt(0)[1] : currentColor]
                              .shade900
                              .withOpacity(.9),
                          borderRadius: BorderRadius.circular(
                            18,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              TextField(
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                controller: username,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  hintText: "Enter your username",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                      color: colorsBox[isReady
                                              ? utils.getAt(0)[1]
                                              : currentColor]
                                          .shade900,
                                      shape: StadiumBorder(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 10),
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      //TODO
                                      onPressed: () {
                                        setState(() {
                                          name = username.text.trim();
                                          Navigator.pop(context);
                                        });
                                      }),
                                  MaterialButton(
                                      color: Colors.red.shade900,
                                      shape: StadiumBorder(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 10),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      //TODO
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            utils.putAt(0, [name, currentColor, currentEmoji]);
            print(utils.values);
            Navigator.pop(context);
          });
        },
        backgroundColor: colorsBox[currentColor].shade900.withOpacity(.9),
        child: Icon(
          Icons.save_as,
          color: Colors.white,
        ),
      ),
    );
  }
}
