import 'package:client/constants/constant.dart';
import 'package:client/models/bokdaeriPost.dart';
import 'package:client/screens/user_info_screen.dart';
import 'package:client/utils/networkHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/models/user_model.dart';
import 'package:client/utils/dialogHelper.dart';

class PostViewScreen extends StatefulWidget {
  PostViewScreen({required this.bokdaeriPost, required this.onlyViewMode});
  final BokdaeriPost bokdaeriPost;
  bool onlyViewMode = false;
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
  }

  String getProgressTypeText(ProgressType type) {
    if (type == ProgressType.continuation) {
      return '속행';
    } else if (type == ProgressType.closure) {
      return '종결';
    } else if (type == ProgressType.advanceHearing) {
      return '사전청취';
    }
    return '';
  }

  String getPartyTypeText(PartyType type) {
    if (type == PartyType.plaintiff) {
      return '원고';
    } else if (type == PartyType.respondent) {
      return '피고';
    }

    return '';
  }

  List<Widget> getButton() {
    if (widget.onlyViewMode) {
      return [];
    }

    List<TextButton> list = [];
    list.add(
      TextButton(
        onPressed: () async {
          print('신청 버튼 클릭 ${bokdaeriPost!.id}');
          NetworkHelper nw = NetworkHelper();
          int bokID = bokdaeriPost!.id;
          String jwt = Provider.of<UserModel>(context, listen: false).userJwt!;
          bool res = await nw.applyPost(jwt, bokID);
          if (res == false) {
            DialogHelper().ShowErrorDialog(context, 'error', '신청 에러!');
          } else {
            Navigator.pop(context);
          }
        },
        child: Text('신청'),
      ),
    );

    list.add(
      TextButton(
        onPressed: () {
          print('취소');
        },
        child: Text('취소'),
      ),
    );

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('복대리'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(bokdaeriPost!.court),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(bokdaeriPost!.time.toString()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(getProgressTypeText(bokdaeriPost!.progressType)),
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
                  child: Text(bokdaeriPost!.caseNum),
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
                  child: Text(bokdaeriPost!.caseDetail),
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
                  child: Text(bokdaeriPost!.caseArgument),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(getPartyTypeText(bokdaeriPost!.myPartyType)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(bokdaeriPost!.myName),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(getPartyTypeText(bokdaeriPost!.otherPartyType)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(bokdaeriPost!.opponentName),
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
                  child: Text(bokdaeriPost!.cost.toString()),
                ),
              ),
            ],
          ),
          Row(
            children: getButton(),
          ),
        ],
      ),
    );
  }
}
