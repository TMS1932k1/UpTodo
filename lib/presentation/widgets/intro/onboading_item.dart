import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/intro/title_subtitle_text.dart';

class OnboadingItem extends StatelessWidget {
  const OnboadingItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 271,
            height: 296,
          ),
          const SizedBox(height: 42),
          TitleSubtitleText(
            title: title,
            subtitle: subtitle,
          ),
        ],
      ),
    );
  }
}
