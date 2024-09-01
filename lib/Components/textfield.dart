import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TFField extends StatelessWidget {
  TFField(
      {Key? key,
      this.validator,
      this.function,
       this.txtController,
      this.rOnly,
      required this.label,
      this.kType,
      this.oChanged,
      this.mLength,
      this.oText,
      this.mLines,
      this.iFormatter})
      : super(key: key);
  String? Function(String?)? validator;
  TextEditingController? txtController;
  String label;
  void Function()? function;
  void Function(String)? oChanged;
  bool? rOnly;
  List<TextInputFormatter>? iFormatter;
  TextInputType? kType;
  int? mLength;
  bool? oText;
  int? mLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      obscureText: oText ?? false,
      maxLength: mLength,
      validator: validator,
      onChanged: oChanged ?? (value) {},
      maxLines: mLines,
      onTap: function,
      readOnly: rOnly ?? false,
      controller: txtController,
      decoration: InputDecoration(labelText: label,border:OutlineInputBorder()),
      inputFormatters: iFormatter,
      keyboardType: kType,
    );
  }
}
