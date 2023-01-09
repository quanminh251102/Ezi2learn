class SpeakLesson {
  String? title;
  String? subTilte;
  List<String>? words;
  List<String>? meanings;
  SpeakLesson(String title, String subTilte, List<String> words,
      List<String> meanings) {
    this.title = title;
    this.subTilte = subTilte;
    this.words = words;
    this.meanings = meanings;
  }
}

var data = [
  SpeakLesson(
    "Pizza for dinner",
    "/i:/ and /i/",
    [
      "see",
      "agree",
      "eat",
      "seat",
      "team",
      "if",
      "listen",
      "miss",
      "dinner",
      "swim"
    ],
    [
      "nhìn",
      "đồng ý",
      "ăn",
      "ghế ngồi",
      "đội",
      "nếu",
      "nghe",
      "bỏ lở",
      "buổi ăn chiều",
      "bơi"
    ],
  ),
  SpeakLesson(
    "Pizza for dinner",
    "/i:/ and /i/",
    [
      "see",
      "agree",
      "eat",
      "seat",
      "team",
      "if",
      "listen",
      "miss",
      "dinner",
      "swim"
    ],
    [
      "nhìn",
      "đồng ý",
      "ăn",
      "ghế ngồi",
      "đội",
      "nếu",
      "nghe",
      "bỏ lở",
      "buổi ăn chiều",
      "bơi"
    ],
  ),
  SpeakLesson(
    "test",
    "test",
    [
      "hello",
      "yellow",
    ],
    ["chào", "vàng"],
  ),
];
