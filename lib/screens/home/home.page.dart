import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jariapp/utils/colors.dart';
import 'package:jariapp/utils/jari_icons.dart';
// import 'package:jariapp/utils/_text.dart';

class HomePage extends StatelessWidget {
  double w;
  double h;
  @override
  Widget build(BuildContext context) {
    //++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    //+++++
    return Scaffold(
      // backgroundColor: Colors.grey[100],

      backgroundColor: AppColors.canvaColor1,

      //+++++
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
              child: IconButton(
                icon: Icon(
                  JariIcons.shopping_cart,
                  size: 32.0,
                  color: AppColors.icongray,
                ),
                onPressed: () {},

                // Icons.shopping_basket,
              ))
        ],
      ),

      //-----------------
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          //fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            //+++++ Boc Background Image +++++++++
            Positioned(
              top: -22,
              child: Container(
                width: w,
                height: h / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/pattern3.jpg',
                    ),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            //+++++ Bloc header+++++++++

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              //-----
              children: [
                Expanded(
                  child: Container(
                    //-----
                    // color: Colors.red.withOpacity(0.2),
                    //-----
                    padding: const EdgeInsets.only(top: 24.0),
                    height: h / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bienvenue',
                                style: TextStyle(
                                  fontFamily: 'Bariol',
                                  color: AppColors.darkblue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 36,
                                ),
                              ),
                              Text(
                                'sur jari!',
                                style: TextStyle(
                                  fontFamily: 'Bariol',
                                  color: AppColors.lightblue3,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 48,
                                ),
                              ),
                              //
                            ],
                          ),
                        ),
                        //-----
                        SizedBox(
                          width: 20.0,
                        ),

                        //++++++
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Image.asset('assets/images/logo-jari1.png'),
                        )),
                      ],
                    ),
                  ),
                ),

                //+++++ List ategory +++++++++

                DemoShader(
                  child: Container(
                    height: (h * 3 / 4) - 60.0,
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0, bottom: 80.0),
                    child: GridView.builder(
                      //shrinkWrap: true,
                      itemCount: 6,
                      padding: const EdgeInsets.all(10.0),
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        //----------

                        return GestureDetector(
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('Item $index'),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              child: new CupertinoAlertDialog(
                                title: new Column(
                                  children: <Widget>[
                                    new Text("GridView"),
                                    new Icon(
                                      Icons.favorite,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                content: new Text("Selected Item $index"),
                                actions: <Widget>[
                                  new FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: new Text("OK"))
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                //--------

                //------
              ],
              //-----

              //-----
            ),

            //+++++
          ],
        ),
      ),
    );
  }
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++

class DemoShader extends StatefulWidget {
  const DemoShader({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _DemoShaderState createState() => _DemoShaderState();
}

class _DemoShaderState extends State<DemoShader> {
  double _closeToTheEdge = 0.0;

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    final double t =
        (((metrics.extentInside - metrics.extentAfter) / metrics.extentInside)
            .clamp(0.0, 1.0));
    // if (t != _closeToTheEdge) {
    //   setState(() {
    //     _closeToTheEdge = t;
    //   });
    // }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: widget.child,
      ),
      shaderCallback: (Rect bounds) {
        return LinearGradient.lerp(
          const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFFFFFFF), Color(0x00FFFFFF)],
            stops: <double>[0.6, 0.9],
          ),
          const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
          ),
          _closeToTheEdge,
        ).createShader(bounds);
      },
    );
  }
}
