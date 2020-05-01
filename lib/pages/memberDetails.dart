import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'addMember.dart';
import 'imageExpand.dart';

class MemberDetails extends StatefulWidget {
  MemberDetails({this.name, this.instagramLink, this.team, this.title, this.githubLink, this.imgURL, this.linkedinLink, this.orderID, this.twitterLink, this.websiteLink});

  final String imgURL, name, instagramLink, twitterLink, githubLink, websiteLink, linkedinLink, orderID, team, title;

  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  Widget _socialLinks(link, icon, color) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(link)) {
          launch(link);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 25,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          alignment: Alignment.bottomRight,
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ImageExpand(imageURL: widget.imgURL)));
                },
                child: Hero(
                  tag: 'image',
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                      imageUrl: widget.imgURL,
                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Text(
                widget.name,
                style: GoogleFonts.montserrat(fontSize: 32),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.title,
                style: GoogleFonts.raleway(fontSize: 24),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.githubLink.length > 0 ? _socialLinks(widget.githubLink, FontAwesomeIcons.github, Color(0xFF000000)) : SizedBox(),
                  SizedBox(width: 12.0),
                  widget.websiteLink.length > 0 ? _socialLinks(widget.websiteLink, FontAwesomeIcons.chrome, Color(0xFFDD4337)) : SizedBox(),
                  SizedBox(width: 12.0),
                  widget.instagramLink.length > 0 ? _socialLinks(widget.instagramLink, FontAwesomeIcons.instagram, Color(0xFFCA2257)) : SizedBox(),
                  SizedBox(width: 12.0),
                  widget.linkedinLink.length > 0 ? _socialLinks(widget.linkedinLink, FontAwesomeIcons.linkedinIn, Color(0xFF0077B5)) : SizedBox(),
                  SizedBox(width: 12.0),
                  widget.twitterLink.length > 0 ? _socialLinks(widget.twitterLink, FontAwesomeIcons.twitter, Color(0xFF00A7E7)) : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
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
              ),
            ),
          );
        },
      ),
    );
  }
}
