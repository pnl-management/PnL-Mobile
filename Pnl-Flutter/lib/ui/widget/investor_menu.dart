import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loginui/bloc/login_bloc.dart';

import 'package:loginui/ui/investor.dart';
import 'package:loginui/ui/showallstore.dart';

import 'package:loginui/ui/user.dart';
import 'package:rxdart/rxdart.dart';

class InvestorMenuPage extends StatelessWidget {
  bool isCollapsed = true;
  final Widget screen;

  InvestorMenuPage({Key key, this.screen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          screen ?? UserHomeScreen(),
          InvestorSideBar(),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Stack(
  //     children: <Widget>[
  //       BlocProvider<NavigationBloc>(
  //         create: (context) => NavigationBloc(),
  //         child: Stack(children: <Widget>[
  //           BlocBuilder<NavigationBloc, NavigationStates>(
  //             builder: (context, navigationState) {
  //               return navigationState as Widget;
  //             },
  //           ),
  //         ]),
  //       ),
  //       ActorSideBar(),
  //     ],
  //   ));
  // }
}

class InvestorSideBar extends StatefulWidget {
  @override
  _InvestorSideBarState createState() => _InvestorSideBarState();
}

class _InvestorSideBarState extends State<InvestorSideBar>
    with SingleTickerProviderStateMixin<InvestorSideBar> {
  AnimationController animationController;

  final animationDuration = const Duration(milliseconds: 500);
  StreamController<bool> isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
    isSideBarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink = isSideBarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    // TODO: implement dispose
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 35,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFF3383CD), Color(0xFF11249F)]),
                  ),
                  child: Column(children: <Widget>[
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),
                    InvestorMenuItem(
                      icon: Icons.home,
                      title: "Trang Chủ",
                      onTap: () {
                        onIconPressed();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                InvestorMenuPage(screen: InvestorPage())));
                      },
                    ),
                    InvestorMenuItem(
                      icon: Icons.store,
                      title: "Danh sách cửa hàng",
                      onTap: () {
                        onIconPressed();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShowStores()));
                      },
                    ),
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),
                    
                    InvestorMenuItem(
                      icon: Icons.exit_to_app,
                      title: "Đăng Xuất",
                      onTap: () {
                        onIconPressed();
                        
                        var loginBloc = LoginBloc();
                        loginBloc.logoutBloc(context);
                      },
                    ),
                  ]),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 50,
                      //color: Color(0xFF3383CE),
                      alignment: Alignment.center,
                      child: AnimatedIcon(
                          progress: animationController.view,
                          icon: AnimatedIcons.list_view,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class InvestorMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const InvestorMenuItem({Key key, this.icon, this.title, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
