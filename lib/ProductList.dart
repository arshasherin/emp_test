import 'dart:developer';

import 'package:emp_test/Model/ProductModel.dart';
import 'package:emp_test/ProductDetail.dart';
import 'package:emp_test/ViewModel/CommonViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class EmployeList extends StatefulWidget {
  const EmployeList({super.key});

  @override
  State<EmployeList> createState() => _EmployeListState();
}

class _EmployeListState extends State<EmployeList> {
  late ProductData main;
  late List<Product> productlistdata = [];
  // late CommonViewModel vm;
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CommonViewModel>(context);
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductDetails()));
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Product List",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              backgroundColor: Colors.red.shade900,
            ),
            body: SingleChildScrollView(
              child: FutureBuilder(
                  future: vm.getproduct(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        {
                          main = vm.products1['WebService'];
                          productlistdata = main.products;
                          log("vm===" + productlistdata.length.toString());
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              // physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: productlistdata.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.blueGrey.shade100,
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            productlistdata[index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Container(

                                              // padding:
                                              //     EdgeInsets.fromLTRB(05, 05, 05, 0),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                              child: CarouselSlider.builder(
                                                unlimitedMode: true,
                                                viewportFraction: 1,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                scrollPhysics:
                                                    const BouncingScrollPhysics(),
                                                enableAutoSlider: true,
                                                autoSliderTransitionCurve:
                                                    Curves.decelerate,
                                                autoSliderDelay:
                                                    const Duration(seconds: 5),
                                                autoSliderTransitionTime:
                                                    const Duration(
                                                        milliseconds: 1000),
                                                itemCount:
                                                    productlistdata[index]
                                                        .images
                                                        .length,
                                                slideBuilder: (index2) {
                                                  // final image =
                                                  //     productlistdata[index].images;
                                                  // log("message==" +
                                                  //     productlistdata[index]
                                                  //         .images[index2]);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            35.0),
                                                    child: ListView(
                                                      children: <Widget>[
                                                        for (var item
                                                            in productlistdata[
                                                                    index]
                                                                .images)
                                                          Image.network(item),

                                                        //  child: NetworkImage(
                                                        //           item[index],
                                                        //         ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )),
                                          Center(
                                              child: Text(
                                            productlistdata[index].description,
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      default:
                        return Center(child: CircularProgressIndicator());
                    }
                  }),
            )));
  }
}
