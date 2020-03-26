import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editHomePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var details;
  List hashTags = List();

  getDetails() async{
    var ref = Firestore.instance;
    details = await ref.collection("details").document("details").get();
  
    for (var i in details["tags"]) {
      var tempTag = textStyleSpan("#" + i + "\t", 8.0, FontWeight.normal, 150, 150, 150, 1.0);
      hashTags.add(tempTag);
    }
    setState(() {
      
    });
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: details == null ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      imageAsset("assets/images/home.jpg", 250.0),
                      RichText(
                        textAlign: TextAlign.left,
                        textScaleFactor: 2,
                        text: TextSpan(
                          children: <TextSpan>[
                            textStyleSpan("Make good things ", 20.0, FontWeight.bold, 97, 97, 97, 1.0),
                            textStyleSpan("together", 20.0, FontWeight.bold, 26, 115, 232, 1.0),
                            textStyleSpan(".", 20.0, FontWeight.bold, 97, 97, 97, 1.0),
                            textStyleSpan("\n\n", 0.0, FontWeight.normal, 0, 0, 0, 0.0),
                            textStyleSpan(details["name"], 10.0, FontWeight.normal, 0, 0, 0, 1.0),
                            textStyleSpan("\n\n", 0.0, FontWeight.normal, 0, 0, 0, 0.0),
                            textStyleSpan(details["shortDescription"], 8.0, FontWeight.normal, 0, 0, 0, 1.0),
                            textStyleSpan("\n\n", 0.0, FontWeight.normal, 0, 0, 0, 0.0),
                            for (var i in hashTags) i,
                            textStyleSpan("\n", 0.0, FontWeight.normal, 0, 0, 0, 0.0),
                          ],
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          details["becomeMemberURL"].length > 0 ? blueRaisedButton("Become A Member", details["becomeMemberURL"]) : Text(""),
                          details["becomeMemberURL"].length > 0 ? VerticalDivider() : Text(""),
                          details["aboutDSCLink"].length > 0 ? cyanFlatButton("Learn More", details["aboutDSCLink"]) : Text(""),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Card(
                color: Color.fromRGBO(240, 240, 240, 1.0),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      textStyleNormal("What we do?", Alignment.centerLeft, TextAlign.left, 2.0, 10.0, FontWeight.w600, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal("A Google Developers program for university students, with the aim to help students build their development skills and knowledge.", Alignment.centerLeft, TextAlign.left, 2.0, 8.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal("About different Google technologies", Alignment.centerLeft, TextAlign.left, 2.0, 8.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          svgAsset("assets/svg/angular.svg", "https://angular.io/", 40.0, 40.0),
                          VerticalDivider(),
                          svgAsset("assets/svg/gcp.svg", "https://cloud.google.com/", 50.0, 50.0),
                          VerticalDivider(),
                          svgAsset("assets/svg/android.svg", "https://www.android.com/", 40.0, 40.0),
                          VerticalDivider(),
                          svgAsset("assets/svg/aog.svg", "https://developers.google.com/actions/", 40.0, 40.0),
                          VerticalDivider(),
                          svgAsset("assets/svg/firebase.svg", "https://firebase.google.com/", 40.0, 40.0),
                          VerticalDivider(),
                          svgAsset("assets/svg/tf.svg", "https://www.tensorflow.org/", 40.0, 40.0),
                        ],
                      ),

                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      Divider(),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      iconAsset(Icons.chat_bubble, Color.fromRGBO(0, 0, 0, 0.6), 60.0),
                      textStyleNormal("Talks", Alignment.center, TextAlign.center, 1.0, 20.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal("Get updated with the latest news and announcements", Alignment.center, TextAlign.center, 1.0, 15.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      Divider(),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      iconAsset(Icons.code, Color.fromRGBO(0, 0, 0, 0.6), 60.0),
                      textStyleNormal("Codelabs", Alignment.center, TextAlign.center, 1.0, 20.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal("Get hands-on experience and guidance from the community members", Alignment.center, TextAlign.center, 1.0, 15.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      Divider(),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      iconAsset(Icons.airplay, Color.fromRGBO(0, 0, 0, 0.6), 60.0),
                      textStyleNormal("Live Viewing Parties", Alignment.center, TextAlign.center, 1.0, 20.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal("Share knowledge in different Companies, colleges and universities", Alignment.center, TextAlign.center, 1.0, 15.0, FontWeight.normal, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                    ],
                  ),
                ),
              ),

              Card(
                color: Color(0xFF4c4a78),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      textStyleNormal("About " + details["name"], Alignment.centerLeft, TextAlign.left, 2.0, 10.0, FontWeight.w600, 255, 255, 255, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal(details["description"], Alignment.centerLeft, TextAlign.left, 2.0, 8.0, FontWeight.normal, 255, 255, 255, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),

                      Row(
                        children: <Widget>[
                          whiteFlatButton("Github Page", details["github"]),
                          VerticalDivider(),
                          whiteFlatButton("Instagram Page", details["instagram"]),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      textStyleNormal("Partners", Alignment.centerLeft, TextAlign.left, 2.0, 10.0, FontWeight.w600, 0, 0, 0, 1.0),
                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),

                      RichText(
                        textAlign: TextAlign.left,
                        textScaleFactor: 2,
                        text: TextSpan(
                          children: <TextSpan>[
                            textStyleSpan("A very big thank you to all our partners for their continued partnership.", 8.0, FontWeight.normal, 0, 0, 0, 1.0),
                            textStyleSpan("\n\n", 0.0, FontWeight.normal, 0, 0, 0, 0.0),
                            textStyleSpan("If you’re interested in being showcased throughout ", 8.0, FontWeight.normal, 0, 0, 0, 1.0),
                            textStyleSpan(details["name"], 8.0, FontWeight.w600, 0, 0, 0, 1.0),
                            textStyleSpan(", contact ", 8.0, FontWeight.normal, 0, 0, 0, 1.0),
                            TextSpan(
                              text: details["email"] + " ",
                              style: GoogleFonts.openSans(
                                  fontSize: 8.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromRGBO(21, 101, 192, 1.0)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launchURL("mailto:" + details["email"]),
                            ),
                            textStyleSpan("to discuss sponsorship opportunities.", 8.0, FontWeight.normal, 0, 0, 0, 1.0),
                          ],
                        ),
                      ),

                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal("General Partners", Alignment.centerLeft, TextAlign.left, 2.0, 7.0, FontWeight.normal, 0, 0, 0, 1.0),
                      Divider(color: Colors.white),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => _launchURL("https://developers.google.com/groups"),
                            padding: EdgeInsets.all(0.0),
                            child: imageAsset("assets/images/gdglogo.png", 50.0),
                          ),

                          VerticalDivider(),

                          RaisedButton(
                            onPressed: () => _launchURL("https://www.womentechmakers.com/"),
                            padding: EdgeInsets.all(0.0),
                            child: imageAsset("assets/images/wtm.png", 50.0),
                          ),
                        ],
                      ),

                      Divider(color: Colors.white),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.white,
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          child: svgAsset("assets/svg/gdg-x.svg", "https://github.com/gdg-x", 50.0, 50.0),
                        ),
                      ),

                      textStyleNormal("\n", Alignment.centerLeft, TextAlign.left, 1.0, 10.0, FontWeight.normal, 0, 0, 0, 0.0),
                      textStyleNormal("Template Partner", Alignment.centerLeft, TextAlign.left, 2.0, 7.0, FontWeight.normal, 0, 0, 0, 1.0),
                      Divider(color: Colors.white),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: RaisedButton(
                          onPressed: () => _launchURL("https://gdgjalandhar.com/"),
                          padding: EdgeInsets.all(0.0),
                          child: imageAsset("assets/images/gdgjalandhar.png", 50.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4c8bf5),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EditHomePage(
                dscName: details["name"],
                shortDesc: details["shortDescription"],
                longDesc: details["description"],
                githubLink: details["github"],
                instagramLink: details["instagram"],
                email: details["email"],
                twitterLink: details["twitter"],
                about: details["about"],
                socials: details["socials"],
                tags: details["tags"],
                coc: details["coc"],
                cocInfo: details["cocInfo"],
              )
            )
          ).then((val){
            setState(() {
              details = null;
              hashTags.clear();
              getDetails();
            });
          });
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  textStyleSpan(String text, double size, weight, int r, int g, int b, double o) {
    return TextSpan(
      text: text,
      style: GoogleFonts.openSans(
          fontSize: size,
          fontWeight: weight,
          color: Color.fromRGBO(r, g, b, o)),
    );
  }

  textStyleNormal(String text, boxalign, textAlign, double scaleFactor, double size, weight, int r, int g, int b, double o) {
    return Align(
      alignment: boxalign,
      child: Text(
        text,
        textAlign: textAlign,
        textScaleFactor: scaleFactor,
        style: GoogleFonts.openSans(
            fontSize: size,
            fontWeight: weight,
            color: Color.fromRGBO(r, g, b, o)),
      ),
    );
  }

  blueRaisedButton(String text, String url) {
    return RaisedButton(
      child: textStyleNormal(text, Alignment.centerLeft, TextAlign.center, 1.0, 15.0, FontWeight.normal, 255, 255, 255, 1.0),
      onPressed: () =>  _launchURL(url),
      color: Color.fromRGBO(53, 131, 235, 1.0),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  cyanFlatButton(String text, String url) {
    return FlatButton(
      child: textStyleNormal(text, Alignment.centerLeft, TextAlign.center, 1.0, 15.0, FontWeight.w600, 0, 188, 212, 1.0),
      onPressed: () => _launchURL(url),
      highlightColor: Color.fromRGBO(225, 247, 250, 1.0),
      splashColor: Color.fromRGBO(168, 232, 240, 1.0),
      shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(0, 188, 212, 1.0)),borderRadius: BorderRadius.circular(5.0)),
    );
  }

  whiteFlatButton(String text, String url) {
    return FlatButton(
      child: textStyleNormal(text, Alignment.center, TextAlign.center, 1.0, 15.0, FontWeight.w600, 255, 255, 255, 1.0),
      onPressed: () => _launchURL(url),
      highlightColor: Color.fromRGBO(151, 150, 182, 1.0),
      splashColor: Color.fromRGBO(97, 95, 136, 1.0),
      shape: RoundedRectangleBorder(side: BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)), borderRadius: BorderRadius.circular(5.0)),
    );
  }

  imageAsset(String asset, double h) {
    return Image(
        image: AssetImage(asset),
        height: h,
    );
  }

  svgAsset(String asset, String url, double w, double h) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: SvgPicture.asset(
        asset,
        width: w,
        height: h,
      ),
    );
  }

  iconAsset(icon, color, size) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch: $url';
    }
  }
}
