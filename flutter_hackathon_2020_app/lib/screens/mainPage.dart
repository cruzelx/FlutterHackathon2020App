import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon_2020_app/screens/createEventScreen.dart';
import 'package:flutter_hackathon_2020_app/screens/eventScreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _page = 0;
  bool _isSelected = false;
  Color _navIconsColor = Colors.white.withOpacity(0.9);
  GlobalKey _bottomNavigationKey = GlobalKey();

  // Widgets

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff0f0f0),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: _page == 0 ? 38 : 30, color: _navIconsColor),
            Icon(Icons.list, size: _page == 1 ? 38 : 30, color: _navIconsColor),
            Icon(Icons.add, size: _page == 2 ? 38 : 30, color: _navIconsColor),
            Icon(Icons.call_split,
                size: _page == 3 ? 38 : 30, color: _navIconsColor),
            Icon(Icons.perm_identity,
                size: _page == 4 ? 38 : 30, color: _navIconsColor),
          ],
          color: Colors.deepPurpleAccent,
          buttonBackgroundColor: Colors.redAccent,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 275),
          onTap: (index) {
            setState(() {
              _page = index;
              switch (_page) {
                case 0:
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (BuildContext context) {
                    return LandingPage();
                  }));
                  break;
                case 2:
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (BuildContext context) {
                    return CreateEventScreen();
                  }));
                  break;
                default:
              }
            });
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
          title: Text("Home"),
          actions: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Container(
                width: 40.0,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      "https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/s960x960/61895741_1030831727110119_8215917200502947840_o.jpg?_nc_cat=102&_nc_sid=85a577&_nc_ohc=7IBS5n55dRMAX_hsWJv&_nc_ht=scontent.fktm7-1.fna&_nc_tp=7&oh=ec6c600fef683cef5c3f03fa6684426b&oe=5F1AC22B"),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text("Nearby Events",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                SizedBox(height: 15.0),
                CarouselSlider.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (BuildContext context) {
                          return EventScreen();
                        }));
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                              // width: MediaQuery.of(context).size.width * 0.80,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://keepnepal.org/wp-content/uploads/2017/02/25th-aniversary.jpg"),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: Text("$index")))),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.1),
                                      Colors.black.withOpacity(0.4),
                                      Colors.black.withOpacity(0.7)
                                    ])),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Center(
                                    child: Text("Bagmati Cleaning Programme",
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold)),
                                  )),

                                  // Divider(color: Colors.white,),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.group_add,
                                          color: Colors.white.withOpacity(0.9)),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "Be a helping hand",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                          DateFormat("yMMMd")
                                              .format(DateTime.now())
                                              .toString(),
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 12.0,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(height: 20.0),
                Text("Popular Events",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                SizedBox(height: 15.0),
                Container(
                  height: 400.0,
                  child: AnimationLimiter(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                  verticalOffset: 100.0,
                                  child: ScaleAnimation(
                                      child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          CupertinoPageRoute(
                                              builder: (BuildContext context) {
                                        return EventScreen();
                                      }));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Container(
                                        height: 150.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.white),
                                        child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        height: 50.0,
                                                        width: 50.0,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                Image.network(
                                                              "https://www.paperstreet.com/blog/wp-content/uploads/2017/07/spaceapegames_img-1-compressor.jpg",
                                                              fit: BoxFit.cover,
                                                            ))),
                                                    SizedBox(width: 8.0),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                              "Bagmati Cleaning Programme",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(height: 5.0),
                                                          Text(
                                                            new DateFormat(
                                                                    'yMMMMd')
                                                                .format(
                                                                    new DateTime
                                                                        .now())
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13.0),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Container(
                                                  height: 35.0,
                                                  child: Center(
                                                    child: Text(
                                                      "Some description about the programme. Some description about the programme. ",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Divider(),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.group_add),
                                                    SizedBox(width: 8.0),
                                                    Text("Join the team",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ))));
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
