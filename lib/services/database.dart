import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('coffee');
}