import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movies/screens/bottom_nav_bar_screens/browse.dart';
import 'package:movies/screens/bottom_nav_bar_screens/home.dart';
import 'package:movies/screens/bottom_nav_bar_screens/search.dart';
import 'package:movies/screens/bottom_nav_bar_screens/wish_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex= 0;
  List<Widget> screens =[
    const Home(),
    const Search(),
    const Browse(),
    const WishList(),
  ];
  void onItemTapped(int index) {
    setState(() {
      index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          screens[currentIndex],
          Positioned(
            right: 20,
            left: 20,
            bottom: 20,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              decoration:  BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 25,
                    offset: Offset(8, 20), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BottomNavigationBar(
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: const Color(0xff1f2029),
                  currentIndex: currentIndex,
                  onTap: (index){
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  items:  const [
                    BottomNavigationBarItem(
                        icon: Icon(Iconsax.home),
                        label: '',
                        backgroundColor:  Color(0xff1f2029)
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Iconsax.search_normal),
                        label: '',
                        backgroundColor:  Color(0xff1f2029)
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.movie),
                        label: '',
                        backgroundColor:  Color(0xff1f2029)
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: '',
                        backgroundColor:  Color(0xff1f2029)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
