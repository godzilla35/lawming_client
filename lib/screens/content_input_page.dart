import 'package:client/models/bokdaeriPost.dart';
import 'package:client/models/user_model.dart';
import 'package:client/utils/networkHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/constants/constant.dart';
import 'package:client/constants/court_info.dart';

class ContentInputPage extends StatefulWidget {
  const ContentInputPage({Key? key}) : super(key: key);

  @override
  _ContentInputPageState createState() => _ContentInputPageState();
}

class _ContentInputPageState extends State<ContentInputPage> {
  ProgressType _progressType = ProgressType.continuation;
  PartyType _myPartyType = PartyType.plaintiff;
  PartyType _otherPartyType = PartyType.plaintiff;

  final timeController = TextEditingController();
  // 진행 설정
  final caseNumController = TextEditingController();
  final caseDetailController = TextEditingController();
  final caseArgumentController = TextEditingController();
  // 당사자 타입
  final myNameController = TextEditingController();
  // 상대방 타입
  final opponentNameController = TextEditingController();
  final costController = TextEditingController();

  String locationDropdownValue = '서울';
  String courtDropdownValue = '대법원';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(title: Text('ContentInputPage')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text('지역 :'),
                  DropdownButton<String>(
                    value: locationDropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 16,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 1,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        locationDropdownValue = newValue!;
                        courtDropdownValue = CourtInfo()
                            .getCourtListByLocation(locationDropdownValue)[0];
                      });
                    },
                    items: CourtInfo()
                        .getLocationList()
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // 법원
              Row(
                children: [
                  Text('법원 :'),
                  DropdownButton<String>(
                    value: courtDropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 16,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 1,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        courtDropdownValue = newValue!;
                      });
                    },
                    items: CourtInfo()
                        .getCourtListByLocation(locationDropdownValue)
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // 날짜, 시간

              Column(
                children: [
                  Row(
                    children: [
                      Text('시간 :'),
                      Expanded(
                        child: TextField(controller: timeController),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: ()  {

                        },
                        child: Text(
                          'show date picker',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          'show time picker',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // 진행 설정
              Row(
                children: [
                  Text('진행 설정 :'),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        '속행',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: ProgressType.continuation,
                      groupValue: _progressType,
                      onChanged: (ProgressType? value) {
                        setState(() {
                          _progressType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        '종결',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: ProgressType.closure,
                      groupValue: _progressType,
                      onChanged: (ProgressType? value) {
                        setState(() {
                          _progressType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        '사전 청취',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: ProgressType.advanceHearing,
                      groupValue: _progressType,
                      onChanged: (ProgressType? value) {
                        setState(() {
                          _progressType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // 사건 번호
              Row(
                children: [
                  Text('사건번호 :'),
                  Expanded(
                    child: TextField(controller: caseNumController),
                  ),
                ],
              ),
              // 사건 내용
              TextField(
                maxLength: 128,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: caseDetailController,
                decoration: InputDecoration(
                  labelText: '사건 내용',
                  counterText: '',
                  border: OutlineInputBorder(),
                  //hintText: '유의사항'
                ),
              ),
              // 변론 사항
              TextField(
                maxLength: 128,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                controller: caseArgumentController,
                decoration: InputDecoration(
                  labelText: '변론 사항',
                  counterText: '',
                  border: OutlineInputBorder(),
                  //hintText: '유의사항'
                ),
              ),
              Row(
                children: [
                  Text('당사자 :'),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        '원고',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: PartyType.plaintiff,
                      groupValue: _myPartyType,
                      onChanged: (PartyType? value) {
                        setState(() {
                          _myPartyType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        '피고',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: PartyType.respondent,
                      groupValue: _myPartyType,
                      onChanged: (PartyType? value) {
                        setState(() {
                          _myPartyType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                maxLength: 128,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: myNameController,
                decoration: InputDecoration(
                  labelText: '명칭 (당사자)',
                  border: OutlineInputBorder(),
                  //hintText: '유의사항'
                ),
              ),
              Row(
                children: [
                  Text('상대방 :'),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        '원고',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: PartyType.plaintiff,
                      groupValue: _otherPartyType,
                      onChanged: (PartyType? value) {
                        setState(() {
                          _otherPartyType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        '피고',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: PartyType.respondent,
                      groupValue: _otherPartyType,
                      onChanged: (PartyType? value) {
                        setState(() {
                          _otherPartyType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                maxLength: 128,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: opponentNameController,
                decoration: InputDecoration(
                  labelText: '명칭 (상대방)',
                  border: OutlineInputBorder(),
                  //hintText: '유의사항'
                ),
              ),
              TextField(
                maxLength: 128,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: costController,
                decoration: InputDecoration(
                  labelText: '희망 비용',
                  border: OutlineInputBorder(),
                  //hintText: '유의사항'
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      BokdaeriPost bok = BokdaeriPost(
                        court: courtDropdownValue,
                        time: DateTime.parse(timeController.text),
                        progressType: _progressType,
                        caseNum: caseNumController.text,
                        caseDetail: caseDetailController.text,
                        caseArgument: caseArgumentController.text,
                        myPartyType: _myPartyType,
                        myName: myNameController.text,
                        otherPartyType: _otherPartyType,
                        opponentName: opponentNameController.text,
                        cost: int.parse(costController.text),
                      );

                      NetworkHelper nw = NetworkHelper();

                      bool res = await nw.bokdaeriPosting(
                          Provider.of<UserModel>(context, listen: false)
                              .userJwt!,
                          bok);

                      if (res) {
                        print('복대리 posting success');
                        Navigator.pop(context);
                      } else {
                        print('복대리 posting failed');
                      }
                    },
                    child: Text('확인'),
                  ),
                  TextButton(
                    onPressed: () {
                      print('복대리 취소 버튼 클릭');
                    },
                    child: Text('취소'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
