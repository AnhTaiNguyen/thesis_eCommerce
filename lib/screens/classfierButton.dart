import 'dart:io';

import 'package:eCommerce/classfication/classifier_float.dart';

// import 'package:eCommerce/features/products/domain/prodel.dart';
import 'package:eCommerce/features/products/presentation/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart' as tf;

import '../classfication/classifier.dart';

class ClassfierButton extends StatefulWidget {
  const ClassfierButton({super.key});
  static const String routeName = '/find';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ClassfierButton(),
    );
  }

  @override
  State<ClassfierButton> createState() => _ClassfierButtonState();
}

class _ClassfierButtonState extends State<ClassfierButton> {
  late Classifier _classifier;

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();
  ProductScreen? productScreen;

  Image? _imageWidget;

  img.Image? fox;

  tf.Category? category;

  late final String name;

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierFloat();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      category = pred;
    });
    // w
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // Close the options modal
              Navigator.of(context).pop();
              getImage();
              // pickImageGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // Close the options modal
              Navigator.of(context).pop();

              // pickimage_camera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[200],
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'PUT YOUR IMAGE HERE ',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black,
                fontSize: 20.0),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          // const Spacer(),
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _imageWidget,
                  ),
          ),
          SizedBox(
            height: 36,
          ),
          Text(
            category != null ? category!.label : '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          // Text(
          //   category != null
          //       ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
          //       : '',
          //   style: TextStyle(fontSize: 16),
          // ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/products',
                  );
                },
                child: Text(
                  category != null
                      ? 'Move to see ${category!.label} product'
                      : '',
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
