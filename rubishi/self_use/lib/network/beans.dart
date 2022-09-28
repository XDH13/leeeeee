

class Video {
  Video({
    this.id,
    this.author,
    this.mid,
    this.typeName,
    this.url,
    this.title,
    this.description,
    this.pic,
    this.playCount,
    this.pubDate,
    this.duration,
    this.uPic,
    this.playLike,
    this.playStar,
  });
  int id;
  String author;
  int mid;
  String typeName;
  String url;
  String title;
  String description;
  String pic;
  int playCount;
  int pubDate;
  String duration;
  String uPic;
  int playLike;
  int playStar;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    author: json["author"],
    mid: json["mid"],
    typeName: json["typename"] ?? '',
    url: json["arcurl"].toString().replaceAll('http', 'https'),
    title: json["title"]
        .toString()
        .replaceAll('<em class="keyword">', '')
        .replaceAll('&quot', '')
        .replaceAll('</em>', ''),
    description: json["description"],
    pic: 'https:' + json["pic"].toString(),
    playCount: json["play"],
    pubDate: json["pubdate"],
    duration: json["duration"],
    uPic: json["upic"],
    playLike: json["like"],
    playStar: json["favorites"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "mid": mid,
    "name": typeName,
    "arcurl": url,
    "title": title,
    "description": description,
    "pic": pic,
    "play": playCount,
    "pubdate": pubDate,
    "duration": duration,
    "upic": uPic,
    "like": playLike,
    "favourites": playStar,
  };
}