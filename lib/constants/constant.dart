import 'package:flutter/material.dart';

const TextStyle kOptionStyle =
TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

// 일의 진행 설정 
// continuation : 속행, closure : 종결, advanceHearing : 사전청취
enum ProgressType {none, continuation, closure, advanceHearing}

// plaintiff : 원고, respondent : 피고
enum PartyType {none, plaintiff, respondent}

/*
 * todo : 복대리 구하는 중,
 * check : 복대리 신청자 확인중,
 * inProgress : 진행중,
 * resolve : 복대리 완료,
 * close: 종료
*/
enum PostState {todo, check, inProgress, resolve, close}

const String localServerUrl = '192.168.35.41';
const String serverUrl = '3.15.146.212';

const String currentServerUrl = localServerUrl;

const String loginAPIUrl = 'http://$currentServerUrl:8080/auth/login';
const String joinAPIUrl = 'http://$currentServerUrl:8080/auth/join';
const String bokdaeriPostAPIUrl = 'http://$currentServerUrl:8080/post';
const String bokdaeriGetAPIUrl = 'http://$currentServerUrl:8080/posts';
const String usersAPIUrl = 'http://$currentServerUrl:8080/users';


const String NULL = 'NULL';
