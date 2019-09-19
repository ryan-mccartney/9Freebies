import 'package:flutter/material.dart';
 
class HashtagTextField extends StatefulWidget {

 final List<String> hashtagList;

 HashtagTextField({
   this.hashtagList
 });
 
  @override
  HashTagTextFieldState createState() => HashTagTextFieldState(hashtagList: hashtagList);
 
}
 
class HashTagTextFieldState extends State<HashtagTextField> {
 
  final myController = TextEditingController();

  HashTagTextFieldState({
    this.hashtagList,
  });

  List<String> hashtagList;

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }
 
  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: myController,
              onChanged: (text) {
                if (text.endsWith(',')) {
                  String tag = '#' + (text.substring(0, text.length - 1));
                  if (!hashtagList.contains(tag)) {
                    hashtagList.add(tag);
                  }
                  myController.text = '';
                }
              })
          ]
        )
    );
    }
 
}