import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:scanner_app/api/FireStorage.dart';
import 'dart:io';

import 'package:scanner_app/api/FirebaseQrDetector.dart';
import 'package:scanner_app/model/Product.dart';
import 'package:scanner_app/widgets/ScannedProduct.dart';

class Scanner extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scanner> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isInitialized = false;
  Product _product;
  void _initializeCamera() {
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        isInitialized = true;
      });
    });
  }
  void _productCallback(Product product){
    if(product!=null){
      setState(() {
        _product=product;
      });
    }
  }

  _getCameras() async {
    cameras = await availableCameras();
    if (cameras.length > 0) _initializeCamera();
  }

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  Future<String> saveQrCode() async {
    final String filePath = await FireStorage.getFilePath();
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      throw Exception('Failed to capture picture : $e');
    }
    return filePath;
  }
  Future<File> _cropImage(File imageFile) async{
     return await ImageCropper.cropImage(
       sourcePath: imageFile.path,
       maxWidth:250,
       maxHeight: 250,
       aspectRatio: CropAspectRatio(ratioX: 1.0,ratioY: 1.0));
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized)
      return Container();
    else
      return ListView(children: <Widget>[
        Column(
        children: <Widget>[
          Container(
            width: 200,
            height: 200,
            child: ClipRect(
                child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  width: 250,
                  height: 250/controller.value.aspectRatio,
                  child: CameraPreview(controller)
                ),
              ),
            )),
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              size: 50,
            ),
            onPressed: (){
              saveQrCode().then((value){
                _cropImage(File(value)).then((croppedimage){
                   FirebaseQrDetector(croppedimage,_productCallback).detectQrcode();

                });
              });
            },
          )
        ],
      ),
      ScannedProduct(product: _product,)
      ],);
  }
}
