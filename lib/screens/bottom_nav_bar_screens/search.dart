

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movies/components/components.dart';
import 'package:movies/components/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movies/screens/movie_details/movie_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchCon = TextEditingController();
  List movies = [];

  Future<void> searchMovies(String query)async{
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=da6ff057b1fb87fab15bcd3d5693722f&query=$query'));
    if(response.statusCode == 200)
    {
     setState(() {
       movies = json.decode(response.body)['results'];
       print(movies);
     });
    }
    else{
      throw Exception('Failed to load search movies');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: true,
        title: const Text('Search For Movie',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            defaultTextFormField(
              controller: searchCon,
              validator: (value)=>value!.isEmpty?'Required':null,
              inputType: TextInputType.text,
              hint: 'search movie',
              prefix: Iconsax.search_normal,
              onChange: (value){
                setState(() {
                  searchMovies(searchCon.text);
                });
              }
            ),
            if(searchCon.text.isEmpty)
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.movie,color: Colors.white,size: 50,),
                    Text('Search Movies',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ),
            if(searchCon.text.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      navigateTo(context, MovieDetails(name:movies[index]['title'] , id: movies[index]['id']));
                    },
                    child: Card(
                      color: Colors.transparent,
                      child: ListTile(
                        leading: SizedBox(
                            height: 100,
                            width: 50,
                            child: CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w500${movies[index]['poster_path']}',
                                errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                            ),

                        ),
                        title: Text(movies[index]['title'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${movies[index]['release_date']}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,color: Colors.amber,),
                                const SizedBox(width: 10,),
                                Text('${movies[index]['vote_average']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
