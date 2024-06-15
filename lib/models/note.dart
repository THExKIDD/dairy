class Note{
  int? id;
  String title , description;
  DateTime createdAt;



  Note({this.id , required this.title , required this.description , required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt' : createdAt.toString(),
    };
  }

}