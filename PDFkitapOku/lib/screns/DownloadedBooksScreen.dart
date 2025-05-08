import 'package:deneme/screns/seconscren.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:deneme/screns/book_detail_page.dart';
import 'package:deneme/screns/Widget/book.dart';

class DownloadedBooksScreen extends StatefulWidget {
  const DownloadedBooksScreen({super.key});

  @override
  State<DownloadedBooksScreen> createState() => _DownloadedBooksScreenState();
}

class _DownloadedBooksScreenState extends State<DownloadedBooksScreen> {
  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  Future<void> loadFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfFiles =
        dir
            .listSync()
            .where((file) => file.path.toLowerCase().endsWith('.pdf'))
            .toList();

    setState(() {
      files = pdfFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        toolbarHeight: 50, // AppBar yüksekliği
        title: const Text(
          "İndirilenler",
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
          files.isEmpty
              ? Center(child: Text("Henüz kitap indirilmedi."))
              : ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  final fileName = file.path.split('/').last;
                  final bookTitle = fileName.replaceAll('.pdf', '');

                  // Doğru kitabı başlığa göre bul
                  final book = allBooks.firstWhere(
                    (book) => book.title == bookTitle,
                    orElse:
                        () => Book(
                          title: bookTitle,
                          yazar: 'Bilinmeyen Yazar',
                          image: 'assets/images/default_cover.png',
                          date: '2023-01-01',
                          aciklama: 'Açıklama yok',
                        ),
                  );

                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 18,
                      right: 18,
                      bottom: 10,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      BookDetailScreen(book: book),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                const begin = Offset(1.0, 0.0); // sağdan başlar
                                const end = Offset.zero;
                                final tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: Curves.easeInOut));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },

                        child: Row(
                          children: [
                            // Kitap Görseli
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
                                    blurRadius: 5, // Gölgenin bulanıklık oranı
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  );
                },
              ),
    );
  }
}
