import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldbook/data/constants.dart';
import 'package:worldbook/logic/bloc/country_bloc.dart';
import 'package:worldbook/logic/cubit/sort_group_cubit.dart';

class SortGroupWidget extends StatelessWidget {
  const SortGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            child: SafeArea(
              child: Column(
                children: [
                  buildDropDownButton('sort', context),
                  buildDropDownButton('group', context),
                  ElevatedButton(
                    onPressed: () {
                      SortGroupState state = BlocProvider.of<SortGroupCubit>(context).state;
                      BlocProvider.of<CountryBloc>(context).add(
                        ChangeGroupAndSortEvent(
                          sortValue: state.sortValue,
                          groupValue: state.groupValue,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropDownButton(String type, BuildContext context) {
    return Column(
      children: [
        Text(
          type == 'sort' ? 'Sorted By' : 'Grouped By',
          style: const TextStyle(fontSize: 16),
        ),
        DropdownButton<String>(
          value: type == 'sort'
              ? BlocProvider.of<SortGroupCubit>(context).state.sortValue
              : BlocProvider.of<SortGroupCubit>(context).state.groupValue,
          items: type == 'sort' ? sortItems.map(buildMenuItem).toList() : groupItems.map(buildMenuItem).toList(),
          onChanged: (value) {
            if (type == 'sort') {
              BlocProvider.of<SortGroupCubit>(context).onChangeSortOption(value!);
            } else {
              BlocProvider.of<SortGroupCubit>(context).onChangeGroupOption(value!);
            }
          },
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    value: item,
    child: Text(item),
  );
}

