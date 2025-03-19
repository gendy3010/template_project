import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      showSnackbar('Image selected from gallery.');

    }
  }

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      showSnackbar('Image captured from camera.');

    }
  }

  Future<void> uploadFile(File file) async {
    var request = http.MultipartRequest('POST', Uri.parse('YOUR_API_URL'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      showSnackbar('File uploaded successfully!');
    } else {
      showSnackbar('File upload failed.');
    }
  }
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.tr()), // استخدم الترجمة هنا إذا كنت بحاجة لذلك
        duration: Duration(seconds: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image').tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('no_image_selected').tr()
                : Image.file(_image!),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('ar'));
                  },
                  child: Text('العربية'),
                ),
                SizedBox(width: 8,),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('en'));
                  },
                  child: Text('English'),
                ),

              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImageFromGallery,
              child: Text('choose_from_gallery').tr(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: pickImageFromCamera,
                  child: Text('open_camera').tr(),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_image != null) {
                      uploadFile(_image!);
                    } else {
                      showSnackbar('Please select an image first.');
                    }
                  },
                  child: Text('upload_image').tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
