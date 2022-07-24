import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // to format the date

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    try {  // I add try&catch to avoid NullSafety issues
      widget.addTx(
                enteredTitle,
        enteredAmount,
        _selectedDate,
      );
      Navigator.of(context).pop();
    }
    catch(e){

    }
  }
  void _presentDatePicker() {
    showDatePicker(
      // the 1st ctx: showDatePicker's argument , the 2nd ctx: is the class property
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState((){
        _selectedDate = pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) =>
                  _submitData, // (_) => : I have an argument but I don't use it here
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Add Transaction',
              ),
              onPressed: _submitData,
              textColor: Theme.of(context).textTheme.button!.color,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
