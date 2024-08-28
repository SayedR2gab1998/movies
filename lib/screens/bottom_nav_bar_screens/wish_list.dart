

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/components/constants.dart';
import 'package:movies/models/watch_list.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> movies = FirebaseFirestore.instance.collection('movies').snapshots();
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: true,
        title: const Text('Watch List',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: movies,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            List<WatchList> watchList = [];
            for(int i =0;i<snapshot.data!.docs.length;i++){
              watchList.add(WatchList.fromJson(snapshot.data!.docs[i]));
            }
            return ListView.builder(
              itemCount: watchList.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: CachedNetworkImage(imageUrl: watchList[index].poster),
                  title: Text(watchList[index].title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(watchList[index].date,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
            );
          }
          else if(snapshot.hasError){
            return const Center(
              child: Text('Data Error from data base',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            );
          }
          else{
            return const Center(
              child: Text('Data Error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            );
          }

        }
      ),
    );
  }
}
