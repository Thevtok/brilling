class Article {
  final String title;
  final Thumbnail? thumbnail;
  final Category? category;

  Article({required this.title, this.thumbnail, this.category});
}

class Thumbnail {
  final String url;
  Thumbnail({required this.url});
}

class Category {
  final String name;
  Category({required this.name});
}