import 'dart:io';
import 'dart:ui' as ui show Image;
import 'dart:ui' as ui show ImageByteFormat;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner_app/api/FireStorage.dart';
import 'package:scanner_app/api/FirebaseQrDetector.dart';

class QrCodeImage extends StatelessWidget {
  final String product;
   GlobalKey _repaint=GlobalKey();
   QrCodeImage({Key key, this.product}) : super(key: key);
Future<File> _captureByteData() async{
  RenderRepaintBoundary boundary=_repaint.currentContext.findRenderObject();
  ui.Image image=await boundary.toImage(
      pixelRatio: 3.0
  );
  var byteData=await image.toByteData(
    format:ui.ImageByteFormat.png
  );
  File imageFile=File(await FireStorage.getFilePath());
  return await FireStorage.writeQrImage(imageFile,byteData);
}
void _productCallback (product){

}
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: RepaintBoundary(
            key: _repaint,
            child: GestureDetector(
              onTap: (){
                _captureByteData().then((value){
                      FirebaseQrDetector(value,_productCallback).detectQrcode();
                });
              },
                          child: QrImage(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(40.0),
                data: product,
                size: 300,
              ),
            ),
          )),
    );
  }
}
