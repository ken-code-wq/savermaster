// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, unused_local_variable, prefer_final_fields, no_leading_underscores_for_local_identifiers
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:susu/Panels/settings.dart';

import 'Panels/savingsPage.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mfBox');
  var allAmount = await Hive.openBox('gfBox');
  var utils = await Hive.openBox('futils');
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

List tabNames = ['Wallet', 'Savings Goals', 'Analytics', 'Preferences'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Save Master',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

TextStyle headerBig = TextStyle(
    color: Colors.white, fontFamily: 'HelveticaRoundedBold', fontSize: 18);
TextStyle headerMedium = TextStyle(
    color: Colors.grey.shade300,
    fontFamily: 'HelveticaRoundedBold',
    fontSize: 14);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String _selectedItem = 'Option 1';
int currentPage = 0;
int currentColor = 0;
int currentEmoji = 0;
int currentGoal = 0;
List selectedGoal = [];
bool warning = false;
num savingsBoxSumToNow = 0;
int currentColorTheme = 0;
int currentEmojiIndex = 0;
String currentItem = '0';
bool refresh = false;

class _MyHomePageState extends State<MyHomePage> {
  int goalIndex = 0;
  var moneyBox = Hive.box('mfBox');
  var utils = Hive.box('futils');
  var savingsBox = Hive.box('gfBox');
  List colorsBox = [
    Colors.red,
    Colors.blue,
    Colors.teal,
    Colors.yellow,
    Colors.pink,
    Colors.amber,
    Colors.brown,
    Colors.cyan,
    // Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    // Colors.grey,
    // Colors.indigo,
    // Colors.lightBlue,
    // Colors.lightGreen,
    // Colors.lime,
    Colors.orange,
    // Colors.purple,
  ];
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
  List backgroundColorsName = [
    "Blue grey",
    "Blue",
    "Cyan",
    "Brown",
    "Deep purple",
    "Green",
    "Grey",
    "Pink",
    "Yellow",
  ];
  PanelController _panelControllerAdd = PanelController();
  TextEditingController _textCon = TextEditingController();
  TextEditingController goalName = TextEditingController();
  TextEditingController goalTarget = TextEditingController();
  bool isUp = false;
  List<double> data = [];
  List<double> initData = [];
  @override
  Widget build(BuildContext context) {
    num moneyInv = 0;
    List invMade = [];
    num nowAmount = 0;
    double currentEmojiL = 0;
    num totalYet = 0;
    int checkControl = 0;
    List savings = [];
    String goalNameStr = "Select your goal";
    List initGoals = [];
    List profile = [];
    // moneyBox.add([16, 9, "hh"]);
    // print(moneyBox.values);
    updateColor(index) {
      setState(() {
        currentColor = index;
      });
    }

    updateEmoji(index) {
      setState(() {
        currentEmoji = index;
        currentEmojiL = index.toDouble();
      });
    }

    addAbbrv(double money) {
      if (money >= 1000000000000) {
        return ("${(money / 1000000000000).toDouble()}T");
      }
      if (money >= 1000000000) {
        return ("${(money / 1000000000).toDouble()}B");
      }
      if (money >= 1000000) {
        return ("${(money / 1000000).toDouble()}M");
      }
      if (money >= 1000) {
        return ("${(money / 1000).toDouble()}K");
      }
    }

    updater(bool analytics, int checks) {
      for (int i = 0; i < moneyBox.length; i++) {
        if (moneyBox.length > 0) {
          moneyInv = moneyInv + (moneyBox.getAt(i)[0]);
          invMade.add(moneyBox.getAt(i));
        }
      }
      setState(() {});
    }

    analyticsUpdater() {
      data.clear();
      if (moneyBox.length > 0) {
        for (int i = 0; i < moneyBox.length; i++) {
          totalYet = totalYet + (moneyBox.getAt(i)[0]);
          initData.add(totalYet.toDouble());
        }
      }
      if (data.length != initData.length) {
        data.addAll(initData);
      }
      totalYet = 0;
      initData.clear();
    }

    nameprofileUpdater() {
      profile.clear();
      if (utils.isNotEmpty) {
        profile.add(utils.getAt(0));
        currentColorTheme = utils.getAt(1);
        setState(() {});
      }
      if (utils.isEmpty) {
        utils.add(["username", 0, 0]);
        utils.add(0);
        currentColorTheme = utils.getAt(1);
        setState(() {});
      }
    }

    @override
    void initState() {
      super.initState();

      nameprofileUpdater();
    }

    updater(true, checkControl == 0 ? 0 : 0);
    analyticsUpdater();
    if (savingsBox.length > 0) {
      selectedGoal.addAll(savingsBox.getAt(currentGoal));
    } else {
      null;
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double incPercntage = moneyBox.length > 1
        ? ((moneyBox.getAt(moneyBox.length - 1)[0] /
                (moneyInv - moneyBox.getAt(moneyBox.length - 1)[0])) *
            10000)
        : moneyBox.length == 1
            ? 10000
            : 0;
    // double incPercntage = 2.0;
    print(utils.values);
    nameprofileUpdater();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
          backgroundColor: backgroundColors[currentColorTheme],
          appBar: AppBar(
            backgroundColor: backgroundColors[currentColorTheme],
            elevation: 0.0,
          ),
          body: SlidingUpPanel(
            minHeight: 0,
            defaultPanelState: PanelState.CLOSED,
            maxHeight: height,
            controller: _panelControllerAdd,
            color: Colors.transparent,
            panel: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                ),
                // color: Colors.amber,
                color: Colors.blueGrey.shade900,
              ),
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 7,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textCon,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'HelveticaRoundedBold',
                            color: Colors.white),
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'HelveticaRoundedBold',
                            color: Colors.white,
                          ),
                          hintText: 'Enter amount',
                          icon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.12,
                      width: width,
                      child: ListView.builder(
                        // physics: FixedExtentScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            savingsBox.length == 0 ? 1 : savingsBox.length,
                        itemBuilder: ((context, index) {
                          return savingsBox.length == 0
                              ? InkWell(
                                  // onTap: () {
                                  //   showCupertinoDialog(
                                  //       barrierDismissible: true,
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return Container(
                                  //           padding: EdgeInsets.symmetric(
                                  //               horizontal: 6),
                                  //           margin: EdgeInsets.symmetric(
                                  //               horizontal: width * 0.1,
                                  //               vertical: height * 0.25),
                                  //           decoration: BoxDecoration(
                                  //             color: Colors.blueGrey.shade900,
                                  //             borderRadius:
                                  //                 BorderRadius.circular(
                                  //               18,
                                  //             ),
                                  //           ),
                                  //           child: Material(
                                  //             color: Colors.transparent,
                                  //             child: Column(
                                  //               children: [
                                  //                 SizedBox(height: 15),
                                  //                 TextField(
                                  //                   style: TextStyle(
                                  //                     fontSize: 15,
                                  //                     fontWeight:
                                  //                         FontWeight.w600,
                                  //                     color: Colors.white,
                                  //                   ),
                                  //                   controller: goalName,
                                  //                   decoration: InputDecoration(
                                  //                     enabledBorder:
                                  //                         OutlineInputBorder(
                                  //                       borderSide: BorderSide(
                                  //                           color:
                                  //                               Colors.white),
                                  //                     ),
                                  //                     labelStyle: TextStyle(
                                  //                       fontSize: 15,
                                  //                       fontWeight:
                                  //                           FontWeight.w600,
                                  //                       color: Colors.white,
                                  //                     ),
                                  //                     hintText:
                                  //                         "Enter goal name",
                                  //                     hintStyle: TextStyle(
                                  //                       fontSize: 15,
                                  //                       fontWeight:
                                  //                           FontWeight.w600,
                                  //                       color: Colors.white,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 15,
                                  //                 ),
                                  //                 TextField(
                                  //                   style: TextStyle(
                                  //                     fontSize: 17,
                                  //                     fontWeight:
                                  //                         FontWeight.w600,
                                  //                     color: Colors.white,
                                  //                   ),
                                  //                   controller: goalTarget,
                                  //                   decoration: InputDecoration(
                                  //                     enabledBorder:
                                  //                         OutlineInputBorder(
                                  //                       borderSide: BorderSide(
                                  //                           color: Colors
                                  //                               .grey.shade400),
                                  //                     ),
                                  //                     labelStyle: TextStyle(
                                  //                       fontSize: 15,
                                  //                       fontWeight:
                                  //                           FontWeight.w600,
                                  //                       color: Colors.white,
                                  //                     ),
                                  //                     hintStyle: TextStyle(
                                  //                       fontSize: 15,
                                  //                       fontWeight:
                                  //                           FontWeight.w600,
                                  //                       color: Colors.white,
                                  //                     ),
                                  //                     hintText: "Enter goal",
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 20,
                                  //                 ),
                                  //                 ListTile(
                                  //                   onTap: () {
                                  //                     showModalBottomSheet(
                                  //                         context: context,
                                  //                         builder: (context) {
                                  //                           return Container(
                                  //                             height: height,
                                  //                             width: width,
                                  //                             color: Colors.grey
                                  //                                 .shade900,
                                  //                             child: ListView
                                  //                                 .builder(
                                  //                                     itemCount:
                                  //                                         colorsBox
                                  //                                             .length,
                                  //                                     itemBuilder:
                                  //                                         ((context,
                                  //                                             index) {
                                  //                                       return ListTile(
                                  //                                         onTap:
                                  //                                             () {
                                  //                                           setState(() {
                                  //                                             currentColor = index;
                                  //                                             Navigator.pop(context);
                                  //                                           });
                                  //                                         },
                                  //                                         trailing: Icon(
                                  //                                             index == currentColor ? Icons.brush_outlined : null,
                                  //                                             color: Colors.white),
                                  //                                         leading: CircleAvatar(
                                  //                                             backgroundColor: colorsBox[index],
                                  //                                             radius: 15),
                                  //                                         title:
                                  //                                             Text(
                                  //                                           colorsName[index],
                                  //                                           style:
                                  //                                               TextStyle(
                                  //                                             fontFamily: 'HelveticaRoundedBold',
                                  //                                             color: Colors.white,
                                  //                                           ),
                                  //                                         ),
                                  //                                       );
                                  //                                     })),
                                  //                           );
                                  //                         });
                                  //                   },
                                  //                   trailing: Icon(
                                  //                       CupertinoIcons.burst,
                                  //                       color: Colors.white),
                                  //                   leading: CircleAvatar(
                                  //                       backgroundColor:
                                  //                           colorsBox[
                                  //                               currentColor],
                                  //                       radius: 15),
                                  //                   title: Text(
                                  //                     "Select Color",
                                  //                     style: TextStyle(
                                  //                       fontFamily:
                                  //                           'HelveticaRoundedBold',
                                  //                       color: Colors.white,
                                  //                     ),
                                  //                   ),
                                  //                   subtitle: Text(
                                  //                     "Current color: ${colorsName[currentColor]}",
                                  //                     style: TextStyle(
                                  //                       color: Colors
                                  //                           .grey.shade400,
                                  //                       fontWeight:
                                  //                           FontWeight.w600,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 ListTile(
                                  //                   title: Text(
                                  //                     "Select emoji",
                                  //                     style: TextStyle(
                                  //                       fontFamily:
                                  //                           'HelveticaRoundedBold',
                                  //                       color: Colors.white,
                                  //                     ),
                                  //                   ),
                                  //                   leading: Text(
                                  //                     emojiList[currentEmoji],
                                  //                     style: TextStyle(
                                  //                         fontSize: 25),
                                  //                   ),
                                  //                   onTap: () {
                                  //                     showModalBottomSheet(
                                  //                         context: context,
                                  //                         builder: (context) {
                                  //                           return Container(
                                  //                             height: height,
                                  //                             width: width,
                                  //                             color: Colors.grey
                                  //                                 .shade900,
                                  //                             child:
                                  //                                 SingleChildScrollView(
                                  //                               child: Wrap(
                                  //                                 spacing: 4,
                                  //                                 runSpacing: 6,
                                  //                                 children: List
                                  //                                     .generate(
                                  //                                   emojiList
                                  //                                       .length,
                                  //                                   (index) =>
                                  //                                       InkWell(
                                  //                                     onTap:
                                  //                                         () {
                                  //                                       setState(
                                  //                                           () {
                                  //                                         currentEmoji =
                                  //                                             index;
                                  //                                         Navigator.pop(
                                  //                                             context);
                                  //                                       });
                                  //                                     },
                                  //                                     child:
                                  //                                         Container(
                                  //                                       padding:
                                  //                                           EdgeInsets.all(4),
                                  //                                       child: Text(
                                  //                                           emojiList[
                                  //                                               index],
                                  //                                           style:
                                  //                                               TextStyle(fontSize: 25)),
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           );
                                  //                         });
                                  //                   },
                                  //                 ),
                                  //                 MaterialButton(
                                  //                     color: Colors
                                  //                         .blueGrey.shade700,
                                  //                     shape: StadiumBorder(),
                                  //                     child: Padding(
                                  //                       padding: EdgeInsets
                                  //                           .symmetric(
                                  //                               horizontal:
                                  //                                   18.0,
                                  //                               vertical: 10),
                                  //                       child: Text(
                                  //                         "Done",
                                  //                         style: TextStyle(
                                  //                           fontSize: 15,
                                  //                           fontWeight:
                                  //                               FontWeight.w600,
                                  //                           color: Colors.white,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     //TODO
                                  //                     onPressed: () {
                                  //                       setState(() {
                                  //                         savingsBox.add([
                                  //                           goalName.text
                                  //                               .trim(),
                                  //                           double.parse(
                                  //                               goalTarget.text
                                  //                                   .trim()),
                                  //                           currentColor,
                                  //                           currentEmoji,
                                  //                           [0],
                                  //                         ]);
                                  //                         goalName.clear();
                                  //                         goalTarget.clear();
                                  //                         goalNameStr = goalName
                                  //                             .text
                                  //                             .trim();
                                  //                         Navigator.pop(
                                  //                             context);
                                  //                       });
                                  //                     }),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         );
                                  //       });
                                  // },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: width * 0.1),
                                    width: width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.grey.shade800,
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons.add,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Add a new goal",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily:
                                                  'HelveticaRoundedBold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedGoal.clear();
                                      currentGoal = index;
                                      selectedGoal.addAll(
                                          savingsBox.getAt(currentGoal));
                                      // print(selectedGoal);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 3),
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: index == currentGoal
                                          ? colorsBox[
                                                  savingsBox.getAt(index)[2]]
                                              .shade500
                                              .withOpacity(.83)
                                          : Colors.transparent,
                                    ),
                                    child: Container(
                                      // padding: EdgeInsets.symmetric(
                                      //     vertical: 3, horizontal: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.grey.shade900,
                                      ),
                                      //TODO:
                                      child: Container(
                                        // margin:
                                        //     EdgeInsets.only(left: 4.5, right: 7.5),
                                        padding: EdgeInsets.all(4),
                                        // height: height * 0.1,
                                        width: width * 0.84,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: colorsBox[
                                                  savingsBox.getAt(index)[2]]
                                              // .shade900
                                              .withOpacity(.23),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: width * 0.2,
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: colorsBox[savingsBox
                                                        .getAt(index)[2]]
                                                    .shade300
                                                    .withOpacity(.83),
                                              ),
                                              child: Center(
                                                child: Text(
                                                    emojiList[savingsBox
                                                        .getAt(index)[3]],
                                                    style:
                                                        TextStyle(fontSize: 25),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ),
                                            SizedBox(
                                              // color: Colors.green,
                                              width: width * 0.6,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: width * 0.58,
                                                          // color: Colors.green,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: width *
                                                                      0.4,
                                                                  child: Text(
                                                                    savingsBox
                                                                        .getAt(
                                                                            index)[0],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          'HelveticaRoundedBold',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "\$${savingsBox.getAt(index)[1] >= 1000 ? addAbbrv(savingsBox.getAt(index)[1]) : savingsBox.getAt(index)[1]}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 7.5),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: SizedBox(
                                                                width: width *
                                                                    0.53,
                                                                child: Text(
                                                                  "${savingsBox.getAt(index)[3]}% done!",
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'HelveticaRoundedBold',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.53,
                                                              child:
                                                                  CurvedLinearProgressIndicator(
                                                                value: 0.29,
                                                                strokeWidth: 5,
                                                                backgroundColor:
                                                                    Colors
                                                                        .blueGrey
                                                                        .shade600,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(7.5),
                      margin: EdgeInsets.all(7.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white, width: 1.3),
                      ),
                      // height: height * 0.6,
                      child: Column(
                        children: [
                          Text(
                            "Create a new goal",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'HelveticaRoundedBold',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              controller: goalName,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                hintText: "Enter goal name",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: goalTarget,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade400,
                                ),
                                hintText: "Enter goal",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                                  updateColor(index);
                                                  Navigator.pop(context);
                                                });
                                              },
                                              trailing: Icon(
                                                  index == currentColor
                                                      ? Icons.brush_outlined
                                                      : null,
                                                  color: Colors.white),
                                              leading: CircleAvatar(
                                                  backgroundColor:
                                                      colorsBox[index],
                                                  radius: 15),
                                              title: Text(
                                                colorsName[index],
                                                style: TextStyle(
                                                  fontFamily:
                                                      'HelveticaRoundedBold',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          })),
                                    );
                                  });
                            },
                            trailing:
                                Icon(CupertinoIcons.burst, color: Colors.white),
                            leading: CircleAvatar(
                                backgroundColor: colorsBox[currentColor],
                                radius: 15),
                            title: Text(
                              "Select Color",
                              style: TextStyle(
                                fontFamily: 'HelveticaRoundedBold',
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "Current color: ${colorsName[currentColor]}",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Select emoji",
                              style: TextStyle(
                                fontFamily: 'HelveticaRoundedBold',
                                color: Colors.white,
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
                                                  updateEmoji(index);
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                child: Text(emojiList[index],
                                                    style: TextStyle(
                                                        fontSize: 25)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                  color: Colors.blueGrey.shade700,
                                  shape: StadiumBorder(),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 10),
                                    child: Text(
                                      "Create goal",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      goalName.text.isEmpty
                                          ? warning = !warning
                                          : goalTarget.text.isEmpty
                                              ? warning = !warning
                                              : savingsBox.add([
                                                  goalName.text.trim(),
                                                  double.parse(
                                                      goalTarget.text.trim()),
                                                  currentColor,
                                                  currentEmoji,
                                                  [0]
                                                ]);
                                      goalName.clear();
                                      selectedGoal.clear();
                                      goalTarget.clear();
                                    });
                                  }),
                              SizedBox(width: 15),
                              MaterialButton(
                                color: Colors.grey.shade800,
                                onPressed: () {
                                  setState(() {
                                    currentColor = 0;
                                    goalName.clear();
                                    goalTarget.clear();
                                  });
                                },
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
                              ),
                              warning
                                  ? Text(
                                      warning
                                          ? "Please add the goal name and target"
                                          : "",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    MaterialButton(
                      animationDuration: Duration(milliseconds: 500),
                      shape: StadiumBorder(),
                      color: savingsBox.length > 0
                          ? colorsBox[savingsBox.getAt(currentGoal)[2]]
                              .shade800
                              .withOpacity(.53)
                          : Colors.blueGrey.shade800,
                      onPressed: () {
                        moneyBox.add([
                          double.parse(_textCon.text.trim()),
                          currentGoal,
                        ]);
                        selectedGoal.clear();
                        selectedGoal.addAll(savingsBox.getAt(currentGoal));
                        selectedGoal[4].add(int.parse(_textCon.text.trim()));
                        // print(selectedGoal[4]);
                        savingsBox.putAt(currentGoal, [
                          selectedGoal[0], //Name
                          selectedGoal[1], //Target
                          selectedGoal[2], //Color
                          selectedGoal[3], //Emoji
                          selectedGoal[4], //All deposits
                        ]);
                        // print(savingsBox.getAt(currentGoal));
//TODO
                        setState(() {
                          // updater(true, checkControl);
                          // analyticsUpdater();
                          _panelControllerAdd.close();
                          isUp = !isUp;
                          _textCon.clear();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: SlidingUpPanel(
              color: Colors.transparent,
              minHeight: currentPage == 0
                  ? height * 0.67
                  : currentPage == 2
                      ? height * 0.31
                      : currentPage == 1
                          ? height * 0.0
                          : currentPage == 3
                              ? height * 0.0
                              : height * 0.6,
              maxHeight: height * 1,
              panel: Container(
                  height: height * .81,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                    ),
                    color: Colors.white,
                  ),
                  width: width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.083,
                            horizontal: height * 0.007),
                        child: CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.only(top: height * 0.04),
                                child: Container(
                                  height: 0.169,
                                  width: width * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey.shade500),
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: invMade.length,
                                (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15.0, left: 8, right: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onLongPress: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: height * 0.1,
                                                      width: height * .1,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: colorsBox[savingsBox
                                                                  .getAt(moneyBox
                                                                      .getAt(moneyBox
                                                                              .length -
                                                                          1 -
                                                                          index)[1])[2]]
                                                              .shade500
                                                              .withOpacity(.83)),
                                                    ),
                                                    SizedBox(height: 16),
                                                    Container(
                                                      width: width,
                                                      height: height * 0.5 - 44,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 12),
                                                      decoration: BoxDecoration(
                                                          // border: Border(
                                                          //     top: BorderSide(
                                                          //         color: Colors
                                                          //             .red,
                                                          //         width: 2)),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          32),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          32)),
                                                          color: Colors
                                                              .grey.shade900),
                                                      child: ListView(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                    savingsBox.getAt(moneyBox.getAt(moneyBox.length -
                                                                            1 -
                                                                            index)[
                                                                        1])[0],
                                                                    style:
                                                                        headerBig),
                                                                subtitle: Text(
                                                                    "Goal Name",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                    savingsBox
                                                                        .getAt(moneyBox.getAt(
                                                                            moneyBox.length -
                                                                                1 -
                                                                                index)[1])[
                                                                            1]
                                                                        .toString(),
                                                                    style:
                                                                        headerBig),
                                                                subtitle: Text(
                                                                    "Goal Target",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                    "16.4 %",
                                                                    style:
                                                                        headerBig),
                                                                subtitle: Text(
                                                                    "% Done",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ),
                                                              ListTile(
                                                                title: Text(
                                                                    "${((((26.9 * 1000) * 0.164) / 100).round()) / 10}K",
                                                                    style:
                                                                        headerBig),
                                                                subtitle: Text(
                                                                    "Amount Saved",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 20),
                                                          Container(
                                                              height:
                                                                  height * 0.4,
                                                              width:
                                                                  height * 0.4,
                                                              color: Colors
                                                                  .deepPurple
                                                                  .shade900),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          // width: width,
                                          padding: EdgeInsets.all(15),
                                          alignment: Alignment.center,
                                          // margin: EdgeInsets.symmetric(
                                          //     horizontal: width * 0.05 - 16),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey.shade800,
                                            borderRadius:
                                                BorderRadius.circular(19),
                                          ),
                                          height: height * 0.152,
                                          width: width - 16 - height * 0.0144,
                                          child: invMade.isEmpty
                                              ? null
                                              : Row(
                                                  children: [
                                                    Container(
                                                      height: height * 0.152,
                                                      width: 7.5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        color: colorsBox[savingsBox
                                                                .getAt(moneyBox
                                                                    .getAt(moneyBox
                                                                            .length -
                                                                        1 -
                                                                        index)[1])[2]]
                                                            .shade500
                                                            .withOpacity(.83),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            CupertinoIcons
                                                                .money_dollar_circle_fill,
                                                            color: Colors
                                                                .blueGrey
                                                                .shade100),
                                                        SizedBox(width: 7.55),
                                                        Text(
                                                          invMade[invMade
                                                                      .length -
                                                                  1 -
                                                                  index][0]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'HelveticaRoundedBold',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15),
                                child: Container(
                                  height: height * 0.32,
                                  width: width * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.12,
                        width: width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Colors.white.withOpacity(.95),
                                Colors.white.withOpacity(.85),
                                Colors.white.withOpacity(.75),
                                Colors.white.withOpacity(.65),
                                Colors.white.withOpacity(.55),
                                Colors.white.withOpacity(.45),
                                Colors.white.withOpacity(.35),
                                Colors.white.withOpacity(.25),
                                Colors.white.withOpacity(.15),
                                Colors.white.withOpacity(.1)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(21),
                            topRight: Radius.circular(21),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: width * 0.225),
                              child: Container(
                                height: 4,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.grey.shade500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Investments made",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'HelveticaRoundedBold'),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              body: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: backgroundColors[currentColorTheme],
                    expandedHeight: height * 0.1,
                    titleSpacing: 0,
                    centerTitle: true,
                    title: Container(
                      color: backgroundColors[currentColorTheme],
                      width: width,
                      height: height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: colorsBox[
                                      profile.isNotEmpty ? profile[0][1] : 0],
                                  child: Text(
                                    emojiList[
                                        profile.isNotEmpty ? profile[0][2] : 0],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'HelveticaRoundedBold',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      profile.isNotEmpty
                                          ? profile[0][0]
                                          : "username",
                                      style: TextStyle(
                                        color: Colors.grey.shade100,
                                        fontFamily: 'HelveticaRoundedBold',
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              icon: Icon(Icons.settings, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  refresh = true;
                                });
                                print(refresh);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SettingsPage()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: width,
                      height: height * 0.82,
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.054,
                            color: backgroundColors[currentColorTheme],
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentPage = index;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: currentPage == index
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 3.7, vertical: 5),
                                      // height: height * 0.05,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: .5),
                                      child: Text(
                                        tabNames[index],
                                        style: TextStyle(
                                            color: currentPage == index
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'HelveticaRoundedBold'),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          currentPage == 0
                              ? wallet(moneyInv, incPercntage, height, width)
                              : currentPage == 2
                                  ? analytics(
                                      _selectedItem, width, height, data)
                                  : currentPage == 1
                                      ? savingGoals(height, width, savings)
                                      : currentPage == 3
                                          ? preferences(height, width)
                                          : wallet(moneyInv, incPercntage,
                                              height, width),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: InkWell(
            onTap: () {
              refresh = false;
              setState(() {});
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              height: height * 0.06,
              width: !refresh ? height * 0.06 : height * 0.18,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                color:
                    refresh ? Colors.blue : backgroundColors[currentColorTheme],
                borderRadius: BorderRadius.circular(32),
              ),
              child: refresh
                  ? Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              refresh = false;
                              setState(() {});
                            },
                            icon: Icon(Icons.refresh, color: Colors.white)),
                        Text("Refresh",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    )
                  : !isUp
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isUp = !isUp;
                              _textCon.clear();
                              _panelControllerAdd.open();
                            });
                          },
                          icon: Icon(Icons.add, color: Colors.white))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              isUp = !isUp;
                              _textCon.clear();
                              _panelControllerAdd.close();
                            });
                          },
                          icon: Icon(CupertinoIcons.clear, color: Colors.white),
                        ),
            ),
          )
          // FloatingActionButton(
          //   backgroundColor: !isUp
          //       ? Colors.white
          //       : isUp
          //           ? Colors.redAccent
          //           : null,
          //   onPressed: () {
          //   },
          //   child: isUp
          //       ? Icon(
          //           CupertinoIcons.clear_thick,
          //           color: Colors.white,
          //         )
          //       : isUp == false
          //           ? Icon(
          //               Icons.add,
          //               color: Colors.blueGrey.shade800,
          //             )
          // : null,
          // ),
          ),
    );
  }

  Widget savingGoals(height, width, List savings) {
    // var abbrv = "";
    addAbbrv(double money) {
      if (money >= 1000000000000) {
        return ("${(money / 1000000000000).toDouble()}T");
      }
      if (money >= 1000000000) {
        return ("${(money / 1000000000).toDouble()}B");
      }
      if (money >= 1000000) {
        return ("${(money / 1000000).toDouble()}M");
      }
      if (money >= 1000) {
        return ("${(money / 1000).toDouble()}K");
      }
      if (money < 100) {
        return money;
      }
    }

    return Expanded(
      child: Container(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: savingsBox.length, (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.25),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return SavingsPage(
                          colorsBox: colorsBox,
                          emojiList: emojiList,
                          index: index,
                          savingsBox: savingsBox,
                        );
                      })));
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 4.25),
                      height: height * 0.152,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        color: colorsBox[savingsBox.getAt(index)[2]]
                            .shade900
                            .withOpacity(.73),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Hero(
                            tag: index,
                            child: Container(
                              width: height * .152,
                              height: height * 0.152,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: colorsBox[savingsBox.getAt(index)[2]]
                                    .shade500
                                    .withOpacity(.83),
                              ),
                              child: Center(
                                child: Text(
                                  emojiList[savingsBox.getAt(index)[3]],
                                  style: TextStyle(
                                    fontSize: 50,
                                    // fontFamily: 'HelveticaRoundedBold',
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // color: Colors.lightGreen,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height * 0.055,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          savingsBox.getAt(index)[0],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily:
                                                  'HelveticaRoundedBold',
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.green,
                                    height: height * 0.055,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Target Amount: \$${savingsBox.getAt(index)[1] >= 1000 ? addAbbrv(savingsBox.getAt(index)[1]) : savingsBox.getAt(index)[1]}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  'HelveticaRoundedBold',
                                              color: Colors.grey.shade300
                                                  .withOpacity(.73)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget preferences(height, width) {
    return Column(
      children: [
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
                        itemCount: backgroundColors.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                currentColorTheme = index;
                                utils.putAt(1, currentColorTheme);
                                Navigator.pop(context);
                              });
                            },
                            trailing: Icon(
                                index == currentColorTheme
                                    ? Icons.brush_outlined
                                    : null,
                                color: Colors.white),
                            leading: CircleAvatar(
                                backgroundColor: backgroundColors[index],
                                radius: 15),
                            title: Text(
                              backgroundColorsName[index],
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
          leading: Icon(CupertinoIcons.moon_fill, color: Colors.grey.shade200),
          title: Text(
            "Change App theme",
            style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 18,
                fontFamily: 'HelveticaRoundedBold'),
          ),
          subtitle: Text(
            "Current theme:",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: CircleAvatar(
            radius: 17,
            backgroundColor: colorsBox[utils.getAt(0)[1]],
            child: Center(
              child: CircleAvatar(
                radius: 15,
                backgroundColor: backgroundColors[currentColorTheme],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget analytics(_selectedItem, width, height, List<double> data) {
    return Column(
      children: [
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(8),
          height: height * 0.4,
          width: width,
          child: Sparkline(
            pointColor: backgroundColors[currentColorTheme],
            gridLineColor: Colors.white,
            gridLineWidth: 1.2,
            gridLineLabelColor: Colors.white,
            lineColor: Colors.white.withOpacity(.8),
            enableGridLines: true,
            averageLine: true,
            gridLinelabelPrefix: "    \$ ",
            lineWidth: 8,
            data: data,
            useCubicSmoothing: true,
            cubicSmoothingFactor: 0.1,
            pointsMode: PointsMode.all,
          ),
        ),
      ],
    );
  }

  Widget wallet(moneyInv, incPercntage, height, width) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Column(
          children: [
            Text(
              "Total Investments",
              style: TextStyle(
                  color: Colors.grey.shade200,
                  // fontFamily: 'HelveticaRoundedBold',
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "\$ ${((moneyInv * 100).round() / 100)}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 35,
                color: Colors.white,
                fontFamily: 'HelveticaRoundedBold',
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  incPercntage.round() > 0
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: incPercntage.round() > 0
                      ? Color.fromARGB(255, 0, 249, 8)
                      : Colors.red,
                  size: 13,
                ),
                Text(
                  "  ${incPercntage.round() / 100} %  increase    ",
                  style: TextStyle(
                      color: incPercntage.round() > 0
                          ? Color.fromARGB(255, 0, 249, 8)
                          : Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
