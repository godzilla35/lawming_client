import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/utils/networkHelper.dart';
import 'package:client/models/bokdaeriPost.dart';
import 'package:client/widgets/content.dart';
import 'package:client/models/user_model.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Content> _contentList = [];

  ListView getListViewBuilder(int currentUserId) {
    int listLength = _contentList.length;
    bool myBokPost = false;

    ListView res = ListView.builder(itemBuilder: (BuildContext context, int index) {
      if (_contentList[index].bokPost.UserId == currentUserId) {
        myBokPost = true;
      } else {
        myBokPost = false;
      }
      return Content(title: '복대리',
          bokPost: _contentList[index].bokPost,
          myUploadingPost: myBokPost ? true : false);
    });

    return res;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<BokdaeriPost>> getBokPosts(String userJWT) async {
    List<BokdaeriPost> list = List.empty();
    NetworkHelper nw = NetworkHelper();
    print('DashBoard::getBokPosts called!');

    list = await nw.getBokPosts(userJWT);

    return list;
  }

  Future<List<Content>> getContents(String userJWT, int currentUserId) async {
    print('userid = $currentUserId');
    List<BokdaeriPost> bokList = await getBokPosts(userJWT);
    print('${bokList.length}');
    List<Content> contentList = [];
    bool myBokPost = false;
    for (int i = 0; i < bokList.length; i++) {
      if (bokList[i].UserId == currentUserId) {
        print('bokList[$i].UserId = ${bokList[i].UserId}');
        myBokPost = true;
      } else {
        myBokPost = false;
      }

      contentList.add(Content(
          title: '복대리',
          bokPost: bokList[i],
          myUploadingPost: myBokPost == true ? true : false));
    }
    _contentList = contentList;

    return contentList;
  }

  @override
  Widget build(BuildContext context) {
    String jwt = Provider.of<UserModel>(context, listen: false).userJwt!;
    int currentUserId = Provider.of<UserModel>(context, listen: false).userID;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
            future: getContents(jwt, currentUserId),
            builder:
                (BuildContext context, AsyncSnapshot<List<Content>> snapshot) {
              if (snapshot.hasData == false) {
                return Container(
                  child: CircularProgressIndicator(),
                  width: 20,
                  height: 20,
                );
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
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
