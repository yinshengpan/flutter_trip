// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      resultPageUrl: json['resultPageUrl'] as String?,
      keyword: json['keyword'] as String?,
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'resultPageUrl': instance.resultPageUrl,
      'keyword': instance.keyword,
    };

SearchItem _$SearchItemFromJson(Map<String, dynamic> json) => SearchItem(
      code: json['code'] as String?,
      word: json['word'] as String?,
      type: json['type'] as String?,
      districtname: json['districtname'] as String?,
      url: json['url'] as String?,
      isBigIcon: json['isBigIcon'] as bool?,
      price: json['price'] as String?,
      zonename: json['zonename'] as String?,
      imageUrl: json['imageUrl'] as String?,
      subImageUrl: json['subImageUrl'] as String?,
      star: json['star'] as String?,
    );

Map<String, dynamic> _$SearchItemToJson(SearchItem instance) =>
    <String, dynamic>{
      'code': instance.code,
      'word': instance.word,
      'type': instance.type,
      'districtname': instance.districtname,
      'url': instance.url,
      'isBigIcon': instance.isBigIcon,
      'price': instance.price,
      'zonename': instance.zonename,
      'imageUrl': instance.imageUrl,
      'subImageUrl': instance.subImageUrl,
      'star': instance.star,
    };
