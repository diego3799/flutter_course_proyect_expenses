import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;
  TransactionList(this.transactions,this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty? 
      Column(
        children: <Widget>[
          Text('No Hay Transacciones aún',
          style: Theme.of(context).textTheme.title,),
          SizedBox(height:20,),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover, ))
        ],
      )
      :ListView.builder(
      
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
              child: ListTile(
              trailing: IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor,onPressed: (){delete(transactions[index].id);},),
              subtitle: Text(DateFormat.yMMMEd().format(transactions[index].date)),
              title: Text(transactions[index].title,style: Theme.of(context).textTheme.title,),
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                    child: FittedBox(
                    child: Text('\$ ${transactions[index].amount}')),
                ),
                ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}