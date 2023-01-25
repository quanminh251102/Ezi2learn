class Option {
  String id;
  String ruid;
  final String text;
  final bool isCorrect;

  Option({this.id = '',this.ruid = '', required this.text, required this.isCorrect});

  Map<String, dynamic> toJson() => {
        'id': id,
        'ruid': ruid,
        'text': text,
        'isCorrect': isCorrect,
      };
  Option.fromMap(Map<String, dynamic> OptionMap)
      : id = OptionMap["id"],
        ruid = OptionMap["ruid"],
        text = OptionMap["text"],
        isCorrect = OptionMap["isCorrect"];
}
