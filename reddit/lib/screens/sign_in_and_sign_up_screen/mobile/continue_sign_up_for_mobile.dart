import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/settings_cubit/settings_cubit.dart';
import 'package:reddit/screens/main_screen.dart';
import 'package:reddit/widgets/sign_in_and_sign_up_widgets/app_bar.dart';

class ContinueSignUpForMobile extends StatefulWidget {
  static const String routeName = '/continue-sign-up-for-mobile';
  const ContinueSignUpForMobile({super.key});

  @override
  State<ContinueSignUpForMobile> createState() =>
      _ContinueSignUpForMobileState();
}

class _ContinueSignUpForMobileState extends State<ContinueSignUpForMobile> {
  final List<String> _genderOption = ['Male', 'Female'];

  final List<String> _interestsOption = [
    'Funny 😂',
    'Jokes 🤣',
    'interesting 😎',
    'Memes 🫠',
    'Gaming 🎮',
    'Music 🎶',
    'Movies 🍿',
    'TV 📺',
    'Sports 🏈',
    'Food 😋',
    'Science 🧪',
    'Technology 📱',
    'Politics 🗳️',
    'Art 🎨',
    'Books 📚',
    'History 📜',
    'Animals 🐕‍🦺',
    'Travel 🛫',
    'Fashion 👗',
    'Beauty 💄',
    'Fitness 🏋️‍♀️',
    'Health 🩺',
    'Relationships 💑',
  ];

  Map<String, Color> colors = {};

  bool _genderSelected = false;

  late final userGender;

  Widget _buildGender(double fontFactor, context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('I\'m a ...',
                  style: TextStyle(fontSize: 20 * fontFactor))),
          ..._genderOption.map((gender) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    userGender = gender;
                    print(userGender);
                    _genderSelected = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(gender,
                    style: TextStyle(
                        fontSize: 20 * fontFactor, color: ColorManager.white)),
              ),
            );
          }).toList()
        ],
      ),
    );
  }

  int numOfInterests = 0;
  Widget _buildInterests(double fontFactor, context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// the interests
          Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 5,
              children: _interestsOption.map((interest) {
                colors[interest] == ColorManager.upvoteRed
                    ? colors[interest] = ColorManager.upvoteRed
                    : colors[interest] = ColorManager.grey;
                return Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (colors[interest] == ColorManager.upvoteRed) {
                        setState(() {
                          print(colors[interest]);
                          numOfInterests--;
                          colors[interest] = ColorManager.grey;
                          print(numOfInterests);
                        });
                      } else if (numOfInterests < 3) {
                        setState(() {
                          numOfInterests++;
                          colors[interest] = ColorManager.upvoteRed;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors[interest],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(interest),
                  ),
                );
              }).toList()),
          // continue button.
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: numOfInterests < 3
                    ? ColorManager.grey
                    : ColorManager.upvoteRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (numOfInterests == 3) {
                  _setGender();

                  /// continue
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreenForMobile.routeName);
                }
              },
              child: Text(
                'Continue $numOfInterests / 3',
                style: TextStyle(
                    color: numOfInterests > 2
                        ? ColorManager.white
                        : ColorManager.eggshellWhite,
                    fontSize: 18),
              ))
        ],
      ),
    );
  }

  /// this is a utilty function used to set the user gender during signup.
  void _setGender() {
    print('Setting the gender');
    SettingsCubit.get(context)
        .changeDropValue(userGender, 'changeGender', context);
  }

  @override
  Widget build(BuildContext context) {
    final fontFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: LogInAppBar(
        sideBarButtonText: 'Skip',
        sideBarButtonAction: () {
          if (_genderSelected) {
            _setGender();
          }
          Navigator.of(context)
              .pushReplacementNamed(HomeScreenForMobile.routeName);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 10),
            child: Text(
              'About You',
              style: TextStyle(
                  fontSize: 20 * fontFactor, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Tell us about yourself to start building your home feed',
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15 * fontFactor),
            ),
          ),
          _genderSelected == true
              ? _buildInterests(fontFactor, context)
              : _buildGender(fontFactor, context),
        ],
      ),
    );
  }
}
