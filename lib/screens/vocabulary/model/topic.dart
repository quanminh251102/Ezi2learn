class Topic {
  String id;
  String title;
  String image;
  int progress;
  int point;
  bool done;
  Topic(
      {this.id = '',
      required this.title,
      required this.image,
      required this.progress,
      required this.point,
      required this.done});
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'progress': progress,
        'point': point,
        'done': done
      };
}
