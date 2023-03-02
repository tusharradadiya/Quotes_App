import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/home/controller/homecontroller.dart';
import 'package:quotes/utils/db_helper.dart';
import 'package:share_plus/share_plus.dart';

class UserQuotesPage extends StatefulWidget {
  const UserQuotesPage({Key? key}) : super(key: key);

  @override
  State<UserQuotesPage> createState() => _UserQuotesPageState();
}

class _UserQuotesPageState extends State<UserQuotesPage> {
  Homecontroller homecontroller = Get.put(Homecontroller());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                "https://i.pinimg.com/originals/cb/60/b0/cb60b0994d251ee68c168e01d1f0409c.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black38,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            "\" ${homecontroller.dataList[homecontroller.changeQuotes.value]['quote']} \"",
                            style: homecontroller.changefonts.value == 0
                                ? GoogleFonts.satisfy(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                    color: Colors.white)
                                : GoogleFonts.ptMono(
                                    fontSize: 27, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 30),
                        Obx(
                          () => Text(
                            "- ${homecontroller.dataList[homecontroller.changeQuotes.value]['author']}",
                            style: homecontroller.changefonts.value == 0
                                ? GoogleFonts.satisfy(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white)
                                : GoogleFonts.ptMono(
                                    fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                        ),
                        Obx(
                          () => IconButton(
                            onPressed: () {
                              if (homecontroller.changefonts.value == 0) {
                                homecontroller.changefonts.value = 1;
                              } else {
                                homecontroller.changefonts.value = 0;
                              }
                            },
                            icon: Icon(Icons.format_color_text_outlined),
                            color: homecontroller.changefonts.value == 0
                                ? Colors.white
                                : Colors.white30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: homecontroller.dataList[
                                    homecontroller.changeQuotes.value]['quote'],
                              ),
                            );
                          },
                          icon: Icon(Icons.copy),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            Share.share(
                                "${homecontroller.dataList[homecontroller.changeQuotes.value]['quote']}");
                            //Share.shareFiles(['/image.jpg'], text: 'Great picture');
                          },
                          icon: Icon(Icons.share),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "",
                                content: Text("Are you Sure,You want to delete?"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      Db_helper.db_helper.deletedata(
                                          id: homecontroller.dataList[
                                              homecontroller
                                                  .changeQuotes.value]['id']);
                                      homecontroller.dataList.value = await Db_helper.db_helper.readAllData();

                                      Get.back();
                                      Get.back();
                                    },
                                    child: Text("delete"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ]);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
