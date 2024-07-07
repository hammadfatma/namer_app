class Quote {
  String? id;
  String? content;
  String? author;
  List<dynamic>? tags;
  String? authorSlug;
  int? length;
  String? dateAdded;
  String? dateModified;

  Quote({
    this.id,
    this.content,
    this.author,
    this.tags,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json['_id'] as String?,
        content: json['content'] as String?,
        author: json['author'] as String?,
        tags: json['tags'] as List<dynamic>?,
        authorSlug: json['authorSlug'] as String?,
        length: json['length'] as int?,
        dateAdded: json['dateAdded'] as String?,
        dateModified: json['dateModified'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'content': content,
        'author': author,
        'tags': tags,
        'authorSlug': authorSlug,
        'length': length,
        'dateAdded': dateAdded,
        'dateModified': dateModified,
      };
}
