import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGuidelines extends StatefulWidget {
  final String pageTitle, title, description;
  final int index;
  List listOfGuidelines = List();
  AddGuidelines({this.pageTitle, this.title, this.description, this.listOfGuidelines, this.index});

  @override
  _AddGuidelinesState createState() => _AddGuidelinesState();
}

class _AddGuidelinesState extends State<AddGuidelines> {
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode valueFocusNode = FocusNode();

  @override
  void initState() {
    titleController.text = widget.title;
    valueController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 64,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: TextFormField(
              focusNode: titleFocusNode,
              autocorrect: false,
              autofocus: true,
              controller: titleController,
              onFieldSubmitted: (val){
                titleController.text = val;
              },
              onEditingComplete: (){
                titleFocusNode.unfocus();
                FocusScope.of(context).requestFocus(valueFocusNode);
              },
              decoration: InputDecoration(
                suffix: Text(
                  "*"
                ),
                suffixStyle: TextStyle(
                  color: Colors.red
                ),
                labelText: "Title"
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              validator: (value){
                if(value.isEmpty){
                  return 'This field is mandatory';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: TextFormField(
              focusNode: valueFocusNode,
              autocorrect: false,
              controller: valueController,
              onFieldSubmitted: (val){
                valueController.text = val;
              },
              onEditingComplete: (){
                valueFocusNode.unfocus();
              },
              decoration: InputDecoration(
                suffix: Text(
                  "*"
                ),
                suffixStyle: TextStyle(
                  color: Colors.red
                ),
                labelText: "Description"
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              validator: (value){
                if(value.isEmpty){
                  return 'This field is mandatory';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 64,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Map<String, dynamic> details = {
            "name": titleController.text,
            "des": valueController.text
          };
          if(widget.index == null){
            widget.listOfGuidelines.add(details);
          }
          else{
            widget.listOfGuidelines.removeAt(widget.index);
            widget.listOfGuidelines.add(details);
          }
          var ref = await Firestore.instance.collection("details").document("details").get();
          Map tempMap = ref.data;
          tempMap["coc"] = widget.listOfGuidelines;
          await Firestore.instance.collection("details").document("details").delete();
          var tempRef = Firestore.instance.collection("details").document("details");
          tempRef.setData(tempMap);
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}