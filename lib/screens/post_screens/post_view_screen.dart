import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/models/bokdaeriPost.dart';
import 'package:client/models/user_model.dart';
import 'package:client/utils/networkHelper.dart';
import 'package:client/utils/dialogHelper.dart';
import 'package:client/utils/stringHelper.dart';
import 'package:client/models/user.dart';
import 'package:client/constants/constant.dart';

class PostViewScreen extends StatefulWidget {
  PostViewScreen({required this.bokdaeriPost, required this.myPost});
  final BokdaeriPost bokdaeriPost;
  bool myPost = false;
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  BokdaeriPost? bokdaeriPost;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bokdaeriPost = widget.bokdaeriPost;
    print('복대리 id : ${bokdaeriPost!.id}, 복대리상태 : ${bokdaeriPost!.state} ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('복대리'),
      ),
      body: getPostBody(),
      persistentFooterButtons: getPostPersistentFooterButtons(context),
    );
  }

  List<Widget> getPostPersistentFooterButtons(BuildContext context) {
    if (widget.myPost) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: ButtonStyle(),
                onPressed: () async {
                  print('신청 버튼 클릭 ${bokdaeriPost!.id}');
                  NetworkHelper nw = NetworkHelper();
                  int bokID = bokdaeriPost!.id;
                  String jwt =
                  Provider.of<UserModel>(context, listen: false).userJwt!;
                  List<User> res = await nw.getPostApplyUsers(jwt, bokID);
                  print(res);

                },
                child: Text('Check Applier')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
          ],
        )
      ];
    }

    void applyPost() async {
      print('신청 버튼 클릭 ${bokdaeriPost!.id}');
      NetworkHelper nw = NetworkHelper();
      int bokID = bokdaeriPost!.id;
      String jwt =
      Provider.of<UserModel>(context, listen: false).userJwt!;
      bool res = await nw.applyPost(jwt, bokID);
      if (res == false) {
        DialogHelper().ShowErrorDialog(context, 'error', '신청 에러!');
      } else {
        Navigator.pop(context);
      }
    }

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: (bokdaeriPost!.state == PostState.todo)  ? applyPost : null,
              style: ButtonStyle(),
              child: (bokdaeriPost!.state == PostState.todo)  ? Text('Apply') : Text('진행중')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')),
        ],
      )
    ];
  }

  Column getPostBody() {
    BokdaeriPost bokdaeriPost = widget.bokdaeriPost;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(bokdaeriPost.court),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(bokdaeriPost.time.toString()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              StringHelper().getProgressTypeText(bokdaeriPost.progressType),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('사건번호'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(bokdaeriPost.caseNum),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('사건 내용'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(bokdaeriPost.caseDetail),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('쟁점'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(bokdaeriPost.caseArgument),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                    StringHelper().getPartyTypeText(bokdaeriPost.myPartyType)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(bokdaeriPost.myName),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(StringHelper()
                    .getPartyTypeText(bokdaeriPost.otherPartyType)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(bokdaeriPost.opponentName),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('희망 가격'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(bokdaeriPost.cost.toString()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
