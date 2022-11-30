import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_scanner/util.dart';
import 'package:swd_scanner/views/scanning_view.dart';
import '../view_models/prof_show_activity_view_model.dart';

class ProfShowActivity extends StatefulWidget {
  const ProfShowActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfShowActivityState();
  }
}

class _ProfShowActivityState extends State<ProfShowActivity> {
  Map<String, int> idMap = {};
  late final ValueNotifier<bool> isLoadingProfShowScreen;
  late String? enteredEventCode;
  List<dynamic> eventCodes = [];
  late String dropDownValue;
  List<String> profShows = [];

  @override
  initState() {
    super.initState();
    isLoadingProfShowScreen = ValueNotifier(true);
    try {
      getEventCodes();
      getProfShowsList();
    } catch (e) {
      isLoadingProfShowScreen.value = false;
      var snackBar = const SnackBar(
        duration: Duration(seconds: 2),
        content: SizedBox(height: 25, child: Center(child: Text("Error"))),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  getProfShowsList() async {
    final prefs = await SharedPreferences.getInstance();
    idMap = await ProfShows().getMapOfShows(prefs.getString('JWT')!);
    profShows = idMap.keys.toList();
    dropDownValue = profShows[0];
    setState(() {
      isLoadingProfShowScreen.value = false;
    });
  }

  getEventCodes() {
    List<dynamic> tempList = [];
  }

  copyList(List<dynamic> tempList) {
    eventCodes = tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: isLoadingProfShowScreen,
      builder: (BuildContext context, bool value, Widget? child) {
        if (isLoadingProfShowScreen.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: dropDownValue,
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                  items: profShows.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  width: ScreenSize.screenWidth * 0.8,
                  child: TextFormField(
                    onChanged: (String value) {
                      enteredEventCode = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Security Code',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text("Scan Prof Show"),
                  onPressed: () {
                    if (enteredEventCode == null || enteredEventCode == '') {
                      var snackBar = const SnackBar(
                        duration: Duration(seconds: 2),
                        content: SizedBox(
                            height: 25,
                            child: Center(child: Text("Enter Security Code"))),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    if (enteredEventCode !=
                            eventCodes[idMap[dropDownValue]!].toString() &&
                        enteredEventCode != null &&
                        enteredEventCode != '') {
                      var snackBar = const SnackBar(
                        duration: Duration(seconds: 2),
                        content: SizedBox(
                            height: 25,
                            child:
                                Center(child: Text("Invalid Security Code"))),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    if (enteredEventCode ==
                        eventCodes[idMap[dropDownValue]!].toString()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScanningView(showId: idMap[dropDownValue]!)));
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    ));
  }
}
