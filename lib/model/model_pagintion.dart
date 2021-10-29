// To parse this JSON data, do
//
//     final modelPagination = modelPaginationFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

ModelPagination modelPaginationFromJson(String str) =>
    ModelPagination.fromJson(json.decode(str));

String modelPaginationToJson(ModelPagination data) =>
    json.encode(data.toJson());

class ModelPagination with ChangeNotifier {
  ModelPagination({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    // this.support,
  });

  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<PaginationData> data;

  // final Support support;

  factory ModelPagination.fromJson(Map<String, dynamic> json) =>
      ModelPagination(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<PaginationData>.from(json["data"]
            .map((x) => PaginationData.fromJson(x, total: json["total"]))),
        // support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "support": support.toJson(),
      };
}

class PaginationData with ChangeNotifier {
  PaginationData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.total,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final int total;

  factory PaginationData.fromJson(Map<String, dynamic> json, {int total}) =>
      PaginationData(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
        total: total,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

