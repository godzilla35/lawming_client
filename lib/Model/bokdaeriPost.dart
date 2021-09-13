import 'package:client/constant.dart';

class BokdaeriPost {
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

}