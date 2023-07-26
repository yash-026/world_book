import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/country_model.dart';

class Countries {
  List<CountryModel> countryList = [];

  Future<List<CountryModel>> getCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body) as List;

      for (var element in jsonList) {
        countryList.add(CountryModel.fromJson(element));
      }
      return countryList;
    } else {
      throw Exception('Failed to load countries.');
    }
  }
  }