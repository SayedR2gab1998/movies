import 'package:cloud_firestore/cloud_firestore.dart';


addMovie({
  required String poster,
  required String title,
  required String date,
}){
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference movies = firestore.collection('movies');

  movies.add({
    'poster_path':poster,
    'title':title,
    'date':date,
  });
}