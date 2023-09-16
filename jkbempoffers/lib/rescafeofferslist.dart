import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jkbempoffers/picgridoffers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fullimg.dart';
import 'notes.dart';
import 'package:firebase_auth/firebase_auth.dart';


final getstorage=GetStorage();


class ResCafeOffersList extends StatefulWidget {


  @override
  _ResCafeOffersListState createState() => _ResCafeOffersListState();

  final String name;
  final String nametype,searchtype,titlebar;
  ResCafeOffersList(this.name,this.nametype,this.searchtype,this.titlebar);


}



class _ResCafeOffersListState extends State<ResCafeOffersList> {


  Database _database = Database();



  Future<void> _launcheurl(_url) async =>
      await canLaunchUrl(_url) ? await launchUrl(_url) : throw 'Could not launch $_url';



  Future<void> _makePhoneCall(String phoneNumer)async
  {
    final Uri launchUri=Uri(scheme: 'tel',path: phoneNumer);
    if(await canLaunchUrl(launchUri))
      {
        await launchUrl(launchUri);
      }
    else
      {
        throw 'Could not launch $launchUri';
      }

  }

  final auth= FirebaseAuth.instance;
  TextEditingController textEditingController=TextEditingController();

  String ? searchstring;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:AppBar (
        backgroundColor: Colors.blue[900],title: Text(widget.titlebar,style: TextStyle(color: Colors.white,fontSize: 13)),actions: [
        TextButton(style: TextButton.styleFrom(foregroundColor: Colors.white),
          onPressed: ()async{

    await auth.signInWithEmailAndPassword(email: 'jkbempoffers@gmail.com', password: 'jkb1976');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Notes()),);

    },child: new Text("notes".tr,style: TextStyle(color:Colors.yellow[700],fontSize: 10)),)
    ],),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  setState(() {
                    searchstring=value.toLowerCase();
                  });
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),


                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: "searchbar".tr,
                    hintStyle: TextStyle(fontSize: 13.0, color: Colors.white),
                    contentPadding: EdgeInsets.only(left: 34.0),
                    filled: true,
                    fillColor: Colors.blue[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    )),
              ),

              SizedBox(
                height: 20.0,
              ),

              Expanded(child:
              StreamBuilder(
                stream: (searchstring==null || searchstring!.trim()=='')
                    ?_database.getoffer1(name: widget.name)
                    :_database.getoffer2(name: widget.name, searchstring: searchstring!),

                builder: (BuildContext context, AsyncSnapshot<List<Offerslis1>>snapshot) {


                  if (snapshot.hasError)
                  {
                    return Center(child: Text('tryorconn'.tr));
                  }


                  if (snapshot.connectionState == ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator());
                  }




                  final List<Offerslis1> offerlist1 = snapshot.data!;
                  return ListView.builder(
                    itemCount: offerlist1.length,
                    itemBuilder: (context,index){
                      final Offerslis1 offerlistbuilder = offerlist1[index];
                      return InkWell(
                        onTap: (){},
                        child: Card(
                          shape: RoundedRectangleBorder
                            (
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.all(5),
                          elevation: 8.0,
                          color: Colors.white,
                          child: Container(

                            padding: EdgeInsets.all(10),
                            child: Column(
                              children:<Widget> [
                                Row(
                                  children: [
                                    avatarWidget(offerlistbuilder.logo, 70.0),

                                    SizedBox(
                                      width: 10,
                                    ),

                                    Flexible(child:
                                    Text(
                                      widget.nametype=='namearabic'?offerlistbuilder.namear
                                          :offerlistbuilder.nameen,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    ),

                                  ],
                                ),

                                SizedBox(height: 10),


                                widget.nametype=='namearabic'? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    offerlistbuilder.expire==null ? 'expire'.tr+' '+'expiredatenotspecified'.tr : 'expire'.tr+' '+offerlistbuilder.expire!,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 12.0,

                                    ),
                                  ),
                                ):
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    offerlistbuilder.expire==null ? 'expire'.tr+' '+'expiredatenotspecified'.tr : 'expire'.tr+' '+offerlistbuilder.expire!,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 12.0,

                                    ),
                                  ),
                                ),



                                Divider(
                                  thickness: 0.3,color: Colors.blueAccent,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child:OutlinedButton(
                                      onPressed: (){

                                        FirebaseFirestore.instance.collection(widget.name).where(widget.nametype,isEqualTo:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen).snapshots().listen((event) {
                                          event.docs.forEach((element) {

                                            try {

                                              int offerscount = element
                                                  .data()['offers'].length;

                                              if (offerscount == 1) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageBui(element
                                                                .data()['offers'][0],
                                                                 widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen)));
                                              }


                                              else if (offerscount == 2) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 2)));
                                              }

                                              else if (offerscount == 3) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 3)));
                                              }

                                              else if (offerscount == 4) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                img4: element
                                                                    .data()['offers'][3],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 4)));
                                              }

                                              else if (offerscount == 5) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                img4: element
                                                                    .data()['offers'][3],
                                                                img5: element
                                                                    .data()['offers'][4],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 5)));
                                              }

                                              else if (offerscount == 6) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                img4: element
                                                                    .data()['offers'][3],
                                                                img5: element
                                                                    .data()['offers'][4],
                                                                img6: element
                                                                    .data()['offers'][5],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 6)));
                                              }

                                              else if (offerscount == 7) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                img4: element
                                                                    .data()['offers'][3],
                                                                img5: element
                                                                    .data()['offers'][4],
                                                                img6: element
                                                                    .data()['offers'][5],
                                                                img7: element
                                                                    .data()['offers'][6],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 7)));
                                              }

                                              else if (offerscount == 8) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                img4: element
                                                                    .data()['offers'][3],
                                                                img5: element
                                                                    .data()['offers'][4],
                                                                img6: element
                                                                    .data()['offers'][5],
                                                                img7: element
                                                                    .data()['offers'][6],
                                                                img8: element
                                                                    .data()['offers'][7],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 8)));
                                              }

                                              else if (offerscount == 9) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                img4: element
                                                                    .data()['offers'][3],
                                                                img5: element
                                                                    .data()['offers'][4],
                                                                img6: element
                                                                    .data()['offers'][5],
                                                                img7: element
                                                                    .data()['offers'][6],
                                                                img8: element
                                                                    .data()['offers'][7],
                                                                img9: element
                                                                    .data()['offers'][8],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 9)));
                                              }

                                              else if (offerscount == 10) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['offers'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['offers'][1],
                                                                img3: element
                                                                    .data()['offers'][2],
                                                                img4: element
                                                                    .data()['offers'][3],
                                                                img5: element
                                                                    .data()['offers'][4],
                                                                img6: element
                                                                    .data()['offers'][5],
                                                                img7: element
                                                                    .data()['offers'][6],
                                                                img8: element
                                                                    .data()['offers'][7],
                                                                img9: element
                                                                    .data()['offers'][8],
                                                                img10: element
                                                                    .data()['offers'][9],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 10)));
                                              }




                                            }

                                            catch(error)
                                            {
                                              print(error);
                                            }

                                          });
                                        });


                                      },
                                      child: new Text("theoffersbutton".tr,style: TextStyle(fontSize: 11)),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.blueAccent,width: 0.3,style: BorderStyle.solid),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),

                                      ),
                                    ),
                                    ),

                                    Expanded(child:OutlinedButton(
                                      onPressed: (){

                                        FirebaseFirestore.instance.collection(widget.name).where(widget.nametype,isEqualTo:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen).snapshots().listen((event) {
                                          event.docs.forEach((element) {

                                            try {

                                              int menucount = element
                                                  .data()['menu'].length;

                                              if (menucount == 1) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImageBui(element
                                                                .data()['menu'][0],
                                                                 widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen)));
                                              }


                                              else if (menucount == 2) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 2)));
                                              }

                                              else if (menucount == 3) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 3)));
                                              }

                                              else if (menucount == 4) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 4)));
                                              }

                                              else if (menucount == 5) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 5)));
                                              }

                                              else if (menucount == 6) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 6)));
                                              }

                                              else if (menucount == 7) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 7)));
                                              }

                                              else if (menucount == 8) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 8)));
                                              }

                                              else if (menucount == 9) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 9)));
                                              }

                                              else if (menucount == 10) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 10)));
                                              }

                                              else if (menucount == 11) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 11)));
                                              }

                                              else if (menucount == 12) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 12)));
                                              }

                                              else if (menucount == 13) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 13)));
                                              }

                                              else if (menucount == 14) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 14)));
                                              }

                                              else if (menucount == 15) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                img15: element
                                                                    .data()['menu'][14],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 15)));
                                              }

                                              else if (menucount == 16) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                img15: element
                                                                    .data()['menu'][14],
                                                                img16: element
                                                                    .data()['menu'][15],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 16)));
                                              }

                                              else if (menucount == 17) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                img15: element
                                                                    .data()['menu'][14],
                                                                img16: element
                                                                    .data()['menu'][15],
                                                                img17: element
                                                                    .data()['menu'][16],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 17)));
                                              }

                                              else if (menucount == 18) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                img15: element
                                                                    .data()['menu'][14],
                                                                img16: element
                                                                    .data()['menu'][15],
                                                                img17: element
                                                                    .data()['menu'][16],
                                                                img18: element
                                                                    .data()['menu'][17],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 18)));
                                              }

                                              else if (menucount == 19) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                img15: element
                                                                    .data()['menu'][14],
                                                                img16: element
                                                                    .data()['menu'][15],
                                                                img17: element
                                                                    .data()['menu'][16],
                                                                img18: element
                                                                    .data()['menu'][17],
                                                                img19: element
                                                                    .data()['menu'][18],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 19)));
                                              }

                                              else if (menucount == 20) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                img15: element
                                                                    .data()['menu'][14],
                                                                img16: element
                                                                    .data()['menu'][15],
                                                                img17: element
                                                                    .data()['menu'][16],
                                                                img18: element
                                                                    .data()['menu'][17],
                                                                img19: element
                                                                    .data()['menu'][18],
                                                                img20: element
                                                                    .data()['menu'][20],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 20)));
                                              }

                                              else if (menucount == 21) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GridImageList
                                                              (img1: element
                                                                .data()['menu'][0]
                                                                ,
                                                                img2: element
                                                                    .data()['menu'][1],
                                                                img3: element
                                                                    .data()['menu'][2],
                                                                img4: element
                                                                    .data()['menu'][3],
                                                                img5: element
                                                                    .data()['menu'][4],
                                                                img6: element
                                                                    .data()['menu'][5],
                                                                img7: element
                                                                    .data()['menu'][6],
                                                                img8: element
                                                                    .data()['menu'][7],
                                                                img9: element
                                                                    .data()['menu'][8],
                                                                img10: element
                                                                    .data()['menu'][9],
                                                                img11: element
                                                                    .data()['menu'][10],
                                                                img12: element
                                                                    .data()['menu'][11],
                                                                img13: element
                                                                    .data()['menu'][12],
                                                                img14: element
                                                                    .data()['menu'][13],
                                                                img15: element
                                                                    .data()['menu'][14],
                                                                img16: element
                                                                    .data()['menu'][15],
                                                                img17: element
                                                                    .data()['menu'][16],
                                                                img18: element
                                                                    .data()['menu'][17],
                                                                img19: element
                                                                    .data()['menu'][18],
                                                                img20: element
                                                                    .data()['menu'][19],
                                                                img21: element
                                                                    .data()['menu'][20],
                                                                name:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen
                                                                ,
                                                                count: 21)));
                                              }






                                            }

                                            catch(error)
                                            {
                                              print(error);
                                            }

                                          });
                                        });


                                      },
                                      child: new Text("menubutton".tr,style: TextStyle(fontSize: 11)),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.blueAccent,width: 0.3,style: BorderStyle.solid),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),

                                      ),
                                    ),
                                    ),

                                    Expanded(child:OutlinedButton(
                                      onPressed: (){

                                        FirebaseFirestore.instance.collection(widget.name).where(widget.nametype,isEqualTo:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen).snapshots().listen((event) {

                                          event.docs.forEach((element) {

                                            try {
                                              int numbercount = element
                                                  .data()['number'].length;
                                              var listofnumber = element
                                                  .data()['number'];
                                              var thenumber = listofnumber
                                                  .values.toList();
                                              var numbername = listofnumber
                                                  .entries.toList();

                                              if (numbercount == 1) {
                                                setState(() {

                                                  _makePhoneCall(thenumber[0].toString());
                                                });
                                              }

                                              else if (numbercount == 2) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              

                                                                  _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              

                                                                  _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 3) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {


                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());


                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 4) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[3].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 5) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[3].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[4].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 6) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[3].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[4].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[5].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 7) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[3].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[4].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[5].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[6].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 8) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[3].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[4].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[5].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[6].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[7]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[7].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 9) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[3].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[4].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[5].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[6].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[7]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[7].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[8]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[8].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (numbercount == 10) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: numbername[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[0].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[1].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[2].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[3].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[4].toString());
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[5].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[6].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[7]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[7].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[8]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[8].toString());
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: numbername[9]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                              _makePhoneCall(thenumber[9].toString());
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }


                                            }
                                            catch(error)
                                            {
                                              print(error);
                                            }

                                          });
                                        });


                                      }
                                      ,child: new Text("callbutton".tr,style: TextStyle(fontSize: 11)),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.blueAccent,width: 0.3,style: BorderStyle.solid),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),

                                      ),
                                    ),
                                    ),

                                    Expanded(child:OutlinedButton(
                                      onPressed: (){



                                        FirebaseFirestore.instance.collection(widget.name).where(widget.nametype,isEqualTo:  widget.nametype=='namearabic'?offerlistbuilder.namear:offerlistbuilder.nameen).snapshots().listen((event) {

                                          event.docs.forEach((element) {

                                            try {
                                              int locationcount = element
                                                  .data()['location'].length;
                                              var listoflocation = element
                                                  .data()['location'];
                                              var locationmap = listoflocation
                                                  .values.toList();
                                              var locationname = listoflocation
                                                  .entries.toList();


                                              if (locationcount == 1) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {


                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 2) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 3) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 4) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {

                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[3].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 5) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[3].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[4].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 6) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[3].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[4].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[5].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 7) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[3].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[4].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[5].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[6].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 8) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[3].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[4].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[5].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[6].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[7]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[7].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 9) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[3].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[4].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[5].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[6].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[7]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[7].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[8]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[8].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }

                                              else if (locationcount == 10) {
                                                AwesomeDialog(
                                                  context: this.context,
                                                  headerAnimationLoop: false,
                                                  dialogType: DialogType
                                                      .noHeader,
                                                  animType: AnimType
                                                      .bottomSlide,
                                                  body: Padding(
                                                    padding: const EdgeInsets
                                                        .all(10.0),
                                                    child: Column(
                                                      children: [
                                                        AnimatedButton(
                                                          text: locationname[0]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[0].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[1]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[1].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[2]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[2].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[3]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[3].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[4]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[4].toString()));
                                                            })
                                                          },
                                                        ),

                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[5]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[5].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[6]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[6].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[7]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[7].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[8]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[8].toString()));
                                                            })
                                                          },
                                                        ),


                                                        SizedBox(height: 3),

                                                        AnimatedButton(
                                                          text: locationname[9]
                                                              .key.toString()
                                                              .tr,
                                                          color: Colors
                                                              .blue[900],
                                                          pressEvent: () =>
                                                          {

                                                            setState(() {
                                                              
                                                                  _launcheurl(Uri.parse(locationmap[9].toString()));
                                                            })
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ).show();
                                              }


                                            }
                                            catch(error)
                                            {
                                              print(error);
                                            }


                                          });
                                        });



                                      }
                                      ,child: new Text("branchesbutton".tr,softWrap: false ,style: TextStyle(fontSize: 11)),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.blueAccent,width: 0.3,style: BorderStyle.solid),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),

                                      ),
                                    ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                        ),
                      );
                    },
                  );



                },
              ),
              )
            ],
          ),
        ),
      ),
    );

  }
}

Widget avatarWidget(String ? urlImg, double radius) {
  if(urlImg==null)
  {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            image: AssetImage('assets/noimageavailable.png'),
          )
      ),
    );
  }

  else
  {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            image: NetworkImage(urlImg),
          )
      ),
    );
  }

}


class Database {


  final _firebaseInstance = FirebaseFirestore.instance;

  Query<Offerslis1> _getCollectionRef1(String name) => _firebaseInstance
      .collection(name).orderBy('order', descending: true)
      .withConverter<Offerslis1>(
    fromFirestore: (snapshot, options) =>
        Offerslis1.fromMap(snapshot.data()!),
    toFirestore: (offerslis, options) => offerslis.toMap(),
  );

  Stream<List<Offerslis1>> getoffer1({required String name}) {

    final Stream<QuerySnapshot<Offerslis1>> query = _getCollectionRef1(name).snapshots();
    final result = query.map((querySnapshot) => querySnapshot.docs
        .map((docSnapshot) => docSnapshot.data())
        .toList());
    return result;
  }

  Query<Offerslis1> _getCollectionRef2(String name,String searchstring) => getstorage.read('lang')=='ar'?_firebaseInstance
      .collection(name).where('searchIndexarabic',arrayContains: searchstring)
      .withConverter<Offerslis1>(
    fromFirestore: (snapshot, options) =>
        Offerslis1.fromMap(snapshot.data()!),
    toFirestore: (offerslis, options) => offerslis.toMap(),
  ):
  _firebaseInstance
      .collection(name).where('searchIndex',arrayContains: searchstring)
      .withConverter<Offerslis1>(
    fromFirestore: (snapshot, options) =>
        Offerslis1.fromMap(snapshot.data()!),
    toFirestore: (offerslis, options) => offerslis.toMap(),
  );

  Stream<List<Offerslis1>> getoffer2({required String name,required String searchstring}) {

    final Stream<QuerySnapshot<Offerslis1>> query = _getCollectionRef2(name,searchstring).snapshots();
    final result = query.map((querySnapshot) => querySnapshot.docs
        .map((docSnapshot) => docSnapshot.data())
        .toList());
    return result;
  }
}

class Offerslis1 {
  final String namear;
  final String nameen;
  final String logo;
  final String ? expire;
  Offerslis1._(
      {required this.namear,
        required this.nameen,
        required this.logo,
        required this.expire,
      });

  factory Offerslis1.fromMap(Map<String, dynamic> data) {
    return Offerslis1._(
        namear: data['namearabic'],
        nameen: data['name'],
        logo: data['logo'],
        expire: data['expire']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'namearabic': namear,
      'name':nameen,
      'logo': logo,
      'expire': expire
    };
  }
}



