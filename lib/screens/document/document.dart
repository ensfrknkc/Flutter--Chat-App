import 'package:flutter/material.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class DocumentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        backgroundColor: UniversalVeriables.appBarColor,
      ),
      backgroundColor: UniversalVeriables.bg,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Center(
                child: Expanded(
                  child: Padding(
                    padding: context.paddingAllLow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: context.dynamicHeight(0.001)),
                        Text(
                          'KARABÜK ÜNİVERSİTESİ ÖN LİSANS-LİSANS ULUSLARARASI ÖĞRENCİLERİN BAŞVURU, KABUL VE KAYIT YÖNERGESİ',
                          style: TextStyle(
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(2.5),
                            color: UniversalVeriables.appBarColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: context.dynamicHeight(0.1)),
                        SizedBox(
                          child: Text(
                            'Gerekli İşlem Adımları:',
                            style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              color: UniversalVeriables.greyColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: context.dynamicHeight(0.1)),
                        SizedBox(
                          child: ListTile(
                            leading: Icon(
                              Icons.arrow_circle_down,
                              color: UniversalVeriables.greyColor,
                              size: 18,
                            ),
                            title: Text(
                              'Başvuru Koşulları' +
                                  "\n" +
                                  'Kontenjanların Belirlenmesi' +
                                  "\n" +
                                  'Başvuruların Değerlendirilmesi' +
                                  "\n" +
                                  'KBU-ULOS' +
                                  "\n" +
                                  'Yerleştirme' +
                                  "\n" +
                                  'Katkı Payı/Öğrenim Ücreti' +
                                  "\n" +
                                  'Öğrenim Vizesi' +
                                  "\n" +
                                  'Kayıt Evrakları' +
                                  "\n" +
                                  'Genel Sağlık Sigortası ',
                              style: TextStyle(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2),
                                color: UniversalVeriables.greyColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(height: context.dynamicHeight(0.1)),
                        SizedBox(
                          child: Center(
                            child: RaisedButton(
                              color: UniversalVeriables.buttonColor,
                              elevation: 10,
                              child: Text(
                                "Ayrıntıları Görmek için Tıklayınız",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.75),
                                ),
                              ),
                              onPressed: () => _launchURL(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _launchURL() async {
    const url = 'https://www.karabuk.edu.tr/belgeler/ybu_yonergeturkce.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
