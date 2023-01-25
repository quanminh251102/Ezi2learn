

class Question {
  String id;
  String topic;
  final String text;
  final String image;
  bool isLocked;
  int? selectedIndex;
  final Map<String, bool> options;

  Question(
      {this.id = '',
      required this.topic,
      required this.text,
      required this.image,
      this.isLocked = false,
      this.selectedIndex,
      required this.options});
  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        'text': text,
        'image': image,
        'isLocked': isLocked,
        'selectedOption': selectedIndex,
        'options': options,
      };
}
