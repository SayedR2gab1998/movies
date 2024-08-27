
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movies/api/home_api.dart';
import 'package:movies/components/components.dart';
import 'package:movies/components/constants.dart';
import 'package:movies/screens/widgets/movie_details.dart';

class MovieDetails extends StatefulWidget {
  final int id;
  final String name;
  const MovieDetails({super.key, required this.name, required this.id});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: const Icon(Iconsax.arrow_left_1,color: Colors.white,),
        ),
        title: Text(widget.name,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white
          ),
        ),
      ),
      body:Column(
        children: [
          MovieBuildDetails(id: widget.id),
          Container(
            height: MediaQuery.of(context).size.height*0.33,
            color: containersBackground,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('More Like This',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: FutureBuilder(
                      future: fetchSimilarMovies(widget.id),
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
                                      width: MediaQuery.of(context).size.height*0.18,
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
                                                height: 110,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
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
                                                    onPressed: (){},
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
                                                Text('${movie['original_title']}',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white
                                                  ),
                                                ),
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
          ),
        ],
      ),
    );
  }
}
