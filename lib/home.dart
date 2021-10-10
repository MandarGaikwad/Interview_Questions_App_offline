import 'package:carousel_pro/carousel_pro.dart';
import 'package:final_interview_app/detail.dart';
import 'package:final_interview_app/textStyle.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mark922_flutter_lottie/mark922_flutter_lottie.dart';
import 'package:residemenu/residemenu.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//This class helps to create links, that we are using in about dialog.
class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                urlLauncher.launch(url);
              });
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  MenuController _menuController;
  var data;

  /// to build a reside menu drawer build by library
  Widget buildItem(String msg, VoidCallback method) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
          title: msg,
          icon: const Icon(Icons.home, color: Colors.grey),
          right: const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
        onTap: () => method,
      ),
    );
  }

  _sharer() {
    Share.share(" INTERVIEWO - Test your knowledge.\n" +
        "The app that will make you an amazing candidate for any job.\n"
            "Are you ready?\n"
            "Download it now\n"
            "demo.www.interviewo.com.mandar");
  }

  _launchgmail() async {
    const url =
        'mailto:mandargaikwad98@gmail.com?subject=Feedback&body=Feedback for Interviewo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///shows the about dialog.
  showAbout(BuildContext context) {
    final TextStyle linkStyle =
        Theme.of(context).textTheme.body2.copyWith(color: Colors.blue);
    final TextStyle bodyStyle =
        new TextStyle(fontSize: 15.0, color: Colors.black);

    return showAboutDialog(
        context: context,
        applicationIcon: Center(
          child: Image(
            height: 150.0,
            width: 200.0,
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/background.jpg"),
          ),
        ),
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: new RichText(
                  textAlign: TextAlign.start,
                  text: new TextSpan(children: <TextSpan>[
                    new TextSpan(
                        style: bodyStyle,
                        text: 'Hello,  I am Mandar Gaikwad, we have published many apps in play store till now,' +
                            ' If you have any business/organisation/ideas and you want to build an app for it ,then  feel free to contact . I will build the app in the lowest price possible, and if your organisation is a non profit organisation then I will even do it for free. '
                                "\n\n"),
                    new TextSpan(
                      style: bodyStyle,
                      text: 'for Business Queries:' + "\n\n",
                    ),
                    new _LinkTextSpan(
                        style: linkStyle,
                        text: 'Send an E-mail' + "\n\n",
                        url:
                            'mailto:mandargaikwad98@gmail.com?subject=InterViewo&body=For business queries'),
                  ]))),
        ]);
  }

  ///Lis-t of interview questions.
  Widget getListItems(
      HexColor color1, HexColor color2, IconData icon, String title) {
    return GestureDetector(
        key: title == 'Behavioural Based' ? Key('item') : null,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              gradient: LinearGradient(
                colors: [color1, color2],
              ),
              borderRadius: BorderRadius.circular(30)),
          height: 300.0,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                title,
                style: Style.headerstyle,
              )
            ],
          )),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Detail(
                    title: title,
                  )));
        });
  }

  ///creating a carousel using carousel pro library.
  final myCraousal = Carousel(
    dotSize: 5.0,
    dotIncreaseSize: 2.0,
    borderRadius: true,
    radius: Radius.circular(10.0),
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(seconds: 2),
    images: [
      AssetImage('assets/images/card1.png'),
      AssetImage('assets/images/card3.png'),
      AssetImage('assets/images/card4.png'),
      AssetImage('assets/images/card2.png'),
    ],
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    _menuController = new MenuController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Interviewo"),
        ),
        backgroundColor: Colors.white38,
        body: ListView(
          children: <Widget>[
            Container(
              key: Key('banner'),
              padding: EdgeInsets.only(bottom: 5.0),
              height: height / 2.5,
              child: myCraousal,
            ),
            getListItems(HexColor("#e65c00"), HexColor("#F9D423"), Icons.person,
                'Behavioural Based'),
            getListItems(HexColor("#1488CC"), HexColor("#2B32B2"), Icons.wc,
                'Communications Based'),
            getListItems(HexColor("#FFE000"), HexColor("#799F0C"),
                Icons.call_split, 'Opinion Based'),
            getListItems(HexColor("#ee0979"), HexColor("#ff6a00"),
                Icons.assessment, 'Performance Based'),
            getListItems(HexColor("#833ab4"), HexColor("#fd1d1d"),
                Icons.help_outline, 'Brainteasers'),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        //Init Floating Action Bubble
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            Bubble(
              title: "Suggestion",
              iconColor: Colors.white,
              bubbleColor: HexColor("#cc2b5e"),
              icon: Icons.question_answer,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _launchgmail();
                _animationController.reverse();
              },
            ),
            //Floating action menu item
            Bubble(
              title: "Share App",
              iconColor: Colors.white,
              bubbleColor: HexColor("#e65c00"),
              icon: Icons.share,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _sharer();
              },
            ),
            Bubble(
              title: "About",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.home,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                showAbout(context);
                _animationController.reverse();
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.blue,

          // Flaoting Action button Icon
          iconData: Icons.menu,
          backGroundColor: Colors.white,
        ));
  }
}
