import 'package:flutter/material.dart';
import 'package:rive_animation/screens/auth/service/auth_service.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: const Text('John Wiston'),
          accountEmail: const Text('john134@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRt5KENnAJ_Vfx8W3gzM_U79r3zNwppNXCknA&usqp=CAU'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.description),
          title: Text('Chính sách'),
          onTap: null,
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Đăng xuất'),
          onTap: () async {
            await AuthService.LogOut();
          },
        )
      ]),
    );
  }
}
