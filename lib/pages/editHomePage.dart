import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditHomePage extends StatefulWidget {

  final dscName, shortDesc, longDesc, githubLink, instaLink, twitterLink, email, about, cocInfo, coc, socials;
  final List tags;
  EditHomePage({this.dscName, this.shortDesc, this.longDesc, this.githubLink, this.instaLink, this.twitterLink, this.email, this.about, this.cocInfo, this.coc, this.socials, this.tags});

  @override
  _EditHomePageState createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {

  FocusNode dscNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode aboutFocusNode = FocusNode();
  FocusNode shortDescFocusNode = FocusNode();
  FocusNode longDescFocusNode = FocusNode();
  FocusNode githubLinkFocusNode = FocusNode();
  FocusNode instaLinkFocusNode = FocusNode();
  FocusNode twitterLinkFocusNode = FocusNode();

  TextEditingController dscNameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController shortDescController = TextEditingController();
  TextEditingController longDescController = TextEditingController();
  TextEditingController githubLinkDescController = TextEditingController();
  TextEditingController instaLinkController = TextEditingController();
  TextEditingController twitterLinkController = TextEditingController();

  @override
  void initState() {
    dscNameController.text = widget.dscName;
    shortDescController.text = widget.shortDesc;
    longDescController.text = widget.longDesc;
    githubLinkDescController.text = widget.githubLink;
    instaLinkController.text = widget.instaLink;
    twitterLinkController.text = widget.twitterLink;
    emailController.text = widget.email;
    aboutController.text = widget.about;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details"
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  focusNode: dscNameFocusNode,
                  decoration: InputDecoration(
                    hintText: "For eg (DSC BVP Pune)",
                    labelText: "DSC Chapter Name"
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: dscNameController,
                  onFieldSubmitted: (val){
                    dscNameController.text = val;
                  },
                  onEditingComplete: (){
                    dscNameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(emailFocusNode);
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: emailFocusNode,
                  autocorrect: false,
                  controller: emailController,
                  onFieldSubmitted: (val){
                    emailController.text = val;
                  },
                  onEditingComplete: (){
                    emailFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(twitterLinkFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "for eg. dscbvppune@gmail.com",
                    labelText: "DSC Email Contact"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: twitterLinkFocusNode,
                  autocorrect: false,
                  controller: twitterLinkController,
                  onFieldSubmitted: (val){
                    twitterLinkController.text = val;
                  },
                  onEditingComplete: (){
                    twitterLinkFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(instaLinkFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "for eg. twitter.com/dscbvppune",
                    labelText: "DSC Twitter Link"
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: instaLinkFocusNode,
                  autocorrect: false,
                  controller: instaLinkController,
                  onFieldSubmitted: (val){
                    instaLinkController.text = val;
                  },
                  onEditingComplete: (){
                    instaLinkFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(githubLinkFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "for eg. instagram.com/dscbvppune",
                    labelText: "DSC Instagram Link"
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: githubLinkFocusNode,
                  autocorrect: false,
                  controller: githubLinkDescController,
                  onFieldSubmitted: (val){
                    githubLinkDescController.text = val;
                  },
                  onEditingComplete: (){
                    githubLinkFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(shortDescFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "for eg. github.com/dscbvppune",
                    labelText: "DSC Github Link"
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: shortDescFocusNode,
                  autocorrect: false,
                  controller: shortDescController,
                  onFieldSubmitted: (val){
                    shortDescController.text = val;
                  },
                  onEditingComplete: (){
                    shortDescFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(longDescFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "A simple one line description",
                    labelText: "Short Description"
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: longDescFocusNode,
                  autocorrect: false,
                  controller: longDescController,
                  onFieldSubmitted: (val){
                    longDescController.text = val;
                  },
                  onEditingComplete: (){
                    longDescFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(aboutFocusNode);
                  },
                  decoration: InputDecoration(
                    hintText: "Detailed description about our DSC Chapter",
                    labelText: "Long Description"
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  focusNode: aboutFocusNode,
                  autocorrect: false,
                  controller: aboutController,
                  onFieldSubmitted: (val){
                    aboutController.text = val;
                  },
                  onEditingComplete: (){
                    aboutFocusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "What is DSC",
                    labelText: "About DSC"
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if(value.isEmpty){
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 36,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Submit Final Details",
        backgroundColor: Color(0xFF4c8bf5),
        onPressed: () async{
          var ref = Firestore.instance;
          Map<String, dynamic> details = {
            "name": dscNameController.text,
            "email": emailController.text,
            "twitter": twitterLinkController.text,
            "instagram": instaLinkController.text,
            "github": githubLinkDescController.text,
            "shortDescription": shortDescController.text,
            "description": longDescController.text,
            "about": aboutController.text,
            "coc": widget.coc,
            "aboutDSCLink": 'https://developers.google.com/community/dsc',
            "cocInfo": widget.cocInfo,
            "becomeMemberURL": '',
            "socials": widget.socials,
            "tags": widget.tags
          };
          var temp = ref.collection("details").document("details");
          temp.delete();
          ref.collection("details").document("details").setData(details);
          Navigator.pop(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}