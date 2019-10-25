
class TimesModel {
  int id;
  String title;
  int points;
  int timeInMinutes;
  DateTime date;

  TimesModel({this.id, this.title, this.date, this.points, this.timeInMinutes});

  TimesModel.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.title = map['title'];
    this.points = map['points'];
    this.timeInMinutes = map['timeInMinutes'];
    this.date = DateTime.parse(map['date']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'title': this.title,
      'points': this.points,
      'timeInMinutes': this.timeInMinutes,
      'date': this.date.toIso8601String()
    };
  }
}