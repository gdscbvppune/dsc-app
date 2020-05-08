import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'authService.dart';
import '../pages/homePage.dart';
import '../pages/eventsPage.dart';
import '../pages/teamPage.dart';
import '../pages/cocPage.dart';

enum Pages {
  HOME,
  EVENTS,
  TEAM,
  COC,
}

class PageHandler extends StatefulWidget {
  PageHandler(this.name, this.email, this.imageUrl);

  final String name;
  final String email;
  final String imageUrl;

  @override
  _PageHandlerState createState() => _PageHandlerState();
}

class _PageHandlerState extends State<PageHandler> {
  Pages _page = Pages.HOME;
  String _pageTitle = "Home";

  List<String> _pageTitles = [
    "Home",
    "Events",
    "Team",
    "Code of Conduct",
  ];

  List<Color> _colors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent[400],
    Colors.purpleAccent,
  ];

  List<Icon> _icons = [
    Icon(Icons.home),
    Icon(Icons.event),
    Icon(Icons.people),
    Icon(Icons.receipt),
  ];

  Widget _drawerHeader() {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: DrawerHeader(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.black26,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.imageUrl),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
          child: Container(
            decoration: BoxDecoration(color: Colors.black12),
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 72.0,
                    height: 72.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.black38,
                      backgroundImage: NetworkImage(widget.imageUrl),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    widget.email,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logOutButton() {
    return IconButton(
      color: Colors.black.withOpacity(0.75),
      tooltip: "Logout",
      icon: Icon(FontAwesomeIcons.signOutAlt),
      onPressed: () {
        _logOutAlert();
      },
    );
  }

  void _logOutAlert() {
    var borderShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: borderShape,
        title: Text("Logout ?"),
        actions: [
          FlatButton(
            color: Colors.blueAccent.withOpacity(0.2),
            shape: borderShape,
            child: Text("Yes", style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.pop(context);
              AuthProvider().signOutGoogle();
            },
          ),
          FlatButton(
            color: Colors.blueAccent.withOpacity(0.2),
            shape: borderShape,
            child: Text("No", style: TextStyle(color: Colors.black)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _aboutDSC() {
    var linkStyle = TextStyle(
      color: Color.fromRGBO(21, 101, 192, 1.0),
      decoration: TextDecoration.underline,
    );

    String url1 = "https://dscbvppune.team";
    String url2 = "https://github.com/dscbvppune/dsc";

    launchUrl(url) async => await canLaunch(url) ? await launch(url) : throw "Could not launch: $url";

    showAboutDialog(
      context: context,
      applicationIcon: Image(
        height: 60.0,
        image: AssetImage("assets/logos/dsc_logo.png"),
      ),
      applicationLegalese: "© 2020 DSC BVP Pune",
      applicationName: "Developers Student Clubs",
      applicationVersion: "Version 2.0.0",
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(text: "\nA companion app for the DSC website repository. DSC websites can be updated using this app on-the-fly.\n\n"),
              TextSpan(text: "Website - "),
              TextSpan(
                style: linkStyle,
                text: url1,
                recognizer: TapGestureRecognizer()..onTap = () => launchUrl(url1),
              ),
              TextSpan(text: "\n\nGithub - "),
              TextSpan(
                style: linkStyle,
                text: url2,
                recognizer: TapGestureRecognizer()..onTap = () => launchUrl(url2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _pageSwitch(page) {
      switch (page) {
        case Pages.HOME:
          return new HomePage();
          break;

        case Pages.EVENTS:
          return new EventsPage();
          break;

        case Pages.TEAM:
          return new TeamPage();
          break;

        case Pages.COC:
          return new COCPage();
          break;
      }
      return null;
    }

    _pageSelect(selectedPage, title) {
      Navigator.pop(context);
      setState(() {
        _pageTitle = title;
        _page = selectedPage;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[200],
        title: Text(
          _pageTitle,
          style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: "About",
            icon: Icon(Icons.info_outline),
            onPressed: () => _aboutDSC(),
          )
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text("Tap back again to exit"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _pageSwitch(_page),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  /*UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      ),
                    ),
                    accountName: Text(
                      name,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                    ),
                    accountEmail: Text(
                      email,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),*/
                  /// Custom User Account Drawer Header
                  /// (as we can't blur background images in [UserAccountsDrawerHeader] widget for now)
                  _drawerHeader(),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      return Material(
                        clipBehavior: Clip.hardEdge,
                        color: _page == Pages.values[i] ? _colors[i].withOpacity(0.25) : Colors.transparent,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(100.0)),
                        child: ListTile(
                          leading: Icon(
                            _icons[i].icon,
                            color: _page == Pages.values[i] ? _colors[i] : Colors.black,
                          ),
                          title: Text(
                            _pageTitles[i],
                            style: GoogleFonts.roboto(
                              color: _page == Pages.values[i] ? _colors[i] : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            _pageSelect(Pages.values[i], _pageTitles[i]);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.info, color: Colors.grey[600]),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      "DSC Web App",
                      style: GoogleFonts.roboto(color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              trailing: _logOutButton(),
            ),
          ],
        ),
      ),
    );
  }
}
