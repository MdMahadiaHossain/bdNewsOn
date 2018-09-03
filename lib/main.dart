import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    "/": (BuildContext cotext) => _NewsPaperList(),
    "/webView": (BuildContext context) => WbeRenderPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Roboto-Regular", accentColor: Colors.white),
      initialRoute: "/",
      routes: routes,
    );
  }
}

class _NewsPaperList extends StatelessWidget {
  final WidgetGroup widgetGroup = WidgetGroup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF2D9CDB),
        padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 57.0),
        child: ListView(
          children: <Widget>[]..addAll(widgetGroup._newsPapers(context)),
        ),
      ),
    );
  }
}

class WbeRenderPage extends StatefulWidget {
  final String newsPaperLink;
  final String newsPaperName;

  const WbeRenderPage({Key key, this.newsPaperLink, this.newsPaperName})
      : super(key: key);

  @override
  _WbeRenderPageState createState() => _WbeRenderPageState();
}

class _WbeRenderPageState extends State<WbeRenderPage> with SingleTickerProviderStateMixin {
  FlutterWebviewPlugin flutterWebviewPlugin;
 

  @override
  void initState() {
    flutterWebviewPlugin = FlutterWebviewPlugin();
   
    super.initState();
  }

  @override
  void dispose() {
    flutterWebviewPlugin.close();
    flutterWebviewPlugin.dispose();

    super.dispose();
  }

  int _bottomNavIconIndex = 0;


  double state= 0.0;

  @override
  Widget build(BuildContext context) {

    flutterWebviewPlugin.onStateChanged.listen((requestState){
      setState(() {
              if(requestState.type==WebViewState.shouldStart){
                state=3.4;
              }else if(requestState.type==WebViewState.startLoad){
                state=1.4;
              }else{
                state=1.0;
              }
            });
    });



    return Scaffold(
      body: Stack(
        children: <Widget>[
          
           WebviewScaffold(
            url: widget.newsPaperLink,
            withLocalStorage: true,
            withZoom: true,
            appBar: new AppBar(
              title: new Text(
                "${widget.newsPaperName}",
                style: TextStyle(fontFamily: "Roboto-Regular", fontSize: 16.0),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _bottomNavIconIndex,
              onTap: (index) {
                setState(() {
                  _bottomNavIconIndex = index;
                });

                switch (index) {
                  case 0:
                    flutterWebviewPlugin.goBack();
                    break;
                  case 1:
                    flutterWebviewPlugin.goForward();
                    break;
                  case 2:
                    {
                      flutterWebviewPlugin.close();
                      Navigator.of(context).pop();
                    }
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.keyboard_arrow_left),
                  title: Text("Previous"),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.keyboard_arrow_right),
                    title: Text("Next")),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                ),
              ],
            ),
          ),
          Positioned(
            top: 33.0,
            right: 30.0,
            child: state==1.4?CircularProgressIndicator():CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.check),
            ),
          )
         
        ],
      ),
    );
  }
}

class DataNewsPaper {
  final String url;
  final String iconLocation;
  final String newsPaperName;

  DataNewsPaper({this.url, this.iconLocation, this.newsPaperName});
}

class WidgetGroup {
  final List<DataNewsPaper> _newsPapersData = [
    DataNewsPaper(
        newsPaperName: "Prothom Alo",
        url: "https://www.prothomalo.com/",
        iconLocation: "assets/images/prothomalo.jpg"),
    DataNewsPaper(
        newsPaperName: "Ittefaq",
        url: "http://ittefaq.com.bd",
        iconLocation: "assets/images/ittefuck.png"),
    DataNewsPaper(
        newsPaperName: "Samakal",
        url: "http://samakal.com",
        iconLocation: "assets/images/samakal.png"),
    DataNewsPaper(
        newsPaperName: "Dainik Amader Shomoy",
        url: "http://dainikamadershomoy.com/",
        iconLocation: "assets/images/amadershomoy.png"),
    DataNewsPaper(
        newsPaperName: "Daily Nayadiganta",
        url: "http://www.dailynayadiganta.com/",
        iconLocation: "assets/images/nayadigonta.png"),
    DataNewsPaper(
        newsPaperName: "Kaler kantho",
        url: "http://www.kalerkantho.com/",
        iconLocation: "assets/images/kalerkontho.png"),
    DataNewsPaper(
        newsPaperName: "Jaijaidinbd",
        url: "http://www.jaijaidinbd.com/",
        iconLocation: "assets/images/jjdin_logo.gif"),
    DataNewsPaper(
        newsPaperName: "Bd-pratidin",
        url: "http://www.bd-pratidin.com/",
        iconLocation: "assets/images/bdprotidin.gif"),
    DataNewsPaper(
        newsPaperName: "Daily Inqilab",
        url: "https://www.dailyinqilab.com/",
        iconLocation: "assets/images/inkilab.png"),
    DataNewsPaper(
        newsPaperName: "Daily Sangram",
        url: "http://www.dailysangram.com/",
        iconLocation: "assets/images/samakal.png"),
    DataNewsPaper(
        newsPaperName: "Bhorer Kagoj",
        url: "http://www.bhorerkagoj.com/",
        iconLocation: "assets/images/Bhorer-Kagoj-logo-1.png"),
    DataNewsPaper(
        newsPaperName: "Daily Janakantha",
        url: "http://www.dailyjanakantha.com/",
        iconLocation: "assets/images/jonokontho.png"),
    DataNewsPaper(
        newsPaperName: "Jugantor",
        url: "https://www.jugantor.com/",
        iconLocation: "assets/images/jugnator.png"),
    DataNewsPaper(
        newsPaperName: "Bd-journal",
        url: "http://www.bd-journal.com/",
        iconLocation: "assets/images/bangladeshJounrnal.png"),
        DataNewsPaper(
        newsPaperName: "The Daily Star",
        url: "https://www.thedailystar.net/",
        iconLocation: "assets/images/thedailyStar.png"),
        DataNewsPaper(
        newsPaperName: "The Financial Express ",
        url: "http://thefinancialexpress.com.bd/",
        iconLocation: "assets/images/theFinanceEx.png"),
  ];

  Widget circleImage(String newtworkImageLink) {
    return Container(
      height: 48.0,
      width: 48.0,
      margin: EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(newtworkImageLink),
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  List<Widget> _newsPapers(BuildContext context) {
    return _newsPapersData.map((data) {
      return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: MaterialButton(
          highlightElevation: 7.0,
          padding: EdgeInsets.only(top: 9.0, bottom: 9.0),
          height: 6.6,
          color: Color(0xFFF2F2F2),
          elevation: 7.0,
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return WbeRenderPage(
                  newsPaperLink: data.url,
                  newsPaperName: data.newsPaperName,
                );
              })),
          child: Row(
            children: <Widget>[
              // you can not wrap Circular image's initial parent container which set the hight and width of the circular image widget
              circleImage(data.iconLocation),
              Expanded(
                flex: 2,
                  child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "${data.newsPaperName}",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto-Regular",
                    ),
                  ),
                ),
              ),
              Expanded(child: Icon(Icons.launch))
            ],
          ),
        ),
      );
    }).toList();
  }
}
