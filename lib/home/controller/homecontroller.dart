import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/home/model/homemodel.dart';

class Homecontroller extends GetxController {
  RxList imageList = [
    "https://wallpaperaccess.com/full/516297.jpg",
    "https://i.pinimg.com/originals/d7/6b/b6/d76bb6c103b22b5bfe2a004551b0de80.png",
    "https://images.hdqwalls.com/download/quotes-qhd-1680x1050.jpg",
    "https://wallpaperaccess.com/full/135452.jpg",
    "https://wallpaper.dog/large/897522.jpg",
    "https://images6.alphacoders.com/427/427408.jpg",
    "https://wallpaper.dog/large/5514701.jpg",
  ].obs;
  RxInt index = 0.obs;

  RxInt changeQuotes = 0.obs;
  RxInt changefonts = 0.obs;

  RxList<Homemodel> quotesList = <Homemodel>[
    Homemodel(
        color: Colors.pink,
        name: "Love Quotes",
        image:
            "https://w0.peakpx.com/wallpaper/211/515/HD-wallpaper-glowing-heart-heart-love-neon-thumbnail.jpg",
        quote: "I still fall in love with you every day."),
    Homemodel(
        color: Colors.blue,
        name: "Swami Vivekanand Quotes",
        image:
            "https://i.pinimg.com/564x/e8/e7/11/e8e711ed905e92f2b1e6fbaf1b95e69e.jpg",
        quote:
            "The world is the great gymnasium where we come to make ourselves strong."),
    Homemodel(
        color: Colors.amber.shade400,
        name: "Albert Einstein Quotes",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/3/3e/Einstein_1921_by_F_Schmutzer_-_restoration.jpg",
        quote:
            "The true sign of intelligence is not knowledge but imagination."),
    Homemodel(
        color: Colors.green.shade400,
        name: "Motivational Quotes",
        image:
            "https://www.wallpapertip.com/wmimgs/58-580761_airplane-in-sky-wallpaper-for-iphoneplus-airplane-wallpaper.jpg",
        quote:
            "Keep your face always toward the sunshine, and shadows will fall behind you."),
  ].obs;
  RxList<Homemodel> authorquotesList = <Homemodel>[
    Homemodel(
        color: Colors.green.shade400,
        name: "Oscar Wilde Quotes",
        image:
            "https://i.pinimg.com/474x/d9/9e/16/d99e16aaa8081744fbf71506c322bc75.jpg",
        quote:
            "To live is the rarest thing in the world. Most people exist, that is all."),
    Homemodel(
        color: Colors.brown.shade600,
        name: "Emily Dickinson Quotes",
        image:
            "https://i.pinimg.com/564x/e8/e7/11/e8e711ed905e92f2b1e6fbaf1b95e69e.jpg",
        quote: "That it will never come again is what makes life so sweet."),
    Homemodel(
        color: Colors.deepOrange.shade400,
        name: "George Eliot Quotes",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/3/3e/Einstein_1921_by_F_Schmutzer_-_restoration.jpg",
        quote: "It is never too late to be what you might have been."),
    Homemodel(
        color: Colors.purple.shade400,
        name: "Haruki Murakami Quotes",
        image:
            "https://www.wallpapertip.com/wmimgs/58-580761_airplane-in-sky-wallpaper-for-iphoneplus-airplane-wallpaper.jpg",
        quote: "Pain is inevitable. Suffering is optional."),
  ].obs;
  RxList dataList = [].obs;
}
