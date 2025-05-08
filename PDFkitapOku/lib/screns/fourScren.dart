import 'package:deneme/screns/KategoriKitaplarScreen.dart';
import 'package:deneme/screns/Widget/kategori.dart';
import 'package:deneme/screns/Widget/yzarKategorilist.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Fourscren extends StatefulWidget {
  const Fourscren({Key? key}) : super(key: key);

  @override
  _FourScreenState createState() => _FourScreenState();
}

class _FourScreenState extends State<Fourscren> {
  final TextEditingController _searchController = TextEditingController();
  late List<Kategori> _filteredKategoriler;

  @override
  void initState() {
    super.initState();
    // Başlangıçta tüm kategorileri göster
    _filteredKategoriler = List.from(kategorilers);
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
        _filteredKategoriler = List.from(kategorilers);
      } else {
        _filteredKategoriler =
            kategorilers
                .where((k) => k.isim.toLowerCase().contains(query))
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
        title: const Text(
          "Kategoriler",
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
                hintText: 'Kategori ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child:
                _filteredKategoriler.isEmpty
                    ? const Center(child: Text('Hiç kategori bulunamadı.'))
                    : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Her satırda 2 eleman
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio:
                                3 / 2.5, // Kart boy oranı (resim/yazı)
                          ),
                      itemCount: _filteredKategoriler.length,
                      itemBuilder: (context, index) {
                        final kategori = _filteredKategoriler[index];
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: const Color.fromARGB(255, 246, 124, 1),
                              width: 2,
                            ),
                          ),
                          elevation: 4,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
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

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                      right: 30,
                                      left: 30,
                                    ),
                                    child:
                                        kategori.resimUrl.startsWith('http')
                                            ? Image.network(
                                              kategori.resimUrl,
                                              height: 70,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                            : Image.asset(
                                              kategori.resimUrl,
                                              height: 70,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Container(
                                  decoration: const BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      246,
                                      124,
                                      1,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  height: 25,
                                  width: double.infinity,

                                  child: Text(
                                    kategori.isim,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
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
