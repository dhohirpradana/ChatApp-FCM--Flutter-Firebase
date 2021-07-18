import 'package:flutter/material.dart';
import 'custom_color.dart';

class AppBarTitleChatWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String url, nama, status;
  const AppBarTitleChatWidget({
    Key? key,
    required this.url,
    required this.nama,
    required this.status,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.wetAsphalt,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              url,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama),
                Text(status,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.white54)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
