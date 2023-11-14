import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClothesDetail extends StatefulWidget {
  const ClothesDetail({super.key});

  @override
  State<ClothesDetail> createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {
  @override
  Widget build(BuildContext context) {
    final clothes = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,// 원하는 너비 설정
                      height: MediaQuery.of(context).size.width, // 원하는 높이 설정
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        clothes['name'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse(clothes['shoppingSiteUrl']);
                    //final url = Uri(scheme: 'https', host: clothes['shoppingSiteUrl']);
                    print(url);
                    if (await canLaunchUrl(url)){
                      launchUrl(Uri.parse(clothes['shoppingSiteUrl']));
                    }
                  },
                  child: Text('구매하기', style: TextStyle(fontSize: 16),),
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFFA8ABFF)),
                )),
          ],
        ),
      ),
    );
  }
}
