import 'package:deneme/screns/Widget/kategori.dart';
import 'package:deneme/screns/Widget/yazar.dart';
import 'package:deneme/screns/seconscren.dart';

final List<Yazar> yazarlars = [
  Yazar(
    isim: "Victor Hugo",
    bilgi: "Nobel ödüllü Türk romancı.",
    resim: ("assets/images/yazar/victoHugo.jpeg"),
  ),
  Yazar(
    isim: "Yaşar Kemal",
    bilgi: "Çağdaş Türk edebiyatının önde gelen yazarlarından.",
    resim: ("assets/images/yazar/yasarKemal.jpeg"),
  ),
  Yazar(
    isim: "Oğuz Atay",
    bilgi: "İnce Memed'in yazarı, Anadolu’nun sesi.",
    resim: ("assets/images/yazar/oguzAtay.jpeg"),
  ),
  Yazar(
    isim: "Fyodor Dostoyevski",
    bilgi: "Polisiye romanlarıyla tanınan başarılı yazar.",
    resim: ("assets/images/yazar/Dostoyewski.jpeg"),
  ),
  Yazar(
    isim: "Lev Tolstoy",
    bilgi: "Tarihi romanları ve biyografileriyle bilinir.",
    resim: ("assets/images/yazar/lewTolstoy.jpeg"),
  ),
];
List<Kategori> kategorilers = [
  Kategori(
    isim: 'Dini Kitaplar',
    resimUrl: ('assets/images/dini.jpeg'),
    kitaplar: [allBooks[0], allBooks[1]],
  ),
  Kategori(
    isim: 'Tarih',
    resimUrl: ('assets/images/tarih.jpeg'),
    kitaplar: [allBooks[2], allBooks[3]],
  ),
  Kategori(
    isim: 'Polisiye',
    resimUrl: ('assets/images/polisiye.jpeg'),
    kitaplar: [allBooks[4]],
  ),
  Kategori(
    isim: 'Psikoloji',
    resimUrl: ('assets/images/pisikoloji.jpeg'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Bildiri',
    resimUrl: ('assets/images/bildiri.png'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Eğlence',
    resimUrl: ('assets/images/eglence.webp'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Korku-Macera',
    resimUrl: ('assets/images/korkuMacera.jpeg'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Kişisel Gelişim',
    resimUrl: ('assets/images/kişiselGelişim.jpeg'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Bilim Kurugu',
    resimUrl: ('assets/images/bilimkurgu.webp'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Fantastik',
    resimUrl: ('assets/images/fantasitik.jpeg'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Roman',
    resimUrl: ('assets/images/roman.jpeg'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Seri Kitaplar',
    resimUrl: ('assets/images/serikitaplar.jpeg'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Aşk Romanları',
    resimUrl: ('assets/images/askRomantik.jpg'),
    kitaplar: [allBooks[5]],
  ),
];
List<Kategori> kategoriler = [
  Kategori(
    isim: 'Dini Kitaplar',
    resimUrl: ('assets/images/dini.jpeg'),
    kitaplar: [allBooks[0], allBooks[1]],
  ),
  Kategori(
    isim: 'Tarih',
    resimUrl: ('assets/images/tarih.jpeg'),
    kitaplar: [allBooks[2], allBooks[3]],
  ),
  Kategori(
    isim: 'Polisiye',
    resimUrl: ('assets/images/polisiye.jpeg'),
    kitaplar: [allBooks[4]],
  ),
  Kategori(
    isim: 'Psikoloji',
    resimUrl: ('assets/images/pisikoloji.jpeg'),
    kitaplar: [allBooks[5]],
  ),
  Kategori(
    isim: 'Bildiri',
    resimUrl: ('assets/images/bildiri.png'),
    kitaplar: [allBooks[5]],
  ),
];
