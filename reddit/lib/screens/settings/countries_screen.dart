/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This screen contains the regions from which the user should come from.

import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/settings_cubit/settings_cubit.dart';
import '../../widgets/settings/settings_app_bar.dart';
import '../../data/settings/countries.dart';

class CountriesScreen extends StatefulWidget {
  static const routeName = '/countries_screen';
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final myList = countries;
  int myVal = 0;

  @override
  Widget build(BuildContext context) {
    Function handler = ModalRoute.of(context)?.settings.arguments as Function;

    return Scaffold(
      appBar: const SettingsAppBar(title: 'Select country/region'),
      body: ListView(
        children: myList.map((country) {
          return RadioListTile(
            toggleable: true,
            groupValue: country,
            value: myVal,
            onChanged: (value) {
              handler(country);
            },
            title: SizedBox(
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: ColorManager.black,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 2.0, left: 5, right: 10),
                      child: Text(
                        country,
                        style: const TextStyle(
                            fontSize: 16,
                            color: ColorManager.eggshellWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
