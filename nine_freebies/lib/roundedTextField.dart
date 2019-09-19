import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {

  final TextEditingController _textFieldController = TextEditingController();

  final String labelText;
  final String hintText;
  final double radius;
  final int maxLines;
  final int charLimit;
  final Color fontColour;
  final Color borderColour;

  RoundedTextField({
    Key key,
    this.labelText,
    this.hintText,
    this.radius,
    this.maxLines,
    this.charLimit,
    this.fontColour,
    this.borderColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
            controller: _textFieldController,
            maxLines: maxLines, 
            maxLength: charLimit,     
            style: TextStyle(color: fontColour),                  
            decoration: InputDecoration(
              labelText: labelText,
              hasFloatingPlaceholder: true,
              hintText: hintText,
              counterStyle: TextStyle(color: fontColour, fontWeight: FontWeight.w900),
              hintStyle: TextStyle(color: fontColour),
              labelStyle: TextStyle(color: fontColour, fontWeight: FontWeight.w900), 
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColour, width: 1),
                borderRadius: BorderRadius.circular(radius), 
              ),           
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),                
              ),
            ),
          );
  }
}