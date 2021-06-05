class VisitInfo {
  final int position;
  final String name;
  final String iconImage;
  final String address;
  final String description;
  final List<String> images;

  VisitInfo(
      this.position, {
        this.name,
        this.iconImage,
        this.address,
        this.description,
        this.images,
      });
}

List<VisitInfo> visits = [
  VisitInfo(
    1,
    name: 'Şeker Kanyonu',
    iconImage: 'image/seker.png',
    description:
    "Karabük-Yenice yolu üzerinde bulunan Şeker Kanyonu, birçok doğa sporuna elverişli bir alandır. Kanyon yüksekliği 100 metreden başlayıp 250 metreye kadar yükselmektedir.",
    images: [
      'https://www.gezihocasi.com/wp-content/uploads/2020/05/karabuk-seker-kanyonu-konaklama.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuHBvfWYaEo4Dqpzxny5Yw_7AiWWtTka3bJg&usqp=CAU'
    ],
    address:
    "Şeker mahallesi, Şeker Kanyonu Mesire alanı, mesire alanı No: 11, 78700 Saray/Yenice/Karabük",
  ),
  VisitInfo(
    2,
    name: 'Kristal Cam Teras',
    iconImage: 'image/cam.png',
    description:
    "Karabük'ün turistik ilçelerinden biri olan hem doğal hem de tarihi güzellikleriyle ünlü Safranbolu'da Tokatlı Kanyonu üzerine yapılan Kristal Cam Teras Safranbolu, yerli ve yabancı turistlerin oldukça ilgisini çekmektedir.",
    images: [
      'https://media-cdn.tripadvisor.com/media/photo-s/04/64/c0/4c/kristal-teras.jpg',
      'https://i0.wp.com/gezikent.com/wp-content/uploads/2019/08/kristal-cam-teras-safranbolu.jpeg?ssl=1',
    ],
    address: "İncekaya-Safranbolu/Karabük",
  ),
  VisitInfo(
    3,
    name: 'Safranbolu Evleri',
    iconImage: 'image/ev.png',
    description:
    "Safranbolu evleri, Karabük iline bağlı Safranbolu ilçesinde, 18. ve 19. yüzyıl Osmanlı kent dokusunun günümüze kadar korunduğu bölgenin genel adıdır. UNESCO tarafından 17.12.1994'te Dünya Kültür Mirası listesine alınmıştır.",
    images: [
      'https://safranboluturizmdanismaburosu.ktb.gov.tr/Resim/156654,dsc0108jpg.png?0',
      'https://www.tatilcity.net/wp-content/uploads/2019/12/Tarihi-Safranbolu-Evleri-1-scaled-e1576242458715.jpg',
    ],
    address: "Atatürk, 78600 Safranbolu/Karabük",
  ),
  VisitInfo(
    4,
    name: 'Safranbolu Eski Çarşı',
    iconImage: 'image/arasta.png',
    description:
    "Safranbolu'da yer alan ve birbirine bitişik 48 ahşap dükkandan oluşan Safranbolu Yemeniciler Çarşısı Arastası, bölgenin tarihi yerlerinin başında gelmektedir. Çarşının bu düzeni ise Osmanlı dönemine kadar uzanmaktadır.",
    images: [
      'https://www.otelcenneti.com/uploads/blog/safranbolu-yemeniciler-carsisi-arastasi.jpg',
      'https://plusfly.com/wp-content/uploads/2017/11/safranbolu-yemeniciler-carsisi-arastasi.jpg',
    ],
    address: "Çeşme, Arasta Arkası Sk., 78600 Safranbolu/Karabük",
  ),
];
