// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavingsPage extends StatefulWidget {
  final int index;
  final List colorsBox;
  final List emojiList;
  final savingsBox;
  const SavingsPage(
      {super.key,
      required this.index,
      required this.colorsBox,
      required this.emojiList,
      required this.savingsBox});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

num moneyInv = 0;
List<double> invMade = [];
double percentageDone = 0;
List<double> data = [];
List<double> initData = [];
num totalYet = 0;
num overload = 0;
int over = 0;

class _SavingsPageState extends State<SavingsPage> {
  @override
  Widget build(BuildContext context) {
    final confettiController = ConfettiController();

    updater(bool analytics, int checks) {
      moneyInv = 0;
      for (int i = 0;
          i != widget.savingsBox.getAt(widget.index)[4].length;
          i++) {
        if (widget.savingsBox.length > 0) {
          if (widget.savingsBox.getAt(widget.index)[4].length > 0) {
            moneyInv = moneyInv + (widget.savingsBox.getAt(widget.index)[4][i]);
            if (moneyInv + (widget.savingsBox.getAt(widget.index)[4][i]) >
                widget.savingsBox.getAt(widget.index)[1]) {
              overload =
                  overload + (widget.savingsBox.getAt(widget.index)[4][i]);
              // print(overload);
            }
          }
        }
      }
    }

    addAbbrvUp(double money) {
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

    analyticsUpdater() {
      data.clear();
      // print(widget.savingsBox.getAt(widget.index)[4].length);
      if (widget.savingsBox.getAt(widget.index)[4].length > 0) {
        for (int i = 0;
            i < widget.savingsBox.getAt(widget.index)[4].length;
            i++) {
          if (totalYet + (widget.savingsBox.getAt(widget.index)[4][i]) <=
              widget.savingsBox.getAt(widget.index)[1]) {
            totalYet = totalYet + (widget.savingsBox.getAt(widget.index)[4][i]);
            initData.add(totalYet.toDouble());
          } else {
            totalYet = widget.savingsBox.getAt(widget.index)[1];
            initData.add(totalYet.toDouble());
          }
        }
      }
      print("${initData} is right");
      if (data.length != initData.length) {
        data.addAll(initData);
        print(data);
      }
      totalYet = 0;
      initData.clear();
    }

    updater(true, 4);
    analyticsUpdater();

    @override
    void dispose() {
      super.dispose();
      confettiController.dispose();
    }

    percentageDone =
        (moneyInv / widget.savingsBox.getAt(widget.index)[1]) * 10000;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    percentageDone / 100 >= 100 ? confettiController.play() : null;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ConfettiWidget(
                        emissionFrequency: 0.04,
                        numberOfParticles: 20,
                        blastDirection: pi / 2,
                        confettiController: confettiController,
                        colors: [
                          widget
                              .colorsBox[
                                  widget.savingsBox.getAt(widget.index)[2]]
                              .shade500
                              .withOpacity(.83),
                          widget
                              .colorsBox[
                                  widget.savingsBox.getAt(widget.index)[2]]
                              .shade900
                              .withOpacity(.23),
                          widget
                              .colorsBox[
                                  widget.savingsBox.getAt(widget.index)[2]]
                              .shade200
                              .withOpacity(.53),
                          widget
                              .colorsBox[
                                  widget.savingsBox.getAt(widget.index)[2]]
                              .shade600
                              .withOpacity(.13),
                          widget.colorsBox[0].shade800,
                          widget.colorsBox[1].shade800,
                          widget.colorsBox[2].shade800,
                          widget.colorsBox[6].shade800,
                          widget.colorsBox[5].shade900,
                          widget.colorsBox[8].shade800,
                          widget.colorsBox[9].shade900,
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        width: width,
                        height: height * 0.152,
                      ),
                      Hero(
                        tag: widget.index,
                        child: Container(
                          width: height * .152,
                          height: height * 0.152,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: widget
                                .colorsBox[
                                    widget.savingsBox.getAt(widget.index)[2]]
                                .shade500
                                .withOpacity(.83),
                          ),
                          child: Center(
                            child: Text(
                              widget.emojiList[
                                  widget.savingsBox.getAt(widget.index)[3]],
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 7.5,
              ),
              Text(
                widget.savingsBox.getAt(widget.index)[0],
                style:
                    TextStyle(fontSize: 20, fontFamily: "HelveticaRoundedBold"),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: widget
                      .colorsBox[widget.savingsBox.getAt(widget.index)[2]]
                      .shade300
                      .withOpacity(.53),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: height * 0.1,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "\$ $moneyInv",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "HelveticaRoundedBold"),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Amount Saved",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: height * 0.07,
                            width: 2,
                            color: Colors.grey.shade700,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "${percentageDone.round() / 100}%",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "HelveticaRoundedBold"),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "% Done",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: height * 0.07,
                            width: 2,
                            color: Colors.grey.shade700,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "\$ ${widget.savingsBox.getAt(widget.index)[1] >= 1000 ? addAbbrvUp(widget.savingsBox.getAt(widget.index)[1]) : widget.savingsBox.getAt(widget.index)[1]}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "HelveticaRoundedBold"),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Goal Target",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Text(
                          "Goal Analytics",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'HelveticaRoundedBold',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.07, vertical: 18),
                          height: height * 0.3,
                          width: width,
                          child: Sparkline(
                            max: widget.savingsBox.getAt(widget.index)[1],
                            pointColor: widget
                                .colorsBox[
                                    widget.savingsBox.getAt(widget.index)[2]]
                                .shade200
                                .withOpacity(.83),
                            gridLineColor: Colors.grey.shade600.withOpacity(.5),
                            gridLineWidth: 1.2,
                            gridLineLabelColor: Colors.grey.shade900,
                            lineColor: widget
                                .colorsBox[
                                    widget.savingsBox.getAt(widget.index)[2]]
                                .shade900
                                .withOpacity(.93),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
