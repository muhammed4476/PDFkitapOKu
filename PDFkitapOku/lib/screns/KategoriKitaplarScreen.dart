import 'package:deneme/screns/Widget/book.dart';
import 'package:deneme/screns/Widget/kategori.dart';
import 'package:deneme/screns/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KategoriKitaplarScreen extends StatefulWidget {
  final Kategori kategori;

  const KategoriKitaplarScreen({Key? key, required this.kategori})
    : super(key: key);

  @override
  _KategoriKitaplarScreenState createState() => _KategoriKitaplarScreenState();
}

class _KategoriKitaplarScreenState extends State<KategoriKitaplarScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Book> _filteredKitaplar;

  @override
  void initState() {
    super.initState();
    _filteredKitaplar = widget.kategori.kitaplar;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredKitaplar =
          widget.kategori.kitaplar
              .where((kitap) => kitap.title.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        toolbarHeight: 50, // AppBar yüksekliği
        title: Text(
          widget.kategori.isim,
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
      body: Column(
        children: [
          // Arama çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Kitap ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Kitaplar listesi
          Expanded(
            child: ListView.builder(
              itemCount: _filteredKitaplar.length,
              itemBuilder: (context, index) {
                final kitap = _filteredKitaplar[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Card(
                    color: const Color.fromARGB(255, 244, 244, 244),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    BookDetailScreen(book: kitap),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              // Sayfanın sağdan sola kayma animasyonu
                              const begin = Offset(
                                1.0,
                                0.0,
                              ); // Sayfa sağdan gelir
                              const end = Offset.zero; // Sayfa ekrana yerleşir
                              final tween = Tween(begin: begin, end: end).chain(
                                CurveTween(
                                  curve: Curves.easeInOut,
                                ), // Animasyon eğrisi
                              );

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                              milliseconds: 500,
                            ), // Animasyon süresi
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),

                              color: Colors.white, // Container'ın rengi
                              border: Border.all(
                                color: const Color.fromARGB(
                                  255,
                                  243,
                                  107,
                                  33,
                                ), // Border rengi
                                width: 2, // Border kalınlığı
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    0.1,
                                  ), // Gölgenin rengi
                                  spreadRadius: 2, // Gölgenin yayılma genişliği
                                  blurRadius: 5, // Gölgenin bulanıklık oranı
                                  offset: Offset(
                                    0,
                                    3,
                                  ), // Gölgenin konumu (x, y)
                                ),
                              ],
                            ),

                            width: 110,
                            height: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child:
                                  kitap.image.startsWith('http')
                                      ? Image.network(
                                        kitap.image,
                                        height: 165,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        kitap.image,
                                        height: 165,
                                        width: 150,
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
                                  spreadRadius: 2, // Gölgenin yayılma genişliği
                                  blurRadius: 5, // Gölgenin bulanıklık oranı
                                  offset: Offset(
                                    0,
                                    3,
                                  ), // Gölgenin konumu (x, y)
                                ),
                              ],
                            ),
                            height: 115,
                            width: 225,

                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kitap.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(kitap.yazar),
                                  Text(
                                    kitap.aciklama,
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
          ),
        ],
      ),
    );
  }
}
