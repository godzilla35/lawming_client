import 'package:flutter/material.dart';

class MyUploadingPostsScreen extends StatefulWidget {
  const MyUploadingPostsScreen({Key? key}) : super(key: key);

  @override
  _MyUploadingPostsScreenState createState() => _MyUploadingPostsScreenState();
}

class _MyUploadingPostsScreenState extends State<MyUploadingPostsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('내가 올린 복대리 내역'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: '진행중',
              ),
              Tab(
                text: '완료',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
