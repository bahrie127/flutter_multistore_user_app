import 'dart:convert';

class BannersResponseModel {
  final List<Banner> data;

  BannersResponseModel({
    required this.data,
  });

  factory BannersResponseModel.fromJson(String str) =>
      BannersResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannersResponseModel.fromMap(Map<String, dynamic> json) =>
      BannersResponseModel(
        data: List<Banner>.from(json["data"].map((x) => Banner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Banner {
  final int id;
  final String name;
  final String bannerUrl;
  final int isEnable;
  final DateTime createdAt;
  final DateTime updatedAt;

  Banner({
    required this.id,
    required this.name,
    required this.bannerUrl,
    required this.isEnable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Banner.fromJson(String str) => Banner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Banner.fromMap(Map<String, dynamic> json) => Banner(
        id: json["id"],
        name: json["name"],
        bannerUrl: json["banner_url"],
        isEnable: json["is_enable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "banner_url": bannerUrl,
        "is_enable": isEnable,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
