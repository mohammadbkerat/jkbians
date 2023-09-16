import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jkbempoffers/fullimg.dart';
import 'package:jkbempoffers/picgridoffers.dart';
import 'package:jkbempoffers/rescafeofferslist.dart';
import 'notes.dart';
import 'offerslist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  final auth= FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],actions: [
        TextButton(style: TextButton.styleFrom(foregroundColor: Colors.white),
          onPressed: ()async{

            await auth.signInWithEmailAndPassword(email: 'jkbempoffers@gmail.com', password: 'jkb1976');
            Navigator.push(context, MaterialPageRoute(builder: (context) => Notes()),);

          },child: new Text("notes".tr,style: TextStyle(color:Colors.yellow[700],fontSize: 10)),)
      ],),


      body: GridView.count(crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 1.3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children:<Widget> [
          myGrid("hotels".tr,0xFF0D47A1,0xFF0D47A1),
          myGrid("restaurantsandcofes".tr,0xFFFBC02D,0xFFFBC02D),
          myGrid("barakamall".tr,0xFFFBC02D,0xFFFBC02D),
          myGrid("education".tr,0xFF0D47A1,0xFF0D47A1),
          myGrid("sportsclub".tr,0xFF448AFF,0xFF448AFF),
          myGrid("healthandbeauty".tr,0xFFFBC02D,0xFFFBC02D),
          myGrid("electronicsdevices".tr,0xFF0D47A1,0xFF0D47A1),
          myGrid("others".tr,0xFF448AFF,0xFF448AFF)

        ],


      ),
    );

  }
  Widget myGrid(String gridname,int color1,int color2)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: new LinearGradient(
          colors: [
            Color(color1),
            Color(color2),
          ],

        ),
      ),
      child: Stack(
        children: <Widget>[
          InkWell(onTap: (){

             if(gridname=="اخرى")
            {
              gridname="Others";
              //Navigator.push(context, MaterialPageRoute(builder: (context) => OffersList(gridname,'namearabic','searchIndexarabic','عروض اخرى')),);
              Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض اخرى'));
            }

            else if(gridname=="المؤسسات التعليمية")
            {
              gridname="Educational Organizations";
              Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض المؤسسات التعليمية'));
            }

            else if(gridname=="الأندية الرياضية")
            {
              gridname="Sports Clubs";
              Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الأندية الرياضية'));

            }

            else if(gridname=="المطاعم و الكافيهات")
            {
              gridname="Restaurants And Cafes";
              Get.to(() =>ResCafeOffersList(gridname,'namearabic','searchIndexarabic','عروض المطاعم و الكافيهات'));

            }


            else if(gridname=="الفنادق")
            {
              gridname="Hotels";
              Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الفنادق'));

            }

            else if(gridname=="الصحة والجمال")
            {
              gridname="Health And Beauty";
              Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الصحة والجمال'));

            }


            else if(gridname=="الالكترونيات-الاجهزة")
            {
              gridname="Electronics-Devices";
              Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الالكترونيات-الاجهزة'));

            }






             else if(gridname=="Others")
             {
               Get.to(() =>OffersList(gridname,'name','searchIndex','Others Offers'));
             }

             else if(gridname=="Educational Organizations")
             {
               Get.to(() =>OffersList(gridname,'name','searchIndex','Educational Organizations Offers'));
             }

             else if(gridname=="Sports Clubs")
             {
               Get.to(() =>OffersList(gridname,'name','searchIndex','Sports Clubs Offers'));
             }

             else if(gridname=="Restaurants And Cafes")
             {
               Get.to(() =>ResCafeOffersList(gridname,'name','searchIndex','Restaurants And Cafes Offers'));
             }


             else if(gridname=="Hotels")
             {
               Get.to(() =>OffersList(gridname,'name','searchIndex','Hotels Offers'));
             }

             else if(gridname=="Health And Beauty")
             {

               Get.to(() =>OffersList(gridname,'name','searchIndex','Health And Beauty Offers'));

             }

             else if(gridname=="Electronics-Devices")
             {

               Get.to(() =>OffersList(gridname,'name','searchIndex','Electronics-Devices Offers'));

             }


             else if(gridname=="Baraka Mall" || gridname=="البركة مول")
             {

               FirebaseFirestore.instance.collection('Baraka Mall').snapshots().listen((event) {
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
                                       'Baraka Mall')));
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
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
                                       name:'Baraka Mall'
                                       ,
                                       count: 10)));
                     }

                     else if (offerscount == 11) {
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
                                       img11: element
                                           .data()['offers'][10],
                                       name:'Baraka Mall'
                                       ,
                                       count: 11)));
                     }

                     else if (offerscount == 12) {
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
                                       img11: element
                                           .data()['offers'][10],
                                       img12: element
                                           .data()['offers'][11],
                                       name:'Baraka Mall'
                                       ,
                                       count: 12)));
                     }

                     else if (offerscount == 13) {
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
                                       img11: element
                                           .data()['offers'][10],
                                       img12: element
                                           .data()['offers'][11],
                                       img13: element
                                           .data()['offers'][12],
                                       name:'Baraka Mall'
                                       ,
                                       count: 13)));
                     }

                     else if (offerscount == 14) {
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
                                       img11: element
                                           .data()['offers'][10],
                                       img12: element
                                           .data()['offers'][11],
                                       img13: element
                                           .data()['offers'][12],
                                       img14: element
                                           .data()['offers'][13],
                                       name:'Baraka Mall'
                                       ,
                                       count: 14)));
                     }


                   }

                   catch(error)
                   {
                     print(error);
                   }

                 });
               });


               //Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageBuiBarakaMall("assets/barakamalloffers.jpg",gridname)));

             }


          },

          ),


          Center(
              child:
              InkWell(
                onTap: (){


                  if(gridname=="اخرى")
                  {
                    gridname="Others";
                    Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض اخرى'));
                  }

                  else if(gridname=="المؤسسات التعليمية")
                  {
                    gridname="Educational Organizations";
                    Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض المؤسسات التعليمية'));
                  }

                  else if(gridname=="الأندية الرياضية")
                  {
                    gridname="Sports Clubs";
                    Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الأندية الرياضية'));
                  }

                  else if(gridname=="المطاعم و الكافيهات")
                  {
                    gridname="Restaurants And Cafes";
                    Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض المطاعم و الكافيهات'));
                  }


                  else if(gridname=="الفنادق")
                  {
                    gridname="Hotels";
                    Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الفنادق'));

                  }

                  else if(gridname=="الصحة والجمال")
                  {
                    gridname="Health And Beauty";
                    Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الصحة والجمال'));

                  }


                  else if(gridname=="الالكترونيات-الاجهزة")
                  {
                    gridname="Electronics-Devices";
                    Get.to(() =>OffersList(gridname,'namearabic','searchIndexarabic','عروض الالكترونيات-الاجهزة'));

                  }






                  else if(gridname=="Others")
                  {
                    Get.to(() =>OffersList(gridname,'name','searchIndex','Others Offers'));
                  }

                  else if(gridname=="Educational Organizations")
                  {
                    Get.to(() =>OffersList(gridname,'name','searchIndex','Educational Organizations Offers'));
                  }

                  else if(gridname=="Sports Clubs")
                  {
                    Get.to(() =>OffersList(gridname,'name','searchIndex','Sports Clubs Offers'));
                  }

                  else if(gridname=="Restaurants And Cafes")
                  {
                    Get.to(() =>OffersList(gridname,'name','searchIndex','Restaurants And Cafes Offers'));
                  }


                  else if(gridname=="Hotels")
                  {
                    Get.to(() =>OffersList(gridname,'name','searchIndex','Hotels Offers'));
                  }

                  else if(gridname=="Health And Beauty")
                  {

                    Get.to(() =>OffersList(gridname,'name','searchIndex','Health And Beauty Offers'));

                  }

                  else if(gridname=="Electronics-Devices")
                  {

                    Get.to(() =>OffersList(gridname,'name','searchIndex','Electronics-Devices Offers'));

                  }


                  else if(gridname=="Baraka Mall" || gridname=="البركة مول")
                  {

                    FirebaseFirestore.instance.collection('Baraka Mall').snapshots().listen((event) {
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
                                            'Baraka Mall')));
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
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
                                            name:'Baraka Mall'
                                            ,
                                            count: 10)));
                          }

                          else if (offerscount == 11) {
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
                                            img11: element
                                                .data()['offers'][10],
                                            name:'Baraka Mall'
                                            ,
                                            count: 11)));
                          }

                          else if (offerscount == 12) {
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
                                            img11: element
                                                .data()['offers'][10],
                                            img12: element
                                                .data()['offers'][11],
                                            name:'Baraka Mall'
                                            ,
                                            count: 12)));
                          }

                          else if (offerscount == 13) {
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
                                            img11: element
                                                .data()['offers'][10],
                                            img12: element
                                                .data()['offers'][11],
                                            img13: element
                                                .data()['offers'][12],
                                            name:'Baraka Mall'
                                            ,
                                            count: 13)));
                          }

                          else if (offerscount == 14) {
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
                                            img11: element
                                                .data()['offers'][10],
                                            img12: element
                                                .data()['offers'][11],
                                            img13: element
                                                .data()['offers'][12],
                                            img14: element
                                                .data()['offers'][13],
                                            name:'Baraka Mall'
                                            ,
                                            count: 14)));
                          }


                        }

                        catch(error)
                        {
                          print(error);
                        }

                      });
                    });
                    
                    
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageBuiBarakaMall("assets/barakamalloffers.jpg",gridname)));

                  }



                },

                child: Text(gridname,style: TextStyle(color: Colors.white,fontSize: 12),),
              )
          )
        ],
      ),
    );
  }
}
