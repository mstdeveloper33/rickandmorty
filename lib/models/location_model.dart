// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'info_model.dart';

class LocationModel {
  InfoModel info;
  final List<LocationItem> locations;

  LocationModel({required this.info, required this.locations});

  LocationModel copyWith({
    InfoModel? info,
    List<LocationItem>? locations,
  }) {
    return LocationModel(
      info: info ?? this.info,
      locations: locations ?? this.locations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
      'locations': locations.map((x) => x.toMap()).toList(),
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      info: InfoModel.fromMap(map['info'] as Map<String, dynamic>),
      locations: List<LocationItem>.from(
        (map['results'] as List).map(
          (x) => LocationItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocationModel(info: $info, locations: $locations)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationModel &&
        other.info == info &&
        listEquals(other.locations, locations);
  }

  @override
  int get hashCode => info.hashCode ^ locations.hashCode;
}

class LocationItem {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List residents;
  final String url;

  LocationItem(
      {required this.id,
      required this.name,
      required this.type,
      required this.dimension,
      required this.residents,
      required this.url});

  LocationItem copyWith({
    int? id,
    String? name,
    String? type,
    String? dimension,
    List<String>? residents,
    String? url,
  }) {
    return LocationItem(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dimension: dimension ?? this.dimension,
      residents: residents ?? this.residents,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'dimension': dimension,
      'residents': residents,
      'url': url,
    };
  }

  factory LocationItem.fromMap(Map<String, dynamic> map) {
    return LocationItem(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      dimension: map['dimension'] as String,
      residents: List.from(
        (map['residents'] as List),
      ),
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationItem.fromJson(String source) =>
      LocationItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(id: $id, name: $name, type: $type, dimension: $dimension, residents: $residents, url: $url)';
  }

  @override
  bool operator ==(covariant LocationItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.dimension == dimension &&
        listEquals(other.residents, residents) &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        dimension.hashCode ^
        residents.hashCode ^
        url.hashCode;
  }
}
