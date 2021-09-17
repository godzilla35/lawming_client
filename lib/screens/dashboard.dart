import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/utils/networkHelper.dart';
import 'package:client/models/bokdaeriPost.dart';
import 'package:client/models/content.dart';
import 'package:client/models/user_model.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  List<Content> _contentList = [];

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
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
        () => 'Data Loaded',
  );


  Future<List<Content>> getContents(String userJWT) async {

    List<BokdaeriPost> bokList = await getBokPosts(userJWT);
    List<Content> contentList = [];
    for (int i = 0; i < bokList.length; i++) {
      contentList.add(Content(title: '복대리', bokPost: bokList[i]));
      print(bokList[i]);
    }
    _contentList = contentList;
    return contentList;

  }

  @override
  Widget build(BuildContext context) {
    String jwt = Provider.of<UserModel>(context, listen: false).userJwt!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder(
          future: getContents(jwt),
          builder: (BuildContext context, AsyncSnapshot<List<Content>> snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            }else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
            }else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: _contentList,
                )
              );
            }
          },
        ),
      ],
    );
  }


}
