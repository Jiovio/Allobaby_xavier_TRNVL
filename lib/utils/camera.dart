import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io' as Io;
import 'dart:convert' as convert;
import 'dart:io';
class Imageutils {


  final picker = ImagePicker();


  Future<List<Object>?> getImageFromCamera(String path) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (pickedFile != null) {
     final image = File(pickedFile.path);

    String url =  await OurFirebase.uploadImageToFirebase( path, "${DateTime.now().toIso8601String()}.jpg", image);

      Fluttertoast.showToast(
          msg: "Image Uploaded Successfully", backgroundColor: PrimaryColor);

          return [url,image];
    } else {
      print('No image selected.');
            Fluttertoast.showToast(
          msg: "No Image Selected", backgroundColor: PrimaryColor);
          return null;
    }

  }

    Future<List<Object>?> getImageFromGallery(String path) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {

      final image = File(pickedFile.path);

      String url =  await OurFirebase.uploadImageToFirebase( path, "${DateTime.now().toIso8601String()}.jpg",image);

      Fluttertoast.showToast(
          msg: "Image Uploaded Successfully", backgroundColor: PrimaryColor);

          return [url,image];
    } else {
      print('No image selected.');
            Fluttertoast.showToast(
          msg: "No Image Selected", backgroundColor: PrimaryColor);

          return null;
    }


  }


}

