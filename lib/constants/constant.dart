import 'package:flutter/material.dart';

const TextStyle kOptionStyle =
TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

// 일의 진행 설정 
// continuation : 속행, closure : 종결, advanceHearing : 사전청취
enum ProgressType {none, continuation, closure, advanceHearing}

// plaintiff : 원고, respondent : 피고
enum PartyType {none, plaintiff, respondent}

const String loginAPIUrl = 'http://3.15.146.212:8080/auth/login';
const String joinAPIUrl = 'http://3.15.146.212:8080/auth/join';
const String bokdaeriPostAPIUrl = 'http://3.15.146.212:8080/post';
const String bokdaeriGetAPIUrl = 'http://3.15.146.212:8080/posts';

const String NULL = 'NULL';
