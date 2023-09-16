import 'package:flutter/material.dart';
import 'package:jkbempoffers/fullimg.dart';



class GridImageList extends StatelessWidget {


  final int ? count;
  final String ? img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17,img18,img19,img20,img21,name;

  const GridImageList({Key ? key, this.count,this.name ,this.img1, this.img2, this.img3, this.img4, this.img5,this.img6,this.img7,this.img8,this.img9,this.img10,this.img11,this.img12,this.img13,this.img14,this.img15,this.img16,this.img17,this.img18,this.img19,this.img20,this.img21}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return SafeArea(
    child: Home(

    img1: img1,img2: img2,img3: img3,img4: img4,img5: img5,img6: img6,img7: img7,img8: img8,img9: img9,img10: img10,img11: img11,img12: img12,img13: img13,img14: img14,img15:img15,img16: img16,img17: img17,img18: img18,img19: img19,img20: img20,img21: img21,count: count,name: name),


    );

  }
}

class Home extends StatefulWidget {

  final int ? count;
  final String ? img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17,img18,img19,img20,img21,name;

  const Home({Key ? key, this.count, this.name,this.img1, this.img2, this.img3, this.img4, this.img5,this.img6,this.img7,this.img8,this.img9,this.img10,this.img11,this.img12,this.img13,this.img14,this.img15,this.img16,this.img17,this.img18,this.img19,this.img20,this.img21}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    var thelistsofimgs;

    if(widget.count==2)
    {
      thelistsofimgs = [widget.img1,widget.img2];
    }
    else if(widget.count==3)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3];

    }

    else if(widget.count==4)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4];

    }

    else if(widget.count==5)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5];

    }

    else if(widget.count==6)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6];

    }

    else if(widget.count==7)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7];

    }

    else if(widget.count==8)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8];

    }

    else if(widget.count==9)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9];

    }

    else if(widget.count==10)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10];

    }

    else if(widget.count==11)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11];

    }

    else if(widget.count==12)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12];

    }

    else if(widget.count==13)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13];

    }

    else if(widget.count==14)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14];

    }

    else if(widget.count==15)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14,widget.img15];

    }
    else if(widget.count==16)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14,widget.img15,widget.img16];

    }
    else if(widget.count==17)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14,widget.img15,widget.img16,widget.img17];

    }
    else if(widget.count==18)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14,widget.img15,widget.img16,widget.img17,widget.img18];

    }
    else if(widget.count==19)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14,widget.img15,widget.img16,widget.img17,widget.img18,widget.img19];

    }
    else if(widget.count==20)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14,widget.img15,widget.img16,widget.img17,widget.img18,widget.img19,widget.img20];

    }
    else if(widget.count==21)
    {
      thelistsofimgs = [widget.img1,widget.img2,widget.img3,widget.img4,widget.img5,widget.img6,widget.img7,widget.img8,widget.img9,widget.img10,widget.img11,widget.img12,widget.img13,widget.img14,widget.img15,widget.img16,widget.img17,widget.img18,widget.img19,widget.img20,widget.img21];

    }

    var myGridView = new GridView.builder(
      primary: true,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(2.0),
      itemCount: thelistsofimgs.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 20.0,
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(tag: thelistsofimgs[index],
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(thelistsofimgs[index]),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          onTap: () {

            Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageBui(thelistsofimgs[index],widget.name!)));

          },
        );
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue[900],
          title: new Text(widget.name!,style: TextStyle(color: Colors.white,fontSize: 15))
      ),
      body: myGridView,
    );
  }
}

