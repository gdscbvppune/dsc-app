import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'addEvent.dart';
import 'eventDescription.dart';

class EventsPage extends StatefulWidget {
  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _reframeDate(String text) {
    var x = text.split('-');
    String date = "";
    for (int i = x.length - 1; i > 0; i--) {
      date += x[i] += '/';
    }
    date += x[0];
    return date;
  }

  Future<bool> _confirmDismiss(DismissDirection direction, snapshot, index) async {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(direction == DismissDirection.startToEnd ? "Do you want to feature this event ?" : "Do you want to delete this event ?"),
            actions: <Widget>[
              FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    if (direction == DismissDirection.startToEnd) {
                      _featureEvent(snapshot, index);
                      Navigator.pop(context, false);
                    } else {
                      Navigator.pop(context, true);
                      _deleteEvent(snapshot, index);
                    }
                  }),
              FlatButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _featureEvent(snapshot, index) async {
    try {
      if (_checkFeatured(snapshot, index)) {
        _showSnackBar("Event is already featured !");
        return;
      }
      await Firestore.instance.collection("events").document(snapshot.data.documents[index].documentID).updateData({"featureEvent": true});
      _showSnackBar("Event is featured now !");
    } catch (e) {
      _showSnackBar("An error occured in featuring the event");
    }
  }

  void _deleteEvent(snapshot, index) async {
    try {
      await Firestore.instance.collection("events").document(snapshot.data.documents[index].documentID).delete();
      await FirebaseStorage.instance.ref().child("events").child(snapshot.data.documents[index]["title"]).delete();
      _showSnackBar("Event Deleted !");
    } catch (e) {
      _showSnackBar("An error occured in deleting the event");
    }
  }

  bool _checkFeatured(snapshot, index) {
    return snapshot.data.documents[index]["featureEvent"].toString().toLowerCase() == "true";
  }

  void _showSnackBar(text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder(
          stream: Firestore.instance.collection("events").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) if (snapshot.data.documents.length != 0)
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 3.0,
                    child: Dismissible(
                      key: Key(snapshot.data.documents[index].documentID),
                      background: Container(
                        padding: EdgeInsets.only(left: 25.0),
                        alignment: Alignment.centerLeft,
                        color: Colors.blue,
                        child: Icon(
                          Icons.star,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.only(right: 25.0),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete_forever,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) => _confirmDismiss(direction, snapshot, index),
                      child: LimitedBox(
                        maxHeight: MediaQuery.of(context).size.height / 5,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                imageUrl: snapshot.data.documents[index]["eventPosterURL"],
                                progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            Container(color: Colors.black45),
                            if (_checkFeatured(snapshot, index))
                              ClipRect(
                                child: Banner(
                                  message: "Featured",
                                  location: BannerLocation.topEnd,
                                  color: Colors.black38,
                                  child: Container(color: Colors.transparent), // Container is neccessary as a banner child
                                ),
                              ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  highlightColor: Colors.white24,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => EventDescription(
                                            eventName: snapshot.data.documents[index]["title"],
                                            eventDate: _reframeDate(snapshot.data.documents[index]["date"]),
                                            eventTimings: snapshot.data.documents[index]["time"],
                                            speaker: snapshot.data.documents[index]["speaker"],
                                            registrationLink: snapshot.data.documents[index]["link"],
                                            desc: snapshot.data.documents[index]["desc"],
                                            eventPosterURL: snapshot.data.documents[index]["eventPosterURL"],
                                            featured: snapshot.data.documents[index]["featureEvent"],
                                            venue: snapshot.data.documents[index]["venue"]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0)),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.45),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                      child: LimitedBox(
                                        maxWidth: MediaQuery.of(context).size.width / 1.2,
                                        child: Text(
                                          snapshot.data.documents[index]["title"],
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            else
              return Container(
                padding: EdgeInsets.only(top: 30),
                alignment: Alignment.topCenter,
                child: Text(
                  "Please add events",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 24),
                  ),
                ),
              );
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddEvent(
                pageTitle: "Add Event",
                featured: "false",
              ),
            ),
          );
        },
      ),
    );
  }
}
