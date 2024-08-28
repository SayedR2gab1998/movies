import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/api/home_api.dart';
import 'package:movies/components/components.dart';
import 'package:movies/components/constants.dart';
import 'package:movies/firebase/firestore.dart';
import 'package:movies/screens/movie_details/movie_details.dart';

class RecomendedMovies extends StatelessWidget {
  const RecomendedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.41,
      color: containersBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recomended',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder(
                future: fetchRecomendedMovies(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  else{
                    return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          final movie = snapshot.data![index];
                          return GestureDetector(
                            onTap: (){
                              navigateTo(context, MovieDetails(name: '${movie['original_title']},',
                                id: movie['id'],
                              ));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.height*0.2,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: const Color(0xff343534),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                            height: 200,
                                            width: double.infinity,
                                            fit: BoxFit.cover
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
                                                title: '${movie['original_title']}',
                                                date: '${movie['release_date']}',
                                              );
                                            },
                                            icon: const Icon(Icons.add,color: Colors.white,)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.star,color: Colors.amber,),
                                              const SizedBox(width: 10,),
                                              Text('${movie['vote_average']}',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Text('${movie['original_title']}',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          Text('${movie['release_date']}',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          );
                        },
                        separatorBuilder: (context,index)=>const SizedBox(width: 12,),
                        itemCount: snapshot.data!.length
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
