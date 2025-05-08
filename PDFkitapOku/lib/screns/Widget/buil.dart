import 'package:deneme/screns/Widget/book.dart';
import 'package:deneme/screns/book_detail_page.dart';
import 'package:deneme/screns/seconscren.dart';

import 'package:flutter/material.dart';
// ignore: must_be_immutable

List<Book> allBooksss = [
  Book(
    title: 'Sefiller',
    yazar: 'Victor Hugo',
    image: ('assets/images/sefiilervictohugu2.jpg'),
    date: ('2025-05-01'),
    aciklama:
        'Bir romanın başyapıtı olan Sefiller, insan ruhunun derinliklerine inen bir yolculuğa çıkarıyor.',
  ),
  Book(
    title: 'İnce Memed 1',
    yazar: 'Yaşar Kemal',
    image: ('assets/images/incememedyasr.png'),
    date: ('2025-05-01'),
    aciklama:
        'İnce Memed, Anadolu insanının direnişini ve özgürlük arayışını anlatan bir başyapıt.',
  ),
  Book(
    title: 'Tutunamayanlar',
    yazar: 'Oğuz Atay',
    image: ('assets/images/osuzataytutunamayanlar.webp'),
    date: ('2025-05-01'),
    aciklama:
        'Tutunamayanlar, bireyin toplumla olan çatışmasını ve yalnızlığını derinlemesine ele alıyor.',
  ),
  Book(
    title: 'Suç ve Ceza',
    yazar: 'Fyodor Dostoyevski',
    image: ('assets/images/dostoyewskisucveceza.png'),
    date: ('2025-05-01'),
    aciklama:
        'Suç ve Ceza, insanın içsel çatışmalarını ve ahlaki sorgulamalarını derinlemesine işleyen bir roman.',
  ),
  Book(
    title: 'Anna Karenina',
    yazar: 'Lev Tolstoy',
    image: ('assets/images/annekareniatolstoy.jpg'),
    date: ('2025-05-01'),
    aciklama:
        'Anna Karenina, aşk, ihanet ve toplumsal normlar üzerine derin bir inceleme sunuyor.',
  ),
  Book(
    title: 'Romeo ve Juliet',
    yazar: 'William Shakespeare',
    image: ('assets/images/romeovejuletsekspir.jpg'),
    date: ('2025-05-01'),
    aciklama:
        'Romeo ve Juliet, yasak bir aşkın trajik hikayesini anlatan bir başyapıt.',
  ),
];

class MyPageViewScreen extends StatefulWidget {
  const MyPageViewScreen({super.key});

  @override
  State<MyPageViewScreen> createState() => _MyPageViewScreenState();
}

class _MyPageViewScreenState extends State<MyPageViewScreen> {
  final PageController controller = PageController(
    initialPage: 0,
  ); // Başlangıç sayfası 0
  int currentPage = 0; // Başlangıç sayfası 0

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: const Color.fromARGB(255, 246, 246, 246),
        elevation: 0,
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final books = allBooks[index % allBooksss.length];
                        final book = allBooksss[index % allBooksss.length];
                        ;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        BookDetailScreen(book: books),
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
                                  const end =
                                      Offset.zero; // Sayfa ekrana yerleşir
                                  final tween = Tween(
                                    begin: begin,
                                    end: end,
                                  ).chain(
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

                          child:
                              book.image.startsWith('http')
                                  ? Image.network(
                                    book.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                  : Image.asset(
                                    book.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 15,
                    right: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allBooksss[currentPage % allBooksss.length].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            allBooksss[currentPage % allBooksss.length].yazar,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                allBooksss.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage % allBooksss.length == index ? 12 : 8,
                  height: currentPage % allBooksss.length == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color:
                        currentPage % allBooksss.length == index
                            ? Colors.blue
                            : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
