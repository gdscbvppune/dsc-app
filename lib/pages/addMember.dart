import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddMember extends StatefulWidget {

  final name, github, instagram, linkedin, twitter, title, team, website, pageTitle, memberImgUrl, order;
  AddMember({this.name, this.github, this.linkedin, this.instagram, this.twitter, this.team, this.website, this.pageTitle, this.title, this.memberImgUrl, this.order});

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {

  TextEditingController nameController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedinContoller = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController orderController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode githubFocusNode = FocusNode();
  FocusNode instagramFocusNode = FocusNode();
  FocusNode linkedinFocusNode = FocusNode();
  FocusNode twitterFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode teamFocusNode = FocusNode();
  FocusNode websiteFocusNode = FocusNode();
  FocusNode orderFocusNode = FocusNode();

  File profileImage;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }

  @override
  void initState() {
    nameController.text = widget.name;
    githubController.text = widget.github;
    titleController.text = widget.title;
    instagramController.text = widget.instagram;
    twitterController.text = widget.twitter;
    teamController.text = widget.team;
    websiteController.text = widget.website;
    linkedinContoller.text = widget.linkedin;
    orderController.text = widget.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
          style: GoogleFonts.openSans(
            fontSize: 20
          ),
        ),
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
                  focusNode: nameFocusNode,
                  autocorrect: false,
                  controller: nameController,
                  onFieldSubmitted: (val){
                    nameController.text = val;
                  },
                  onEditingComplete: (){
                    nameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(teamFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. Dewansh Rawat",
                    labelText: "Name"
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
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: teamFocusNode,
                  autocorrect: false,
                  controller: teamController,
                  onFieldSubmitted: (val){
                    teamController.text = val;
                  },
                  onEditingComplete: (){
                    teamFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(titleFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. Core Team",
                    labelText: "Team Name"
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
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: titleFocusNode,
                  autocorrect: false,
                  controller: titleController,
                  onFieldSubmitted: (val){
                    titleController.text = val;
                  },
                  onEditingComplete: (){
                    titleFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(twitterFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. Core Team Member",
                    labelText: "Title"
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
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: twitterFocusNode,
                  autocorrect: false,
                  controller: twitterController,
                  onFieldSubmitted: (val){
                    twitterController.text = val;
                  },
                  onEditingComplete: (){
                    twitterFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(instagramFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. https://twitter.com/dewanshrawat15",
                    labelText: "Twitter URL"
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
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: instagramFocusNode,
                  autocorrect: false,
                  controller: instagramController,
                  onFieldSubmitted: (val){
                    instagramController.text = val;
                  },
                  onEditingComplete: (){
                    instagramFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(githubFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. https://intagram.com/dewanshrawat15",
                    labelText: "Instagram URL"
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
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: githubFocusNode,
                  autocorrect: false,
                  controller: githubController,
                  onFieldSubmitted: (val){
                    githubController.text = val;
                  },
                  onEditingComplete: (){
                    githubFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(orderFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. https://github.com/dewanshrawat15",
                    labelText: "Github URL"
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
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: orderFocusNode,
                  autocorrect: false,
                  controller: orderController,
                  onFieldSubmitted: (val){
                    orderController.text = val;
                  },
                  onEditingComplete: (){
                    orderFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(linkedinFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. 3",
                    labelText: "Member Position"
                  ),
                  keyboardType: TextInputType.number,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: linkedinFocusNode,
                  autocorrect: false,
                  controller: linkedinContoller,
                  onFieldSubmitted: (val){
                    linkedinContoller.text = val;
                  },
                  onEditingComplete: (){
                    linkedinFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(websiteFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. https://linkedin.com/in/dewanshrawat15",
                    labelText: "Linkedin URL"
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
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: websiteFocusNode,
                  autocorrect: false,
                  controller: websiteController,
                  onFieldSubmitted: (val){
                    websiteController.text = val;
                  },
                  onEditingComplete: (){
                    websiteFocusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "For eg. https://dewanshrawat.tech",
                    labelText: "Website"
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
              RaisedButton.icon(
                onPressed: (){
                  getImage();
                },
                icon: Icon(Icons.photo_library),
                label: Text(
                  "Pick from Gallery",
                  style: GoogleFonts.openSans(
                    fontSize: 18
                  ),
                )
              ),
              SizedBox(
                height: 48,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var profileImgURL;
          var firebaseStorageRef = FirebaseStorage.instance.ref().child("team");
          if(widget.memberImgUrl == null && profileImage != null){
            var eventImgRef = firebaseStorageRef.child(nameController.text);
            StorageUploadTask imgUpload = eventImgRef.putFile(profileImage);
            StorageTaskSnapshot tempSnapshot = await imgUpload.onComplete;
            profileImgURL = await tempSnapshot.ref.getDownloadURL();
          }
          else{
            if(widget.memberImgUrl != null && profileImage != null){
              var eventImgRef = firebaseStorageRef.child(widget.name);
              await eventImgRef.delete();
              var newEventImgRef = firebaseStorageRef.child(nameController.text);
              StorageUploadTask imgUpload = newEventImgRef.putFile(profileImage);
              StorageTaskSnapshot tempSnapshot = await imgUpload.onComplete;
              profileImgURL = await tempSnapshot.ref.getDownloadURL();
            }
            else{
              profileImgURL = widget.memberImgUrl;
            }
          }
          Map<String, dynamic> memberDetails = {
            "name": nameController.text,
            "title": titleController.text,
            "team": teamController.text,
            "github": githubController.text,
            "linkedin": linkedinContoller.text,
            "instagram": instagramController.text,
            "twitter": twitterController.text,
            "website": websiteController.text,
            "id": orderController.text.toString(),
            "profileImage": profileImgURL
          };
          var teamMembersRef = Firestore.instance.collection("teams");
          var docs = await teamMembersRef.getDocuments();
          for (var item in docs.documents){
            var tempItem = await teamMembersRef.document(item.documentID).get();
            if(tempItem["name"] == widget.name){
              await teamMembersRef.document(item.documentID).delete();
              break;
            }
          }
          await teamMembersRef.add(memberDetails);
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}