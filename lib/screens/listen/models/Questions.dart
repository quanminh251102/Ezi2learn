class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "...",
    "options": ['Not at all', 'Not so much', 'Not that I know of'],
    "answer_index": 0,
  },
  {
    "id": 2,
    "question": "...",
    "options": ['Thanks a lot', 'Sounds good', 'Up to you'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "...",
    "options": ["Yes! That's this!", "Yes! That's it!", "Yes! That's that!"],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question": "...",
    "options": ["I'm afraid so", "I'm afraid not", "I'm afraid no"],
    "answer_index": 1,
  },
  {
    "id": 5,
    "question": "...",
    "options": ["No way", "Nothing much", "Not that I know of"],
    "answer_index": 1,
  },
  {
    "id": 6,
    "question": "...",
    "options": ["Much, sir", "Yes please", "Yes, I care"],
    "answer_index": 1,
  },
];
