import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_2/models/transaction.dart';
import 'package:proyecto_2/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  double get totalSpending{
    return gruopedTransactionValues.fold(0, (sum,item){
      return sum+item['amount'];
    });
  }
  List<Map<String,Object>> get gruopedTransactionValues{
    return List.generate(7, (index){
      final weekDate= DateTime.now().subtract(Duration(days: index));
      double total=0;
      for (var tx in recentTransactions){
        if(tx.date.day==weekDate.day&&tx.date.month==weekDate.month&&tx.date.year==weekDate.year){
          total+=tx.amount;

        }
      
      }
      // print(total);
      // print(weekDate);
      return {
        'day':DateFormat.E().format(weekDate).substring(0,1),'amount':total
      };
    }).reversed.toList();
  }
  @override
  Widget build(BuildContext context) {
    // print(gruopedTransactionValues);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: gruopedTransactionValues.map((item){
            return Flexible(
            fit: FlexFit.tight,   
            child :ChartBar(
              item['day'],
              item['amount'],
              totalSpending==0?0:
              (item['amount'] as double)/totalSpending)
            );
          }).toList(),
        ),
      ),      
    );
  }
}