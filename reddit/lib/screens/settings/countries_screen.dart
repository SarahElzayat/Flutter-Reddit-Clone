/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This screen contains the regions from which the user should come from.

import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/settings_cubit/settings_cubit.dart';
import '../../widgets/settings/settings_app_bar.dart';
import '../../data/settings/countries.dart';

class CountriesScreen extends StatelessWidget {
  static const routeName = '/countries_screen';
  const CountriesScreen({super.key});
  final myList = countries;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(title: 'Select country/region'),
      body: ListView(
        children: myList.map((country) {
          return InkWell(
            onTap: () {
              SettingsCubit.get(context).changeCountry(country, context);
              Navigator.of(context).pop();
            },
            child: SizedBox(
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
                            fontSize: 18, color: ColorManager.eggshellWhite),
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
