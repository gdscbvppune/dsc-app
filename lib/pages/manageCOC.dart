import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addGuidelines.dart';

class ManageCommunityGuidelinesScreen extends StatefulWidget {
  @override
  _ManageCommunityGuidelinesScreenState createState() => _ManageCommunityGuidelinesScreenState();
}

class _ManageCommunityGuidelinesScreenState extends State<ManageCommunityGuidelinesScreen> {
  List<Widget> _listOfGuidelines = List();
  List<Map> _updatedGuidelinesList = List();

  _fetchGuidelines() async {
    var details = await Firestore.instance.collection("details").document("details").get();
    for (var item in details["coc"]) {
      _listOfGuidelines.add(
        ListTile(
          title: Text(item["name"]),
          subtitle: Text(item["des"]),
        ),
      );
      Map<String, dynamic> tempDetails = {"name": item["name"], "des": item["des"]};
      _updatedGuidelinesList.add(tempDetails);
      setState(() {});
    }
  }

  Future<bool> _confirmDismiss(DismissDirection direction) async {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Do you want to delete this guideline ?"),
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

  Future<bool> _deleteGuideline(index) async {
    try {
      var ref = [];
      ref.add(_updatedGuidelinesList[index]);
      await Firestore.instance.collection("details").document('details').updateData({"coc": FieldValue.arrayRemove(ref)});
      return true;
    } catch (e) {
      return false;
    }
  }

  void _clearGuidelines() {
    setState(() {
      _updatedGuidelinesList.clear();
      _listOfGuidelines.clear();
      _fetchGuidelines();
    });
  }

  @override
  void initState() {
    _fetchGuidelines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Community Guidelines"),
        centerTitle: true,
      ),
      body: _listOfGuidelines.length == 0
          ? Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: Text(
                "Add Guidelines",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              physics: BouncingScrollPhysics(),
              itemCount: _listOfGuidelines.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: EdgeInsets.only(right: 25.0),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete_forever,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) => _confirmDismiss(direction),
                      onDismissed: (direction) async {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(await _deleteGuideline(index) ? "Guideline deleted successfully !" : "An error occured while deleting guideline !"),
                          ),
                        );
                        _clearGuidelines();
                      },
                      child: InkWell(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AddGuidelines(
                                    pageTitle: "Edit Guidelines",
                                    title: _updatedGuidelinesList[index]["name"],
                                    description: _updatedGuidelinesList[index]["des"],
                                    listOfGuidelines: _updatedGuidelinesList,
                                    index: index,
                                  ),
                                ),
                              ).then((onValue) => _clearGuidelines()),
                          child: _listOfGuidelines[index])),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddGuidelines(
                pageTitle: "Add Guidelines",
                title: "",
                description: "",
                listOfGuidelines: _updatedGuidelinesList,
              ),
            ),
          ).then((onValue) => _clearGuidelines());
        },
      ),
    );
  }
}
