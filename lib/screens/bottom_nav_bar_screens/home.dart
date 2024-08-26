import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movies/api/home_api.dart';
import 'package:movies/components/constants.dart';
import 'package:movies/screens/widgets/banners_of_movies.dart';
import 'package:movies/screens/widgets/new_release_movies.dart';
import 'package:movies/screens/widgets/recomended_movies.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body:  ListView(
          children: [
            const BannersOfMovies(),
            const SizedBox(height: 20,),
            const NewReleaseMovies(),
            const SizedBox(height: 20,),
            const RecomendedMovies(),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          ],
        ),
      ),
    );
  }
}
