/// @author SarahElzayat
/// @date 25/10/2022
/// general search field to be included in home, subreddits, profiles... etc

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../components/helpers/color_manager.dart';

class SearchFiled extends StatefulWidget {
  final String? labelText;
  final bool isSubreddit;
  final bool isProfile;
  final void Function()? onChanged;
  final void Function()? onPressed;
  final void Function(String)? onSubmitted;
  final TextEditingController textEditingController;

  const SearchFiled(
      {super.key,
      this.labelText,
      this.isSubreddit = false,
      this.isProfile = false,
      this.onChanged,
      this.onPressed,
      required this.textEditingController,
      this.onSubmitted});

  @override
  State<SearchFiled> createState() => _SearchFiledState();
}

class _SearchFiledState extends State<SearchFiled> {
  bool isPrefix = true;

  bool isOpne = false;
  final FocusNode _focus = FocusNode();

  List<String> items = [
    'Post 1',
    'Post 2',
    'Post 3',
    'Post 4',
    'Post 5',
    'Post 6'
  ];

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint('Focus: ${_focus.hasFocus.toString()}');
  }

  Widget _showTrending(List<String> items) {
    return ListView.builder(
      itemBuilder: (context, index) => Text(items[index]),
      itemCount: items.length,
      itemExtent: 30,
    );
  }   

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 5,
      decoration: ShapeDecoration(
        shape: CacheHelper.getData(key: 'isAndroid')!
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            : const StadiumBorder(),
        color: ColorManager.darkGrey,
      ),
      child: TextField(
        focusNode: _focus,
        onSubmitted: widget.onSubmitted,
        cursorColor: ColorManager.grey,
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
          border: InputBorder.none,

          hintStyle: const TextStyle(
            fontSize: 18,
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
          focusedBorder: CacheHelper.getData(key: 'isWindows')!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: ColorManager.blue))
              : null,

          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: ColorManager.darkGrey)),
          // border: InputBorder.none,
        ),
      ),
    );
  }
}
