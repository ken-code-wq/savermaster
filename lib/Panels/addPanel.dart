// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddPanel extends StatefulWidget {
  final PanelController action;
  final void update;
  const AddPanel({super.key, required this.action, required this.update});

  @override
  State<AddPanel> createState() => _AddPanelState();
}

class _AddPanelState extends State<AddPanel> {
  @override
  Widget build(BuildContext context) {
    var count = Hive.box('moneyBox');
    TextEditingController _textCon = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
          ),
          // color: Colors.amber,
          color: Colors.white,
        ),
        width: width,
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
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    hintText: 'Enter amount',
                    icon: Icon(Icons.monetization_on_rounded)),
                style:
                    TextStyle(fontSize: 20, fontFamily: 'HelveticaRoundedBold'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.playlist_add_check_rounded),
                title: Text(
                  "Select your goal",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Divider(),
            SizedBox(
              height: 12,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  count.add([double.parse(_textCon.text.trim()), ""]);
                  _textCon.clear();
                  widget.action.close();
                  widget.update;
                });
              },
              child: Text(
                "Done",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
