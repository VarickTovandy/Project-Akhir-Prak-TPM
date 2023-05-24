import 'package:flutter/material.dart';
import 'package:project_manga/pages/manga_detail_page.dart';

class FavoriteMangaPage extends StatefulWidget {
  @override
  _FavoriteMangaPageState createState() => _FavoriteMangaPageState();
}

class _FavoriteMangaPageState extends State<FavoriteMangaPage> {
  List<dynamic> favoriteMangaList = FavoriteManga.FavoriteMangas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            color: Colors.grey.withOpacity(0.1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Favorite',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: favoriteMangaList.isEmpty
          ? Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.network(
          'https://storage.googleapis.com/sticker-prod/5BmzE1tKhsiOvIQNdqjx/14.png',
          height: 100,
          ),
          SizedBox(height: 16),
          Text('No favorite manga yet.'),
          ],
          ),
          )
                : ListView.builder(
              itemCount: favoriteMangaList.length,
              itemBuilder: (context, index) {
                final manga = favoriteMangaList[index];
                return GestureDetector(
                  onTap: () {
                    // Handle tap on the ListTile
                    // Add your desired functionality here
                    // For example, navigate to a detail page:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MangaDetailPage(manga: manga),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(manga['images']['webp']['image_url']),
                    title: Text(manga['title'].toString()),
                    subtitle: Text(manga['status'].toString()),
                    // Add more details or customize the layout as needed
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
