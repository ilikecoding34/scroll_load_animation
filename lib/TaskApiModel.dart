class TaskApiModel {
  int userId;
  int id;
  String title;
  bool completed;

  int get getuserid => userId;
  int get getid => id;
  String get getTitle => title;
  bool get getcompleted => completed;

  TaskApiModel(this.userId, this.id, this.title, this.completed);
}
