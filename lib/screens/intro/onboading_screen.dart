import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_constant.dart';
import 'package:todo_app/screens/intro/start_screen.dart';
import 'package:todo_app/widgets/intro/onboading_item.dart';

class OnboadingScreen extends StatefulWidget {
  const OnboadingScreen({super.key});

  @override
  State<OnboadingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends State<OnboadingScreen> {
  final pages = [
    const OnboadingItem(
      image: onboadingOneImage,
      title: 'Manage your tasks',
      subtitle:
          'You can easily manage all of your daily tasks in DoMe for free',
    ),
    const OnboadingItem(
      image: onboadingTwoImage,
      title: 'Create daily routine',
      subtitle:
          'In Uptodo  you can create your personalized routine to stay productive',
    ),
    const OnboadingItem(
      image: onboadingThreeImage,
      title: 'Orgonaize your tasks',
      subtitle:
          'You can organize your daily tasks by adding your tasks into separate categories',
    )
  ];

  late final PageController controller;
  bool isEnd = false;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Navigate to [StartScreen]
  void navigateToStartScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const StartScreen(),
      ),
    );
  }

  /// Onclick next page
  /// Will next where [controller.page] < [pages.length] - 1
  void nextOnboading() async {
    if (controller.page!.toInt() < pages.length - 1) {
      await controller
          .animateToPage(
            controller.page!.toInt() + 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          )
          .then(
            (value) => setState(() {
              isEnd = (pages.length - 1 == controller.page);
            }),
          );
    }
  }

  /// Onclick next page
  /// Will do where [controller.page] > 0
  void backOnboading() async {
    if (controller.page!.toInt() > 0) {
      await controller
          .animateToPage(
            controller.page!.toInt() - 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          )
          .then(
            (value) => setState(() {
              isEnd = (pages.length - 1 == controller.page);
            }),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: navigateToStartScreen,
              child: Text(
                'SKIP',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.grey),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (value) => setState(() {
                  isEnd = (pages.length - 1 == value);
                }),
                itemBuilder: (context, index) => pages[index],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24, right: 24, bottom: 62),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: backOnboading,
                    child: Text(
                      'BACK',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: !isEnd ? nextOnboading : navigateToStartScreen,
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Text(
                      !isEnd ? 'NEXT' : 'GET STARTED',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
