import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.index = 0,
    required this.icon,
    required this.selectedIcon,
    this.isSelected = false,
    this.animationController,
  });

  final IconData icon;
  final IconData selectedIcon;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      icon: Icons.dashboard_customize ,
      selectedIcon: Icons.dashboard_customize , 
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      icon: Icons.groups , 
      selectedIcon: Icons.groups, 
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      icon: Icons.subscriptions  , 
      selectedIcon: Icons.subscriptions  ,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      icon: Icons.receipt_long , 
      selectedIcon: Icons.receipt_long , 
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
