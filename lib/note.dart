class Note {
  final int? id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  /*

e.g. map <---> note

{
  'id':1,
  'content': 'hello'
}

Note(
  'id':1,
  'content': 'hello'
)

*/

  //map -> note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
  //note -> map
  Map<String, dynamic> toMap() {
    final map = {
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id.toString();
    }
    return map;
  }
}
