import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/api/home_api.dart';
import 'package:movies/components/components.dart';
import 'package:movies/components/constants.dart';
import 'package:movies/screens/movie_details/movie_details.dart';

class NewReleaseMovies extends StatelessWidget {
  const NewReleaseMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.25,
      color: containersBackground,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('New Release',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            FutureBuilder(
                future: fetchNewReleaseMovies(),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  else{
                    return Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          final movie = snapshot.data![index];
                          return Card(
                            child: GestureDetector(
                              onTap: (){navigateTo(context, MovieDetails(
                                name: '${movie['original_title']}',
                                id: movie['id'],
                             ));},
                                child: CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}')),
                          );
                        },
                        separatorBuilder: (context,index)=>const SizedBox(width: 12,),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
