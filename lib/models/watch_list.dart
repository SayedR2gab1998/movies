class WatchList {
  final String poster;
  final String title;
  final String date;

  WatchList({required this.poster, required this.title,required this.date,});

  factory WatchList.fromJson(json) {
    return WatchList(
      poster: json['poster'],
      title: json['title'],
      date: json['date'],
    );
  }
}