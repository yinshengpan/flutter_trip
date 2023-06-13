import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  HomeModel({
    this.config,
    this.bannerList,
    this.localNavList,
    this.gridNav,
    this.subNavList,
    this.salesBox,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  ConfigModel? config;
  List<CommonModel>? bannerList;
  List<CommonModel>? localNavList;
  GridNav? gridNav;
  List<CommonModel>? subNavList;
  SalesBoxModel? salesBox;

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class SalesBoxModel {
  SalesBoxModel({
    this.icon,
    this.moreUrl,
    this.bigCard1,
    this.bigCard2,
    this.smallCard1,
    this.smallCard2,
    this.smallCard3,
    this.smallCard4,
  });

  factory SalesBoxModel.fromJson(Map<String, dynamic> json) =>
      _$SalesBoxModelFromJson(json);

  String? icon;
  String? moreUrl;
  CommonModel? bigCard1;
  CommonModel? bigCard2;
  CommonModel? smallCard1;
  CommonModel? smallCard2;
  CommonModel? smallCard3;
  CommonModel? smallCard4;

  Map<String, dynamic> toJson() => _$SalesBoxModelToJson(this);
}

@JsonSerializable()
class GridNav {
  GridNav({
    this.hotel,
    this.flight,
    this.travel,
  });

  factory GridNav.fromJson(Map<String, dynamic> json) =>
      _$GridNavFromJson(json);

  GridNavItem? hotel;
  GridNavItem? flight;
  GridNavItem? travel;

  Map<String, dynamic> toJson() => _$GridNavToJson(this);
}

@JsonSerializable()
class CommonModel {
  CommonModel({
    this.title,
    this.icon,
    this.url,
    this.hideAppBar,
    this.statusBarColor,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) =>
      _$CommonModelFromJson(json);

  String? title;
  String? icon;
  String? url;
  bool? hideAppBar;
  String? statusBarColor;

  Map<String, dynamic> toJson() => _$CommonModelToJson(this);
}

@JsonSerializable()
class GridNavItem {
  GridNavItem({
    this.startColor,
    this.endColor,
    this.mainItem,
    this.item1,
    this.item2,
    this.item3,
    this.item4,
  });

  factory GridNavItem.fromJson(Map<String, dynamic> json) =>
      _$GridNavItemFromJson(json);

  String? startColor;
  String? endColor;
  CommonModel? mainItem;
  CommonModel? item1;
  CommonModel? item2;
  CommonModel? item3;
  CommonModel? item4;

  Map<String, dynamic> toJson() => _$GridNavItemToJson(this);
}

@JsonSerializable()
class ConfigModel {
  ConfigModel({
    this.searchUrl,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);
  String? searchUrl;

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}
