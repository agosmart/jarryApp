import 'package:flutter/material.dart';
import 'package:jarryApp/screens/cart.items/cart.items.page.dart';
import 'package:jarryApp/screens/home/home.page.dart';
import 'package:jarryApp/screens/landing/landing_page.dart';
import 'package:jarryApp/screens/location/location.page.dart';
import 'package:jarryApp/screens/map/map.page.dart';
import 'package:jarryApp/screens/order/order.page.dart';
import 'package:jarryApp/screens/products/product.details.page.dart';
import 'package:jarryApp/screens/products/products.page.dart';
import 'package:jarryApp/screens/terms.conditions/cgv.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {

      //-- Home Page
      case "/homePage":
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      //-- Landing Page
      case "/landing":
        return MaterialPageRoute(
          builder: (context) => LandingPage(),
        );
      //-- Product Page
      case "/productsPage":
        return MaterialPageRoute(
          builder: (context) => ProductsPage(),
        );

      //-- Product Details Page
      case "/productDetailsPage":
        return MaterialPageRoute(
          builder: (context) => ProductDetailsPage(),
        );
      //-- Product cart Items Page
      case "/cartItemsPage":
        return MaterialPageRoute(
          builder: (context) => CartItemsPage(),
        );
      //--- Conditions Page
      case "/cgvPage":
        return MaterialPageRoute(
          builder: (context) => CGVPage(),
          fullscreenDialog: true,
        );
      //--- Location Page
      case "/locationPage":
        return MaterialPageRoute(
          builder: (context) => LocationPage(),
        );
      //--- Map Page
      case "/mapPage":
        return MaterialPageRoute(
          builder: (context) => MapPage(),
        );
      //------------------------------
      case "/orderPage":
        return MaterialPageRoute(
          builder: (context) => OrderPage(),
        );
      //------------------------------

      default:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
    }
  }
}
/*
import 'package:aydak/screens/active-page/activePage.dart';
import 'package:aydak/screens/home/homeScreen.dart';
import 'package:aydak/screens/landing-page/landing.dart';
import 'package:aydak/screens/login/login.dart';
import 'package:aydak/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  loggedActived,
  loggedNotActived,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _status;

  Future<void> _setStatus(_status) async {
    final SharedPreferences prefs = await _prefs;
    final String status =
        prefs.getString('status') == null ? 'UNKNOWN' : _status;

    setState(() {
      _status = prefs.setString('status', status).then((bool success) {
        print('STATUS :::: $status');
        return status;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _status = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('status') ?? 'unknown');
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //get the state, check current User, set AuthStatus based on state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    print(_returnString);

    if (_returnString == "success") {
      print('actived:::${_currentUser.getCurrentUser.actived}');
      if (_currentUser.getCurrentUser.actived != 0) {
        setState(() {
          _authStatus = AuthStatus.loggedActived;
          _setStatus('loggedActived');
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.loggedNotActived;
          _setStatus('loggedNotActived');
        });
        setState(() {
          _authStatus = AuthStatus.loggedNotActived;
          _setStatus('loggedNotActived');
        });
      }
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
        _setStatus('notLoggedIn');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = LandingPage();
        break;
      case AuthStatus.notLoggedIn:
        retVal = Login();
        break;
      case AuthStatus.loggedNotActived:
        print('logged not actived screen!!!!');
        retVal = ActivePage();
        break;
      case AuthStatus.loggedActived:
        print('logged  actived screen ????');
        retVal = HomeScreen();
        // retVal = ChangeNotifierProvider(
        //   create: (context) => CurrentGroup(),
        //   child: HomeScreen(),
        // );
        break;
      default:
    }
    return retVal;
  }
}
*/
