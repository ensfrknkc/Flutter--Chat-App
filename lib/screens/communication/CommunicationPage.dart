import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class CommunicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      appBar: AppBar(
        title: Text(getTranslated(context, "Communication")),
        backgroundColor: UniversalVeriables.appBarColor,
        centerTitle: true,
      ),
      body: Center(
        child: Expanded(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Card(
                  color: UniversalVeriables.bg,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("image/konum1.png"),
                      ),
                      SizedBox(
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            color: UniversalVeriables.buttonColor,
                            size: 35,
                          ),
                          title: Text(
                            getTranslated(context, "Address:"),
                            style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2.5),
                                fontWeight: FontWeight.bold,
                                color: UniversalVeriables.appBarColor),
                          ),
                          subtitle: Text(
                            'Karabük Üniversitesi, Kastamonu Yolu Demir Çelik Kampüsü, 78050  Merkez/Karabük',
                            style: TextStyle(
                              color: UniversalVeriables.greyColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.1),
                      ),
                      SizedBox(
                        child: ListTile(
                          leading: Icon(
                            Icons.phone_callback,
                            color: UniversalVeriables.buttonColor,
                            size: 35,
                          ),
                          title: Text(
                            getTranslated(context, "Communication"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: UniversalVeriables.appBarColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                            ),
                          ),
                          subtitle: Text(
                            '444 0 478',
                            style: TextStyle(
                              color: UniversalVeriables.greyColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.dynamicHeight(0.1),
                      ),
                      SizedBox(
                        child: ListTile(
                          leading: Icon(
                            Icons.web,
                            color: UniversalVeriables.buttonColor,
                            size: 35,
                          ),
                          onTap: () => _launchURL(),
                          title: Text(
                            'Web',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: UniversalVeriables.appBarColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                            ),
                          ),
                          subtitle: Text(
                            'www.karabuk.edu.tr',
                            style: TextStyle(
                              color: UniversalVeriables.greyColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  _launchURL() async {
    //FUTURE WİDGET YAPILMALI HATA VERMEMESİ İÇİN
    var url = 'https://www.karabuk.edu.tr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
