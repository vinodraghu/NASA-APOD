import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod/model/nasa_apod_model.dart';
import 'package:nasa_apod/widget/slider_card.dart';

class ImageSliderScreen extends StatelessWidget {
  final List<NasaApodModel>? jsonResponseData;
  final int? index;

  ImageSliderScreen({this.jsonResponseData, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              initialPage: index ?? 0,
              autoPlay: true,
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: jsonResponseData
                ?.map((item) => Container(
                      child: Center(
                          child: SliderCard(
                        data: item,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
