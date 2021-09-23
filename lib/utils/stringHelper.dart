import 'package:client/constants/constant.dart';

class StringHelper {

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

}