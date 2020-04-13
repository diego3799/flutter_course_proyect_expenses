import 'package:flutter/material.dart';
import 'package:proyecto_2/models/transaction.dart';
import 'package:proyecto_2/widgets/chart.dart';
import 'package:proyecto_2/widgets/new_transaction.dart';
import 'package:proyecto_2/widgets/transaction_list.dart';
// import 'package:proyecto_2/widgets/user_transactions.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        // accentColor: Colors.red,
        primarySwatch: Colors.lime,
        accentColor: Colors.amber,
        fontFamily: 'Open Sans',
        textTheme: ThemeData.light().textTheme.copyWith(
          title:TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 18,
            
            ),
            button: TextStyle(color: Colors.white)
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title:TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20
              )
              )
          )
        
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List <Transaction> get recentTransactions{
    return _transactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  final List<Transaction> _transactions=[
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  void _addNewTransaction(String title,double amount,DateTime chosenDate){
    final newTx= new Transaction(id: DateTime.now().toString(), title: title, amount: amount,date: chosenDate);
    setState(() {
      _transactions.add(newTx);
    });
  }
  void _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((item){
        return item.id==id;
      });
    });
  }
  final titleController=TextEditingController();
  final amountController=TextEditingController();

  void startAddNewTransaction(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder:(bctx){
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: (){},
          behavior: HitTestBehavior.opaque,
          
          ) ; 
      }
      
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses',),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add)
            ,onPressed:() {startAddNewTransaction(context);}
          )
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions),
            TransactionList(_transactions,_deleteTransaction )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed:() {startAddNewTransaction(context);},),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}