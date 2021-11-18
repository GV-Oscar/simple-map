import 'dart:convert';

GeocodingResponse geocodingResponseFromJson(String str) =>
    GeocodingResponse.fromJson(json.decode(str));

String geocodingResponseToJson(GeocodingResponse data) =>
    json.encode(data.toJson());

class GeocodingResponse {
  GeocodingResponse({
    this.query,
    required this.features,
    this.attribution,
  });

  List<String>? query;
  List<Feature> features;
  String? attribution;

  factory GeocodingResponse.fromJson(Map<String, dynamic> json) =>
      GeocodingResponse(
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "query":
            query == null ? null : List<dynamic>.from(query!.map((x) => x)),
        "features": features == null
            ? null
            : List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.text,
    required this.placeName,
    this.bbox,
    required this.center,
    required this.geometry,
    required this.context,
    this.matchingText,
    this.matchingPlaceName,
  });

  String id;
  List<String> placeType;
  int relevance;
  Properties properties;
  String text;
  String placeName;
  List<double>? bbox;
  List<double> center;
  Geometry geometry;
  List<Context> context;
  String? matchingText;
  String? matchingPlaceName;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null
            ? null
            : List<double>.from(json["bbox"].map((x) => x.toDouble())),
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        matchingText:
            json["matching_text"] == null ? null : json["matching_text"],
        matchingPlaceName: json["matching_place_name"] == null
            ? null
            : json["matching_place_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text": text,
        "place_name": placeName,
        "bbox": bbox == null ? null : List<dynamic>.from(bbox!.map((x) => x)),
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
        "matching_text": matchingText == null ? null : matchingText,
        "matching_place_name":
            matchingPlaceName == null ? null : matchingPlaceName,
      };
}

class Context {
  Context({
    this.id,
    this.wikidata,
    this.shortCode,
    this.textEs,
    this.languageEs,
    this.text,
    this.language,
  });

  String? id;
  String? wikidata;
  String? shortCode;
  String? textEs;
  String? languageEs;
  String? text;
  String? language;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"] == null ? null : json["id"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        shortCode: json["short_code"] == null ? null : json["short_code"],
        textEs: json["text_es"] == null ? null : json["text_es"],
        languageEs: json["language_es"] == null ? null : json["language_es"],
        text: json["text"] == null ? null : json["text"],
        language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wikidata": wikidata,
        "short_code": shortCode,
        "text_es": textEs,
        "language_es": languageEs,
        "text": text,
        "language": language,
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.wikidata,
    this.foursquare,
    this.landmark,
    this.address,
    this.category,
  });

  String? wikidata;
  String? foursquare;
  bool? landmark;
  String? address;
  String? category;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        foursquare: json["foursquare"] == null ? null : json["foursquare"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        address: json["address"] == null ? null : json["address"],
        category: json["category"] == null ? null : json["category"],
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata == null ? null : wikidata,
        "foursquare": foursquare == null ? null : foursquare,
        "landmark": landmark == null ? null : landmark,
        "address": address == null ? null : address,
        "category": category == null ? null : category,
      };
}
