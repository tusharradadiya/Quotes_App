import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:quotes/authorquotes/view/authorpage.dart';
import 'package:quotes/fixQuotes/view/fixQuotesPage.dart';
import 'package:quotes/userquotes/view/userQuotesPage.dart';
import 'package:quotes/utils/db_helper.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/homecontroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Homecontroller homecontroller = Get.put(Homecontroller());

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    homecontroller.dataList.value = await Db_helper.db_helper.readAllData();
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade500,
          title: Text(
            "Amazing Quotes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Get.back();
                        Get.toNamed('add');
                      },
                      leading: Icon(Icons.add),
                      title: Text("Add Category"),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Get.back();
                      },
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                    ),
                  ),
                ];
              },
            ),
            SizedBox(
              width: 4,
            ),
          ],
        ),
        backgroundColor: Color(0xffdedcdc),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 220,
                    child: Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            onPageChanged: (inde, reason) {
                              homecontroller.index.value = inde;
                            },
                            height: 220,
                            animateToClosest: true,
                            enlargeCenterPage: true,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            autoPlayInterval: Duration(seconds: 10),
                            viewportFraction: 1,
                            autoPlay: true,
                          ),
                          items:
                              homecontroller.imageList.asMap().entries.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 7),
                                  child: Image.network(
                                    "${homecontroller.imageList[i.key]}",
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: homecontroller.imageList
                                    .asMap()
                                    .entries
                                    .map(
                                      (i) => Container(
                                        margin: EdgeInsets.only(
                                            bottom: 20, left: 3, right: 3),
                                        height:
                                            homecontroller.index.value == i.key
                                                ? 13
                                                : 7,
                                        width:
                                            homecontroller.index.value == i.key
                                                ? 13
                                                : 7,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: homecontroller.index.value ==
                                                    i.key
                                                ? Colors.white
                                                : Colors.grey),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Container(
                    width: double.infinity,
                    height: 273,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " Most Popular",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1),
                          ),
                          SizedBox(height: 6),
                          Expanded(
                            child: Obx(
                              () => GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                13),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    homecontroller.changeQuotes.value = index;
                                    Get.to(
                                      FixQuotesPage(),
                                    );
                                  },
                                  child: quoteContainer(
                                      "${homecontroller.quotesList[index].name}",
                                      homecontroller.quotesList[index].color),
                                ),
                                itemCount: homecontroller.quotesList.length,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(
                          height: 15,
                        ),
                  Container(
                          width: double.infinity,
                          height: 180,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "  Quotes by Category",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1),
                                    ),
                                    Spacer(),
                                    Text(
                                      " Show All   ",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: 125,
                                  child: Obx(
                                    () => ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homecontroller.dataList.length,
                                      itemBuilder: (context, index) =>
                                          FocusedMenuHolder(
                                        animateMenuItems: true,
                                        menuWidth: 130,
                                        onPressed: () {},
                                        menuItems: <FocusedMenuItem>[
                                          FocusedMenuItem(
                                              title: Text("Share"),
                                              trailingIcon: Icon(Icons.share),
                                              onPressed: () {
                                                Share.share(
                                                    "${homecontroller.dataList[index]['quote']}");
                                              }),
                                          FocusedMenuItem(
                                              title: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.redAccent),
                                              ),
                                              trailingIcon: Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                              onPressed: () {
                                                Db_helper.db_helper.deletedata(
                                                    id: homecontroller
                                                        .dataList[index]['id']);
                                                getdata();
                                              }),
                                        ],
                                        child: InkWell(
                                          onTap: () {
                                            homecontroller.changeQuotes.value =
                                                index;
                                            Get.to(UserQuotesPage());
                                          },
                                          child: Container(
                                            width: 210,
                                            margin: EdgeInsets.only(
                                                right: 5, left: 7),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${homecontroller.dataList[index]['cat']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 21,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                index%7==0?Colors.pink.shade600:index%5==0?Colors.blue.shade600:index%3==0?Colors.green.shade600:index%2==0?Colors.purple.shade600:Colors.amber.shade600,
                                                index%7==0?Colors.pink.shade100:index%5==0?Colors.blue.shade100:index%3==0?Colors.green.shade100:index%2==0?Colors.purple.shade100:Colors.amber.shade100,
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 273,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " Quotes by Author",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1),
                          ),
                          SizedBox(height: 6),
                          Expanded(
                            child: Obx(
                              () => GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                13),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    homecontroller.changeQuotes.value = index;
                                    Get.to(
                                      AuthorPage(),
                                    );
                                  },
                                  child: quoteContainer(
                                      "${homecontroller.authorquotesList[index].name}",
                                      homecontroller
                                          .authorquotesList[index].color),
                                ),
                                itemCount:
                                    homecontroller.authorquotesList.length,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quoteContainer(String name, color) {
    return Container(
      height: 110,
      alignment: Alignment.center,
      child: Text(
        "$name",
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
