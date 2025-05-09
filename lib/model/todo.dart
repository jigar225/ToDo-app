class Todo{
  final String title;
  final String subtitle;
  final DateTime? dueDate;
  bool isDone;

  Todo({
    this.title = "",
    this.subtitle = "",
    this.isDone = false,
    this.dueDate,
});
  Todo copyWith({
    String? title,
    String? subtitle,
    bool? isDone,
    DateTime? dueDate,
}){
    return Todo(
      title: title ?? this.title,
      subtitle:  subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
      dueDate: dueDate ?? this.dueDate,
    );
  }
  factory Todo.fromJson(Map<String,dynamic>json){
    return Todo(
      title:json['title'],
      subtitle: json['subtitle'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      isDone: json['isDone'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'title':title,
      'subtitle':subtitle,
      'dueDate': dueDate?.toIso8601String(),
      'isDone':isDone,
    };
  }

  @override
  String toString(){
    return ''' Todo:{
    title:$title\n
    subtitle:$subtitle\n
    dueDate: $dueDate\n
    isDone:$isDone\n
    }''';
  }
}