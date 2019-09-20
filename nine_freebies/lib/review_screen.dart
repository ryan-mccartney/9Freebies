import 'package:nine_freebies/camera.dart';
import 'package:flutter/material.dart';
import 'package:nine_freebies/review_rating_bar.dart';
import 'package:nine_freebies/roundedTextField.dart';
import 'package:nine_freebies/sharing_bar.dart';
import 'package:card_settings/card_settings.dart';
import 'package:nine_freebies/hashtag_text_field.dart';
import 'home.dart';
import 'registration.dart';

class ReviewScreen extends StatelessWidget {

  final ReviewItem reviewItem;

  ReviewScreen({
    Key key,
    this.reviewItem,
  }) : super (key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Review(reviewItem: reviewItem,)
    );
  }
}

class Review extends StatefulWidget {

  final ReviewItem reviewItem;

  Review({
    this.reviewItem,
  });

  @override
  ReviewForm createState() => ReviewForm(reviewItem: reviewItem);
}

class ReviewForm extends State<Review> {

  ReviewItem reviewItem;

  List<String> hashtags = new List<String>();

  ReviewForm({
    this.reviewItem,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/nine_freebies_logo.png'),
        backgroundColor: new Color(0xff1b2d36),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            backgroundColor: hexToColor("#1b2d36"),
            accentColor: hexToColor("#1b2d36"),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                fontSize: 14.0
              )
            )
          ),
          child: CardSettings.sectioned(
            children: <CardSettingsSection>[
              CardSettingsSection(
                header: CardSettingsHeader(label: 'Review - ${reviewItem.productName}'),
                instructions: CardSettingsInstructions(
                    text: 'How did you enjoy your "${reviewItem.productName}" freebie? \n\nTake a photo of your experience with your freebie, \nrate it, and share it with the world!'
                    
                  ),
              ),
              CardSettingsSection(
                header: CardSettingsHeader(label: 'Take a photo!'),
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      decoration: new BoxDecoration(          
                      color: Colors.white,                                            
                      ),                  
                      width: MediaQuery.of(context).size.width,
                      height: 290.0,
                      child: CameraWidget()
                  ),
                ]
              ),
              CardSettingsSection(
                header: CardSettingsHeader(label: 'Rate it!'),
                children: <Widget>[
                  new Container(
                        padding: EdgeInsets.only(top: 10.0),
                      decoration: new BoxDecoration(          
                        color: Colors.white,                                            
                        ),   
                        child: new RatingsWidget(fontColour: Colors.black, ratingQuestion: reviewItem.ratingQuestion,)
                      ),

                      // new Container(
                      //   padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      //   decoration: new BoxDecoration(          
                      //     color: Colors.white,                                            
                      //     ),   
                      //   child: new RoundedTextField(labelText: 'What did you think?', hintText: '', maxLines: 5, charLimit: 255, radius: 10.0, fontColour: Colors.black, borderColour: Colors.blue,)
                      // ),
                      CardSettingsParagraph(
                        label: 'How was your experience?',
                        initialValue: '',
                        numberOfLines: 5,
                        onSaved: (value) => reviewItem.productDescription = value,
                        onChanged: (value) {
                          setState(() {
                            reviewItem.productDescription = value;
                          });
                          //_showSnackBar('Description', value);
                        },
                      )                      
                ]
              ),
              CardSettingsSection(
                header: CardSettingsHeader(label: 'Share it!'),
                children: <Widget>[
                    CardSettingsMultiselect(
                        label: '#Tags',
                        initialValues: allHashtags(hashtags),
                        options: hashtags,
                        autovalidate: false,                        
                        validator: (List<String> value) {
                          if (value == null || value.isEmpty)
                            return 'You must add one hashtag!';

                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            reviewItem.userInputTags = allHashtags(hashtags);                            
                          });                          
                        },
                    ),
                    HashtagTextField(hashtagList: hashtags,),
                    Container(
                      decoration: new BoxDecoration(          
                        color: Colors.white,                                            
                      ),   
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: SharingWidget(detail: SharingDetail(isFacebookEnabled: true, isTwitterEnabled: true, isInstagramEnabled: false),),
                      )
                    ),
                  ],
              ),
              CardSettingsSection(
                children: <Widget>[
                  CardSettingsButton(
                    label: 'Continue',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoadingPage()));
                    },
                    visible: true,
                    backgroundColor: Colors.blueAccent,
                    bottomSpacing: 4.0
                  ),
                ]
              )
            ]
          )
        )
      )
    );
  }

  
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  List<String> allHashtags(List<String> additionalTags) {
    List<String> allTags = new List<String>();
    allTags.addAll(reviewItem.requiredTags);
    allTags.addAll(additionalTags);

    return allTags;
  }
}

class ReviewItem {

  ReviewItem({
    this.isTwitterShared,
    this.isInstagramShared,
    this.isFacebookShared,
    this.productDescription,
    this.productName,
    this.writtenReview,
    this.requiredTags,
    this.ratingQuestion
  });

  String productName = "Test Product";
  String productDescription = "This is a test product.";
  String ratingQuestion = "How did you find this freebie?";
  String writtenReview = "";
  List<String> requiredTags;
  List<String> userInputTags;

  bool isFacebookShared = false;
  bool isInstagramShared = false;
  bool isTwitterShared = false;
}