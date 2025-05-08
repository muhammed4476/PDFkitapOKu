import 'package:flutter/material.dart';
import 'package:deneme/screns/book_detail_page.dart';
import 'package:deneme/screns/Widget/book.dart';
import 'package:flutter/services.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BooksListScreen();
  }
}

List<Book> allBooks = [
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
  Book(
    title: 'Semerkant',
    yazar: 'Amin Maalouf',
    image: ('assets/images/semerkant.jpeg'),
    date: ('2025-05-01'),
    aciklama: 'Semerkand, tarih ve edebiyatın iç içe geçtiği bir roman.',
  ),
  Book(
    title: 'Devlet Ana',
    yazar: 'Kemal Tahir',
    image: ('assets/images/KemalTahir-DevletAna.jpg'),
    date: ('2025-05-01'),
    aciklama:
        'Devlet Ana, Anadolu insanının direnişini ve özgürlük arayışını anlatan bir başyapıt.',
  ),
];

class BooksListScreen extends StatefulWidget {
  const BooksListScreen({super.key});

  @override
  _BooksListScreenState createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  List<Book> filteredBooks = allBooks;
  String searchText = '';

  void updateSearch(String text) {
    setState(() {
      searchText = text;
      filteredBooks =
          allBooks
              .where(
                (book) => book.title.toLowerCase().contains(text.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        toolbarHeight: 50, // AppBar yüksekliği
        title: const Text(
          "Kitaplar",
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
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 18,
              right: 18,
              bottom: 10,
            ),
            child: TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                hintText: "Kitap ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                return BookCard(book: filteredBooks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final ImageProvider imageProvider =
        book.image.startsWith('http')
            ? NetworkImage(book.image)
            : AssetImage(book.image) as ImageProvider;

    return Card(
      color: const Color.fromARGB(255, 244, 244, 244),
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      elevation: 0,
      child: InkWell(
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
                const begin = Offset(1.0, 0.0); // Sayfa sağdan gelir
                const end = Offset.zero; // Sayfa ekrana yerleşir
                final tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: Curves.easeInOut));

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
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
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
                    color: Colors.black.withOpacity(0.1), // Gölgenin rengi
                    spreadRadius: 2, // Gölgenin yayılma genişliği
                    blurRadius: 5, // Gölgenin bulanıklık oranı
                    offset: Offset(0, 3), // Gölgenin konumu (x, y)
                  ),
                ],
              ),
              width: 110,
              height: 170,
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
                    color: Colors.black.withOpacity(0.1), // Gölgenin rengi
                    spreadRadius: 2, // Gölgenin yayılma genişliği
                    blurRadius: 5, // Gölgenin bulanıklık oranı
                    offset: Offset(0, 3), // Gölgenin konumu (x, y)
                  ),
                ],
              ),
              height: 115,
              width: 230,

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
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
