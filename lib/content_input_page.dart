import 'package:client/Model/bokdaeriPost.dart';
import 'package:client/Model/user_model.dart';
import 'package:client/networkHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ContentInputPage extends StatefulWidget {
  const ContentInputPage({Key? key}) : super(key: key);

  @override
  _ContentInputPageState createState() => _ContentInputPageState();
}

class _ContentInputPageState extends State<ContentInputPage> {
  ProgressType _progressType = ProgressType.continuation;
  PartyType _myPartyType = PartyType.plaintiff;
  PartyType _otherPartyType = PartyType.plaintiff;

  final courtController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(title: Text('ContentInputPage')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 법원
              Row(
                children: [
                  Text('법원 :'),
                  Expanded(
                    child: TextField(controller: courtController,),
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
                        onPressed: () async {
                          DateTime? datetime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse("2021-01-01"),
                            lastDate: DateTime.parse("2025-12-31"),
                          );
                          print(datetime);
                        },
                        child: Text(
                          'show date picker',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showTitleActions: true,
                              showSecondsColumn: false, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now());
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
                      BokdaeriPost bok = BokdaeriPost();
                      print('복대리 등록 버튼 클릭');
                      print(courtController.text);
                      bok.court = courtController.text;

                      print(timeController.text);
                      DateTime dt = DateTime.parse(timeController.text);
                      bok.time = dt;

                      print(_progressType);
                      bok.progressType = _progressType;

                      print(caseNumController.text);
                      bok.caseNum = caseNumController.text;

                      print(caseDetailController.text);
                      bok.caseDetail = caseDetailController.text;

                      print(caseArgumentController.text);
                      bok.caseArgument = caseArgumentController.text;

                      print(_myPartyType);
                      bok.myPartyType = _myPartyType;

                      print(myNameController.text);
                      bok.myName = myNameController.text;

                      print(_otherPartyType);
                      bok.otherPartyType = _otherPartyType;

                      print(opponentNameController.text);
                      bok.opponentName = opponentNameController.text;

                      print(costController.text);
                      bok.cost = int.parse(costController.text);

                      NetworkHelper nw = NetworkHelper();

                      bool res = await nw.bokdaeriPosting(Provider.of<UserModel>(context, listen: false).userJwt!, bok);

                      if (res) {
                        print('복대리 posting success');
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
