import 'package:deneme/screns/BooksPage.dart';
import 'package:deneme/screns/DownloadedBooksScreen.dart';
import 'package:deneme/screns/KategoriKitaplarScreen.dart';
import 'package:deneme/screns/Widget/book.dart';
import 'package:deneme/screns/Widget/buil.dart';
import 'package:deneme/screns/Widget/yzarKategorilist.dart';

import 'package:deneme/screns/book_detail_page.dart';
import 'package:deneme/screns/favorite_screen.dart';
import 'package:deneme/screns/fourScren.dart';
import 'package:deneme/screns/seconscren.dart';
import 'package:deneme/screns/thirdScren.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Homescren extends StatelessWidget {
  List<Book> allBookss = [
    Book(
      title: 'Sefiller',
      yazar: 'Victor Hugo',
      image: ('assets/images/sefiller.jpeg'),
      date: ('2024-01-20'), // ✅ Doğru format

      aciklama:
          'Bir romanın başyapıtı olan Sefiller, insan ruhunun derinliklerine inen bir yolculuğa çıkarıyor.',
    ),
    Book(
      title: 'İnce Memed 1',
      yazar: 'Yaşar Kemal',
      image: ('assets/images/İnceMemed1.jpeg'),
      date: ('2025-05-01'),
      aciklama:
          'İnce Memed, Anadolu insanının direnişini ve özgürlük arayışını anlatan bir başyapıt.',
    ),
    Book(
      title: 'Tutunamayanlar',
      yazar: 'Oğuz Atay',
      image: 'assets/images/tutunamayanlar.jpg',
      date: ('2025-05-01'),
      aciklama:
          'Tutunamayanlar, bireyin toplumla olan çatışmasını ve yalnızlığını derinlemesine ele alıyor.',
    ),
    Book(
      title: 'Suç ve Ceza',
      yazar: 'Fyodor Dostoyevski',
      image: ('assets/images/sucveceza.jpg'),
      date: ('2025-05-01'),
      aciklama:
          'Suç ve Ceza, insanın içsel çatışmalarını ve ahlaki sorgulamalarını derinlemesine işleyen bir roman.',
    ),
    Book(
      title: 'Anna Karenina',
      yazar: 'Lev Tolstoy',
      image: ('assets/images/annekarenia.jpeg'),
      date: ('2025-05-01'),
      aciklama:
          'Anna Karenina, aşk, ihanet ve toplumsal normlar üzerine derin bir inceleme sunuyor.',
    ),
    Book(
      title: 'Romeo ve Juliet',
      yazar: 'William Shakespeare',
      image: ('assets/images/romeovejuliet.jpg'),
      date: ('2025-05-01'),
      aciklama:
          'Romeo ve Juliet, yasak bir aşkın trajik hikayesini anlatan bir başyapıt.',
    ),
  ];

  Homescren({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color.fromARGB(
          255,
          191,
          97,
          1,
        ), // Alt navigation bar rengi
        systemNavigationBarIconBrightness:
            Brightness.light, // Alt simgeler beyaz
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        // Uygulama çubuğu
        toolbarHeight: 50, // AppBar yüksekliği
        title: Text(
          "PDF Kitaplar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ), // AppBar başlığı

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
        // AppBar arka plan rengi
      ),

      // Burada Drawer menüsü ekleniyor
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        width: 260,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 246, 124, 1),
              ),
              child: Card(
                color: Color.fromARGB(255, 246, 124, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                child: Column(
                  children: [
                    Image.asset(
                      ('assets/images/logo.png'),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'Ana Sayfa',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Anasayfa',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              onTap: () {
                Navigator.pop(context); // Drawer'ı kapat
                // Ana sayfada olduğumuz için yönlendirmeye gerek yok
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'Kitaplar',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              onTap: () {
                Navigator.pop(context); // Drawer'ı kapat
                // Kitaplar sayfasına yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'favoriler',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoriteScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text(
                'indirilenler',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DownloadedBooksScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            1, // Tek sayfa içeriği
            (index) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,

                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        "En Popüler",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'CalSans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  MyPageViewScreen(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Popüler",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'CalSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: SizedBox(
                            height: 23,
                            width: 110,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  246,
                                  124,
                                  1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ), // Buton köşe yuvarlama
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const SecondScreen(),
                                    transitionsBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      const begin = Offset(
                                        1.0,
                                        0.0,
                                      ); // sağdan başlar
                                      const end = Offset.zero; // ekrana oturur
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
                                    transitionDuration: Duration(
                                      milliseconds: 400,
                                    ), // isteğe göre ayarlanabilir
                                  ),
                                );
                              },

                              child: const Text(
                                'Tümünü listele',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'CalSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Horizontal ListView
                  Padding(
                    // Liste için boşluk
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ), // Liste için boşluk
                    child: SizedBox(
                      height: 243, // ListView yüksekliği
                      child: ListView(
                        // Yatay liste
                        scrollDirection: Axis.horizontal, // Yatay kaydırma

                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ), // Liste için boşluk
                        children:
                            allBookss.map((book) {
                              return buildImageCard(
                                book.image,
                                book.title,
                                book.yazar,
                                () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => BookDetailScreen(book: book),
                                      transitionsBuilder: (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        const begin = Offset(
                                          1.0,
                                          0.0,
                                        ); // sağdan başlar
                                        const end =
                                            Offset.zero; // ekrana oturur
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
                                      transitionDuration: Duration(
                                        milliseconds: 300,
                                      ), // Geçiş süresi
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Yazarlar",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'CalSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: SizedBox(
                            height: 23,
                            width: 110,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  246,
                                  124,
                                  1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ), // Buton köşe yuvarlama
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const Thirdscren(),
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
                                        CurveTween(
                                          curve: Curves.easeInOut,
                                        ), // Animasyonun eğrisi
                                      );

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(
                                      milliseconds: 300,
                                    ), // Geçiş süresi
                                  ),
                                );
                              },

                              child: const Text(
                                'Tümünü listele',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'CalSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Horizontal ListView
                  Padding(
                    // Liste için boşluk
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ), // Liste için boşluk
                    child: SizedBox(
                      height: 80, // ListView yüksekliği
                      child: ListView(
                        // Yatay liste
                        scrollDirection: Axis.horizontal, // Yatay kaydırma

                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ), // Liste için boşluk
                        children:
                            yazarlars.map((yazar) {
                              return yazarCard(yazar.resim, yazar.isim, () {
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
                                        CurveTween(
                                          curve: Curves.easeInOut,
                                        ), // Animasyonun eğrisi
                                      );

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(
                                      milliseconds: 300,
                                    ), // Geçiş süresi
                                  ),
                                );
                              });
                            }).toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Kategoriler",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'CalSans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: SizedBox(
                            height: 23,
                            width: 110,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  246,
                                  124,
                                  1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ), // Buton köşe yuvarlama
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const Fourscren(),
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
                                        CurveTween(
                                          curve: Curves.easeInOut,
                                        ), // Animasyonun eğrisi
                                      );

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(
                                      milliseconds: 300,
                                    ), // Geçiş süresi
                                  ),
                                );
                              },

                              child: const Text(
                                'Tümünü listele',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'CalSans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Horizontal ListView
                  // Kategoriler bölümünü ekleyin
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      height: 160, // ListView yüksekliği
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        children:
                            kategoriler.map((kategori) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => KategoriKitaplarScreen(
                                            kategori: kategori,
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
                                            Offset
                                                .zero; // Sayfa ekrana yerleşir
                                        final tween = Tween(
                                          begin: begin,
                                          end: end,
                                        ).chain(
                                          CurveTween(
                                            curve: Curves.easeInOut,
                                          ), // Animasyonun eğrisi
                                        );

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(
                                        milliseconds: 300,
                                      ), // Geçiş süresi
                                    ),
                                  );
                                },

                                child: kategorilerCard(
                                  kategori.resimUrl, // Kategori resmi
                                  kategori.isim,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildImageCard(
    String imageUrl,
    String title,
    String yazar,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap, // Tıklanınca yapılacak işlem
      child: Container(
        width: 128,
        child: Card(
          color: const Color.fromARGB(255, 246, 246, 246),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                child:
                    imageUrl.startsWith('http')
                        ? Image.network(
                          imageUrl,
                          height: 165,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          imageUrl,
                          height: 165,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 6.0,
                  top: 12,
                  right: 6,
                  bottom: 6,
                ),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  yazar,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget yazarCard(String imageUrl, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Yazar kartına tıklandığında yapılacak işlem
      child: Container(
        child: Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: const Color.fromARGB(255, 246, 124, 1),
              width: 3,
            ),
          ),
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                      imageUrl.startsWith('http')
                          ? Image.network(
                            imageUrl,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                          : Image.asset(
                            imageUrl,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget kategorilerCard(String imageUrl, String title) {
    return Container(
      width: 140,

      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: const Color.fromARGB(255, 246, 124, 1),
            width: 3,
          ),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    imageUrl.startsWith('http')
                        ? Image.network(
                          imageUrl,
                          height: 70,
                          width: 90,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          imageUrl,
                          height: 70,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
