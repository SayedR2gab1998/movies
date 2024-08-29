import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/api/home_api.dart';
import 'package:movies/firebase/firestore.dart';


class MovieBuildDetails extends StatefulWidget {
  final int id;
  const MovieBuildDetails({super.key, required this.id});

  @override
  State<MovieBuildDetails> createState() => _MovieBuildDetailsState();
}

class _MovieBuildDetailsState extends State<MovieBuildDetails> {
  late Future<Map<String, dynamic>> movieDetails;

  @override
  void initState() {
    movieDetails =  fetchMoviesDetails(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: movieDetails,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError){
            return Center(child: Text('Error : ${snapshot.error}'),);
          }
          else{
            final movie = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height*0.25,
                    width: double.infinity,
                    child: CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                      fit: BoxFit.fitWidth,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie['title'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24
                        ),
                      ),
                      Text(movie['release_date'],
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.33,
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*0.32,
                                  width: MediaQuery.of(context).size.width*0.37,
                                  decoration:BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/bookmark.png',),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                  child: IconButton(
                                      onPressed: (){
                                        addMovie(
                                          poster: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                          title: movie['title'],
                                          date: movie['release_date'],
                                          context: context,
                                          id: movie['id']
                                        );
                                      },
                                      icon: const Icon(Icons.add,color: Colors.white,)
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(movie['overview'],
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,color: Colors.amber,),
                                      Text('${movie['vote_average']}',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            );
          }
        }
    );
  }
}

