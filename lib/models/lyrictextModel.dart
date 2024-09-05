class LyricTextModel{
  // List? engtext;
  String? engtext;
  // List? hebtext;
  String? hebtext;
  String? titlename;
  String? titleSubname;
  String? chapterUrl;
  String? fileurl;
  String? RootUrl;
  String? AudioUrl;
  int? chaptersId;
  int? VersesId;

  LyricTextModel.fromJson(Map<String,dynamic> map){
    if(map.containsKey("text"))
    {
      engtext = map["text"];
    }
    if(map.containsKey("he"))
    {
      hebtext = map["he"];
    }
    if(map.containsKey("ref"))
    {
      titlename = map["ref"];
    }
  }

  List<LyricTextModel> lyricmodel = [];
  List<LyricTextModel> ChaptersList = [];

  LyricTextModel.fromJsonDetails(Map<String,dynamic> map){
    if(map.containsKey("Chapter")){
      List chapter = map["Chapter"];

      ChaptersList = chapter.map((e) => LyricTextModel.fromChapterList(e)).toList();
    }
    if(map.containsKey("Verses")){
      List verses = map["Verses"];

      lyricmodel = verses.map((e) =>  LyricTextModel.fromContentJson(e)).toList();
    }
  }

  LyricTextModel.fromChapterList(Map<String, dynamic> map) {

    if (map.containsKey("Name")) {
      titlename = map["Name"];
    }
    if (map.containsKey("SubTitle")) {
      titleSubname = map["SubTitle"];
    }

    if (map.containsKey("FileUrl")) {
      fileurl = map["FileUrl"];
    }
    if (map.containsKey("RootUrl")) {
      RootUrl = map["RootUrl"];
    }
    AudioUrl = "${RootUrl}"+"${fileurl}";
    print("AudioUrl:: " + AudioUrl.toString());
  }

  LyricTextModel.fromContentJson(Map<String, dynamic> map) {
    if (map.containsKey("VerseEnglish")) {
      engtext = map["VerseEnglish"];
    }
    if (map.containsKey("VerseHebrew")) {
      hebtext = map["VerseHebrew"];
    }
    if (map.containsKey("VersesId")) {
      VersesId = map["VersesId"];
    }
  }

  LyricTextModel.fromAudioJson(Map<String, dynamic> map) {
    if (map.containsKey("FileUrl")) {
      fileurl = map["FileUrl"];
    }
  }

}