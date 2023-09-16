import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'categories.dart';

final Uri _url = Uri.parse('https://www.facebook.com/groups/JKBEmployees/permalink/382548132859431/');

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final getstorage=GetStorage();

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  bool passwordvisible=true;
  TextEditingController username=new TextEditingController();
  TextEditingController pass=new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF0D47A1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: new AssetImage('assets/jkbianslogo.png'),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'welcome'.tr,
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'signin'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.0),
                        topLeft: Radius.circular(50.0))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: username,
                            decoration: InputDecoration(
                              hintText: 'usernamelogin'.tr,
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: pass,
                            decoration: InputDecoration(
                                hintText: 'passlogin'.tr,
                                hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                floatingLabelBehavior: FloatingLabelBehavior.never,

                                suffixIcon: IconButton(
                                  icon: Icon(
                                      passwordvisible ? Icons.visibility : Icons.visibility_off
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      passwordvisible=!passwordvisible;
                                    });
                                  },
                                )
                            ),
                            obscureText: passwordvisible,

                          ),
                        ),


                        SizedBox(
                          height: 40.0,
                        ),

                        InkWell(
                          onTap: (){

                            if(username.text.toLowerCase()=="jkb" && pass.text.toLowerCase()=="jkb1976")
                              {
                                getstorage.write('password','jkb1976');
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()),);
                              }


                             else
                            {
                             /* Fluttertoast.showToast(
                                msg: "incorrectuserpass".tr,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.blue[900],
                              );

                              */

                              showToast('incorrectuserpass'.tr,
                                  context: context,
                                  textStyle: TextStyle (fontWeight: FontWeight.normal,color: Colors.white),
                                  backgroundColor: Colors.blue[900],
                                  alignment: Alignment.bottomCenter,
                                  position: StyledToastPosition(offset: 20,
                                      align: Alignment.bottomCenter));

                            }


                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Color(0xFF0D47A1),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Center(
                              child: Text(
                                'signin'.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 40.0,
                        ),

                        InkWell(
                          onTap: ()=>{

                            setState(() {
                              _launchUrl();

                            })



                          },
                          child: Text(
                            'forgotpassorusername'.tr,
                            style: TextStyle(color: Colors.grey,fontSize: 13),
                          ),
                        ),



                        /*Image.asset(
                          'assets/jkbianslogo.png',
                          height: 120.0,
                          width: 120.0,
                          fit: BoxFit.cover,
                        ),

                         */

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}