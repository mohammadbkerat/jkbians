import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
//import 'package:store_redirect/store_redirect.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;
import 'package:open_store/open_store.dart';



remoteConfigFirebase(context) async {


  final FirebaseRemoteConfig remoteConfig = await FirebaseRemoteConfig.instance;
  final defaults=<String, dynamic>{'update': 25};
  await remoteConfig.setDefaults(defaults);
  PackageInfo info=await PackageInfo.fromPlatform();
  int currentVersion=int.parse(info.buildNumber);


  try
  {
    // Using default duration to force fetching from remote server.
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.fetchAndActivate();
    int configupdate=int.parse(remoteConfig.getString('update'));


    if(currentVersion<configupdate)
    {
      _showVersionDialog(context);
    }


  }
  on FirebaseException catch (exception)
  {
    // Fetch throttled.
    print(exception);
  }

  catch (exception)
  {
    print('Unable to fetch remote config. Cached or default values will be used');
  }
}

//Show Dialog to force user to update
_showVersionDialog(context) async {

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

