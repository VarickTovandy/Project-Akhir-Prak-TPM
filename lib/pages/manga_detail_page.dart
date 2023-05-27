import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:line_icons/line_icons.dart';

import 'package:project_manga/theme/colors.dart';
import 'package:project_manga/pages/favorite_manga_page.dart';

class MangaDetailPage extends StatefulWidget {
  final Map manga;

  const MangaDetailPage({Key? key, required this.manga}) : super(key: key);

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteManga().isFavorite(widget.manga);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Menambahkan atau menghapus agent dari daftar favorite
    if (isFavorite) {
      FavoriteManga().addToFavorites(widget.manga);
    } else {
      FavoriteManga().removeFromFavorites(widget.manga);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(200), // Adjust the height value as needed
      ),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: white,
      flexibleSpace: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            child: OverflowBox(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.manga['images']['webp']['image_url']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(color: black.withOpacity(0.2)),
          ),
          Container(
            height: 180,
            width: double.infinity,
            child: Stack(
              children: [
                BlurryContainer(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: white,
                                size: 22,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon:
                                    isFavorite ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.white),
                                  onPressed: toggleFavorite,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.manga['title'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getFirstSection() {
    return Container(
      decoration: BoxDecoration(
        color: white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                widget.manga['chapters'].toString(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Chapters",
                style: TextStyle(fontSize: 14, color: black.withOpacity(0.5)),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                widget.manga['status'].toString(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Status",
                style: TextStyle(fontSize: 14, color: black.withOpacity(0.5)),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                widget.manga['score'].toString(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Score",
                style: TextStyle(fontSize: 14, color: black.withOpacity(0.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget getSecondSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Synopsis",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 15),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            text: widget.manga['synopsis'].toString(),
            style: TextStyle(fontSize: 14, color: black.withOpacity(0.8)),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget getBody() {
    return ListView(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getFirstSection(),
              SizedBox(height: 20),
              getSecondSection(),
              SizedBox(height: 20),
              // Add more sections and widgets here for manga details
            ],
          ),
        ),
      ],
    );
  }
}

class FavoriteManga {
  static final FavoriteManga _instance = FavoriteManga._internal();

  factory FavoriteManga() {
    return _instance;
  }

  FavoriteManga._internal();

  static List<dynamic> FavoriteMangas = [];

  void addToFavorites(dynamic agent) {
    FavoriteMangas.add(agent);
  }

  void removeFromFavorites(dynamic agent) {
    FavoriteMangas.remove(agent);
  }

  bool isFavorite(dynamic agent) {
    return FavoriteMangas.contains(agent);
  }
}
