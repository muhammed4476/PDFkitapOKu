class Book {
  final String title; // Kitabın başlığı
  final String yazar; // Kitabın yazarı
  final String image; // Kitabın görsel URL'si veya asset yolu
  final String date; // Kitabın eklendiği tarih
  final String aciklama; // Kitabın açıklaması veya özeti

  Book({
    required this.title,
    required this.yazar,
    required this.image,
    required this.date,
    required this.aciklama,
  });

  /// JSON’a çevirirken DateTime’ı ISO string’e dönüştürüyoruz
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'yazar': yazar,
      'image': image,
      'date': date,
      'aciklama': aciklama,
    };
  }

  /// JSON’dan okurken ISO string’i DateTime’a parse ediyoruz
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      yazar: json['yazar'] as String,
      image: json['image'] as String,
      date: json['date'] as String,
      aciklama: json['aciklama'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Book &&
            title == other.title &&
            yazar == other.yazar &&
            image == other.image &&
            date == other.date &&
            aciklama == other.aciklama);
  }

  @override
  int get hashCode =>
      title.hashCode ^
      yazar.hashCode ^
      image.hashCode ^
      date.hashCode ^
      aciklama.hashCode;
}
