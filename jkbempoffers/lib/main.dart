import 'dart:io' show Platform;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jkbempoffers/remoteconfigfirebase.dart';
import 'package:jkbempoffers/translations.dart';
import 'package:open_store/open_store.dart';
import 'categories.dart';
import 'loginpage.dart';
import 'notification_services.dart';
import 'package:get/get.dart';



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}





void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  runApp(GetMaterialApp(
    translations: TranslationsApp(),
    locale: Locale('en', 'US'),
    fallbackLocale: Locale('ar', 'JO'),
    home: MyApp(),
  ));

}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
        ]
    );


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: Colors.blue[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key ? key, this.title}) : super(key: key);

  final String ? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {


  FirebaseFirestore getdata=FirebaseFirestore.instance;
  NotificationServices notificationServices = NotificationServices();
  final getstorage=GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    remoteConfigFirebase(context);

    final getdata2=getdata.collection('Config').doc('nYcN0MGPXz3mFLbNved2');
    getdata2.get().then((value) {
      String down=value.get('Down');
      String update=value.get('Update');
      String downtext=value.get('DownText');


      if(down=='on')
        {

          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            headerAnimationLoop: false,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            desc: downtext ,
          ).show();

        }

      else if(update=='on')
        {

            AwesomeDialog(
              context: context,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              headerAnimationLoop: false,
              dialogType: DialogType.info,
              animType: AnimType.bottomSlide,
              btnCancelColor: Colors.blue[900],
              btnCancelText: 'updatebtn'.tr,
              btnCancelOnPress: (){

                if(Platform.isAndroid)
                {
                  OpenStore.instance.open(
                    androidAppBundleId: 'com.jkbiansoffers.jkbiansoffers',
                  );

                }

                else if(Platform.isIOS)
                {
                  OpenStore.instance.open(
                    appStoreId: '1553120187',
                  );
                }

              },
              title: 'newupdatetitle'.tr,
              desc: 'newupdatedesc'.tr,
            ).show();


        }


    });





  }






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

          backgroundColor: Colors.blue[900]

      ),


      body:
      Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MaterialButton(
            color: Colors.blue[900],
            shape: CircleBorder(),

            child: Padding(
              padding: const EdgeInsets.all(55),
              child: Text("English"
                ,style: TextStyle(color: Colors.white,fontSize: 13),
              ),
            ),


            onPressed: (){
              getstorage.write('lang', 'en');
             setState(() {
               Get.updateLocale(Locale('en', 'US'));
                getvalidation();

              });



            },),

          SizedBox(height: 15),

          MaterialButton(

            color: Colors.blue[900],
            shape: CircleBorder(),

            child: Padding(
              padding: const EdgeInsets.all(55),
              child: Text("العربية"
                ,style: TextStyle(color: Colors.white,fontSize: 13),
              ),
            ),


            onPressed: (){
              getstorage.write('lang', 'ar');
              setState(() {
                Get.updateLocale(Locale('ar', 'JO'));
                getvalidation();

              });

            },),

        ],

      ),
    );

  }


  void getvalidation() async
  {
    var sharedpassword=getstorage.read('password');

    if(sharedpassword=="jkb1976")
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()),);
    }

    else
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
    }


  }

}

