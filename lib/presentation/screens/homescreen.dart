import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldbook/data/functions.dart';
import 'package:worldbook/logic/bloc/country_bloc.dart';
import 'package:worldbook/model/country_model.dart';
import 'package:worldbook/presentation/widgets/group_list_widget.dart';
import 'package:worldbook/presentation/widgets/sorting_grouping_drawer.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CountryInitialState) {
            return Center(
              child: SizedBox(
                width: 200.0,
                height: 100.0,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CountryBloc>(context).add(LoadCountryEvent());
                  },
                  child: const Text(
                      'Get the Countries',
                      style: TextStyle(
                          fontSize: 18
                      )
                  ),
                ),
              ),
            );
          }

          if (state is CountryLoadedState) {
            List<MapEntry<String, List<CountryModel>>> sortedGroupedList = (
                generateCountryMap(
                    state.groupingStatus,
                    state.countryList
                )..forEach(
                    (key, value) {
                  value.sort(
                          (country1, country2) => generateSorting(
                      state.sortingStatus, country1, country2));
                },
              )
            ).entries.toList();

            return Scaffold(
              drawer: const SortGroupWidget(),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    expandedHeight: 125,
                    pinned: true,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('World Book'),
                      centerTitle: true,
                    ),
                  ),
                  MultiSliver(
                    children: buildCountryGroups(groupedList: sortedGroupedList),
                  )
                ],
              ),
            );
          }
          return const Center();
        },
      ),
    );
  }
}

List<Widget> buildCountryGroups(
    {required List<MapEntry<String, List<CountryModel>>>
    groupedList}) =>
    groupedList
        .map((e) => GroupListWidget(groupTitle: e.key, countryList: e.value))
        .toList();



