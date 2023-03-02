import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/home/controller/homecontroller.dart';
import 'package:share_plus/share_plus.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
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
                "https://i.pinimg.com/originals/d8/58/12/d858121124f38e2b7bfd08425ef3ba81.jpg",
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
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            "\" ${homecontroller.authorquotesList[homecontroller.changeQuotes.value].quote} \"",
                            style: homecontroller.changefonts.value == 0
                                ? GoogleFonts.satisfy(
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
                                color: Colors.white)
                                : GoogleFonts.ptMono(

                                fontSize: 27,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 30),
                        Obx(
                          () => Text(
                            "- ${homecontroller.authorquotesList[homecontroller.changeQuotes.value].name}",
                              style: homecontroller.changefonts.value == 0
                                  ? GoogleFonts.satisfy(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white)
                                  : GoogleFonts.ptMono(

                                  fontSize: 22,
                                  color: Colors.white),
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
                            homecontroller.changefonts.value = 0;

                            if (homecontroller.changeQuotes.value > 0) {
                              homecontroller.changeQuotes.value =
                                  homecontroller.changeQuotes.value - 1;
                            }
                          },
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                        ),
                        Obx(
                              () =>  IconButton(
                            onPressed: () {
                              if (homecontroller.changefonts.value == 0) {
                                homecontroller.changefonts.value = 1;
                              } else {
                                homecontroller.changefonts.value = 0;
                              }
                              ;
                            },
                            icon: Icon(Icons.format_color_text_outlined),
                            color: homecontroller.changefonts.value == 0?Colors.white:Colors.white30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: homecontroller
                                    .authorquotesList[
                                        homecontroller.changeQuotes.value]
                                    .quote,
                              ),
                            );
                          },
                          icon: Icon(Icons.copy),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            Share.share(
                                "${homecontroller.authorquotesList[homecontroller.changeQuotes.value].quote}");
                            //Share.shareFiles(['/image.jpg'], text: 'Great picture');
                          },
                          icon: Icon(Icons.share),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            if (homecontroller.changeQuotes.value < 3) {
                              homecontroller.changeQuotes.value =
                                  homecontroller.changeQuotes.value + 1;
                            }
                            homecontroller.changefonts.value = 0;
                          },
                          icon: Icon(Icons.arrow_forward_ios),
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
