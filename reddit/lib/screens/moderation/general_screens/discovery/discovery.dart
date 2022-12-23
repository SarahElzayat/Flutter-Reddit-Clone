import 'package:flutter/material.dart';
import '../../../../components/helpers/color_manager.dart';
import '../../../../components/moderation_components/modtools_components.dart';
import 'choose_language.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Discovery extends StatefulWidget {
  static const String routeName = 'discovery';
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  enabledButton() {}

  /// determines whether a change in variables has been made
  bool isChanged = false;

  /// indicates whethwe traffic switch is turned on or off
  bool trafficSwitch = false;

  /// indicates whethwe recommend switch is turned on or off
  bool recommendSwitch = false;

  ///@param [switcher] new value of switch
  /// toggles the recommend subreddit and sets it state
  toggleTraffic(switcher) {
    setState(() {
      trafficSwitch = switcher;
    });
  }

  ///@param [switcher] new value of switch
  /// toggles the recommend subreddit and sets it state
  toggleRecommend(switcher) {
    setState(() {
      recommendSwitch = switcher;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: moderationAppBar(context, 'Discovery', enabledButton, isChanged),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
                'Show your community to the general Reddit populationor just the people who have similar interests, by adjusting how people can find it. Not sure what\'s best for you? Learn More',
                style: TextStyle(color: ColorManager.lightGrey)),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            color: ColorManager.darkGrey,
            child: Column(
              children: [
                rowSwitch('Show up in high-traffic feeds', trafficSwitch,
                    toggleTraffic),
                const Text(
                    'Allow your community to be in r/all, e/popular, and trending lists where it can be seen by the general Reddit population',
                    style: TextStyle(color: ColorManager.lightGrey)),
                SizedBox(height: 4.h),
                rowSwitch('Get recommended to individual redditors',
                    recommendSwitch, toggleRecommend),
                const Text(
                    'Let Reddit recommend your community to people who have similar interests',
                    style: TextStyle(color: ColorManager.lightGrey))
              ],
            ),
          ),
          SizedBox(height: 5.h),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            tileColor: ColorManager.darkGrey,
            title: const Text('Choose primary language'),
            subtitle: const Text(
                'Make it easier for people who speak your community\'s primary language to find it.'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChooseLanguage())),
          ),
        ],
      ),
    );
  }
}
