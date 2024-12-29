// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class InfoModel {
  final String count;
  final String pages;
  final String? next;
  final String? prev;
  InfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });
  

  InfoModel copyWith({
    String? count,
    String? pages,
    String? next,
    String? prev,
  }) {
    return InfoModel(
      count: count ?? this.count,
      pages: pages ?? this.pages,
      next: next ?? this.next,
      prev: prev ?? this.prev,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      count: map['count'] as String,
      pages: map['pages'] as String,
      next: map['next'] != null ? map['next'] as String : null,
      prev: map['prev'] != null ? map['prev'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoModel.fromJson(String source) => InfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InfoModel(count: $count, pages: $pages, next: $next, prev: $prev)';
  }

  @override
  bool operator ==(covariant InfoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.count == count &&
      other.pages == pages &&
      other.next == next &&
      other.prev == prev;
  }

  @override
  int get hashCode {
    return count.hashCode ^
      pages.hashCode ^
      next.hashCode ^
      prev.hashCode;
  }
}
