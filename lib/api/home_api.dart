import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/components/constants.dart';


Future<List<dynamic>> fetchPopularMovies()async{
  final response = await http.get(Uri.parse('${baseUrl}popular'),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDYzNzg1Mi44MDA2NTksInN1YiI6IjY2Y2IyMDIwZGQzZjRhMTViNDJkNjE0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GIP7i44m0vHe9j-nIW3-cNx0ZFhZ-_Xcvd9fUicyF7s',
      }
  );
  if(response.statusCode == 200)
  {
    Map<String,dynamic> data = jsonDecode(response.body);
    List<dynamic> movie = data['results'];
    return movie;
  }
  else{
    throw Exception('Failed to load popular movies');
  }
}

Future<List<dynamic>> fetchNewReleaseMovies()async{
  final response = await http.get(Uri.parse('${baseUrl}upcoming'),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDYzNzg1Mi44MDA2NTksInN1YiI6IjY2Y2IyMDIwZGQzZjRhMTViNDJkNjE0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GIP7i44m0vHe9j-nIW3-cNx0ZFhZ-_Xcvd9fUicyF7s',
      }
  );
  if(response.statusCode == 200)
  {
    Map<String,dynamic> data = jsonDecode(response.body);
    List<dynamic> movie = data['results'];
    return movie;
  }
  else{
    throw Exception('Failed to load New Release movies');
  }
}

Future<List<dynamic>> fetchRecomendedMovies()async{
  final response = await http.get(Uri.parse('${baseUrl}top_rated'),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDYzNzg1Mi44MDA2NTksInN1YiI6IjY2Y2IyMDIwZGQzZjRhMTViNDJkNjE0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GIP7i44m0vHe9j-nIW3-cNx0ZFhZ-_Xcvd9fUicyF7s',
      }
  );
  if(response.statusCode == 200)
  {
    Map<String,dynamic> data = jsonDecode(response.body);
    List<dynamic> movie = data['results'];
    return movie;
  }
  else{
    throw Exception('Failed to load Top Rated movies');
  }
}


Future<Map<String, dynamic>> fetchMoviesDetails(int id)async{
  final response = await http.get(Uri.parse('$baseUrl$id'),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDYzNzg1Mi44MDA2NTksInN1YiI6IjY2Y2IyMDIwZGQzZjRhMTViNDJkNjE0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GIP7i44m0vHe9j-nIW3-cNx0ZFhZ-_Xcvd9fUicyF7s',
      }
  );
  if(response.statusCode == 200)
  {
    return json.decode(response.body);
  }
  else{
    throw Exception('Failed to load Top Rated movies');
  }
}



Future<List> fetchSimilarMovies(int id)async{
  final response = await http.get(Uri.parse('$baseUrl$id/similar'),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTZmZjA1N2IxZmI4N2ZhYjE1YmNkM2Q1NjkzNzIyZiIsIm5iZiI6MTcyNDYzNzg1Mi44MDA2NTksInN1YiI6IjY2Y2IyMDIwZGQzZjRhMTViNDJkNjE0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GIP7i44m0vHe9j-nIW3-cNx0ZFhZ-_Xcvd9fUicyF7s',
      }
  );
  if(response.statusCode == 200)
  {
    Map<String,dynamic> data = jsonDecode(response.body);
    List<dynamic> movie = data['results'];
    return movie;
  }
  else{
    throw Exception('Failed to load Top Rated movies');
  }
}