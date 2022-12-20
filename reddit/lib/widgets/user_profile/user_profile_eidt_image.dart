import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../components/helpers/color_manager.dart';

class UserProfileEditImage extends StatelessWidget {
  const UserProfileEditImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return SizedBox(
      width: mediaquery.size.width,
      height: 145,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            child: DottedBorder(
                dashPattern: const [10, 5],
                color: (true) ? ColorManager.white : ColorManager.black,
                child: SizedBox(
                  width: mediaquery.size.width,
                  height: 120,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/profile_banner.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                      const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              height: 60,
              width: 60,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(
                      'assets/images/Logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          onTap: (() {}),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            shadows: <Shadow>[
                              Shadow(color: Colors.black, blurRadius: 20.0),
                              Shadow(color: Colors.black, blurRadius: 20.0)
                            ],
                          )))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
