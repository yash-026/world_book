import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worldbook/model/country_model.dart';

class CountryScreen extends StatelessWidget {
  CountryScreen({super.key, required this.countryModel});

  final CountryModel countryModel;

  final NumberFormat populationFormat =
  NumberFormat('###,###,###,###', 'en_US');
  final NumberFormat areaFormat = NumberFormat('###,###,###,###.#', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
            countryModel.nameCommon,
            style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.network(countryModel.flagPng),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                titleGenerator('Common Name'),
                const SizedBox(height: 8.0),
                Text(countryModel.nameCommon,
                    style: const TextStyle(fontSize: 14)),
                const Divider(thickness: 2),
                titleGenerator('Official Name'),
                const SizedBox(height: 8.0),
                Text(countryModel.nameOfficial,
                    style: const TextStyle(fontSize: 14)),
                const Divider(thickness: 2),
                rowGenerator(
                  header: 'Capital',
                  text: countryModel.capital,
                  flex: 7,
                ),
                rowGenerator(
                  header: 'Region',
                  text: countryModel.region,
                  flex: 7,
                ),
                rowGenerator(
                  header: 'Sub-region',
                  text: countryModel.subregion,
                  flex: 7,
                ),
                rowGenerator(
                  header: 'Area',
                  text:
                  '${areaFormat.format(countryModel.area)} km\u{00B2}',
                  flex: 1,
                ),
                rowGenerator(
                  header: 'Population',
                  text:
                  populationFormat.format(countryModel.population),
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );


  }
}

Row rowGenerator({
  required String header,
  required String text,
  required int flex,
}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      expandedWidgetGenerator(header, text, flex),
    ],
  );
}

Expanded expandedWidgetGenerator(
    String header, String text, int flex) =>
    Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleGenerator(header),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
          const Divider(
              thickness: 2.0,
              height: 16.0
          ),
        ],
      ),
    );

Text titleGenerator(String title) {
  return Text(
    title,
    style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
    ),
  );
}
