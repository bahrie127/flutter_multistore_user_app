import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic7_app/pages/auth/auth_page.dart';
import 'package:flutter_fic7_app/pages/home/home_page.dart';

import '../../bloc/logout/logout_bloc.dart';
import '../../utils/images.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _HomePageState();
}

class _HomePageState extends State<DashboardPage> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;

  String token = '';

  @override
  void initState() {
    super.initState();

    AuthLocalDatasource().getToken().then((value) {
      setState(() {
        token = value;
      });
    });

    _screens = [
      HomePage(),
      const Center(
        child: Text('Order'),
      ),
      Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (message) {
                AuthLocalDatasource().removeAuthData();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const AuthPage();
                }), (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Logout Successfully'),
                  backgroundColor: Colors.blue,
                ));
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ));
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text('Logout'),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(token)),
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        items: _getBottomWidget(singleVendor),
        onTap: (int index) {
          _setPage(index);
        },
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _screens.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _screens[index];
        },
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: index == _pageIndex
            ? Theme.of(context).primaryColor
            : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
        height: 25,
        width: 25,
      ),
      label: label,
    );
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> list = [];
    list.add(_barItem(Images.homeImage, 'Home', 0));
    list.add(_barItem(Images.shoppingImage, 'Orders', 1));
    list.add(_barItem(Images.moreImage, 'More', 2));
    return list;
  }
}
