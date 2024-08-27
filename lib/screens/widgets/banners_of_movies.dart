import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/api/home_api.dart';
import 'package:movies/components/components.dart';
import 'package:movies/screens/movie_details/movie_details.dart';

class BannersOfMovies extends StatelessWidget {
  const BannersOfMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.4,
      child: FutureBuilder(
          future: fetchPopularMovies(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            else{
              return CarouselSlider(
                items: snapshot.data!.map((movie){
                  return GestureDetector(
                    onTap: (){
                      navigateTo(context, MovieDetails(
                        name: '${movie['original_title']}',
                        id: movie['id'],
                      )
                      );
                    },
                    child: Stack(
                      children: [
                        CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                          fit: BoxFit.cover,
                          height: 270,
                        ),
                        Positioned(
                          left: 20,bottom: 0,
                          child: SizedBox(
                            width: 160,
                            child: CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'),
                          ),
                        ),
                        Positioned(
                          left: 190,
                          bottom: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${movie['original_title']}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                              ),
                              Row(
                                children: [
                                  Text('${movie['release_date']}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 400.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                ),
              );
            }
          }
      ),
    );
  }
}
