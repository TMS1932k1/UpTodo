import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/data/models/category.dart';
import 'package:todo_app/presentation/screens/home/calender_page.dart';
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
const emptyListImage = 'assets/images/empty_list.png';

final List<Map<String, dynamic>> homePages = [
  {
    'name': 'Index',
    'page': const IndexPage(),
    'icon': homeImage,
    'active': homeBoldImage,
  },
  {
    'name': 'Calendar',
    'page': const CalendarPage(),
    'icon': calendarImage,
    'active': calendarBoldImage,
  },
  {
    'name': 'Focuse',
    'page': const Scaffold(),
    'icon': clockImage,
    'active': clockBoldImage,
  },
  {
    'name': 'Profile',
    'page': const Scaffold(),
    'icon': userImage,
    'active': userImage,
  },
];

final List<Category> categogies = [
  Category(
    id: 1,
    title: 'Work',
    icon: FontAwesomeIcons.briefcase,
    colorBg: const Color(0xffFF9680),
    colorIcon: const Color(0xffA31D00),
  ),
  Category(
    id: 2,
    title: 'Home',
    icon: FontAwesomeIcons.house,
    colorBg: const Color(0xffFFCC80),
    colorIcon: const Color(0xffA36200),
  ),
  Category(
    id: 3,
    title: 'Sport',
    icon: FontAwesomeIcons.baseball,
    colorBg: const Color(0xff80FFFF),
    colorIcon: const Color(0xff3B734B),
  ),
  Category(
    id: 4,
    title: 'Music',
    icon: FontAwesomeIcons.music,
    colorBg: const Color(0xffFC80FF),
    colorIcon: const Color(0xffA000A3),
  ),
  Category(
    id: 5,
    title: 'Movie',
    icon: FontAwesomeIcons.video,
    colorBg: const Color(0xff80D1FF),
    colorIcon: const Color(0xff0069A3),
  ),
  Category(
    id: 6,
    title: 'Education',
    icon: FontAwesomeIcons.school,
    colorBg: const Color(0xff809CFF),
    colorIcon: const Color(0xff0055A3),
  ),
  Category(
    id: 7,
    title: 'Cook',
    icon: FontAwesomeIcons.cookie,
    colorBg: const Color(0xffCCFF80),
    colorIcon: const Color(0xff21A300),
  ),
];
