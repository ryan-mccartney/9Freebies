import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'loaders/color_loader_2.dart';
import 'utils.dart';
import 'review_screen.dart';

class QRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: QRCode());
  }
}

class QRCode extends StatefulWidget {
  @override
  QRCodePresenter createState() => QRCodePresenter();
}

class QRCodePresenter extends State<QRCode> {
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
                        labelStyle: TextStyle(fontSize: 14.0))),
                child: CardSettings.sectioned(children: <CardSettingsSection>[
                  CardSettingsSection(
                    header: Image.asset('assets/frame.png'),
                  ),
                  CardSettingsSection(
                    header: CardSettingsHeader(label: 'Freebie Invitation'),
                    instructions: CardSettingsInstructions(
                        text:
                            'Congratulations - we have a new sample waiting for you!\n\nA new launch from A2 Milk, a lactose-free milk from the number \n1 milk suppliers in Australia.\n\nScan this QR code at your nearest Coles or Woolworths to \nredeem your free sample.\nMake sure to share your experience!\n\nOne product per code. \nRead full Terms and Conditions for further info.'),
                  ),
                  CardSettingsSection(children: <Widget>[
                    CardSettingsButton(
                        label: 'Continue',
                        onPressed: _savePressed,
                        backgroundColor: Colors.blueAccent,
                        bottomSpacing: 4.0),
                  ])
                ]))));
  }

  Future _savePressed() async {
    var requiredTags = List<String>();
    requiredTags.add('#hackathon2019');
    requiredTags.add('#9freebies');

    var reviewItem = new ReviewItem(
      productName: 'A2 Lactose-Free Milk',
      requiredTags: requiredTags,
      ratingQuestion: 'How did you find this Freebie?'
    );

    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReviewScreen(
                    reviewItem: reviewItem,
                  )));
    }
  }
}

class CouponLoadingPage extends StatefulWidget {
  @override
  _CouponLoadingPageState createState() => _CouponLoadingPageState();
}

class _CouponLoadingPageState extends State<CouponLoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((__) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => QRCodePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexToColor("#1b2d36"),
        body: Center(
            child: Container(
                color: hexToColor("#1b2d36"),
                child: ColorLoader2(
                    color1: Colors.lightBlueAccent,
                    color2: Colors.redAccent,
                    color3: Colors
                        .blueAccent)))); // this widget stays here for 2 seconds
  }
}
