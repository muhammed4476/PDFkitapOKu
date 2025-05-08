import 'package:deneme/screns/Widget/book.dart';

class Kategori {
  final String isim;
  final String resimUrl;
  final List<Book> kitaplar;

  Kategori({
    required this.isim,
    required this.resimUrl,
    required this.kitaplar,
  });
}
