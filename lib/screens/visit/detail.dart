import 'package:flutter/material.dart';
import 'package:getflutter/components/rating/gf_rating.dart';
import 'package:kbu_app/screens/visit/data.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class DetailPage extends StatefulWidget {
  final VisitInfo visitInfo;

  const DetailPage({Key key, this.visitInfo}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController controller = new TextEditingController();
  String result = "";
  double _rating = 1;
  double count = 1;

  _Post() {
    Text(
      result,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: context.paddingAllLow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: context.dynamicHeight(0.1),
                          ),
                          Text(
                            widget.visitInfo.name,
                            style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(5),
                              color: UniversalVeriables.appBarColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Divider(color: Colors.grey),
                          SizedBox(height: context.dynamicHeight(0.1)),
                          Text(
                            widget.visitInfo.description ?? '',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                              color: UniversalVeriables.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: context.dynamicHeight(0.1)),
                          Divider(color: Colors.grey),
                          Text(
                            "Adres: " + widget.visitInfo.address ?? '',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              color: UniversalVeriables.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: context.dynamicHeight(0.1),
                          ),
                          Divider(color: Colors.grey),
                        ],
                      ),
                    ),
                    Padding(
                      padding: context.paddingAllLow,
                    ),
                    Container(
                      height: context.dynamicHeight(0.5),
                      padding: context.paddingAllLow,
                      child: ListView.builder(
                          itemCount: widget.visitInfo.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    widget.visitInfo.images[index],
                                    fit: BoxFit.cover,
                                  )),
                            );
                          }),
                    ),
                    Divider(
                        color: Colors.grey,
                        height: context.dynamicHeight(0.1),
                        indent: 35,
                        endIndent: 35),
                    SizedBox(
                      height: context.dynamicHeight(0.1),
                    ),
                    Container(
                      margin: context.marginAllLow,
                      height: context.dynamicHeight(0.1),
                      width: context.dynamicWidth(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 3.0)),
                      child: TextField(
                          style: TextStyle(color: UniversalVeriables.greyColor),
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: UniversalVeriables.greyColor),
                            hintText: "Yorum ekle",
                          ),
                          onSubmitted: (String str) {
                            setState(() {
                              result = result + "\n" + str;
                            });
                            controller.text = "";
                          },
                          controller: controller),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.01),
                    ),
                    Padding(
                      padding: context.paddingAllLow,
                      child: SizedBox(
                        child: RaisedButton(
                          color: UniversalVeriables.appBarColor,
                          elevation: 10,
                          child: Text(
                            "Yorum Gönder",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                            ),
                          ),
                          onPressed: () => _Post,
                        ),
                      ),
                    ),
                    SizedBox(height: context.dynamicHeight(0.01)),
                    SizedBox(
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
                    SizedBox(height: context.dynamicHeight(0.01)),
                    Padding(
                      padding: context.paddingAllLow,
                      child: SizedBox(
                        child: RaisedButton(
                          color: UniversalVeriables.appBarColor,
                          onPressed: () {
                            setState(() {
                              _rating = count++;
                            });
                          },
                          child: Text(
                            "Puan Ver",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
