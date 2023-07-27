class NewsModel {
  List<News>? news;
  String? idArray;

  NewsModel({this.news, this.idArray});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(new News.fromJson(v));
      });
    }
    idArray = json['idArray'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v.toJson()).toList();
    }
    data['idArray'] = this.idArray;
    return data;
  }
}

class News {
  String? createdAt;
  String? title;
  String? description;
  String? imageUrl;
  String? id;

  News({this.createdAt, this.title, this.description, this.imageUrl, this.id});

  News.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}
