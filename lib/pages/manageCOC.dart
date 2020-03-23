import 'addGuidelines.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageCommunityGuidelinesScreen extends StatefulWidget {
  @override
  _ManageCommunityGuidelinesScreenState createState() => _ManageCommunityGuidelinesScreenState();
}

class _ManageCommunityGuidelinesScreenState extends State<ManageCommunityGuidelinesScreen> {

  List<Widget> listOfGuidelines = List();
  List<Map> updatedGuidlinesList = List();

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
      updatedGuidlinesList.add(tempDetails);
      setState(() {
        
      });
    }
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
                onDismissed: (direction) async{
                  listOfGuidelines.removeAt(index);
                  updatedGuidlinesList.removeAt(index);
                  var ref = await Firestore.instance.collection("details").document("details").get();
                  Map tempMap = ref.data;
                  tempMap["coc"] = updatedGuidlinesList;
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
                          title: updatedGuidlinesList[index]["name"],
                          description: updatedGuidlinesList[index]["des"],
                          listOfGuidelines: updatedGuidlinesList,
                          index: index,
                        )
                      )
                    ).then((onValue){
                      setState(() {
                        updatedGuidlinesList.clear();
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
                listOfGuidelines: updatedGuidlinesList,
              )
            )
          ).then((onValue){
            setState(() {
              updatedGuidlinesList.clear();
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