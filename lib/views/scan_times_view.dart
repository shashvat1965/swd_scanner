import 'package:flutter/material.dart';

class ScanTimes extends StatefulWidget {
  ScanTimes({Key? key, required this.timeList}) : super(key: key);
  List<dynamic> timeList;
  @override
  State<ScanTimes> createState() => _ScanTimesState();
}

class _ScanTimesState extends State<ScanTimes> {
  String dateAndTime(String timestamp) {
    String date = timestamp.split("T")[0];
    String time = timestamp.split("T")[1];
    String formattedString = "$date $time";
    DateTime indianCorrectTime = DateTime.parse(formattedString).toLocal();
    return indianCorrectTime.toString().split(".")[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SCAN TIMES",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
                itemCount: widget.timeList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(dateAndTime(widget.timeList[index].toString()));
                })
          ],
        ),
      ),
    );
  }
}
