/// @author SarahElzayat
/// @date 25/10/2022
/// general search field to be included in home, subreddits, profiles... etc
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/search/search_screen.dart';
import 'helpers/color_manager.dart';

/// @param [subredditName] is case the field is used in a subreddit page, the subreddit name
///                         should be passed to the widget
/// @param [isSubreddit] a bool that indicates whether the field is used in a subreddit page or not
/// @param [onChanged] an optional funtion that triggers any desired action on the change of the input
/// @param [onChanged] an optional funtion that triggers any desired action on the change of the input
/// @param [onPressed] a function that's associated with the cancel button
/// @param [onSubmitted] the method that's applied when the text field is submitted
/// @param [textEditingController] the controller of the text field
/// @param [isResult] a bool that indicates whether the field is called in a search result page or not

class SearchField extends StatefulWidget {
  final String? subredditName;
  final bool isSubreddit;
  final void Function()? onChanged;
  final void Function()? onPressed;
  final void Function(String)? onSubmitted;
  final TextEditingController textEditingController;
  final bool isResult;

  const SearchField({
    super.key,
    this.subredditName,
    this.isSubreddit = false,
    this.onChanged,
    this.onPressed,
    required this.textEditingController,
    this.onSubmitted,
    this.isResult = false,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  /// @param[_focus] the focus node of the text field
  final FocusNode _focus = FocusNode();

  /// @param[isPrefix] checks if the search is inside a subreddit and the prefix is not deleted
  bool isPrefix = true;

  /// initial state of the widget, binds the focus nod to its listner
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    debugPrint('Focus: ${_focus.hasFocus.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: !kIsWeb
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            : const StadiumBorder(),
        color: (widget.isSubreddit)
            ? const Color.fromARGB(120, 0, 0, 0)
            : ColorManager.darkGrey,
      ),
      child: TextField(
        onTap: () {
          if (widget.isResult) {
            _focus.unfocus();
            if (!kIsWeb) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      subredditName: widget.subredditName,
                      isSubreddit: widget.isSubreddit,
                      query: widget.textEditingController.text,
                    ),
                  ));
            }
          }
        },
        focusNode: _focus,
        onSubmitted: widget.onSubmitted,
        cursorColor: ColorManager.eggshellWhite,
        onChanged: (value) => setState(() {
          (widget.textEditingController.text);
        }),
        controller: widget.textEditingController,
        style: const TextStyle(color: ColorManager.eggshellWhite, fontSize: 18),
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
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.search,
                  color: ColorManager.lightGrey,
                ),
                if (widget.isSubreddit && isPrefix)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                        color: ColorManager.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          '${widget.subredditName!} ',
                          style: const TextStyle(
                              fontSize: 16, color: ColorManager.eggshellWhite),
                        ),
                      ),
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
          focusedBorder: kIsWeb
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
