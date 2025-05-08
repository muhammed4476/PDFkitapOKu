import 'dart:io';

import 'package:deneme/screns/BookReadScreen.dart';
import 'package:deneme/screns/Widget/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:ui';

List<Book> favoriteBooks = [];

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final Map<String, String> bookSummaries = {
    'Sefiller':
        'Sefiller, toplumsal adaletsizlikleri ve insanın kurtuluş mücadelesini anlatan bir romandır. Başkahraman Jean Valjean, bir somun ekmek çaldığı için 19 yıl hapis yatar. Tahliyesinden sonra toplum tarafından dışlanır, ancak bir piskoposun iyiliğiyle hayatını değiştirerek dürüst bir insan olmaya karar verir. Yeni kimliğiyle başarılı bir sanayici ve belediye başkanı olur. Ancak polis müfettişi Javert, geçmişini öğrenip peşine düşer. Bu sırada Valjean, kimsesiz kalan Cosette’i evlat edinir ve onu korumak için mücadele eder. Hikâye boyunca iyilik, bağışlama, aşk, fedakârlık ve adalet temaları işlenir.',
    'İnce Memed 1':
        'Çukurova’nın bir köyünde yaşayan genç Memed, köylüleri zulümle yöneten zalim toprak ağası Abdi Ağa’ya karşı büyük bir kin beslemektedir. Memed, sevdiği kız Hatçe’yle birlikte kaçmak ister, ancak yakalanırlar. Abdi Ağa, Hatçe’yi hapse attırır. Memed ise intikam için dağa çıkar ve eşkıya olur. Zamanla halkın sevgisini kazanan bir halk kahramanına dönüşür. Memed, ağalara ve zulme karşı savaşırken hem sevdiği kadının özgürlüğü hem de adaletin sağlanması için mücadele eder. Roman, Memed’in Abdi Ağa’yı öldürmesiyle sona erer.',
    'Tutunamayanlar':
        'Roman, Turgut Özben adlı bir mühendis arkadaşının (Selim Işık) intiharını öğrenince onun hayatını anlamaya çalışır. Turgut, Selim’in geçmişini araştırırken onun aslında toplumun dayattığı değerlere uyum sağlayamayan, “tutunamayan” biri olduğunu fark eder. Selim’in düşünceleri, hayalleri ve kırgınlıkları üzerinden hem bireysel hem de toplumsal bir sorgulama yapılır. Turgut da zamanla kendi iç dünyasına yönelir ve onun da aslında tutunamayan biri olduğu ortaya çıkar. Roman, Turgut’un kendi kimliğini arayışıyla sona erer.',
    'Suç ve Ceza':
        'St. Petersburg’da yaşayan fakir bir üniversite öğrencisi olan Raskolnikov, toplumun çıkarı için “zararsız” gördüğü bir tefeci kadını öldürerek büyük bir suç işler. Cinayeti mantıkla ve üstün insan teorisiyle meşrulaştırmaya çalışsa da, vicdan azabıyla baş edemez. Psikolojik çöküntü yaşar, çevresindekilerle ilişkileri bozulur. Sonunda suçunu itiraf eder ve Sibirya’ya sürgüne gönderilir. Romanın sonunda Raskolnikov, Sonya adlı dindar bir genç kadının desteğiyle manevi bir uyanış yaşar.',
    'Anna Karenina':
        'Anna Karenina, yüksek sosyeteye mensup evli bir kadındır. Soğuk bir evlilik hayatı sürerken, genç ve yakışıklı subay Vronski ile tutkulu bir aşk yaşamaya başlar. Bu ilişki toplum tarafından dışlanmasına ve ailesinden kopmasına neden olur. Zamanla Vronski’yle ilişkisi de yıpranır, yalnızlık ve umutsuzluk içinde kalan Anna intihar eder. Paralel olarak anlatılan Levin karakterinin hikâyesi ise kırsal yaşam, aile ve inanç üzerinden anlam arayışını konu alır.',
    'Romeo ve Juliet':
        'Verona’da birbirine düşman iki soylu aile, Capulet ve Montague aileleri arasında büyük bir husumet vardır. Capuletlerin kızı Juliet ile Montague’lerin oğlu Romeo, bir maskeli baloda tesadüfen karşılaşır ve birbirlerine âşık olurlar. Ailelerinin düşmanlığına rağmen gizlice evlenirler. Ancak aralarındaki düşmanlık kanlı olaylara yol açar. Romeo sürgün edilir, Juliet’in evlendirilmek istenmesi üzerine ikili bir kaçış planı yapar. Ancak plan yanlış anlaşılır, Romeo Juliet’in öldüğünü sanıp intihar eder. Juliet uyanınca Romeo’nun öldüğünü görür ve o da kendini öldürür. İki aşığın trajik ölümü, aileleri barıştırır.',

    'Semerkant':
        'Roman iki ana zaman diliminde geçer. Birinci bölümde, Ömer Hayyam, Hasan Sabbah ve Nizamülmülk’ün yolları kesişir. Üçlü, gençliklerinde bir anlaşma yapar: Her biri başarıya ulaşırsa diğerlerine yardım edecektir. Ömer Hayyam, astronomi ve şiirle ilgilenir, ünlü Rubaiyat’ını yazar. Rubailerin yazıldığı Semerkand yazması, zamanla değerli bir eser haline gelir.İkinci bölümde, 19. yüzyıl sonunda Amerikalı bir tarihçi olan Benjamin Omar Lesage, bu yazmanın peşine düşer. İran’daki siyasi karışıklıklar arasında yazmayı bulur ama yazma, 1912’de Titanic’in batışıyla birlikte kaybolur..',

    'Devlet Ana':
        'Roman, 13. yüzyılın sonlarında, Anadolu’da beyliklerin ve aşiretlerin parçalı yapıda olduğu bir dönemde geçer. Olaylar, Osman Bey’in liderliğinde Osmanlı Beyliği nin kuruluş süreci etrafında şekillenir.Merkezde, Devlet Ana lakaplı bilge ve güçlü bir kadın olan Fatma Hatun yer alır. O, topluluğun birliğini, adaleti ve düzeni sağlamada önemli rol oynar. Öte yandan, Osman Bey, Şeyh Edebali, Dursun Fakih gibi tarihi şahsiyetler de halkın geleceği için mücadele eder.Roman boyunca, fetih ruhu, İslamî değerler, birlik ve dayanışma, Bizans’a karşı savaşlar ve iç ihanetlerle şekillenen bir devletin doğuşuna tanıklık ederiz. Kemal Tahir, bu süreci halkın gözüyle, ideolojik bir bakışla ama edebi bir derinlikle anlatır.',
  };

  final Map<String, String> fullBookContents = {
    'Sefiller':
        'https://yalcinkoresortaokulu.meb.k12.tr/meb_iys_dosyalar/44/10/760537/dosyalar/2019_05/08181114_sefiller-victor-hugo.pdf',
    'İnce Memed 1':
        'https://bartinfuatsezginmtal.meb.k12.tr/meb_iys_dosyalar/74/01/766388/dosyalar/2020_04/09195609_Ynce_Memed_1_-_YaYar_Kemal__PDFDrive.com_.pdf',
    'Tutunamayanlar':
        'https://anayolhaber.com/wp-content/uploads/2024/10/oguz-atay-tutunamayanlar.pdf',
    'Suç ve Ceza':
        'https://yalcinkoresortaokulu.meb.k12.tr/meb_iys_dosyalar/44/10/760537/dosyalar/2019_05/08180311_5468-Such_Ve_Ceza-Fyodor_Dostoyevski-Hasan_Alizade-1964-1300s.pdf',
    'Anna Karenina':
        'http://kosektas.net/FileUpload/op35018/File/anna-karenina.pdf',
    'Romeo ve Juliet':
        'https://kasimtiyatrosu.files.wordpress.com/2019/01/william-shakespeare-romeo-juliet.pdf',
    'Semerkant':
        'https://bartinfuatsezginmtal.meb.k12.tr/meb_iys_dosyalar/74/01/766388/dosyalar/2020_04/09195234_Semerkant_-_Amin_Maalouf__PDFDrive.com_.pdf',
    'Devlet Ana':
        'https://kapadokya.edu.tr/MediaUploader/Documents/Devlet%20Ana%20-%20Kemal%20Tahir%20(%20PDFDrive.com%20).pdf',
  };

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> bookJsonList =
        favoriteBooks.map((book) => jsonEncode(book.toJson())).toList();
    await prefs.setStringList('favorites', bookJsonList);
  }

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
    } else {
      setState(() {
        favoriteBooks = []; // Eğer veriler yoksa boş listeyi ayarla
      });
    }
  }

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
    final book = widget.book;
    final summary = bookSummaries[book.title] ?? 'Özet bulunamadı.';
    final fullContent = fullBookContents[book.title] ?? 'İçerik bulunamadı.';
    final isFavorite = favoriteBooks.contains(book);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child:
                        book.image.startsWith("http")
                            ? Image.network(book.image, fit: BoxFit.cover)
                            : Image.asset(book.image, fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft, // Sol üst köşeye yerleştir
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 16,
                    ), // Butona etrafında boşluk ekleyebiliriz
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context); // Geri gitmek için
                      },
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image:
                                book.image.startsWith("http")
                                    ? NetworkImage(book.image)
                                    : AssetImage(book.image) as ImageProvider,
                            height: 270,
                            width: 170,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        book.yazar,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 239, 239),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 16,
                  right: 16,
                  bottom: 10,
                ),
                child: Card(
                  color: const Color.fromARGB(255, 243, 193, 144),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.book, size: 30), // Oku ikonu
                            onPressed: () async {
                              final dir =
                                  await getApplicationDocumentsDirectory();
                              final filePath = '${dir.path}/${book.title}.pdf';
                              final file = File(filePath);

                              if (await file.exists()) {
                                // Eğer dosya varsa cihazdan oku
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BookReadScreen(
                                          title: book.title,
                                          content: filePath,
                                          fromFile: true,
                                        ),
                                  ),
                                );
                              } else {
                                // Dosya yoksa internetten oku
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BookReadScreen(
                                          title: book.title,
                                          content: fullContent,
                                          fromFile: false,
                                        ),
                                  ),
                                );
                              }
                            },
                          ),

                          Text("Read"),
                        ],
                      ),

                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              favoriteBooks.contains(book)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 30,
                              color:
                                  favoriteBooks.contains(book)
                                      ? Colors.red
                                      : null, // Favori kitaplar kırmızı kalp olacak
                            ),
                            onPressed: () {
                              setState(() {
                                if (favoriteBooks.contains(book)) {
                                  favoriteBooks.remove(book);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Favorilerden çıkarıldı'),
                                    ),
                                  );
                                } else {
                                  favoriteBooks.add(book);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Favorilere eklendi'),
                                    ),
                                  );
                                }
                                saveFavorites(); // Favoriler kaydedildi
                              });
                            },
                          ),
                          Text("Favoriler"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.download, size: 30),
                            onPressed: () async {
                              downloadPdf(context, book.title, fullContent);
                            },
                          ),
                          Text("İndir"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Özet kartı
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey, // Kenarlık rengi
                            width: 2.0, // Kenarlık kalınlığı
                          ),
                        ),
                        color: const Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ), // Arka plan rengi
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15), // Sol üst köşe yuvarlat
                          topRight: Radius.circular(
                            15,
                          ), // Sağ üst köşe yuvarlat
                        ), // Köşeleri 20 birim yuvarlat
                      ),

                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Icon(
                              Icons.error_outline,
                              size: 30,
                              color: Color.fromARGB(
                                255,
                                191,
                                97,
                                1,
                              ), // Bildirim çubuğ
                            ),
                          ),
                          Text(
                            "Book Description",
                            style: TextStyle(
                              color: Color.fromARGB(
                                255,
                                191,
                                97,
                                1,
                              ), // Bildirim çubuğu rengi (
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.access_time,
                              size: 30,
                              color: Color.fromARGB(
                                255,
                                191,
                                97,
                                1,
                              ), // Bildirim çubuğu rengi (
                            ),
                          ),
                          Text(
                            book.date.toString(),
                            style: TextStyle(
                              color: Color.fromARGB(
                                255,
                                191,
                                97,
                                1,
                              ), // Bildirim çubuğu rengi (
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            summary,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 246, 124, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

Future<void> downloadPdf(BuildContext context, String title, String url) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$title.pdf';
    final file = File(filePath);

    // Eğer dosya zaten varsa, silme işlemi için onay iste
    if (await file.exists()) {
      // Onay penceresini göster
      bool? shouldDelete = await showDialog<bool>(
        context: context,
        barrierDismissible:
            false, // Kullanıcı dışarı tıklayarak pencereyi kapatamasın
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Kitap Silinsin Mi?'),
            content: Text(
              '$title kitabını silmek istediğinizden emin misiniz?',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Hayır'),
                onPressed: () {
                  Navigator.of(context).pop(false); // Hayır seçeneği
                },
              ),
              TextButton(
                child: const Text('Evet'),
                onPressed: () {
                  Navigator.of(context).pop(true); // Evet seçeneği
                },
              ),
            ],
          );
        },
      );

      if (shouldDelete != true) {
        return; // Kullanıcı silmeyi onaylamadıysa işlem sonlandırılır
      }

      // Kitap silinecekse, silme işlemi yapılır
      await file.delete(); // Dosyayı sil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$title başarıyla silindi."),
          backgroundColor: Colors.red,
        ),
      );
      return; // Silme işleminden sonra fonksiyonu bitir
    }

    // Dosya yoksa, indir
    final dio = Dio();
    double progress = 0;

    // Dialog'u göstermek için controller
    late void Function(void Function()) updateState;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: const Text("İndiriliyor"),
            content: StatefulBuilder(
              builder: (context, setState) {
                updateState = setState; // setState'i dışa al
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(value: progress),
                    const SizedBox(height: 16),
                    Text("%${(progress * 100).toStringAsFixed(0)}"),
                  ],
                );
              },
            ),
          ),
    );

    await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          progress = received / total;
          updateState(() {}); // setState çağrısı burada yapılmalı
        }
      },
    );

    Navigator.of(context).pop(); // Dialog kapatılır

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title başarıyla indirildi."),
        backgroundColor: Colors.green,
      ),
    );

    await OpenFile.open(filePath); // Dosya açılır
  } catch (e) {
    Navigator.of(context).pop(); // Hata anında dialog kapatılır
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("İndirme hatası: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
