// This screen is used to set and unset filters on the meals to filter them according to certain preferences

import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key, required this.setFilters, required this.filterData}) : super(key: key);
  static const routeName = "/filters-screen";
  final Function setFilters; //Receives a function to store the status of the filters so that it can be reflected throughout the app
  final Map<String, bool> filterData; //receives the current status of the filter data to load the filters accordingly as set or unset

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text(
        "Filters",
      ),
      actions: [
        IconButton(
          onPressed: () {
            widget.setFilters(widget.filterData); // this will set the filters and filter all the available meals according to the status of the filters
            Navigator.pop(context, widget.filterData); //Once user saves this filter data, this filters screen is popped from the navigator
          },
          icon: const Icon(Icons.save),
        )
      ],
    );

    return Scaffold(
        drawer: MainDrawer(
          appBarHeight: appBar.preferredSize.height,
        ),
        appBar: appBar,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Filter your selections",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildFilterTile(initialValue: widget.filterData['gluten'], changeValue: (value) => widget.filterData['gluten'] = value, titleText: 'Gluten Free'),
                  buildFilterTile(initialValue: widget.filterData['lactose'], changeValue: (value) => widget.filterData['lactose'] = value, titleText: 'Lactose Free'),
                  buildFilterTile(initialValue: widget.filterData['vegan'], changeValue: (value) => widget.filterData['vegan'] = value, titleText: 'Vegan'),
                  buildFilterTile(
                      initialValue: widget.filterData['vegetarian'], changeValue: (value) => widget.filterData['vegetarian'] = value, titleText: 'Vegetarian'),
                ],
                //gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
              ),
            )
          ],
        ));
  }

//Filter tile builder. Takes a function which can be used to control a particular boolean which is what controls a filter's status
  Card buildFilterTile({required bool? initialValue, required Function changeValue, required String titleText}) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: SwitchListTile(
          title: Text(
            titleText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onChanged: (bool value) {
            setState(() {
              changeValue(value);
            });
          },
          value: initialValue as bool,
        ),
      ),
    );
  }
}
