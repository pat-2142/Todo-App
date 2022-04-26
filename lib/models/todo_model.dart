class Todo {
  int? id;
  final String title;
  bool isChecked;

  // the constructor
  Todo({
    this.id,
    required this.title,
    required this.isChecked,
  });

  // this function converts the data into maps
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isChecked': isChecked
          ? 1
          : 0, // sqflite does not support boolean so will be saved as an integer
    };
  }

  // this function is for debugging only
  @override
  String toString() {
    return 'Todo(id : $id, title : $title, isChecked : $isChecked)';
  }
}
