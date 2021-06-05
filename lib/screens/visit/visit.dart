import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:getflutter/components/rating/gf_rating.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/screens/visit/detail.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'data.dart';

class VisitPage extends StatefulWidget {
  @override
  _VisitPage createState() => _VisitPage();
}

class _VisitPage extends State<VisitPage> {
  double _rating = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "Places to visit")),
        backgroundColor: UniversalVeriables.appBarColor,
        centerTitle: true,
      ),
      backgroundColor: UniversalVeriables.bg,
      body: SingleChildScrollView(
        child: Expanded(
          child: Center(
            child: Container(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: context.dynamicHeight(1.5),
                      width: context.dynamicWidth(2),
                      padding: context.paddingAllLow,
                      child: Swiper(
                        itemCount: visits.length,
                        itemHeight: MediaQuery.of(context).size.height - 1 * 35,
                        itemWidth: MediaQuery.of(context).size.width - 1 * 28,
                        layout: SwiperLayout.STACK,
                        pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(),
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => DetailPage(
                                    visitInfo: visits[index],
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: context.dynamicHeight(0.6),
                                    ),
                                    Expanded(
                                      child: Card(
                                        elevation: 15,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(32),
                                        ),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: context.paddingAllLow,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height:
                                                context.dynamicHeight(0.2),
                                              ),
                                              Text(
                                                visits[index].name,
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize:
                                                  ResponsiveFlutter.of(
                                                      context)
                                                      .fontSize(2.25),
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                height:
                                                context.dynamicHeight(0.1),
                                              ),
                                              Text(
                                                'KARABÜK',
                                                style: TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontSize:
                                                  ResponsiveFlutter.of(
                                                      context)
                                                      .fontSize(2.25),
                                                  color: UniversalVeriables
                                                      .appBarColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                height:
                                                context.dynamicHeight(0.1),
                                              ),
                                              Container(
                                                child: GFRating(
                                                  size: 24.0,
                                                  color: Colors.yellow,
                                                  value: _rating,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _rating = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                context.dynamicHeight(0.1),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Daha Fazla Bilgi',
                                                    style: TextStyle(
                                                      fontFamily: 'Avenir',
                                                      fontSize:
                                                      ResponsiveFlutter.of(
                                                          context)
                                                          .fontSize(2),
                                                      color: UniversalVeriables
                                                          .greyColor,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: UniversalVeriables
                                                        .greyColor,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(150),
                                // ),
                                Padding(
                                  padding: context.paddingAllLow,
                                  child: Container(
                                    child: Image.asset(
                                      visits[index].iconImage,
                                      height: context.dynamicHeight(1),
                                      width: context.dynamicWidth(1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
