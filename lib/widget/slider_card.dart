import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod/model/nasa_apod_model.dart';

class SliderCard extends StatelessWidget {
  final NasaApodModel? data;

  const SliderCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey.withOpacity(0.5),
              child: CachedNetworkImage(
                imageUrl: data?.url ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
                errorWidget: (context, url, error) => Container(
                  color: Colors.white,
                ),
              )),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0x77000000),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x13000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data?.title != null ? data?.title.toString() ?? "" : "",
                  // style: AppStyle.titleText(
                  //     fontSize: FontSize.s16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
