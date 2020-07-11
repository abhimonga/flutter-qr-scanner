import 'package:flutter/material.dart';
import 'package:scanner_app/widgets/QrCodeImage.dart';
import 'package:scanner_app/widgets/QrForm.dart';
class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}
class _CreateState extends State<Create>{
  String _product;
  void _productCallback(product){
    setState(() {
      _product=product;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_product != null)
      return Column(
        children: <Widget>[
          QrForm(
            serializedCallback: _productCallback,
          ),
          QrCodeImage(
            product: _product,
          ),
        ],
      );
    else
      return Column(
        children: <Widget>[
          QrForm(
            serializedCallback: _productCallback,
          ),
          Container(),
        ],
      );
  }

}
