import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({super.key});

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {

  int _currentIndex = 0;

  void changePage(int index) {
    // 하단바의 아이템을 클릭할 때 실행되는 함수
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      marginR: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      paddingR: EdgeInsets.only(bottom: 5, top: 10),
      itemPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      boxShadow: [
        // 하단바 그림자
        BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)
      ],
      dotIndicatorColor: Colors.transparent,
      // 선택된 아이템을 가리키는 점이 보이지 않길 원하면 투명 상태로 설정해야 함
      selectedItemColor: Color(0xFFA8ABFF),
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
          icon: Icon(
            Icons.home,
            size: 35,
          ),
        ),
        DotNavigationBarItem(
          icon: Icon(
            Icons.shopping_bag,
            size: 35,
          ),
        ),
        DotNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 35,
          ),
        ),
      ],
    );
  }
}
