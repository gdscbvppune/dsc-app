import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DatabaseHandler extends StatefulWidget {
  @override
  _DatabaseHandlerState createState() => _DatabaseHandlerState();
}

class _DatabaseHandlerState extends State<DatabaseHandler> {
  ProgressDialog pd;

  Future<bool> loadJsonData(context) async {
    var instance = Firestore.instance;
    var home = await instance.collection("details").getDocuments();
    var events = await instance.collection("events").getDocuments();
    var team = await instance.collection("teams").getDocuments();

    if (home.documents.length == 0) {
      loadHomeJson(instance);
    }

    if (events.documents.length == 0) {
      loadEventsJson(instance);
    }

    if (team.documents.length == 0) {
      loadTeamJson(instance);
    }
    return true;
  }

  void loadHomeJson(instance) async {
    var temp = await DefaultAssetBundle.of(context)
        .loadString('assets/json/homePage.json');
    var homeData = await json.decode(temp);
    instance.collection("details").document("details").setData(homeData);
  }

  void loadEventsJson(instance) async {
    var temp = await DefaultAssetBundle.of(context)
        .loadString('assets/json/eventsPage.json');
    var eventData = await json.decode(temp);
    instance.collection("events").document().setData(eventData);
  }

  void loadTeamJson(instance) async {
    var temp = await DefaultAssetBundle.of(context)
        .loadString('assets/json/teamPage.json');
    var teamData = await json.decode(temp);
    instance.collection("teams").document().setData(teamData);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      _showAlert(context);
      bool _done = await loadJsonData(context);

      if (_done == true) {
        pd.hide().whenComplete(() => Navigator.pop(context));
        print("Done initializing database");
      } else {
        pd.hide().whenComplete(() => Navigator.pop(context));
        print("An error occured in initializing database");
      }
    });
    return Opacity(opacity: 0.0);
  }

  void _showAlert(context) async {
    pd = new ProgressDialog(context, isDismissible: true, showLogs: false);
    pd.style(
      message: "No website database found, initializing ...",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Padding(
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator(),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: GoogleFonts.lato(
        color: Colors.black,
        fontSize: 15.0,
      ),
    );
    await pd.show();
  }
}
