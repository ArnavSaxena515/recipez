//This is a drawer for the scaffolds to offer easy navigation for a user to go to the main categories screen and the filters screen

import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
    required this.appBarHeight,
  }) : super(key: key);
  final double appBarHeight; //for layout purposes

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: (mediaQueryData.size.height - appBarHeight - mediaQueryData.viewInsets.top) * 0.1,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    15,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                "What's cooking?",
                style: TextStyle(fontFamily: 'Raleway', fontSize: 30, color: Colors.pink, fontWeight: FontWeight.w900),
                // style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.pink, fontSize: 30),
              ),
            ),
            buildListTile(
                iconData: Icons.restaurant,
                title: "Meals",
                onTapAction: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.pushReplacementNamed(context, TabsScreen.routeName); //Push the tabsScreen as a replacement for the current screen in the navigator stack
                  } else {
                    Navigator.pushNamed(context, TabsScreen.routeName);
                  }
                }),
            buildListTile(
                iconData: Icons.filter_alt,
                title: "Filters",
                onTapAction: () {
                  return Navigator.pushNamed(context, FiltersScreen.routeName).then((value) {
                    Navigator.pushReplacementNamed(
                        context, TabsScreen.routeName); //Push the filters screen as a replacement for the current screen in the navigator stack
                  });
                }),
          ],
        ),
      ),
    );
  }

//Method to build options for app drawer
  ListTile buildListTile({required IconData iconData, required String title, required Function onTapAction}) {
    return ListTile(
      onTap: onTapAction as VoidCallback,
      leading: Icon(iconData),
      title: Text(
        title,
        style: const TextStyle(fontFamily: "RobotoCondensed", fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
