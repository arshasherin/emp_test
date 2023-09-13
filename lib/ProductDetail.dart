import 'dart:developer';

import 'package:emp_test/Model/ProductModel.dart';
import 'package:emp_test/ViewModel/CommonViewModel.dart';
import 'package:emp_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late ProductData main2;
  late List<Product> productlistdetails = [];
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CommonViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Product details",
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
                      main2 = vm.products1['WebService'];
                      productlistdetails = main2.products;
                      log("vm===" + productlistdetails.length.toString());
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          // physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: productlistdetails.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.white70,
                                elevation: 5,
                                child: Column(
                                  children: [
                                    Text(
                                      productlistdetails[index].title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(productlistdetails[index]
                                            .rating
                                            .toString() +
                                        "rating"),
                                    Container(

                                        // padding:
                                        //     EdgeInsets.fromLTRB(05, 05, 05, 0),
                                        height:
                                            MediaQuery.of(context).size.height /
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
                                          itemCount: productlistdetails[index]
                                              .images
                                              .length,
                                          slideBuilder: (index2) {
                                            // final image =
                                            //     productlistdata[index].images;

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: ListView(
                                                children: <Widget>[
                                                  for (var item
                                                      in productlistdetails[
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
                                    Text(productlistdetails[index]
                                            .discountPercentage
                                            .toString() +
                                        "%"),
                                    Center(
                                        child: Text(productlistdetails[index]
                                            .description)),
                                    Text(
                                      "Price :" +
                                          productlistdetails[index]
                                              .price
                                              .toString(),
                                      selectionColor: Colors.amber,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text("Stock :" +
                                            productlistdetails[index]
                                                .stock
                                                .toString()),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Text("Brand :" +
                                            productlistdetails[index]
                                                .brand
                                                .toString())
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  default:
                    return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
