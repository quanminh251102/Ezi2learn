class Vocabulary {
  String id;
  String text;
  String image;
  String spelling;
  String meaning;
  bool studied;
  Vocabulary(
      {this.id = '',
      required this.text,
      required this.image,
      required this.spelling,
      required this.meaning,
      this.studied = false,});
  Map<String, dynamic> toJson() => {
        'id': '',
        'text': text,
        'image': image,
        'spelling': spelling,
        'meaning': meaning,
        'studied': studied
      };
}
