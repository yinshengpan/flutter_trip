import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  SearchModel({
    this.data,
    this.resultPageUrl,
    this.keyword,
  });

  List<SearchItem>? data;
  String? resultPageUrl;
  String? keyword;

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}

@JsonSerializable()
class SearchItem {
  SearchItem({
    this.code,
    this.word,
    this.type,
    this.districtname,
    this.url,
    this.isBigIcon,
    this.price,
    this.zonename,
    this.imageUrl,
    this.subImageUrl,
    this.star,
  });

  String? code;
  String? word;
  String? type;
  String? districtname;
  String? url;
  bool? isBigIcon;
  String? price;
  String? zonename;
  String? imageUrl;
  String? subImageUrl;
  String? star;

  factory SearchItem.fromJson(Map<String, dynamic> json) =>
      _$SearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchItemToJson(this);
}
