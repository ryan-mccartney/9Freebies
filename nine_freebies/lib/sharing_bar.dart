import 'package:flutter/material.dart';

class SharingWidget extends StatefulWidget {

SharingDetail detail;

  SharingWidget({
    Key key,
    this.detail
  });

  @override
  SharingState createState() => SharingState(detail: detail);
}

class SharingState extends State<SharingWidget> {

  SharingDetail detail;

  SharingState({
    this.detail
  });

  bool isFacebookEnabled;
  bool isInstagramEnabled;
  bool isTwitterEnabled;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
          Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          child: RawMaterialButton(
            onPressed: () {
              if (detail.isFacebookEnabled)  {
                final snackBar = SnackBar(content: Text('Successfully posted your review to your Facebook wall!'));
                Scaffold.of(context).showSnackBar(snackBar);
                detail.isFacebookEnabled = false;
              }
            },          
            child: Image(
                image: new AssetImage('assets/facebook_icon' + (detail.isFacebookEnabled ? '' : '_disabled') + '.png'),
                fit: BoxFit.fill
            ),
            shape: new CircleBorder(),
            elevation: 1.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
        Container(
          height: 80,
          width: 80,
          child: RawMaterialButton(
            onPressed: () {
              if (detail.isInstagramEnabled)  {
                final snackBar = SnackBar(content: Text('Successfully posted your review to Instagram! #nofilter'));
                Scaffold.of(context).showSnackBar(snackBar);
                detail.isInstagramEnabled = false;
              }
            },          
            child: Image(
                image: new AssetImage('assets/instagram_icon' + (detail.isInstagramEnabled ? '' : '_disabled') + '.png'),
                fit: BoxFit.fill
            ),
            shape: new CircleBorder(),
            elevation: 1.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
        Container(
          height: 80,
          width: 80,
          child: RawMaterialButton(                        
            onPressed: () {
              if (detail.isTwitterEnabled)  {
                final snackBar = SnackBar(content: Text('Successfully tweeted your review!'));
                Scaffold.of(context).showSnackBar(snackBar);
                detail.isTwitterEnabled = false;
              }
            },          
            child: Image(
                image: new AssetImage('assets/twitter_icon' + (detail.isTwitterEnabled ? '' : '_disabled') + '.png'),
                fit: BoxFit.fill,                
            ),
            shape: new CircleBorder(),
            elevation: 1.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
      ],
    );
  }

}

class SharingDetail {

  SharingDetail({
    this.isTwitterEnabled,
    this.isInstagramEnabled,
    this.isFacebookEnabled
  });

  bool isFacebookEnabled = true;
  bool isInstagramEnabled = true;
  bool isTwitterEnabled = true;
}