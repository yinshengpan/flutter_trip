class HomeModel {
  HomeModel({
    this.config,
    this.bannerList,
    this.localNavList,
    this.gridNav,
    this.subNavList,
    this.salesBox,
  });

  HomeModel.fromJson(dynamic json) {
    config = json['config'] != null ? ConfigModel.fromJson(json['config']) : null;
    if (json['bannerList'] != null) {
      bannerList = [];
      json['bannerList'].forEach((v) {
        bannerList?.add(CommonModel.fromJson(v));
      });
    }
    if (json['localNavList'] != null) {
      localNavList = [];
      json['localNavList'].forEach((v) {
        localNavList?.add(CommonModel.fromJson(v));
      });
    }
    gridNav =
        json['gridNav'] != null ? GridNav.fromJson(json['gridNav']) : null;
    if (json['subNavList'] != null) {
      subNavList = [];
      json['subNavList'].forEach((v) {
        subNavList?.add(CommonModel.fromJson(v));
      });
    }
    salesBox =
        json['salesBox'] != null ? SalesBoxModel.fromJson(json['salesBox']) : null;
  }

  ConfigModel? config;
  List<CommonModel>? bannerList;
  List<CommonModel>? localNavList;
  GridNav? gridNav;
  List<CommonModel>? subNavList;
  SalesBoxModel? salesBox;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (config != null) {
      map['config'] = config?.toJson();
    }
    if (bannerList != null) {
      map['bannerList'] = bannerList?.map((v) => v.toJson()).toList();
    }
    if (localNavList != null) {
      map['localNavList'] = localNavList?.map((v) => v.toJson()).toList();
    }
    if (gridNav != null) {
      map['gridNav'] = gridNav?.toJson();
    }
    if (subNavList != null) {
      map['subNavList'] = subNavList?.map((v) => v.toJson()).toList();
    }
    if (salesBox != null) {
      map['salesBox'] = salesBox?.toJson();
    }
    return map;
  }
}

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

  SalesBoxModel.fromJson(dynamic json) {
    icon = json['icon'];
    moreUrl = json['moreUrl'];
    bigCard1 = json['bigCard1'] != null
        ? CommonModel.fromJson(json['bigCard1'])
        : null;
    bigCard2 = json['bigCard2'] != null
        ? CommonModel.fromJson(json['bigCard2'])
        : null;
    smallCard1 = json['smallCard1'] != null
        ? CommonModel.fromJson(json['smallCard1'])
        : null;
    smallCard2 = json['smallCard2'] != null
        ? CommonModel.fromJson(json['smallCard2'])
        : null;
    smallCard3 = json['smallCard3'] != null
        ? CommonModel.fromJson(json['smallCard3'])
        : null;
    smallCard4 = json['smallCard4'] != null
        ? CommonModel.fromJson(json['smallCard4'])
        : null;
  }

  String? icon;
  String? moreUrl;
  CommonModel? bigCard1;
  CommonModel? bigCard2;
  CommonModel? smallCard1;
  CommonModel? smallCard2;
  CommonModel? smallCard3;
  CommonModel? smallCard4;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['moreUrl'] = moreUrl;
    if (bigCard1 != null) {
      map['bigCard1'] = bigCard1?.toJson();
    }
    if (bigCard2 != null) {
      map['bigCard2'] = bigCard2?.toJson();
    }
    if (smallCard1 != null) {
      map['smallCard1'] = smallCard1?.toJson();
    }
    if (smallCard2 != null) {
      map['smallCard2'] = smallCard2?.toJson();
    }
    if (smallCard3 != null) {
      map['smallCard3'] = smallCard3?.toJson();
    }
    if (smallCard4 != null) {
      map['smallCard4'] = smallCard4?.toJson();
    }
    return map;
  }
}

class GridNav {
  GridNav({
    this.hotel,
    this.flight,
    this.travel,
  });

  GridNav.fromJson(dynamic json) {
    hotel = json['hotel'] != null ? GridNavItem.fromJson(json['hotel']) : null;
    flight =
        json['flight'] != null ? GridNavItem.fromJson(json['flight']) : null;
    travel =
        json['travel'] != null ? GridNavItem.fromJson(json['travel']) : null;
  }

  GridNavItem? hotel;
  GridNavItem? flight;
  GridNavItem? travel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hotel != null) {
      map['hotel'] = hotel?.toJson();
    }
    if (flight != null) {
      map['flight'] = flight?.toJson();
    }
    if (travel != null) {
      map['travel'] = travel?.toJson();
    }
    return map;
  }
}

class CommonModel {
  CommonModel({
    this.title,
    this.icon,
    this.url,
    this.hideAppBar,
    this.statusBarColor,
  });

  CommonModel.fromJson(dynamic json) {
    title = json['title'];
    icon = json['icon'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
    statusBarColor = json['statusBarColor'];
  }

  String? title;
  String? icon;
  String? url;
  bool? hideAppBar;
  String? statusBarColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['icon'] = icon;
    map['url'] = url;
    map['hideAppBar'] = hideAppBar;
    map['statusBarColor'] = statusBarColor;
    return map;
  }
}

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

  GridNavItem.fromJson(dynamic json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? CommonModel.fromJson(json['mainItem'])
        : null;
    item1 = json['item1'] != null ? CommonModel.fromJson(json['item1']) : null;
    item2 = json['item2'] != null ? CommonModel.fromJson(json['item2']) : null;
    item3 = json['item3'] != null ? CommonModel.fromJson(json['item3']) : null;
    item4 = json['item4'] != null ? CommonModel.fromJson(json['item4']) : null;
  }

  String? startColor;
  String? endColor;
  CommonModel? mainItem;
  CommonModel? item1;
  CommonModel? item2;
  CommonModel? item3;
  CommonModel? item4;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startColor'] = startColor;
    map['endColor'] = endColor;
    if (mainItem != null) {
      map['mainItem'] = mainItem?.toJson();
    }
    if (item1 != null) {
      map['item1'] = item1?.toJson();
    }
    if (item2 != null) {
      map['item2'] = item2?.toJson();
    }
    if (item3 != null) {
      map['item3'] = item3?.toJson();
    }
    if (item4 != null) {
      map['item4'] = item4?.toJson();
    }
    return map;
  }
}

class ConfigModel {
  ConfigModel({
    this.searchUrl,
  });

  ConfigModel.fromJson(dynamic json) {
    searchUrl = json['searchUrl'];
  }

  String? searchUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchUrl'] = searchUrl;
    return map;
  }
}
