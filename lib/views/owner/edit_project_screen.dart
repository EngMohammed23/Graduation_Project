import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProjectScreen extends StatefulWidget {
  final String projectId;
  final Map<String, dynamic> projectData;

  const EditProjectScreen({
    Key? key,
    required this.projectId,
    required this.projectData,
  }) : super(key: key);

  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;
  late String _relatedSkills;
  late String _duration;
  late String _expectedDelivery;

  @override
  void initState() {
    super.initState();
    _title = widget.projectData['title'] ?? '';
    _description = widget.projectData['description'] ?? '';
    _relatedSkills = widget.projectData['relatedSkills'] ?? '';
    _duration = widget.projectData['duration'] ?? '1000- 2000';
    _expectedDelivery = widget.projectData['expectedDelivery'] ?? '';
  }

  Future<void> _updateProject() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseFirestore.instance.collection('projects').doc(widget.projectId).update({
          'title': _title,
          'description': _description,
          'relatedSkills': _relatedSkills,
          'duration': _duration,
          'expectedDelivery': _expectedDelivery,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('projectUpdated'.tr())),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${'errorUpdatingProject'.tr()}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('editProject'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'projectTitle'.tr()),
                onSaved: (value) => _title = value!.trim(),
                validator: (value) => (value == null || value.isEmpty) ? 'enterProjectTitle'.tr() : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'projectDescription'.tr()),
                maxLines: 4,
                onSaved: (value) => _description = value!.trim(),
                validator: (value) => (value == null || value.isEmpty) ? 'enterProjectDescription'.tr() : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: _relatedSkills,
                decoration: InputDecoration(labelText: 'relatedSkills'.tr()),
                onSaved: (value) => _relatedSkills = value!.trim(),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _duration,
                decoration: InputDecoration(labelText: 'expectedBudget'.tr()),
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
                    _duration = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: _expectedDelivery,
                decoration: InputDecoration(labelText: 'expectedDeliveryTime'.tr()),
                keyboardType: TextInputType.number,
                onSaved: (value) => _expectedDelivery = value!.trim(),
                validator: (value) => (value == null || value.isEmpty) ? 'enterExpectedDeliveryTime'.tr() : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _updateProject,
                child: Text('saveChanges'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class EditProjectScreen extends StatefulWidget {
//   final String projectId;            // معرّف المشروع في Firestore
//   final Map<String, dynamic> projectData; // بيانات المشروع الحالية
//
//   const EditProjectScreen({
//     Key? key,
//     required this.projectId,
//     required this.projectData,
//   }) : super(key: key);
//
//   @override
//   State<EditProjectScreen> createState() => _EditProjectScreenState();
// }
//
// class _EditProjectScreenState extends State<EditProjectScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   // متغيرات لتخزين قيم الحقول
//   late String _title;
//   late String _description;
//   late String _relatedSkills;
//   late String _duration;
//   late String _expectedDelivery;
//
//   @override
//   void initState() {
//     super.initState();
//     // تهيئة القيم الافتراضية من بيانات المشروع الحالية
//     _title = widget.projectData['title'] ?? '';
//     _description = widget.projectData['description'] ?? '';
//     _relatedSkills = widget.projectData['relatedSkills'] ?? '';
//     _duration = widget.projectData['duration'] ?? '1000- 2000';
//     _expectedDelivery = widget.projectData['expectedDelivery'] ?? '';
//   }
//
//   // دالة لحفظ التعديلات
//   Future<void> _updateProject() async {
//     // التحقق من صحة الحقول
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//
//       try {
//         // تحديث البيانات في Firestore
//         await FirebaseFirestore.instance.collection('projects').doc(widget.projectId).update({
//           'title': _title,
//           'description': _description,
//           'relatedSkills': _relatedSkills,
//           'duration': _duration,
//           'expectedDelivery': _expectedDelivery,
//         });
//
//         // الرجوع إلى شاشة المشاريع
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('تم تحديث المشروع بنجاح!')),
//         );
//         Navigator.pop(context);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('حدث خطأ أثناء التحديث: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تعديل المشروع'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // حقل العنوان
//               TextFormField(
//                 initialValue: _title,
//                 decoration: const InputDecoration(labelText: 'عنوان المشروع'),
//                 onSaved: (value) => _title = value!.trim(),
//                 validator: (value) =>
//                 (value == null || value.isEmpty) ? 'الرجاء إدخال عنوان المشروع' : null,
//               ),
//               const SizedBox(height: 16),
//
//               // حقل الوصف
//               TextFormField(
//                 initialValue: _description,
//                 decoration: const InputDecoration(labelText: 'وصف المشروع'),
//                 maxLines: 4,
//                 onSaved: (value) => _description = value!.trim(),
//                 validator: (value) =>
//                 (value == null || value.isEmpty) ? 'الرجاء إدخال وصف للمشروع' : null,
//               ),
//               const SizedBox(height: 16),
//
//               // المهارات
//               TextFormField(
//                 initialValue: _relatedSkills,
//                 decoration: const InputDecoration(labelText: 'المهارات المرتبطة (اختياري)'),
//                 onSaved: (value) => _relatedSkills = value!.trim(),
//               ),
//               const SizedBox(height: 16),
//
//               // الميزانية المتوقعة
//               DropdownButtonFormField<String>(
//                 value: _duration,
//                 decoration: const InputDecoration(labelText: 'الميزانية المتوقعة'),
//                 items: const [
//                   DropdownMenuItem(value: '1000- 2000', child: Text('1000- 2000')),
//                   DropdownMenuItem(value: '2000- 5000', child: Text('2000- 5000')),
//                   DropdownMenuItem(value: '5000 - 10000', child: Text('5000 - 10000')),
//                   DropdownMenuItem(value: 'more than 10000', child: Text('more than 10000')),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     _duration = value!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               // زمن التسليم
//               TextFormField(
//                 initialValue: _expectedDelivery,
//                 decoration: const InputDecoration(labelText: 'زمن التسليم المتوقع (بالأيام)'),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) => _expectedDelivery = value!.trim(),
//                 validator: (value) =>
//                 (value == null || value.isEmpty) ? 'الرجاء إدخال زمن التسليم' : null,
//               ),
//               const SizedBox(height: 24),
//
//               // زر حفظ التعديلات
//               ElevatedButton(
//                 onPressed: _updateProject,
//                 child: const Text('حفظ التعديلات'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }