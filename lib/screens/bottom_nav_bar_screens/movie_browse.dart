import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movies/api/home_api.dart';
import 'package:movies/components/constants.dart';
import 'package:movies/models/movie_by_genre.dart';

class MovieBrowse extends StatefulWidget {
  final String name;
  final List<int> genreIds;

  const MovieBrowse({super.key, required this.name, required this.genreIds});

  @override
  State<MovieBrowse> createState() => _MovieBrowseState();
}

class _MovieBrowseState extends State<MovieBrowse> {


  late Future<MovieList> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMoviesByGenres(widget.genreIds);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: const Icon(Iconsax.arrow_left_1,color: Colors.white,)
        ),
        title: Text(widget.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future:futureMovies,
            builder: (context,snapshot){
              if(snapshot.hasData)
                {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,  // Number of columns in the grid
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.6,  // Adjust the aspect ratio of the grid items
                    ),
                    itemBuilder: (context,index){
                      final movie = snapshot.data!.movies[index];
                      return Card(
                        elevation: 2.0,
                        color: Colors.transparent,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(movie.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,color: Colors.amber,),
                                      const SizedBox(width: 10,),
                                      Text('${movie.vote_average}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
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
                    },
                    itemCount: snapshot.data!.movies.length,
                  );
                }
              else if(snapshot.hasError) {
                return const Center(child: Text('Error'),);
              }
              else{return const CircularProgressIndicator();}
            }
          ),
        ),
      ),
    );
  }
}
