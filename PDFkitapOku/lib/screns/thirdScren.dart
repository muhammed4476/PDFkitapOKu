import 'package:flutter/material.dart';
import 'package:deneme/screns/Widget/yazar.dart';
import 'package:deneme/screns/BooksPage.dart';
import 'package:deneme/screns/seconscren.dart';
import 'package:flutter/services.dart'; // allBooks burada tanımlı

/// Örnek yazar modeli (Widget/yazar.dart içinde olabilir)
/// class Yazar {
///   final String isim;
///   final String bilgi;
///   final String resim;
///
///   Yazar({required this.isim, required this.bilgi, required this.resim});
/// }

final List<Yazar> yazarlar = [
  Yazar(
    isim: "Victor Hugo",
    bilgi:
        "Victor Hugo Fransız yazar, şair ve romantizm akımının öncüsüdür. Sefiller ve Notre Dame’ın Kamburu ile tanınır.",
    resim: ("assets/images/yazar/victoHugo.jpeg"),
  ),
  Yazar(
    isim: "Yaşar Kemal",
    bilgi:
        "Yasar Kemal Türk romancı ve gazetecidir Anadolu insanını ve doğayı epik bir dille anlatmıştır İnce Memed ile tanınır.",
    resim: ("assets/images/yazar/yasarKemal.jpeg"),
  ),
  Yazar(
    isim: "Oğuz Atay",
    bilgi:
        "Oguz Atay Türk yazar ve mühendistir. Tutunamayanlar adlı romanıyla modern Türk edebiyatında önemli bir yer edinmiştir.",
    resim: ("assets/images/yazar/oguzAtay.jpeg"),
  ),
  Yazar(
    isim: "Fyodor Dostoyevski",
    bilgi:
        "Dostoyevski Rus yazardır, insan psikolojisini derinlemesine işleyen romanlarıyla tanınır. Suç ve Ceza ile büyük ün kazanmıştır.",
    resim: ("assets/images/yazar/Dostoyewski.jpeg"),
  ),
  Yazar(
    isim: "Lev Tolstoy",
    bilgi:
        "Tolstoy Rus yazardır, realist edebiyatın öncülerindendir. Savaş ve Barış ile Anna Karenina en ünlü eserlerindendir.",
    resim: ("assets/images/yazar/lewTolstoy.jpeg"),
  ),
  Yazar(
    isim: "William Shakespeare",
    bilgi:
        "William Shakespeare İngiliz oyun yazarı ve şairdir, dünya edebiyatının en önemli isimlerinden biridir. Romeo ve Juliet ile Hamlet en bilinen eserlerindendir.",
    resim: ("assets/images/yazar/williamSekspare.jpeg"),
  ),
  Yazar(
    isim: "Amin Maalouf",
    bilgi:
        "Amin Maalouf Lübnan asıllı Fransız yazardır, tarih ve kimlik temalarını işler. Semerkand ve Doğu'nun Limanları en bilinen eserlerindendir.",
    resim: ("assets/images/yazar/KemalThair.jpeg"),
  ),
  Yazar(
    isim: "Kemal Tahir",
    bilgi:
        "Kemal Tahir Türk romancı, yazar ve düşünürdür. Devlet Ana ve Yorgun Savaşçı gibi eserleriyle Türk edebiyatında önemli bir yere sahiptir.",
    resim: ("assets/images/yazar/lewTolstoy.jpeg"),
  ),
];

class Thirdscren extends StatefulWidget {
  const Thirdscren({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<Thirdscren> {
  final TextEditingController _searchController = TextEditingController();
  late List<Yazar> _filteredYazarlar;

  @override
  void initState() {
    super.initState();
    _filteredYazarlar = List.from(yazarlar);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredYazarlar = List.from(yazarlar);
      } else {
        _filteredYazarlar =
            yazarlar
                .where((y) => y.isim.toLowerCase().contains(query))
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        toolbarHeight: 50, // AppBar yüksekliği
        title: Text(
          "Yazarlar",
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
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Yazar ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Filtrelenmiş Yazar Listesi
          Expanded(
            child:
                _filteredYazarlar.isEmpty
                    ? const Center(child: Text('Hiç yazar bulunamadı.'))
                    : ListView.builder(
                      itemCount: _filteredYazarlar.length,
                      itemBuilder: (context, index) {
                        final yazar = _filteredYazarlar[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 246, 124, 1),
                                width: 2,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => BooksPage(
                                          yazarAdi: yazar.isim,
                                          kitaplar: allBooks,
                                        ),
                                    transitionsBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      const begin = Offset(
                                        1.0,
                                        0.0,
                                      ); // Sayfa sağdan gelir
                                      const end =
                                          Offset.zero; // Sayfa ekrana yerleşir
                                      final tween = Tween(
                                        begin: begin,
                                        end: end,
                                      ).chain(
                                        CurveTween(curve: Curves.easeInOut),
                                      );

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(
                                      milliseconds: 500,
                                    ),
                                  ),
                                );
                              },

                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child:
                                          yazar.resim.startsWith('http')
                                              ? Image.network(
                                                yazar.resim,
                                                width: 80,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                              : Image.asset(
                                                yazar.resim,
                                                width: 80,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            yazar.isim,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            yazar.bilgi,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            maxLines: 3,
                                            overflow:
                                                TextOverflow
                                                    .ellipsis, // Taşan metin için "..."
                                          ),
                                        ],
                                      ),
                                    ),
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
