import 'package:fire_chat/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'custom_color.dart';

class AppBarTitleWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTitleWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.wetAsphalt,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'Fire',
                style: TextStyle(color: Colors.orangeAccent),
              ),
              Text(
                'chat',
                style: TextStyle(color: Colors.cyan[200]),
              )
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            icon: const Icon(MdiIcons.accountCircle),
            splashColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
