import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  const CountryModel({
    required this.nameCommon,
    required this.nameOfficial,
    required this.capital,
    required this.capitalLocation,
    required this.region,
    required this.subregion,
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.languages,
    required this.area,
    required this.topLevelDomain,
    required this.population,
    required this.phoneCode,
    required this.timeZones,
    required this.carDrivingSide,
    required this.border,
    required this.googleMap,
    required this.continents,
    required this.flagPng,
    this.unGrouped = 'All Countries',
  });

  final String nameCommon;
  final String nameOfficial;
  final String capital;
  final List capitalLocation;
  final String region;
  final String subregion;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final String languages;
  final double area;
  final String topLevelDomain;
  final int population;
  final String phoneCode;
  final String timeZones;
  final String carDrivingSide;
  final String border;
  final Uri googleMap;
  final String continents;
  final String flagPng;
  final String unGrouped;

  @override
  List<Object?> get props => [
    nameCommon,
    nameOfficial,
    capital,
    capitalLocation,
    region,
    subregion,
    currencyCode,
    currencyName,
    currencySymbol,
    languages,
    area,
    topLevelDomain,
    population,
    phoneCode,
    timeZones,
    carDrivingSide,
    border,
    googleMap,
    continents,
    flagPng,
  ];

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? currenciesData = json["currencies"];
    String currencyCode = 'Unknown';
    String currencyName = 'Unknown';
    String currencySymbol = 'Unknown';

    if (currenciesData != null && currenciesData.isNotEmpty) {
      MapEntry<String, dynamic> currencyEntry = currenciesData.entries.first;
      currencyCode = currencyEntry.key;
      Map<String, dynamic> currencyInfo = currencyEntry.value;
      currencyName = currencyInfo["name"] ?? 'Unknown';
      currencySymbol = currencyInfo["symbol"] ?? 'Unknown';
    }

    Map<String, dynamic>? languagesData = json["languages"];
    List<String> languageNames = [];

    if (languagesData != null && languagesData.isNotEmpty) {
      languagesData.forEach((key, value) => languageNames.add(value));
    }

    Uri mapUri = Uri.parse(json["maps"]["googleMaps"]);

    return CountryModel(
      nameCommon: json["name"]["common"] ?? 'Unknown',
      nameOfficial: json["name"]["official"] ?? 'Unknown',
      capital: List<String>.from(
          json["capital"]?.map((cap) => cap) ?? ['No Capital'])
          .toString()
          .replaceAll(']', '')
          .replaceAll('[', ''),
      capitalLocation: List.from(
          json["capitalInfo"]["latlng"]?.map((latlng) => latlng) ?? ['No Capital'])
          .toList(),
      region: json["region"] ?? 'Unknown',
      subregion: json["subregion"] ?? 'No Subregion',
      currencyCode: currencyCode.toString(),
      currencyName: currencyName,
      currencySymbol: currencySymbol,
      languages: languageNames.map((lan) => lan)
          .toString()
          .replaceAll(')', '')
          .replaceAll('(', ''),
      area: json["area"]?.toDouble() ?? 0.0,
      topLevelDomain: List<String>.from(
          json["tld"]?.map((tld) => tld) ?? ['No Top Level Domains'])
          .toString()
          .replaceAll(']', '')
          .replaceAll('[', ''),
      population: json["population"] ?? 0,
      phoneCode: '${json["idd"]["root"] ?? 'No phone code'}${List<String>.from(
          json["idd"]["suffixes"]?.map((suf) => suf) ?? ['No phone code'])
          .toString()
          .replaceAll(']', '')
          .replaceAll('[', '')}',
      timeZones: List<String>.from(
          json["timezones"]?.map((tz) => tz) ?? ['Time Zone Unavailable'])
          .toString()
          .replaceAll(']', '')
          .replaceAll('[', ''),
      carDrivingSide: json["car"]["side"] ?? 'Unknown',
      border: List<String>.from(
          json["borders"]?.map((bor) => bor) ?? ['No Borders'])
          .toString()
          .replaceAll(']', '')
          .replaceAll('[', ''),
      googleMap: mapUri,
      continents: json["continents"]?.isNotEmpty == true ? json["continents"][0]
          .toString() : 'Unknown',
      flagPng: json["flags"]["png"] ?? 'Unknown',
    );
  }
}
