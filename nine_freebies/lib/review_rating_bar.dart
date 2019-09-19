import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsWidget extends StatefulWidget {

  final Color fontColour;

  RatingsWidget({
    key,
    this.fontColour,
  }) : super(key: key);

  @override
  RatingsState createState() => RatingsState();
}

class RatingsState extends State<RatingsWidget> {

  double _rating = 5.0;
  
  Widget bar; 

    @override
    void initState() {
    super.initState();       

    bar = FlutterRatingBar(
            initialRating: _rating,
            fillColor: Colors.amber,
            borderColor: Colors.amber.withAlpha(50),
            allowHalfRating: true,
            onRatingUpdate: (rating) {
              setState(() {
               _rating = rating; 
              });
            }          
          );
  }

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: <Widget>[
          bar,
          Center(
            child: Text('Rating: ${_rating.toString()}', style: TextStyle(color: widget.fontColour, fontWeight: FontWeight.w900),)
          ),
        ],
      );
  }
}
