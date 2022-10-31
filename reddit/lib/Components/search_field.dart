/// @author SarahElzayat
/// @date 25/10/2022
/// general search field to be included in home, subreddits, profiles... etc

import 'package:flutter/material.dart';
import '../Components/Helpers/color_manager.dart';

class SearchFiled extends StatefulWidget {
  final String? labelText;
  final bool isSubreddit;
  final bool isProfile;
  final void Function()? onChanged;
  final void Function()? onPressed;
  final TextEditingController textEditingController;

  const SearchFiled(
      {super.key,
      this.labelText, //= 'Search Reddit',
      this.isSubreddit = false,
      this.isProfile = false,
      this.onChanged,
      this.onPressed,
      required this.textEditingController});

  @override
  State<SearchFiled> createState() => _SearchFiledState();
}

class _SearchFiledState extends State<SearchFiled> {
  bool isPrefix = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        // borderRadius: BorderRadius.circular(5),
        shape: StadiumBorder(),

        color: ColorManager.darkGrey,
      ),
      child: TextField(
        onChanged: (value) => setState(() {
          (widget.textEditingController.text);
        }),

        controller: widget.textEditingController,
        style: const TextStyle(
          color: ColorManager.lightGrey,
        ),
        // textAlignVertical: TextAlignVertical.,
        decoration: InputDecoration(
          hintText: 'Search Reddit',
          hintStyle: const TextStyle(
              color: ColorManager.lightGrey,
              textBaseline: TextBaseline.alphabetic),

          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,

          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.search,
                  color: ColorManager.lightGrey,
                ),
                if (widget.isSubreddit || widget.isProfile && isPrefix)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: ColorManager.grey,
                    ),
                    // margin: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.labelText!} ',
                          style: const TextStyle(
                              color: ColorManager.eggshellWhite),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                isPrefix = false;
                              });
                            },
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: ColorManager.lightGrey,
                              // size: MediaQuery.,
                              // size: ,
                            ))
                      ],
                    ),
                  ),
              ],
            ),
          ),
          suffixIcon: widget.textEditingController.text.isNotEmpty
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      widget.textEditingController.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.cancel_sharp,
                    color: ColorManager.lightGrey,
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: ColorManager.blue)),

          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: ColorManager.darkGrey)),
          // border: InputBorder.none,
        ),
      ),
    );
  }
}
