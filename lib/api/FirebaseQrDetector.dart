import 'dart:convert';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:scanner_app/model/Product.dart';

class FirebaseQrDetector{
  final File imagefile;
  final Function(Product) _productCallback;
  FirebaseQrDetector(this.imagefile, this._productCallback);
  void detectQrcode() async{
     final visionImage=FirebaseVisionImage.fromFile(imagefile);
     BarcodeDetectorOptions options=BarcodeDetectorOptions(barcodeFormats: 
     BarcodeFormat.qrCode);
     final detector=FirebaseVision.instance.barcodeDetector(options);
     List<Barcode> barcodes=await detector.detectInImage(visionImage);
     _extractProducts(barcodes);
  }
  _extractProducts(List<Barcode> barcodes){
    for(Barcode barcode in barcodes){
         final String rawvalue=barcode.rawValue;
         final Map productMap=json.decode(rawvalue);
         final Product product=Product.fromJSON(productMap);
         _productCallback(product);
    }
  }
}