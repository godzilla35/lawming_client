import 'package:client/constants/constant.dart';

class BokdaeriPost {
  int id = 0;
  String court = 'court'; // 법원
  DateTime time = DateTime.now(); // 시간
  ProgressType progressType = ProgressType.continuation; // 진행 설정
  PartyType myPartyType = PartyType.plaintiff; // 본인
  String myName = 'me';
  PartyType otherPartyType = PartyType.plaintiff; // 상대
  String opponentName = 'you';
  String caseNum = 'null';
  String caseDetail = 'null';
  String caseArgument = 'null';
  int cost = 100000;
  int UserId = 0;

  BokdaeriPost({
    required this.court,
    required this.time,
    required this.progressType,
    required this.myPartyType,
    required this.myName,
    required this.otherPartyType,
    required this.opponentName,
    required this.caseNum,
    required this.caseDetail,
    required this.caseArgument,
    required this.cost,
  });


  factory BokdaeriPost.fromJson(Map<String, dynamic> json) {

    // enum ProgressType {continuation, closure, advanceHearing}
    ProgressType getProgressType =  ProgressType.none;

    if(json['progressType'] == 'ProgressType.continuation') {
      getProgressType = ProgressType.continuation;
    } else if(json['progressType'] == 'ProgressType.closure') {
      getProgressType = ProgressType.closure;
    } else if(json['progressType'] == 'ProgressType.advanceHearing') {
      getProgressType = ProgressType.advanceHearing;
    }

    // enum PartyType {plaintiff, respondent}
    PartyType getMyPartyType = PartyType.none;
    if(json['myPartyType'] == 'PartyType.plaintiff') {
      getMyPartyType = PartyType.plaintiff;
    } else if(json['myPartyType'] == 'PartyType.respondent') {
      getMyPartyType = PartyType.respondent;
    }

    PartyType getOtherPartyType = PartyType.none;
    if(json['otherPartyType'] == 'PartyType.plaintiff') {
      getOtherPartyType = PartyType.plaintiff;
    } else if(json['otherPartyType'] == 'PartyType.respondent') {
      getOtherPartyType = PartyType.respondent;
    }


    BokdaeriPost bok = BokdaeriPost(
      court: json['court'],
      time: DateTime.parse(json['time'].toString()),
      progressType: getProgressType,
      myPartyType: getMyPartyType,
      myName: json['myName'],
      otherPartyType: getOtherPartyType,
      opponentName: json['opponentName'],
      caseNum: json['caseNum'],
      caseDetail: json['caseDetail'],
      caseArgument: json['caseArgument'],
      cost: json['cost'],
    );

    bok.id = json['id'];
    bok.UserId = json['UserId'];

    return bok;
  }
}
