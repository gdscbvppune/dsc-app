import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'addMember.dart';
import 'memberDetails.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _confirmDismiss(DismissDirection direction) async {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Do you want to remove this member ?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () => Navigator.pop(context, true),
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _removeMember(snapshot, index) async {
    try {
      await Firestore.instance.collection("teams").document(snapshot.data.documents[index].documentID).delete();
      _showSnackBar("Team member removed !");
    } catch (e) {
      _showSnackBar("An error occured in removing team member");
    }
  }

  void _showSnackBar(text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder(
        stream: Firestore.instance.collection("teams").orderBy("id").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) if (snapshot.data.documents.length != 0)
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    child: Dismissible(
                      key: Key(snapshot.data.documents[index].documentID),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: EdgeInsets.only(right: 25.0),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(
                          FontAwesomeIcons.userSlash,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) => _confirmDismiss(direction),
                      onDismissed: (direction) => _removeMember(snapshot, index),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MemberDetails(
                                  name: snapshot.data.documents[index]["name"],
                                  imgURL: snapshot.data.documents[index]["profileImage"],
                                  instagramLink: snapshot.data.documents[index]["instagram"],
                                  twitterLink: snapshot.data.documents[index]["twitter"],
                                  linkedinLink: snapshot.data.documents[index]["linkedin"],
                                  githubLink: snapshot.data.documents[index]["github"],
                                  orderID: snapshot.data.documents[index]["id"],
                                  team: snapshot.data.documents[index]["team"],
                                  title: snapshot.data.documents[index]["title"],
                                  websiteLink: snapshot.data.documents[index]["website"]),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: ClipOval(
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              width: 55.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                              imageUrl: snapshot.data.documents[index]["profileImage"],
                              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          title: Text(
                            snapshot.data.documents[index]["name"],
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data.documents[index]["title"],
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          else
            return Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: Text(
                "Please add Team Members",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Member",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddMember(
                pageTitle: "Add Member",
                title: "",
                team: "",
                instagram: "",
                twitter: "",
                linkedin: "",
                github: "",
                name: "",
                website: "",
              ),
            ),
          );
        },
      ),
    );
  }
}
