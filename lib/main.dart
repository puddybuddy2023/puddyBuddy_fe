import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_stage1.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_stage3.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_start.dart';
import 'package:mungshinsa/size_measure_page/measure_start.dart';
import 'package:mungshinsa/store_page/review_detail.dart';
import 'package:mungshinsa/user_info.dart';
import 'package:mungshinsa/user_page.dart';
import 'package:provider/provider.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import 'login_page/splash_screen.dart';
import 'login_page/log_in.dart';
import 'login_page/nickname.dart';
import 'board_page/boards.dart';
import 'package:mungshinsa/board_page/board_detail.dart';
import 'size_measure_page/measure_result.dart';
import 'store_page/clothes.dart';
import 'store_page/clothes_detail.dart';
import 'my_page/my_page.dart';
import 'my_page/create_prefer.dart';
import 'settings.dart';
import 'board_page/create_board.dart';

import 'package:mungshinsa/providers/board_provider.dart';
import 'providers/comments_provider.dart';
import 'providers/clothes_provider.dart';
import 'package:mungshinsa/providers/prefer_api.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'f636a4a6298ad948a6fb3dd100d602ce');
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoardProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
        ChangeNotifierProvider(create: (_) => ClothesProvider()),
        ChangeNotifierProvider(create: (_) => PreferProvider()),
      ],
      child: MaterialApp(
        title: 'PuddyBuddy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blue,
            primarySwatch: Colors.indigo,
            fontFamily: 'NanumBarunGothic'),
        home: IndexScreen(),
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LogIn(),
          '/nickname': (context) => Nickname(),
          '/index': (context) => IndexScreen(),
          '/board_detail': (context) => const BoardDetail(),
          '/clothesDetail': (context) => const ClothesDetail(),
          '/reviewDetail': (context) => const ReviewDetail(),
          '/myPage': (context) => const MyPage(),
          '/userPage': (context) => const UserPage(),
          '/createPrefer': (context) => const CreatePrefer(),
          '/petsnalColorStart': (context) => const PetsnalColorStartPage(),
          '/measureStart': (context) => const SizeMeasureStart(),
          '/settings': (context) => const Settings(),
          '/temp': (context) => const Stage3Q1(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}

class IndexScreen extends StatefulWidget {
  IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const FeedView(),
    const Store(),
    const MyPage()
  ];

  void changePage(int index) {
    // 하단바의 아이템을 클릭할 때 실행되는 함수
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    userInfo.getUserId();
    userInfo.getUserNickname();
    return Scaffold(
      extendBody: true, // extendBody를 true로 해야 하단바 뒤로도 내용이 보임
      body: _widgetOptions[_currentIndex],
      bottomNavigationBar: Row(
        children: [
          Flexible(
            child: DotNavigationBar(
              marginR: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              paddingR: const EdgeInsets.only(bottom: 5, top: 5),
              itemPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              boxShadow: [
                // 하단바 그림자
                BoxShadow(
                  color: Colors.black12.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                )
              ],
              dotIndicatorColor: Colors.transparent,
              // 선택된 아이템을 가리키는 점이 보이지 않길 원하면 투명 상태로 설정해야 함
              selectedItemColor: const Color(0xFFA8ABFF),
              // 선택된 상태의 아이템 색상
              unselectedItemColor: Colors.black,
              // 선택되지 않은 상태의 아이템 색상
              currentIndex: _currentIndex,
              onTap: changePage,
              // 아이템을 선택하면 실행되는 함수
              enablePaddingAnimation: false,
              // 아이템 선택할 때 실행되는 애니메이션 비활성화
              items: [
                DotNavigationBarItem(
                  // 하단바에 들어갈 아이템들
                  icon: const Icon(
                    Icons.window,
                    size: 35,
                  ),
                ),
                DotNavigationBarItem(
                  icon: const Icon(
                    Icons.shopping_bag_rounded,
                    size: 35,
                  ),
                ),
                DotNavigationBarItem(
                  icon: const Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: FloatingActionButton(
              // BottomNavigationBar 옆에 추가한 Button
              backgroundColor: const Color(0xFFA8ABFF),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const WriteNewBoard()));
              },
              child: Container(
                padding: EdgeInsets.all(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/footprint.png',
                      width: 40,
                      height: 40,
                      //fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
