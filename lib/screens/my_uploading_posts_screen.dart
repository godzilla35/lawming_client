import 'package:client/utils/networkHelper.dart';
import 'package:flutter/material.dart';
import 'package:client/models/content.dart';
import 'package:provider/provider.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/bokdaeriPost.dart';

class MyUploadingPostsScreen extends StatefulWidget {
  const MyUploadingPostsScreen({Key? key}) : super(key: key);

  @override
  _MyUploadingPostsScreenState createState() => _MyUploadingPostsScreenState();
}

class _MyUploadingPostsScreenState extends State<MyUploadingPostsScreen> {
  List<Content> _contentList = [];

  NetworkHelper nw = NetworkHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<BokdaeriPost>> getUploadedBokPosts(
      String userJWT, int userID) async {
    List<BokdaeriPost> list = List.empty();
    NetworkHelper nw = NetworkHelper();

    list = await nw.getUploadedBokPosts(userJWT, userID);
    return list;
  }

  Future<List<Content>> getUploadedContents(String userJWT, int userID) async {
    print('getUploadedContents($userID)');
    List<BokdaeriPost> bokList = await getUploadedBokPosts(userJWT, userID);
    print('${bokList.length}');
    List<Content> contentList = [];
    for (int i = 0; i < bokList.length; i++) {
      contentList.add(Content(title: '복대리', bokPost: bokList[i], onlyViewMode: true,));
      print(bokList[i]);
    }
    _contentList = contentList;
    return contentList;
  }

  @override
  Widget build(BuildContext context) {
    String jwt = Provider.of<UserModel>(context, listen: false).userJwt!;
    int userID = Provider.of<UserModel>(context, listen: false).userID;

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
          body: TabBarView(
            children: [
              FutureBuilder(
                future: getUploadedContents(jwt, userID),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Content>> snapshot) {
                  if (snapshot.hasData == false) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: _contentList,
                      ),
                    );
                  }
                },
              ),
              Icon(Icons.directions_bike),
            ],
          )),
    );
  }
}
