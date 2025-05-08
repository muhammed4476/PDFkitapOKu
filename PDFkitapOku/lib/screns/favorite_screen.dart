import 'package:flutter/material.dart';
import 'package:deneme/screns/book_detail_page.dart';
import 'package:deneme/screns/Widget/book.dart'; // Book modelinizi buraya ekliyoruz
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Book> favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  // Favori kitapları SharedPreferences'tan yüklemek
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? bookJsonList = prefs.getStringList('favorites');
    if (bookJsonList != null) {
      setState(() {
        favoriteBooks =
            bookJsonList
                .map((bookJson) => Book.fromJson(jsonDecode(bookJson)))
                .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        toolbarHeight: 50, // AppBar yüksekliği
        title: const Text(
          "Favori Kitaplar",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color.fromARGB(255, 246, 124, 1),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(
            255,
            191,
            97,
            1,
          ), // Bildirim çubuğu rengi (koyu turuncu)
          statusBarIconBrightness:
              Brightness.light, // Bildirim çubuğu simgeleri beyaz olsun
        ),
      ),
      body:
          favoriteBooks.isEmpty
              ? const Center(child: Text("Henüz favori kitap eklemediniz"))
              : ListView.builder(
                itemCount: favoriteBooks.length,
                itemBuilder: (context, index) {
                  final book = favoriteBooks[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 18,
                      right: 18,
                      bottom: 10,
                    ),
                    child: Card(
                      color: const Color.fromARGB(255, 243, 243, 243),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookDetailScreen(book: book),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Container(
                                width: 110,
                                height: 170,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 243, 107, 33),
                                    width: 2,
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image:
                                        book.image.startsWith("http")
                                            ? NetworkImage(book.image)
                                            : AssetImage(book.image)
                                                as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  color: Colors.white, // Container'ın rengi
                                  border: const Border(
                                    top: BorderSide(
                                      color: Color.fromARGB(255, 243, 107, 33),
                                      width: 2,
                                    ),
                                    right: BorderSide(
                                      color: Color.fromARGB(255, 243, 107, 33),
                                      width: 2,
                                    ),
                                    bottom: BorderSide(
                                      color: Color.fromARGB(255, 243, 107, 33),
                                      width: 2,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                        0.1,
                                      ), // Gölgenin rengi
                                      spreadRadius:
                                          2, // Gölgenin yayılma genişliği
                                      blurRadius:
                                          5, // Gölgenin bulanıklık oranı
                                      offset: Offset(
                                        0,
                                        3,
                                      ), // Gölgenin konumu (x, y)
                                    ),
                                  ],
                                ),
                                height: 115,
                                width: 222,

                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(book.yazar),
                                      Text(
                                        book.aciklama,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
