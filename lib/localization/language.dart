class Language{
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.languageCode, this.flag);

  static List<Language> languageList(){
    return <Language>[
      Language(1, "English", "en",'🇺🇸'),
      Language(2, "Turkish", "tr",'🇹🇷'),
      Language(3, "Arabic", "ar",'🇸🇦'),
      //Language(2, "Arabic", "ar",'🇸🇦')
    ];
  }

}