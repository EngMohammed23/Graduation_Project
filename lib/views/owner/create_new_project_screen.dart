import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String _projectDuration = '1000- 2000';
  String _projectExpectedDeliveryTime = '';

  File? _selectedImage;
  String? _selectedImageWeb;
  File? _selectedFile;

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

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (kIsWeb) {
        setState(() {
          _selectedFile = null;
        });
      } else {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    }
  }

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

      // الحصول على الـ userId من Firebase Authentication
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // في حال لم يكن هناك مستخدم مسجل دخوله
        return;
      }
      String userId = user.uid;  // userId الحالي

      // إضافة المشروع إلى Firestore
      await FirebaseFirestore.instance.collection('projects').add({
        'title': titleProject,
        'description': _projectDescription,
        'duration': _projectDuration,
        'expectedDelivery': _projectExpectedDeliveryTime,
        'imageUrl': imageUrl ?? _selectedImageWeb,
        'fileUrl': fileUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': userId,  // إضافة الـ userId هنا
      });

      // مسح الحقول بعد النجاح
      clearFields();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('projectPublished'.tr()),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error publishing project: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('projectPublishFailed'.tr()),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Future<void> _publishProject() async {
  //   try {
  //     String? imageUrl;
  //     String? fileUrl;
  //
  //     if (_selectedImage != null) {
  //       imageUrl = await _uploadFile(_selectedImage!, 'project_images');
  //     }
  //     if (_selectedFile != null) {
  //       fileUrl = await _uploadFile(_selectedFile!, 'project_files');
  //     }
  //
  //     await FirebaseFirestore.instance.collection('projects').add({
  //       'title': titleProject,
  //       'description': _projectDescription,
  //       'duration': _projectDuration,
  //       'expectedDelivery': _projectExpectedDeliveryTime,
  //       'imageUrl': imageUrl ?? _selectedImageWeb,
  //       'fileUrl': fileUrl,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //
  //     // مسح الحقول بعد النجاح
  //     clearFields();
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('projectPublished'.tr()),
  //         backgroundColor: Colors.green,
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   } catch (e) {
  //     print('Error publishing project: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('projectPublishFailed'.tr()),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }

  void clearFields() {
    setState(() {
      titleProject = '';
      _projectDescription = '';
      _projectDuration = '1000- 2000';
      _projectExpectedDeliveryTime = '';
      _selectedImage = null;
      _selectedImageWeb = null;
      _selectedFile = null;
    });

    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Center(
          child: Text(
            'createNewProject'.tr(),
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
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
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'titleProjectHint'.tr(),
                    labelText: 'titleProject'.tr(),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => titleProject = value!,
                  validator: (value) => value == null || value.isEmpty ? 'enterProjectTitle'.tr() : null,
                ),
                SizedBox(height: 14.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'descriptionHint'.tr(),
                    labelText: 'projectDescription'.tr(),
                  ),
                  maxLines: 5,
                  onSaved: (value) => _projectDescription = value!,
                  validator: (value) => value == null || value.isEmpty ? 'enterProjectDescription'.tr() : null,
                ),
                SizedBox(height: 14.0),
                DropdownButtonFormField<String>(
                  value: _projectDuration,
                  decoration: InputDecoration(
                    labelText: 'expectedBudget'.tr(),
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
                    labelText: 'expectedDeliveryTime'.tr(),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _projectExpectedDeliveryTime = value!,
                  validator: (value) => value == null || value.isEmpty ? 'enterExpectedDeliveryTime'.tr() : null,
                ),
                SizedBox(height: 18.0),
                MaterialButton(
                  height: 56,
                  minWidth: double.infinity,
                  color: Color(0XFF003366),
                  textColor: Colors.white,
                  child: Text('publishNow'.tr()),
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
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as path;
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
//   String _projectDuration = '1000- 2000';
//   String _projectExpectedDeliveryTime = '';
//
//   File? _selectedImage;
//   String? _selectedImageWeb;
//   File? _selectedFile;
//
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
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       if (kIsWeb) {
//         setState(() {
//           _selectedFile = null;
//         });
//       } else {
//         setState(() {
//           _selectedFile = File(result.files.single.path!);
//         });
//       }
//     }
//   }
//
//   Future<String?> _uploadFile(File file, String folder) async {
//     try {
//       String fileName = path.basename(file.path);
//       Reference storageRef = FirebaseStorage.instance.ref().child('$folder/$fileName');
//       UploadTask uploadTask = storageRef.putFile(file);
//       TaskSnapshot snapshot = await uploadTask;
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       print('Error uploading file: $e');
//       return null;
//     }
//   }
//
//   Future<void> _publishProject() async {
//     try {
//       String? imageUrl;
//       String? fileUrl;
//
//       if (_selectedImage != null) {
//         imageUrl = await _uploadFile(_selectedImage!, 'project_images');
//       }
//       if (_selectedFile != null) {
//         fileUrl = await _uploadFile(_selectedFile!, 'project_files');
//       }
//
//       await FirebaseFirestore.instance.collection('projects').add({
//         'title': titleProject,
//         'description': _projectDescription,
//         'duration': _projectDuration,
//         'expectedDelivery': _projectExpectedDeliveryTime,
//         'imageUrl': imageUrl ?? _selectedImageWeb,
//         'fileUrl': fileUrl,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('projectPublished'.tr()),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } catch (e) {
//       print('Error publishing project: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('projectPublishFailed'.tr()),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Text(''),
//         title: Center(
//           child: Text(
//             'createNewProject'.tr(),
//             style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
//           ),
//         ),
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
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'titleProjectHint'.tr(),
//                     labelText: 'titleProject'.tr(),
//                     border: OutlineInputBorder(),
//                   ),
//                   onSaved: (value) => titleProject = value!,
//                   validator: (value) => value == null || value.isEmpty ? 'enterProjectTitle'.tr() : null,
//                 ),
//                 SizedBox(height: 14.0),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'descriptionHint'.tr(),
//                     labelText: 'projectDescription'.tr(),
//                   ),
//                   maxLines: 5,
//                   onSaved: (value) => _projectDescription = value!,
//                   validator: (value) => value == null || value.isEmpty ? 'enterProjectDescription'.tr() : null,
//                 ),
//                 SizedBox(height: 14.0),
//                 DropdownButtonFormField<String>(
//                   value: _projectDuration,
//                   decoration: InputDecoration(
//                     labelText: 'expectedBudget'.tr(),
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
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'expectedDeliveryTime'.tr(),
//                     border: OutlineInputBorder(),
//                   ),
//                   onSaved: (value) => _projectExpectedDeliveryTime = value!,
//                   validator: (value) => value == null || value.isEmpty ? 'enterExpectedDeliveryTime'.tr() : null,
//                 ),
//                 SizedBox(height: 18.0),
//                 MaterialButton(
//                   height: 56,
//                   minWidth: double.infinity,
//                   color: Color(0XFF003366),
//                   textColor: Colors.white,
//                   child: Text('publishNow'.tr()),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       _publishProject();
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
