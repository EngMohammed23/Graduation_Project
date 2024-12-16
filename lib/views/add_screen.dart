import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // لمعرفة بيئة التشغيل

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  String titleProject = '';
  String _projectDescription = '';
  String _projectRelatedSkills = '';
  String _projectDuration = '1000- 2000';
  String _projectExpectedDeliveryTime = '';

  File? _selectedImage; // للهواتف
  String? _selectedImageWeb; // للويب
  File? _selectedFile;

  // اختيار الصورة
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        setState(() {
          _selectedImageWeb = image.path;
        });
      } else {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    }
  }

  // اختيار الملف
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (kIsWeb) {
        // للويب: المسار غير متاح
        setState(() {
          _selectedFile = null; // Reset any previous file object
        });
        print('Selected File Name: ${result.files.single.name}');
      } else {
        // للهواتف: المسار متاح
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  color: Color(0XFFE7F0FF),
                  elevation: 0,
                  onPressed: pickImage,
                  height: 116,
                  minWidth: double.infinity,
                  child: Icon(Icons.image, color: Colors.white, size: 45),
                ),
                if (_selectedImageWeb != null && kIsWeb)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.network(
                      _selectedImageWeb!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                if (_selectedImage != null && !kIsWeb)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.file(
                      _selectedImage!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title Your Project ...',
                    labelText: 'Title Project',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => titleProject = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Skills ...',
                    labelText: 'Project Related Skills (Optional)',
                  ),
                  onSaved: (value) => _projectRelatedSkills = value!,
                ),
                SizedBox(height: 14.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description ...',
                    labelText: 'Describe The Project',
                  ),
                  maxLines: 5,
                  onSaved: (value) => _projectDescription = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14.0),
                DropdownButtonFormField<String>(
                  value: _projectDuration,
                  decoration: InputDecoration(
                    labelText: 'Expected Budget',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    '1000- 2000',
                    '2000- 5000',
                    '5000 - 10000',
                    'more than 10000',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _projectDuration = value!;
                    });
                  },
                ),
                SizedBox(height: 14.0),
                TextFormField(
                keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Expected Delivery Time (In Days)',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _projectExpectedDeliveryTime = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Expected Delivery Time';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18.0),
                // زر لاختيار الملف
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: MaterialButton(
                    onPressed: pickFile,
                    child: ListTile(
                      leading: Icon(Icons.attach_file, color: Colors.black),
                      title: Text(
                        'Attach files',
                        style: GoogleFonts.poppins(fontSize: 18, color: Color(0XFF393939)),
                      ),
                    ),
                  ),
                ),
                if (_selectedFile != null )
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Selected File: ${_selectedFile!.path.split('/').last}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                SizedBox(height: 19.0),
                MaterialButton(
                  height: 56,
                  minWidth: double.infinity,
                  color: Color(0XFF003366),
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print('Project Name: $titleProject');
                      print('Project Description: $_projectDescription');
                      print('Project Skills: $_projectRelatedSkills');
                      print('Project Duration: $_projectDuration');
                      print('Expected Delivery: $_projectExpectedDeliveryTime');
                      print('Image Path: ${_selectedImage?.path}');
                      print('Web Image Path: $_selectedImageWeb');
                      print('File Path: ${_selectedFile?.path}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Project published successfully!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to publish project!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text('Publish now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
