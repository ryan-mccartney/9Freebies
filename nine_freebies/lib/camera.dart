import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;


List<CameraDescription> cameras;

class CameraWidget extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraWidget> {
  List<CameraDescription> cameras;
  CameraController controller;
  Future<void> _initialiseControllerFuture;
  bool showCamera = true;
  String imagePath;

  @override
  void initState() {
    super.initState();

    initialiseCameras();
  }

  Future<void> initialiseCameras() async { 
    cameras = await availableCameras();
    setState(() {
          controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
        _initialiseControllerFuture = controller.initialize();
    });
  }

  String timeStamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder<void>( 
        future: _initialiseControllerFuture,
        builder: (context, snapshot) {
          return Container (
          width: MediaQuery.of(context).size.width,
           child: showCamera ?
                (snapshot.connectionState == ConnectionState.done
                  ? Column(
                    children: <Widget>[
                      Expanded(
                      child: cameraPreviewWidget()),
                      captureControlWidget(),
                    ],
                  )
                  : Center(child: CircularProgressIndicator()))
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: imagePreviewWidget(),
                      ),                      
                        resetCaptureControlWidget(),
                    ]                     
                  )
          );
        }        
      )
    );
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    // final Directory extDir = await getApplicationDocumentsDirectory();
    // final String dirPath = '${extDir.path}/Picture/9Freebies/ReviewSnaps';
    // await Directory(dirPath).create(recursive: true);
    // final String filePath = '$dirPath/${timeStamp()}.jpg';
    final filePath = join((await getTemporaryDirectory()).path, '${timeStamp()}');

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      return null;
    }

    return filePath;
  }

  Widget cameraPreviewWidget() {
    return squareClippedContainer(CameraPreview(controller));
  }
  
  Widget imagePreviewWidget() {
    return imagePath == null ? null : squareClippedContainer(Image.file(File(imagePath)));
  }

  Container squareClippedContainer(element) {
    var size = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10.0),
      width: size,
      height: size,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: size,
              height:
                  size / controller.value.aspectRatio,
              child: element,
            ),
          ),
        ),
      ),
    );
  }

  Widget captureControlWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: RawMaterialButton(                        
          onPressed: () async {
            await _initialiseControllerFuture;
            onTakePicturePressed();
          },          
          child: new Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 30.0,
          ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.blue,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
      ],
    );
  }

  Widget resetCaptureControlWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new RawMaterialButton(
          onPressed: () async {
            setState(() {
             showCamera = true;
             imagePath = null; 
            });
          },
          child: new Icon(
            Icons.refresh,
            color: Colors.white,
            size: 30.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.blue,
          padding: const EdgeInsets.all(15.0)
        ),
      ],
    );
  }

  void onTakePicturePressed() async {
    await takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
         showCamera = false;
         imagePath = filePath; 
        });
      }
    });
  }

}