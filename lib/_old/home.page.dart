import 'package:flutter/material.dart';
import 'package:jariapp/utils/jari_icons_v1.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: null,
        automaticallyImplyLeading: false,
        elevation: 6,
        // toolbarHeight: 60.0,
        // title: Text(
        //   "Jari App",
        //   style: TextStyle(color: Colors.grey[800], fontSize: 20),
        // ),

        centerTitle: true,
        title: Image.asset(
          'assets/images/logo-jari-only.png',
          //fit: BoxFit.scaleDown,
          height: 58.0,
        ),

        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                // Icons.shopping_basket,
                JariIcons.shopping_cart,
                size: 32.0,
                color: Colors.black,
              ))
        ],
      ),

      //-----------------
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                "Bienvenue sur Jari!",
                style: TextStyle(
                    fontFamily: 'Bariol',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Colors.blue,
                            Colors.blue.withOpacity(.7)
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Promo 1",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "135.00 DA (Pack de 6 bites)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++++++++++++
                  Expanded(
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Colors.pink,
                            Colors.red.withOpacity(.7)
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Promo 2",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "120.00 DA (Pack de  6 bites)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Jari Categories",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),

              //+++++++++++++++++++++++ LIST ++++++++++++++++++++++
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: SingleChildScrollView(
                    //++++
                    /*
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: Text(
                            "Activity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: Text(
                            "Activity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: Text(
                            "Activity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: Text(
                            "Activity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: Text(
                            "Activity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: Text(
                            "Activity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: Text(
                            "Activity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                      */

                    //++++
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
