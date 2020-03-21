import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_storage/firebase_storage.dart';

class EventsPage extends StatefulWidget{

  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage>{

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20
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
                          background: Container(color: Colors.blue,),
                          onDismissed: (direction){
                           
                          },
                          child: InkWell(
                            onTap: (){
                             
                            },
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    snapshot.data.documents[index]["eventPosterURL"],
                                    fit: BoxFit.fitWidth,
                                    width: MediaQuery.of(context).size.width - 20,
                                    height: MediaQuery.of(context).size.height / 5,
                                  ),
                                  Container(
                                    color: Colors.black38,
                                  ),
                                  Positioned(
                                    bottom: 24,
                                    left: 24,
                                    child: FittedBox(
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Container(
                                              color: Colors.blue[200],
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 12
                                                ),
                                                child: Text(
                                                  snapshot.data.documents[index]["title"],
                                                  style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                      fontSize: 16,
                                                    )
                                                  ),
                                                ),
                                              )
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
         
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
