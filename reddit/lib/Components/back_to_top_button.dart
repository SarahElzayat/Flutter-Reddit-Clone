import 'package:flutter/material.dart';
import 'package:reddit/components/Helpers/color_manager.dart';

class BackToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  const BackToTopButton({super.key, required this.scrollController});

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool showbtn = false;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      //scroll listener
      double showoffset = MediaQuery.of(context).size.height /
          2; //Back to top botton will show on scroll offset 10.0

      if (widget.scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500), //show/hide animation
      opacity: showbtn ? 1.0 : 0.0, //set obacity to 1 on visible, or hide
      child: MaterialButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          widget.scrollController.animateTo(
              //go to top of scroll
              0, //scroll offset to go
              duration: const Duration(milliseconds: 500), //duration of scroll
              curve: Curves.fastOutSlowIn //scroll type
              );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const ShapeDecoration(
            color: ColorManager.darkBlue,
            // color: Colors.red,
            shape: StadiumBorder(),
          ),
          margin: EdgeInsets.only(right: width * 0.20),
          child: Text(
            'Back to Top',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
