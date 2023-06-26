import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/dimen_constant.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.onSearch,
  });

  final void Function(String)? onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
      child: TextField(
        decoration: const InputDecoration(
          icon: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            size: 24,
          ),
          border: InputBorder.none,
          hintText: "Enter task's title to search...",
        ),
        maxLines: 1,
        onChanged: onSearch,
      ),
    );
  }
}
