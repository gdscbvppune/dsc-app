import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addEvent.dart';
import 'eventDescription.dart';

class EventsPage extends StatefulWidget{
  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage>{
  String reframeDate(String text){
    var x = text.split('-');
    String date = "";
    for(int i = x.length - 1; i > 0; i--){
      date = date + x[i];
      date = date + "/";
    }
    date = date + x[0];
    return date;
  }
    Future<bool> checkDelete(DismissDirection direction) async {
          return showDialog(context: context,
        builder: (context)=>AlertDialog(title: Text("Do you want to delete this event ?"),
        actions: <Widget>[
          FlatButton(child: Text("Yes"), onPressed: () => Navigator.pop(context,true)),
          FlatButton(child: Text("No"), onPressed: () => Navigator.pop(context,false))
        ],
        ),

        )?? false;
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10,
        ),
        child: StreamBuilder(
          stream: Firestore.instance.collection("events").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.documents.length != 0){
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: MediaQuery.of(context).size.height / 5,
                        child: Dismissible(
                          key: Key(snapshot.data.documents[index].documentID),
                          background: Container(color: Colors.blue),
                          onDismissed: (direction){
                             Firestore.instance.collection("events").document(snapshot.data.documents[index].documentID).delete();
                            FirebaseStorage.instance.ref().child("events").child(snapshot.data.documents[index]["title"]).delete();
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Event deleted"
                                )
                              )
                            );

                          },
                          confirmDismiss: (direction) => checkDelete(direction),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => EventDescription(
                                    eventName: snapshot.data.documents[index]["title"],
                                    eventDate: reframeDate(snapshot.data.documents[index]["date"]),
                                    eventTimings: snapshot.data.documents[index]["time"],
                                    speaker: snapshot.data.documents[index]["speaker"],
                                    registrationLink: snapshot.data.documents[index]["link"],
                                    desc: snapshot.data.documents[index]["desc"],
                                    eventPosterURL: snapshot.data.documents[index]["eventPosterURL"],
                                    featured: snapshot.data.documents[index]["featureEvent"],
                                    venue: snapshot.data.documents[index]["venue"]


                                  )
                                )
                              );

                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                children: <Widget>[
                                  FadeInImage.assetNetwork(
                                    height: MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width - 20,
                                    fit: BoxFit.fitWidth,
                                    placeholder: "assets/images/cogs.gif",
                                    image: snapshot.data.documents[index]["eventPosterURL"],
                                  ),
                                  Container(
                                    color: Colors.black38,
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: FittedBox(
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                              child: Container(
                                                decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                                                //color: Colors.blue[200],
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 12
                                                  ),
                                                  child: Text(
                                                    snapshot.data.documents[index]["title"],
                                                    style: GoogleFonts.openSans(
                                                      textStyle: TextStyle(color: Colors.white,
                                                        fontSize: 16,
                                                      )
                                                    ),
                                                  ),
                                                )
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    )
                                  )
                                ],
                              ),
                            )
                          )
                        ),
                      ),
                    );
                  }
                );
              }
              else{
                return Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Please add events",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 24
                          )
                        )
                      ),
                      SizedBox(
                        height: 32,
                      )
                    ],
                  )
                );
              }
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddEvent(
                pageTitle: "Add Event",
                featured: "false",

              )
            )
          );


        },
        child: Icon(Icons.add),
      ),
    );
  }
}
