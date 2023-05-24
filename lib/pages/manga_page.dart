import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_manga/pages/manga_detail_page.dart';

class MangaListPage extends StatefulWidget {
  @override
  _MangaListPageState createState() => _MangaListPageState();
}

class _MangaListPageState extends State<MangaListPage> {
  List? mangaList;
  List? filteredMangaList;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchMangaData() async {
    final response = await http.get(Uri.parse("https://api.jikan.moe/v4/top/manga"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        mangaList = data['data'];
        filteredMangaList = mangaList;
      });
    }
  }

  @override
  void initState() {
    fetchMangaData();
    super.initState();
  }

  void searchManga(String query) {
    setState(() {
      filteredMangaList = mangaList?.where((manga) {
        final title = manga['title'].toString().toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    });
  }

  Widget readerToday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          color: Colors.grey.withOpacity(0.1),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Manga',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
            child: TextField(
              controller: searchController,
              cursorColor: Colors.blue,
              onChanged: searchManga,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search...",
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Manga List",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: mangaList == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        children: [
          readerToday(),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: filteredMangaList!.length,
            itemBuilder: (context, index) {
              final manga = filteredMangaList![index];
              return GestureDetector(
                onTap: () {
                  // Handle navigation to manga detail page here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MangaDetailPage(manga: manga),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                manga['images']['webp']['image_url'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        manga['title'].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        manga['status'].toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
