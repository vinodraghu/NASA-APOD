import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nasa_apod/model/nasa_apod_model.dart';
import 'package:nasa_apod/screens/image_slider_screen.dart';
import 'package:nasa_apod/viewmodel/app_model.dart';
import 'package:nasa_apod/widget/grid_item_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, AppModel appNotifier, child) {
      return LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text("NASA APOD"),
            actions: [
              Align(
                  alignment: Alignment.center,
                  child: Text(appNotifier.isDark ? "Dark Mode" : "Light Mode")),
              IconButton(
                  icon: Icon(appNotifier.isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny),
                  onPressed: () {
                    appNotifier.isDark
                        ? appNotifier.isDark = false
                        : appNotifier.isDark = true;
                  })
            ],
          ),
          body: appNotifier.jsonResponseData.isNotEmpty
              ? Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: StaggeredGridView.countBuilder(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    key: ObjectKey(constraints.maxWidth > 1025.0 ? 18 : 10),
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: constraints.maxWidth > 1025.0 ? 18 : 10,
                    itemCount: appNotifier.jsonResponseData.length,
                    staggeredTileBuilder: (index) => StaggeredTile.count(
                        constraints.maxWidth > 1025.0 ? 3 : 5,
                        constraints.maxWidth > 1025.0 ? 3 : 5),
                    itemBuilder: (context, index) {
                      NasaApodModel? data = appNotifier.jsonResponseData[index];
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageSliderScreen(
                                        jsonResponseData:
                                            appNotifier.jsonResponseData,
                                        index: index,
                                      )),
                            ).then((value) {});
                          },
                          child: GridItemCard(
                            data: data,
                          ));
                    },
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
        );
      });
    });
  }
}
