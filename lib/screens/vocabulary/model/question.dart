
class Question {
  String id;
  String topic;
  final String text;
  final String image;
  bool isLocked;
  int? selectedIndex;

  Question(
      {this.id = '',
      required this.topic,
      required this.text,
      required this.image,
      this.isLocked = false,
      this.selectedIndex});
  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        'text': text,
        'image': image,
        'isLocked': isLocked,
        'selectedOption': selectedIndex,
      };
}
