import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:get/get.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  final database=FirebaseFirestore.instance;
  TextEditingController notes=new TextEditingController();
  TextEditingController empname=new TextEditingController();
  TextEditingController empid=new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() async{
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {

      var date=new DateTime.now().toString();
      var dateParse=DateTime.parse(date);
      var formatDate='${dateParse.day.toString()}/${dateParse.month.toString()}/${dateParse.year.toString()}';
      await database.collection('Notes').add({'note':notes.text,'name':empname.text,'id':empid.text,'date':formatDate});
      empname.clear();
      empid.clear();
      notes.clear();
      /*Fluttertoast.showToast(
        msg: "sendsuccesfully".tr,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue[900],
      );



       */

      showToast('sendsuccesfully'.tr,
          context: context,
          textStyle: TextStyle (fontWeight: FontWeight.normal,color: Colors.white),
          backgroundColor: Colors.blue[900],
          alignment: Alignment.bottomCenter,
          position: StyledToastPosition(
              align: Alignment.bottomCenter, offset: 20));

    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar (
        backgroundColor: Colors.blue[900],title: Text('notes'.tr,style: TextStyle(color: Colors.white,fontSize: 15)),),

      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLength: 50,
                  controller: empname,
                  validator: (value) => value!.isEmpty ? '!' : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900]!)),
                    hintText: 'empname'.tr,
                    hintStyle: TextStyle(color: Colors.blue[900],fontSize: 13),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: empid,
                  validator: (value) => value!.isEmpty ? '!' : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900]!)),
                    hintText: 'empid'.tr,
                    hintStyle: TextStyle(color: Colors.blue[900],fontSize: 13),
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: notes,
                  maxLength: 300,
                  maxLines: 7,
                  validator: (value) => value!.isEmpty ? '!' : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[900]!)),
                    hintText: 'typehere'.tr,
                    hintStyle: TextStyle(color: Colors.blue[900],fontSize: 13),
                  ),
                ),
              ),

              SizedBox(height: 10),
              ElevatedButton(onPressed:()  {


                validateAndSave();


              },style: ElevatedButton.styleFrom(foregroundColor: Colors.white,backgroundColor: Colors.blue[900]),child: Text('send'.tr))
                //textColor: Colors.white, color: Colors.blue[900],child: Text('send'.tr),)
            ],

          ),
        ),

      ),

    );
  }
}
