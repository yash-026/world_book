import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:worldbook/model/country_model.dart';
import 'package:worldbook/presentation/screens/country_details_screen.dart';
import 'package:worldbook/presentation/widgets/group_background_widget.dart';
import 'package:worldbook/presentation/widgets/group_header_widget.dart';


class GroupListWidget extends StatelessWidget {
  const GroupListWidget({required this.groupTitle, required this.countryList, Key? key})
      : super(key: key);

  final String groupTitle;
  final List<CountryModel> countryList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(12.0).copyWith(top: 0),
      sliver: MultiSliver(
        pushPinnedChildren: true,
        children: [
          SliverStack(
            insetOnOverlap: true,
            children: [
              const SliverPositioned.fill(
                top: GroupHeaderWidget.padding,
                child: GroupBackgroundWidget(),
              ),
              MultiSliver(
                children: [
                  SliverPinnedHeader(child: GroupHeaderWidget(title: groupTitle)),
                  SliverClip(
                    child: buildList(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 50,
                          child: Image.network(countryList[index].flagPng),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: SizedBox(
                        height: 20,
                        child: Text(
                          countryList[index].nameCommon,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CountryScreen(
                        countryModel: countryList[index]
                    )
                )
            )
          );
        },
        childCount: countryList.length,
      ),
    );
  }
}

