import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String expectedDelivery;
  final String duration;
  final String imageUrl;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.expectedDelivery,
    required this.duration,
    required this.imageUrl,
  });

  // لتحويل البيانات من Firestore إلى Model
  factory ProjectModel.fromMap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProjectModel(
      id: doc.id,  // استخدام ID من Firestore مباشرة
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? 'No Description',
      expectedDelivery: data['expectedDelivery'] ?? 'Unknown',
      duration: data['duration'] ?? 'Unknown',
      imageUrl: data['imageUrl'] ?? 'assets/images/three.jpg',
    );
  }
}
