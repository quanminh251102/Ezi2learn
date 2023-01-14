class Option {
  String id;
  final String text;
  final bool isCorrect;

  Option({this.id = '', required this.text, required this.isCorrect});

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'isCorrect': isCorrect,
      };
}
