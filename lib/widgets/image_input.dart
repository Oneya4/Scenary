import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    //In the line below, we reffer to the already converted path _storedImage after setState. Image Fie will cause an error because it is yet to be resolved
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: deviceSize.width * .62,
          height: deviceSize.height * .33,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(18),
          ),
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                )
              : Text('No Image Taken', textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera_enhance),
            label: Text('Take Picture'),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
