import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addGuidelines.dart';

class ManageCommunityGuidelinesScreen extends StatefulWidget {
  @override
  _ManageCommunityGuidelinesScreenState createState() => _ManageCommunityGuidelinesScreenState();
}

class _ManageCommunityGuidelinesScreenState extends State<ManageCommunityGuidelinesScreen> {
  List<Widget> listOfGuidelines = List();
  List<Map> updatedGuidelinesList = List();

  fetchCOC() async{
    var details = await Firestore.instance.collection("details").document("details").get();
    for (var item in details["coc"]){
      var tempTile = ListTile(
        title: Text(
          item["name"]
        ),
        subtitle: Text(
          item["des"]
        ),
      );
      listOfGuidelines.add(tempTile);
      Map<String, dynamic> tempDetails = {
        "name": item["name"],
        "des": item["des"]
      };
      updatedGuidelinesList.add(tempDetails);
      setState(() {
        
      });
    }
  }

  Future<bool> checkDelete(DismissDirection direction) async {
          return showDialog(context: context,
        builder: (context)=>AlertDialog(title: Text("Do you want to delete this guideline ?"),
        actions: <Widget>[
          FlatButton(child: Text("Yes"), onPressed: () => Navigator.pop(context,true)),
          FlatButton(child: Text("No"), onPressed: () => Navigator.pop(context,false))
        ],
        ),

        )?? false;
      }

  @override
  void initState() {
    fetchCOC();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Community Guidelines"
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 12
        ),
        child: ListView.builder(
          itemCount: listOfGuidelines.length,
          itemBuilder: (BuildContext context, int index){
            if(listOfGuidelines.length == 0){
              return Center(
                child: Text(
                  "Add Guidelines"
                ),
              );
            }
            else{
              return Dismissible(
                key: Key(index.toString()),
                background: Container(
                  color: Colors.blue,
                ),
                confirmDismiss: (direction) => checkDelete(direction),
                onDismissed: (direction) async{
                  listOfGuidelines.removeAt(index);
                  updatedGuidelinesList.removeAt(index);
                  var ref = await Firestore.instance.collection("details").document("details").get();
                  Map tempMap = ref.data;
                  tempMap["coc"] = updatedGuidelinesList;
                  await Firestore.instance.collection("details").document("details").delete();
                  var tempRef = Firestore.instance.collection("details").document("details");
                  tempRef.setData(tempMap);
                  setState(() {
                    
                  });
                },
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AddGuidelines(
                          pageTitle: "Edit Guidelines",
                          title: updatedGuidelinesList[index]["name"],
                          description: updatedGuidelinesList[index]["des"],
                          listOfGuidelines: updatedGuidelinesList,
                          index: index,
                        )
                      )
                    ).then((onValue){
                      setState(() {
                        updatedGuidelinesList.clear();
                        listOfGuidelines.clear();
                        fetchCOC();
                      });
                    });
                  },
                  child: listOfGuidelines[index]
                )
              );
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddGuidelines(
                pageTitle: "Add Guidelines",
                title: "",
                description: "",
                listOfGuidelines: updatedGuidelinesList,
              )
            )
          ).then((onValue){
            setState(() {
              updatedGuidelinesList.clear();
              listOfGuidelines.clear();
              fetchCOC();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}