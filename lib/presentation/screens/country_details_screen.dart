// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(countryModel.flagPng),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  titleGenerator('Common Name'),
                  Text(countryModel.nameCommon,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8.0),
                  titleGenerator('Official Name'),
                  Text(countryModel.nameOfficial,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8.0),
                  const Divider(thickness: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8.0),
                      titleGenerator('Region'),
                      Text(
                        countryModel.region,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      titleGenerator('Sub-region'),
                      Text(
                        countryModel.subregion,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(
                          thickness: 2.0,
                          height: 16.0
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8.0),
                      titleGenerator('Capital'),
                      Text(
                        countryModel.capital,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      titleGenerator('Capital Location'),
                      Text(
                        countryModel.capitalLocation.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(
                          thickness: 2.0,
                          height: 16.0
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8.0),
                      titleGenerator('Currency Code'),
                      Text(
                        countryModel.currencyCode,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      titleGenerator('Currency Name'),
                      Text(
                        countryModel.currencyName,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      titleGenerator('Currency Symbol'),
                      Text(
                        countryModel.currencySymbol,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(
                          thickness: 2.0,
                          height: 16.0
                      ),
                    ],
                  ),
                  rowGenerator(
                    header: 'Languages',
                    text:
                    countryModel.languages,
                    flex: 1,
                  ),
                  rowGenerator(
                    header: 'Area',
                    text:
                    '${areaFormat.format(countryModel.area)} km\u{00B2}',
                    flex: 1,
                  ),
                  rowGenerator(
                    header: 'Top Level Domain',
                    text: countryModel.topLevelDomain,
                    flex: 7,
                  ),
                  rowGenerator(
                    header: 'Population',
                    text:
                    populationFormat.format(countryModel.population),
                    flex: 1,
                  ),
                  rowGenerator(
                    header: 'Country Phone Code',
                    text:
                    countryModel.phoneCode.toString(),
                    flex: 1,
                  ),
                  rowGenerator(
                    header: 'Time Zones',
                    text:
                    countryModel.timeZones.toString(),
                    flex: 1,
                  ),
                  rowGenerator(
                    header: 'Car Driving Side',
                    text:
                    countryModel.carDrivingSide,
                    flex: 1,
                  ),
                  rowGenerator(
                    header: 'Border Countries',
                    text: countryModel.border,
                    flex: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8.0),
                      titleGenerator('Google Map Link'),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: _launchURL,
                        child: const Text(
                          'Click to open Google Maps',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
  void _launchURL() async {
    String urlString = Uri.encodeFull(countryModel.googleMap.toString());
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'Could not launch $urlString';
    }
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
          const SizedBox(height: 8.0),
          titleGenerator(header),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8.0),
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
