import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';

import '../../components/button.dart';

class SubredditWeb extends StatefulWidget {
  const SubredditWeb({Key? key}) : super(key: key);

  @override
  State<SubredditWeb> createState() => _SubredditWebState();
}

class _SubredditWebState extends State<SubredditWeb> {
  bool titleFlag = true;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
              height: 100,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fill,
              )),
          Container(
            color: ColorManager.bottomSheetBackgound,
            width: mediaQuery.size.width,
            // height: 200,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.6,
                  // height: 68,
                  // margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: mediaQuery.size.width * 0.01),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/icon.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: mediaQuery.size.width * 0.45,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          // maxLines: titleFlag ? 1 : 2,
                                          // overflow: titleFlag
                                          //     ? TextOverflow.ellipsis
                                          //     : null,
                                          'Subreddit Name',
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 22 *
                                                  mediaQuery.textScaleFactor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Button(
                                    onPressed: () {},
                                    buttonHeight: 35,
                                    text: 'Join',
                                    textFontSize: 20)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              right: mediaQuery.size.width * 0.02,
                            ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    ('Subreddit'),
                                    style: TextStyle(
                                        fontSize:
                                            17 * mediaQuery.textScaleFactor),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          ////////////////////////////////////////
          SizedBox(
            width: mediaQuery.size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (mediaQuery.size.width > 1000)
                  SizedBox(
                    width: mediaQuery.size.width * 0.2,
                  ),
                Container(
                  width: (mediaQuery.size.width > 1000)
                      ? mediaQuery.size.width * 0.4
                      : mediaQuery.size.width * 0.95,
                  margin: (mediaQuery.size.width <= 1000)
                      ? EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width * 0.02)
                      : null,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    itemBuilder: (context, index) => Container(
                      height: 300,
                      color: Color.fromARGB(
                          255, index * 10, index * 15, index * 13),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Text(
                        'Post $index',
                      ),
                    ),
                  ),
                ),
                // if (mediaQuery.size.width <= 1000)
                //   SizedBox(
                //     width: mediaQuery.size.width * 0.2,
                //   ),
                if (mediaQuery.size.width > 1000)
                  Container(
                    color: ColorManager.bottomSheetBackgound,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    width: mediaQuery.size.width * 0.2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'About Community',
                              style:
                                  TextStyle(color: ColorManager.eggshellWhite),
                            ),
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    child: Text('Add To Favorites')),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Welcome! This is a friendly place for those cringe-worthy and (maybe) funny attempts at humour that we call dad jokes. Often (but not always) a verbal or visual pun, if it elicited a snort or face palm then our community is ready to groan along with you. To be clear, dad status is not a requirement. We\'re all different and excellent. Some people are born with lame jokes in their heart and so here, everyone is a dad. Some dads are wholesome, some are not. It\'s about how the joke is delivered.',
                          style: TextStyle(
                              color: ColorManager.eggshellWhite, height: 1.5),
                        )
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
