import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // لمعرفة بيئة التشغيل
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as path;

class CreateNewProjectScreen extends StatefulWidget {
  const CreateNewProjectScreen({super.key});

  @override
  _CreateNewProjectScreenState createState() => _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  String titleProject = '';
  String _projectDescription = '';
 // String _projectRelatedSkills = '';
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
        setState(() {
          _selectedFile = null; // Reset any previous file object
        });
        print('Selected File Name: ${result.files.single.name}');
      } else {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    }
  }

  // رفع الملفات إلى Firebase Storage وإرجاع رابط التحميل
  Future<String?> _uploadFile(File file, String folder) async {
    try {
      String fileName = path.basename(file.path);
      Reference storageRef = FirebaseStorage.instance.ref().child('$folder/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  // نشر المشروع في Firestore
  Future<void> _publishProject() async {
    try {
      String? imageUrl;
      String? fileUrl;

      if (_selectedImage != null) {
        imageUrl = await _uploadFile(_selectedImage!, 'project_images');
      }
      if (_selectedFile != null) {
        fileUrl = await _uploadFile(_selectedFile!, 'project_files');
      }

      await FirebaseFirestore.instance.collection('projects').add({
        'title': titleProject,
        'description': _projectDescription,
      //  'relatedSkills': _projectRelatedSkills,
        'duration': _projectDuration,
        'expectedDelivery': _projectExpectedDeliveryTime,
        'imageUrl': imageUrl ?? _selectedImageWeb, // الصورة من الويب إن وُجدت
        'fileUrl': fileUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Project published successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error publishing project: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to publish project!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Center(
          child: Text(
            'Create New Project',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
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
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a project name' : null,
                ),
                // SizedBox(height: 14),
                // TextFormField(
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Skills ...',
                //     labelText: 'Project Related Skills (Optional)',
                //   ),
                //   onSaved: (value) => _projectRelatedSkills = value!,
                // ),
                SizedBox(height: 14.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description ...',
                    labelText: 'Describe The Project',
                  ),
                  maxLines: 5,
                  onSaved: (value) => _projectDescription = value!,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a project description' : null,
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
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter Expected Delivery Time' : null,
                ),
                SizedBox(height: 18.0),
                MaterialButton(
                  height: 56,
                  minWidth: double.infinity,
                  color: Color(0XFF003366),
                  textColor: Colors.white,
                  child: Text('Publish now'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _publishProject();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:flutter/foundation.dart'; // لمعرفة بيئة التشغيل
//
// class CreateNewProjectScreen extends StatefulWidget {
//   const CreateNewProjectScreen({super.key});
//
//   @override
//   _CreateNewProjectScreenState createState() => _CreateNewProjectScreenState();
// }
//
// class _CreateNewProjectScreenState extends State<CreateNewProjectScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String titleProject = '';
//   String _projectDescription = '';
//   String _projectRelatedSkills = '';
//   String _projectDuration = '1000- 2000';
//   String _projectExpectedDeliveryTime = '';
//
//   File? _selectedImage; // للهواتف
//   String? _selectedImageWeb; // للويب
//   File? _selectedFile;
//
//   // اختيار الصورة
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       if (kIsWeb) {
//         setState(() {
//           _selectedImageWeb = image.path;
//         });
//       } else {
//         setState(() {
//           _selectedImage = File(image.path);
//         });
//       }
//     }
//   }
//
//   // اختيار الملف
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       if (kIsWeb) {
//         // للويب: المسار غير متاح
//         setState(() {
//           _selectedFile = null; // Reset any previous file object
//         });
//         print('Selected File Name: ${result.files.single.name}');
//       } else {
//         // للهواتف: المسار متاح
//         setState(() {
//           _selectedFile = File(result.files.single.path!);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Create New Project',style: GoogleFonts.poppins(fontSize: 20,color: Colors.black),)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(30.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MaterialButton(
//                   color: Color(0XFFE7F0FF),
//                   elevation: 0,
//                   onPressed: pickImage,
//                   height: 116,
//                   minWidth: double.infinity,
//                   child: Icon(Icons.image, color: Colors.white, size: 45),
//                 ),
//                 if (_selectedImageWeb != null && kIsWeb)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Image.network(
//                       _selectedImageWeb!,
//                       height: 150,
//                       width: 150,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 if (_selectedImage != null && !kIsWeb)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Image.file(
//                       _selectedImage!,
//                       height: 150,
//                       width: 150,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'Title Your Project ...',
//                     labelText: 'Title Project',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSaved: (value) => titleProject = value!,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a project name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 14),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Skills ...',
//                     labelText: 'Project Related Skills (Optional)',
//                   ),
//                   onSaved: (value) => _projectRelatedSkills = value!,
//                 ),
//                 SizedBox(height: 14.0),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Description ...',
//                     labelText: 'Describe The Project',
//                   ),
//                   maxLines: 5,
//                   onSaved: (value) => _projectDescription = value!,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a project description';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 14.0),
//                 DropdownButtonFormField<String>(
//                   value: _projectDuration,
//                   decoration: InputDecoration(
//                     labelText: 'Expected Budget',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: [
//                     '1000- 2000',
//                     '2000- 5000',
//                     '5000 - 10000',
//                     'more than 10000',
//                   ].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _projectDuration = value!;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 14.0),
//                 TextFormField(
//                 keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Expected Delivery Time (In Days)',
//                     border: OutlineInputBorder(),
//                   ),
//                   onSaved: (value) => _projectExpectedDeliveryTime = value!,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Expected Delivery Time';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 18.0),
//                 // زر لاختيار الملف
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black54, width: 1),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: MaterialButton(
//                     onPressed: pickFile,
//                     child: ListTile(
//                       leading: Icon(Icons.attach_file, color: Colors.black),
//                       title: Text(
//                         'Attach files',
//                         style: GoogleFonts.poppins(fontSize: 18, color: Color(0XFF393939)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (_selectedFile != null )
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Text(
//                       'Selected File: ${_selectedFile!.path.split('/').last}',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 SizedBox(height: 19.0),
//                 MaterialButton(
//                   height: 56,
//                   minWidth: double.infinity,
//                   color: Color(0XFF003366),
//                   textColor: Colors.white,
//                   child: Text('Publish now'),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       print('Project Name: $titleProject');
//                       print('Project Description: $_projectDescription');
//                       print('Project Skills: $_projectRelatedSkills');
//                       print('Project Duration: $_projectDuration');
//                       print('Expected Delivery: $_projectExpectedDeliveryTime');
//                       print('Image Path: ${_selectedImage?.path}');
//                       print('Web Image Path: $_selectedImageWeb');
//                       print('File Path: ${_selectedFile?.path}');
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Project published successfully!'),
//                           duration: Duration(seconds: 2),
//                         ),
//                       );
//                     }else{
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Failed to publish project!'),
//                           duration: Duration(seconds: 2),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
