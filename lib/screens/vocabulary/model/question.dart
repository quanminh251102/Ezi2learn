

class Question {
  String id;
  String topic;
  final String text;
  final String image;
  bool isLocked;
  bool? selectedOption;
  final Map<String, bool> options;

  Question(
      {this.id = '',
      required this.topic,
      required this.text,
      required this.image,
      this.isLocked = false,
      this.selectedOption,
      required this.options});
  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        'text': text,
        'image': image,
        'isLocked': isLocked,
        'selectedOption': selectedOption,
        'options': options,
      };
}
