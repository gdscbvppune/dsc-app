import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddEvent extends StatefulWidget {
  final pageTitle, eventTitle, eventDate, eventTime, eventSpeaker, eventDescription, eventURL, eventPosterUrl, featured, eventVenue;
  AddEvent({this.pageTitle, this.eventDate, this.eventDescription, this.eventSpeaker, this.eventTime, this.eventTitle, this.eventURL, this.eventPosterUrl, this.featured, this.eventVenue});

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();
  TextEditingController eventSpeakerController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();
  TextEditingController eventRegistrationLinkController = TextEditingController();
  TextEditingController venueController = TextEditingController();

  FocusNode eventTitleFocusNode = FocusNode();
  FocusNode eventDateFocusNode = FocusNode();
  FocusNode eventTimeFocusNode = FocusNode();
  FocusNode eventSpeakerFocusNode = FocusNode();
  FocusNode eventDescFocusNode = FocusNode();
  FocusNode venueFocusNode = FocusNode();
  FocusNode eventRegistrationLinkFocusNode = FocusNode();

  String featureEventVal = "true";

  File posterImage;
  String title, date, time, speaker, desc, registerLink;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      posterImage = image;
    });
  }

  String getInitials(String text){
    var words = text.split(' ');
    String icon = "";
    for(var item in words){
      if(icon.length < 2){
        icon = icon + item.substring(0,1).toUpperCase();
      }
    }
    return icon;
  }

  String reframeDate(String text){
    var words = text.split("/");
    String newDate = "";
    newDate = words[2] + "-" + words[1] + "-" + words[0];
    return newDate;
  }

  @override
  void initState() {
    eventTitleController.text = widget.eventTitle;
    eventDescController.text = widget.eventDescription;
    eventDateController.text = widget.eventDate;
    eventTimeController.text = widget.eventTime;
    eventSpeakerController.text = widget.eventSpeaker;
    eventRegistrationLinkController.text = widget.eventURL;
    featureEventVal = widget.featured;
    venueController.text = widget.eventVenue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: eventTitleFocusNode,
                  autocorrect: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  controller: eventTitleController,
                  onFieldSubmitted: (val){
                    eventTitleController.text = val;
                  },
                  onChanged: (val){
                    title = val;
                  },
                  onEditingComplete: (){
                    eventTitleController.text = title;
                    eventTitleFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(eventDescFocusNode);
                  },
                  decoration: InputDecoration(
                    suffix: Text(
                      "*"
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: "Frontend 101",
                    labelText: "Event Title"
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: eventDescFocusNode,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.sentences,
                  controller: eventDescController,
                  onFieldSubmitted: (val){
                    eventDescController.text = desc;
                  },
                  onEditingComplete: (){
                    eventDescFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(eventDateFocusNode);
                  },
                  onChanged: (val){
                    desc = val;
                  },
                  decoration: InputDecoration(
                    suffix: Text(
                      "*"
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: "What is the event all about?",
                    labelText: "Event Description"
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(child: Text("Is this featured event ?",style: TextStyle(fontSize: 18),),),
              SizedBox(height:12),
              DropdownButton(
                icon: Icon(Icons.arrow_drop_down),
                underline: Container(
                  height: 2,
                  color: Color(0xFF4c8bf5),
                ),
                value: featureEventVal,
                items: <String>["true", "false"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                .toList(),
                onChanged: (val){
                  setState(() {
                    featureEventVal = val;
                  });
                }
              ),
               



 SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: eventDateFocusNode,
                  autocorrect: false,
                  controller: eventDateController,
                  onChanged: (val){
                    date = val;
                  },
                  onFieldSubmitted: (val){
                    eventDateController.text = date;
                  },
                  onEditingComplete: (){
                    eventDateFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(eventTimeFocusNode);
                  },
                  decoration: InputDecoration(
                    suffix: Text(
                      "*"
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: "For eg. 2019-01-15",
                    labelText: "Event Date"
                  ),
                  keyboardType: TextInputType.datetime,
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: eventTimeFocusNode,
                  autocorrect: false,
                  controller: eventTimeController,
                  onChanged: (val){
                    time = val;
                  },
                  onFieldSubmitted: (val){
                    eventTimeController.text = time;
                  },
                  onEditingComplete: (){
                    eventTimeFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(eventSpeakerFocusNode);
                  },
                  decoration: InputDecoration(
                    suffix: Text(
                      "*"
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: "For eg. 4:00PM - 7:00PM",
                    labelText: "Event Time"
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: eventSpeakerFocusNode,
                  autocorrect: false,
                  controller: eventSpeakerController,
                  onChanged: (val){
                    speaker = val;
                  },
                  onFieldSubmitted: (val){
                    eventSpeakerController.text = speaker;
                  },
                  onEditingComplete: (){
                    eventSpeakerFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(eventRegistrationLinkFocusNode);
                  },
                  decoration: InputDecoration(
                    suffix: Text(
                      "*"
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: "For eg. Dewansh Rawat, a GDE on Flutter",
                    labelText: "Event Speaker"
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: eventRegistrationLinkFocusNode,
                  autocorrect: false,
                  controller: eventRegistrationLinkController,
                  onChanged: (val){
                    registerLink = val;
                  },
                  onFieldSubmitted: (val){
                    eventRegistrationLinkController.text = registerLink;
                  },
                  onEditingComplete: (){
                    eventRegistrationLinkFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(venueFocusNode);
                  },
                  decoration: InputDecoration(
                    suffix: Text(
                      "*"
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: "For eg. http://bit.ly/registerForDSCSolChallenge",
                    labelText: "Registration Link"
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: venueFocusNode,
                  autocorrect: false,
                  controller: venueController,
                  textCapitalization: TextCapitalization.words,
                  onFieldSubmitted: (val){
                    venueController.text = val;
                  },
                  onEditingComplete: (){
                    venueFocusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    suffix: Text(
                      "*"
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.red
                    ),
                    hintText: "For eg. College of Engineering, COEP",
                    labelText: "Venue"
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(child: Text("Pick Event Poster", style: TextStyle(fontSize: 18))),
              SizedBox(height:12),
              RaisedButton.icon(
                onPressed: (){
                  getImage();
                },
                icon: Icon(Icons.photo_library),
                label: Row(
                  children: <Widget>[
                    Text(
                      "Pick from Gallery",
                      style: GoogleFonts.openSans(
                        fontSize: 18
                      ),
                    ),
                    Text(
                      "*",
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: Colors.red
                      ),
                    )
                  ],
                )
              ),
              SizedBox(
                height: 24,
              )
              
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Done",
        onPressed: () async{
          var posterURL;
          var firebaseStorageRef = FirebaseStorage.instance.ref().child("events");
          if(widget.eventPosterUrl == null && posterImage != null){
            var eventImgRef = firebaseStorageRef.child(eventTitleController.text);
            StorageUploadTask imgUpload = eventImgRef.putFile(posterImage);
            StorageTaskSnapshot tempSnapshot = await imgUpload.onComplete;
            posterURL = await tempSnapshot.ref.getDownloadURL();
          }
          else{
            if(widget.eventPosterUrl != null && posterImage != null){
              var eventImgRef = firebaseStorageRef.child(widget.eventTitle);
              await eventImgRef.delete();
              var newEventImgRef = firebaseStorageRef.child(eventTitleController.text);
              StorageUploadTask imgUpload = newEventImgRef.putFile(posterImage);
              StorageTaskSnapshot tempSnapshot = await imgUpload.onComplete;
              posterURL = await tempSnapshot.ref.getDownloadURL();
            }
            else{
              posterURL = widget.eventPosterUrl;
            }
          }
          Map<String, dynamic> eventData = {
            "title": eventTitleController.text,
            "desc": eventDescController.text,
            "date": reframeDate(eventDateController.text),
            "time": eventTimeController.text,
            "speaker": eventSpeakerController.text,
            "link": eventRegistrationLinkController.text,
            "icon": getInitials(eventTitleController.text),
            "featureEvent": featureEventVal,
            "eventPosterURL": posterURL,
            "venue": venueController.text
          };
          var eventRef = Firestore.instance.collection("events");
          var docs = await eventRef.getDocuments();
          for (var item in docs.documents){
            var tempItem = await eventRef.document(item.documentID).get();
            if(tempItem["title"] == widget.eventTitle){
              await eventRef.document(item.documentID).delete();
              break;
            }
          }
          await eventRef.add(eventData);
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}