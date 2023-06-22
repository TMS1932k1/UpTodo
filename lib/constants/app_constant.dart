import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/presentation/screens/home/index_page.dart';

const logoImage = 'assets/images/logo.png';
const onboadingOneImage = 'assets/images/onboading_one.png';
const onboadingTwoImage = 'assets/images/onboading_two.png';
const onboadingThreeImage = 'assets/images/onboading_three.png';
const calendarImage = 'assets/images/calendar.png';
const calendarBoldImage = 'assets/images/calendar_bold.png';
const clockImage = 'assets/images/clock.png';
const clockBoldImage = 'assets/images/clock_bold.png';
const homeImage = 'assets/images/home.png';
const homeBoldImage = 'assets/images/home_bold.png';
const userImage = 'assets/images/user.png';

const List<Map<String, dynamic>> homePages = [
  {
    'name': 'Index',
    'page': IndexPage(),
    'icon': homeImage,
    'active': homeBoldImage,
  },
  {
    'name': 'Calendar',
    'page': Scaffold(),
    'icon': calendarImage,
    'active': calendarBoldImage,
  },
  {
    'name': 'Focuse',
    'page': Scaffold(),
    'icon': clockImage,
    'active': clockBoldImage,
  },
  {
    'name': 'Profile',
    'page': Scaffold(),
    'icon': userImage,
    'active': userImage,
  },
];
