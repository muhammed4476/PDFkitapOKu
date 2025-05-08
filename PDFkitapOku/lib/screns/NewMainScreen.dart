import 'package:flutter/material.dart';
import 'package:deneme/screns/DownloadedBooksScreen.dart';
import 'package:deneme/screns/fourScren.dart';
import 'package:deneme/screns/homeScren.dart';
import 'package:deneme/screns/favorite_screen.dart'; // Favori ekranı

class NewMainScreen extends StatefulWidget {
  const NewMainScreen({super.key});

  @override
  _NewMainScreenState createState() => _NewMainScreenState();
}

class _NewMainScreenState extends State<NewMainScreen> {
  int _selectedIndex = 0; // Geçerli alt çubuk indexi

  final List<Widget> _pages = [
    Homescren(), // Ana sayfa
    Fourscren(), // Kategori sayfası
    DownloadedBooksScreen(), // İndirilenler sayfası
    FavoriteScreen(), // Favoriler sayfası
  ];

  // Bu fonksiyonla her tıklamada alt çubuğun indexi değişiyor
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sayfa içerikleri değişiyor ama alt navigasyon çubuğu sabit kalıyor
      body: _pages[_selectedIndex], // Sayfalar burada değişiyor
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(
          255,
          255,
          255,
          255,
        ), // Alt çubuğun arka plan rengi
        selectedItemColor: Color.fromARGB(255, 191, 97, 1),
        unselectedItemColor: const Color.fromARGB(
          255,
          196,
          195,
          195,
        ), // Seçili olmayan öğelerin rengi
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'İndirilenler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
        ],
      ),
    );
  }
}
