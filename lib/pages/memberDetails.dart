import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'addMember.dart';
import 'imageExpand.dart';

class MemberDetails extends StatefulWidget {
  final String imgURL, name, instagramLink, twitterLink, githubLink, websiteLink, linkedinLink, orderID, team, title;
  MemberDetails({this.name, this.instagramLink, this.team, this.title, this.githubLink, this.imgURL, this.linkedinLink, this.orderID, this.twitterLink, this.websiteLink});

  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          alignment: Alignment.bottomRight,
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ImageExpand(imageURL: widget.imgURL);
                  }));
                },
                child: Hero(
                  tag: 'image',
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      placeholder: "assets/images/cogs.gif",
                      image: widget.imgURL,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Text(
                widget.name,
                style: GoogleFonts.montserrat(
                  fontSize: 32,
                  color: Colors.black
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.title,
                style: GoogleFonts.raleway(
                  fontSize: 24,
                  color: Colors.black
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.githubLink.length > 0 ? InkWell(
                      onTap: () async{
                        if(await canLaunch(widget.githubLink)){
                          launch(widget.githubLink);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.github,
                          size: 24
                        ),
                      ),
                    ) : Text(""),
                    SizedBox(
                      width: 20,
                    ),
                    widget.websiteLink.length > 0 ? InkWell(
                      onTap: () async{
                        if(await canLaunch(widget.websiteLink)){
                          launch(widget.websiteLink);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.chrome,
                          size: 24,
                          color: Color(0xFFde5246),
                        ),
                      ),
                    ) : Text(""),
                    SizedBox(
                      width: 12,
                    ),
                    widget.instagramLink.length > 0 ? InkWell(
                      onTap: () async{
                        if(await canLaunch(widget.instagramLink)){
                          launch(widget.instagramLink);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.instagram,
                          size: 24,
                          color: Colors.redAccent,
                        ),
                      ),
                    ) : Text(""),
                    SizedBox(
                      width: 12,
                    ),
                    widget.linkedinLink.length > 0 ? InkWell(
                      onTap: () async{
                        if(await canLaunch(widget.linkedinLink)){
                          launch(widget.linkedinLink);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.linkedinIn,
                          size: 24,
                          color: Color(0xFF0072b1),
                        ),
                      ),
                    ) : Text(""),
                    SizedBox(
                      width: 12,
                    ),
                    widget.twitterLink.length > 0 ? InkWell(
                      onTap: () async{
                        if(await canLaunch(widget.twitterLink)){
                          launch(widget.twitterLink);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.twitter,
                          size: 24,
                          color: Color(0xFF00acee),
                        ),
                      ),
                    ) : Text(""),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddMember(
                pageTitle: "Edit Details",
                name: widget.name,
                linkedin: widget.linkedinLink,
                instagram: widget.instagramLink,
                github: widget.githubLink,
                twitter: widget.twitterLink,
                website: widget.websiteLink,
                order: widget.orderID,
                team: widget.team,
                title: widget.title,
                memberImgUrl: widget.imgURL,
              )
            )
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}