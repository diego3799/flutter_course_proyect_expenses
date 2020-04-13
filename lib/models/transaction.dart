import 'package:flutter/material.dart';

class Transaction{
  String id,title;
  double amount;
  DateTime date;
  Transaction(
    {
     @required this.id,
     @required this.amount,
     @required this.title,
     @required this.date
    }
  );
}