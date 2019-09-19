import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsWidget extends StatefulWidget {

  final Color fontColour;
  final String ratingQuestion;

  RatingsWidget({
    key,
    this.fontColour,
    this.ratingQuestion
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
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
            child: Align(
            alignment: Alignment.centerLeft,
            child: Text('${widget.ratingQuestion}', style: TextStyle(color: widget.fontColour, fontWeight: FontWeight.w700),)
            ),
          ),
          bar,
          Center(
            child: Text('Rating: ${_rating.toString()}', style: TextStyle(color: widget.fontColour, fontWeight: FontWeight.w900),)
          ),
        ],
      );
  }
}
