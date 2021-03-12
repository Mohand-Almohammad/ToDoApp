
class Task{
  int _id;
  String _title;
  bool _is_completed;
  String _created_at;

Task(this._title, this._is_completed, this._created_at, this._id);

   Task.fromJson(Map<String, dynamic> map){
      this._id             = map["id"];
      this._title          = map["title"];
      this._is_completed   = map["is_completed"];
      this._created_at     = map["created_at"];
  }

  
  String get created_at  => created_at;
  int    get id          => _id;
  String get title       => _title;
  bool get is_completed  => _is_completed;
  
  set setId(int id)                => _id = id;
  set setUserId(String created_at) => _created_at = created_at;
  set setTitle(String title)        => _title = title;
  set setIsCompleted(bool is_completed)  => _is_completed = is_completed;
}