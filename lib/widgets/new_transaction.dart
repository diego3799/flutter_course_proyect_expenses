import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
 
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();

  final _amountController=TextEditingController();
  DateTime _selectedDate;
  void _presentDatePicker(BuildContext ctx){
    
    showDatePicker(
      context: ctx, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now() 
      ).then((value){
        if(value==null)
        return;
        else{
          setState(() {
          _selectedDate=value;
          });
        }
      });
  }

  void _submit(){
    if(_titleController.text.isEmpty||double.parse(_amountController.text)<=0||_selectedDate==null)
    return;
    else{
     widget.addTransaction(_titleController.text,double.parse(_amountController.text),_selectedDate);
     Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                   decoration: InputDecoration(labelText: 'Title'),
                   controller: _titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted:(_)=>_submit(),
                  ),
                  Container(
                    height: 70,
                    child: Row(children: <Widget>[
                      
                      Expanded(child: Text(_selectedDate==null?'No Date Chosen':'Picked Date:${DateFormat.yMMMEd().format(_selectedDate)}')),
                      FlatButton(child:Text('Choose a Date' ,style: TextStyle(fontWeight: FontWeight.bold) ),
                      textColor:Theme.of(context).primaryColor ,
                      onPressed: ()=>{_presentDatePicker(context)},)
                    ],

                    ),
                  ),

                  RaisedButton(
                    child: Text('Add Transaction'),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _submit
                  ),
                ],
              ),
            ),
          );
  }
}