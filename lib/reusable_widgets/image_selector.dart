import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCarousel extends StatefulWidget {
  final void Function(List<XFile>) onImagesSelected;

  const ImageCarousel({Key? key, required this.onImagesSelected}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
      widget.onImagesSelected(_images);
    }
  }

  Future<void> _removeImage(int index) async {
    setState(() {
      _images.removeAt(index);
    });
    widget.onImagesSelected(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < _images.length; i++)
          Stack(
            children: [
              Image.file(
                File(_images[i].path),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () => _removeImage(i),
                  icon: Icon(Icons.close),
                ),
              ),
            ],
          ),
        if (_images.length < 3)
          IconButton(
            onPressed: _selectImage,
            icon: const Icon(Icons.add),
          ),
      ],
    );
  }
}