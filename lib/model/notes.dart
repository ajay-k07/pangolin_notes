// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// ignore: must_be_immutable
class Notes extends Equatable {
  @Id(assignable: false)
  int? id;
  final String? title;
  final String? body;
  final String? category;
  final String? color;
  @Property(type: PropertyType.date)
  final DateTime? created;
  @Property(type: PropertyType.date)
  final DateTime? lastEdit;
  final bool? pinned;
  Notes({
    this.id = 0,
    this.title = 'New Note',
    this.body = '',
    this.category = 'General',
    this.color = '4294940672',
    this.created,
    this.lastEdit,
    this.pinned = false,
  });

  Notes copyWith({
    int? id,
    String? title,
    String? body,
    String? category,
    String? color,
    DateTime? created,
    DateTime? lastEdit,
    bool? pinned,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      color: color ?? this.color,
      created: created ?? this.created,
      lastEdit: lastEdit ?? this.lastEdit,
      pinned: pinned ?? this.pinned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'category': category,
      'color': color,
      'created': created?.millisecondsSinceEpoch,
      'lastEdit': lastEdit?.millisecondsSinceEpoch,
      'pinned': pinned,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      created: map['created'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created'] as int)
          : null,
      lastEdit: map['lastEdit'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastEdit'] as int)
          : null,
      pinned: map['pinned'] != null ? map['pinned'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) =>
      Notes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notes(id: $id, title: $title, body: $body, category: $category, color: $color, created: $created, lastEdit: $lastEdit, pinned: $pinned)';
  }

  @override
  List<Object?> get props =>
      [id, title, body, category, color, created, lastEdit, pinned];
}

extension MaterialUtil on Notes? {
  Color get materialColor => stringToColour(this!.color);
}

Color stringToColour(String? stringColor) {
  final value = int.parse(stringColor!);
  return Color(value).withOpacity(1);
}
