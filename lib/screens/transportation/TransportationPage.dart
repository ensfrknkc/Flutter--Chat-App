import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class TransportationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(getTranslated(context, "Communication")), //ULAŞIM OLMASI LAZIM
        backgroundColor: UniversalVeriables.appBarColor,
        centerTitle: true,
      ),
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  color: UniversalVeriables.buttonColor,
                  child: Text(
                    "İSTANBUL",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _istanbulRotation(context)));
                  }),
              RaisedButton(
                  color: UniversalVeriables.buttonColor,
                  child: Text(
                    "ANKARA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _ankaraRotation(context)));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _istanbulRotation(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      appBar: AppBar(
        title: Text(getTranslated(context, "Directions")),
        backgroundColor: UniversalVeriables.appBarColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Expanded(
            child: Padding(
              padding: context.paddingAllLow,
              child: Column(
                children: [
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.airplanemode_active,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "Başlangıç Noktası: İstanbul Havalimanı" +
                            "\n" +
                            "Varış Noktası: Karabük Üniversitesi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: UniversalVeriables.appBarColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(2),
                        ),
                      ),
                      subtitle: Text(
                        "Lütfen aşağıdaki adımları takip ediniz",
                        style: TextStyle(
                          color: UniversalVeriables.greyColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.bus_alert,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "H-3 Metrobüsünü bekle",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                      subtitle: Text("Gümrük / Eminönü yönü",
                          style: TextStyle(
                            color: UniversalVeriables.greyColor,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.5),
                          )),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_walk,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Masko 1/ Topkapı-Bahçeşehir Yönünde in",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                      subtitle: Text(
                        " Masko 1/Topkapı yönünde 1 dk boyunca yürü",
                        style: TextStyle(
                          color: UniversalVeriables.greyColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.bus_alert,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "760 numaralı metrobüsü bekle",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                      subtitle: Text(
                        "Esenler Otogar son durakta in",
                        style: TextStyle(
                          color: UniversalVeriables.greyColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_bus,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "Karabük otobüsünün olduğu peronlara çık",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_walk_sharp,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Karabük otogarında indikten sonra otogarın ön cephesine yürü",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_bus,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "100.yıl yazan herhangi bir araca binebilirsin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.business,
                        color: Colors.brown,
                      ),
                      title: Text(
                        "Son durak: Karabük Üniversitesine ulaştınız",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ankaraRotation(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      appBar: AppBar(
        title: Text(getTranslated(context, "Directions")),
        backgroundColor: UniversalVeriables.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Expanded(
            child: Padding(
              padding: context.paddingAllLow,
              child: Column(
                children: [
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.airplanemode_active,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "Başlangıç Noktası: Esenboğa Havalimanı" +
                            "\n" +
                            "Varış Noktası: Karabük Üniversitesi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                      subtitle: Text(
                        "Lütfen aşağıdaki adımları takip ediniz",
                        style: TextStyle(
                          color: UniversalVeriables.greyColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_walk,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Havalimanı - Dış Hatlar yönünde sola doğru dönün",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.bus_alert,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "442-K numaralı Kızılay(Güven Park) otobüsünü bekleyin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                      subtitle: Text(
                        "10 durak boyunca yolculuğa devam edin. Kızılay Güvenpark durağında inin",
                        style: TextStyle(
                          color: UniversalVeriables.greyColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_walk,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Kızılay Güvenpark girişinden girin, 1 dk boyunca yürüyün",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                      subtitle: Text(
                        "Sola doğru dönün Milli Müdafaa Caddesi boyunca",
                        style: TextStyle(
                          color: UniversalVeriables.greyColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.subway,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "Aşti metrosunu bekleyin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                      subtitle: Text(
                        "7 durak boyunca gidin. Son durak Aşti de inin",
                        style: TextStyle(
                          color: UniversalVeriables.greyColor,
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_bus,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "Karabük otobüsünün olduğu peronlara çıkın",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_walk_sharp,
                        color: Colors.green,
                      ),
                      title: Text(
                        "Karabük otogarında indikten sonra otogarın ön girişine doğru yürüyün",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.directions_bus,
                        color: UniversalVeriables.customDrawerColor,
                      ),
                      title: Text(
                        "100.yıl yazan herhangi bir araca binebilirsin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: context.marginAllLow,
                    padding: context.paddingAllLow,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: UniversalVeriables.customDrawerColor,
                            width: 5.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.business,
                        color: Colors.brown,
                      ),
                      title: Text(
                        "Son durak: Karabük Üniversitesine ulaştınız",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                            color: UniversalVeriables.appBarColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
