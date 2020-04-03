import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addMember.dart';
import 'memberDetails.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final databaseReference = Firestore.instance;

  Future<bool> checkDelete(DismissDirection direction) async {
          return showDialog(context: context,
        builder: (context)=>AlertDialog(title: Text("Do you want to remove this member ?"),
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
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20
          ),
          child: StreamBuilder(
            stream: databaseReference.collection("teams").orderBy("id").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                if(snapshot.data.documents.length != 0){
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index){
                      return Dismissible(
                        background: Container(
                          color: Colors.blue,
                        ),
                        key: Key(snapshot.data.documents[index].documentID),
                        confirmDismiss: (direction) => checkDelete(direction),
                        onDismissed: (direction){
                          Firestore.instance.collection("teams").document(snapshot.data.documents[index].documentID).delete();
                          var snackBar = SnackBar(
                            content: Text(
                              "Team Member Removed"
                            ),
                            duration: Duration(
                              seconds: 2
                            ),                          
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                        child: InkWell(
                          onTap: (){
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
                                  websiteLink: snapshot.data.documents[index]["website"]
                                )
                              )
                            );
                          },
                          child: ListTile(
                            leading: ClipOval(
                              child: FadeInImage.assetNetwork(
                                height: 100,
                                width: 55,
                                fit: BoxFit.cover,
                                placeholder: "assets/images/cogs.gif",
                                image: snapshot.data.documents[index]["profileImage"],
                              ),
                            ),
                            title: Text(
                              snapshot.data.documents[index]["name"],
                              style: GoogleFonts.raleway(
                                fontSize: 16
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data.documents[index]["title"],
                              style: GoogleFonts.openSans(
                                fontSize: 16
                              ),
                            ),
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
                          "Please add Team Members",
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
            },
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
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
              )
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}