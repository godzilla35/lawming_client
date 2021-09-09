import 'package:flutter/material.dart';

const TextStyle kOptionStyle =
TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

// 일의 진행 설정 
// continuation : 속행, closure : 종결, advanceHearing : 사전청취
enum ProgressType {continuation, closure, advanceHearing}

// plaintiff : 원고, closure : 종결
enum PartyType {plaintiff, respondent}