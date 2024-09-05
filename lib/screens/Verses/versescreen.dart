import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';
import 'package:audio_session/audio_session.dart';
import 'package:christian_lyrics/christian_lyrics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:tanachyomi/main.dart';
import 'package:tanachyomi/screens/more_library_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/current_userinfo.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:universal_io/io.dart';
import '../../apis/apihandler.dart';
import '../../apis/primitive_wrapper.dart';
import '../../models/chapter_verseses.dart';
import '../../models/completed_model.dart';
import '../../models/updateTimeModel.dart';
import '../../models/verses_chapter_model.dart';
import '../../models/verses_model.dart';
import '../control_buttons.dart';
import '../errorscreenpage.dart';
import '../no_internet_screen.dart';
import '../please_wait_loader.dart';
import 'audioutils.dart';

class VerseScreen extends StatefulWidget {
  String? subTitle;
  String? bookname;
  String? subChapter;
  int? chaptersId;
  int? audioId;
  String? url;
  bool? isCompleted;

  VerseScreen({
    Key? key,
    this.subTitle,
    this.bookname,
    this.subChapter,
    this.audioId,
    this.chaptersId,
    this.url,
    this.isCompleted,
  }) : super(key: key);

  @override
  _VerseScreenState createState() => _VerseScreenState();
}

class _VerseScreenState extends State<VerseScreen> with RouteAware {
  AudioPlayer _player = AudioPlayer();
  final christianLyrics = ChristianLyrics();
  double? volcontrol = 0.0;
  String? lang = "ah";
  String? bookversion = "";
  String? bookname;
  List<String> partition = <String>[];
  List<VersesModel> versesInChapter = [];
  ChapterModel? chapterModel;
  FontSize? font = FontSize(14);
  FontSize? hfont = FontSize(24);
  bool isCompleted = false;
  var lyricText =
      "1\r\n00:00:01,000 --> 00:00:29,950\r\n* * *\r\n\r\n2\r\n00:00:30,000 --> 00:00:33,350\r\nOh holy night!\r\n\r\n3\r\n00:00:33,400 --> 00:00:37,950\r\nThe stars are brightly shining\r\n\r\n4\r\n00:00:38,000 --> 00:00:46,950\r\nIt is the night of our dear savior's birth\r\n\r\n5\r\n00:00:47,000 --> 00:00:54,950\r\nLong lay the world in sin and error, pining\r\n\r\n6\r\n00:00:55,000 --> 00:01:02,950\r\n'Til He appear'd and the soul felt it's worth.\r\n\r\n7\r\n00:01:03,000 --> 00:01:03,950\r\n \r\n\r\n8\r\n00:01:04,000 --> 00:01:11,350\r\nA thrill of hope, the weary world rejoices\r\n\r\n9\r\n00:01:11,400 --> 00:01:19,950\r\nFor yonder breaks a new and glorious morn\r\n\r\n10\r\n00:01:20,000 --> 00:01:33,950\r\nFall on your knees! O hear the angel voices!\r\n\r\n11\r\n00:01:34,000 --> 00:01:34,950\r\n \r\n\r\n12\r\n00:01:35,000 --> 00:01:48,950\r\nO night divine, O night when Christ was born;\r\n\r\n13\r\n00:01:49,000 --> 00:02:06,950\r\nO night divine, O night, O night Divine.\r\n\r\n14\r\n00:02:07,000 --> 00:02:21,950\r\n \r\n\r\n15\r\n00:02:22,000 --> 00:02:30,950\r\nTruly He taught us to love one another;\r\n\r\n16\r\n00:02:31,000 --> 00:02:39,950\r\nHis law is love and His gospel is peace.\r\n\r\n17\r\n00:02:40,000 --> 00:02:41,950\r\nChains shall He break for the slave is our brother;\r\n\r\n18\r\n00:02:42,000 --> 00:02:56,950\r\nAnd in His name all oppression shall cease.\r\n\r\n19\r\n00:02:57,000 --> 00:03:04,950\r\nSweet hymns of joy in grateful chorus raise we,\r\n\r\n20\r\n00:03:05,000 --> 00:03:12,950\r\nLet all within us praise His holy name.\r\n\r\n21\r\n00:03:13,000 --> 00:03:28,950\r\nChrist is the Lord! O praise His Name forever,\r\n\r\n22\r\n00:03:29,000 --> 00:03:42,950\r\nHis power and glory evermore proclaim.\r\n\r\n23\r\n00:03:43,000 --> 00:03:53,000\r\nHis power and glory evermore proclaim.";

  String? getUrl;
  String bookName = "";
  ReceivePort _port = ReceivePort();
  int currentSelectedChapterId = 0;
  @override
  void initState() {
    currentSelectedChapterId = widget.chaptersId!;
    isCompleted = widget.isCompleted ?? false;
    internetConnection();
    try {
      bookName = chapterModel?.name ??
          "" +
              "(${chapterModel!.subTitle.toString() + " - " + chapterModel!.name})";
    } catch (e) {
      bookName =
          widget.subTitle!.isNotEmpty ? widget.subTitle! : widget.subChapter!;
    }

    _player.stop();

    super.initState();
    if (widget.isCompleted != true) startTimer();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
    _player.dispose();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    // _player.stop();

    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void didPush() {
    super.didPush();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  void didPop() {
    chaptersUpdateTime();

    super.didPop();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  bool? isdark;
  bool? isclick = false;
  bool isError = false;
  bool? isInternet;
  bool? isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Do you want to complete it'),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appColorPrimaryValue,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                      markChapterComplete();
                    },
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                ],
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.grey600,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  SlideRightRoute(
                      widget: MoreLibraryScreen(
                          chaptersId: currentSelectedChapterId)));
            },
            child: Icon(
              Icons.description,
              color: AppColor.appColorPrimaryValue,
              size: 26,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isclick = !isclick!;
              });
            },
            child: Container(
              height: 5,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
              child: Image.asset(
                "assets/images/shapeformat.png",
                width: 30,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
            child: Column(
              children: [
                Container(
                  color: AppColor.appColorSecondaryValue,
                  height: 4.0,
                ),
              ],
            ),
            preferredSize: Size.fromHeight(4.0)),
        title: Text(
          chapterModel != null
              ? (chapterModel?.name ??
                  "" +
                      "(${chapterModel!.subTitle.toString() + " - " + chapterModel!.name})")
              : widget.subTitle!.isNotEmpty
                  ? widget.subTitle!
                  : widget.subChapter!,
          //widget.subTitle!.isNotEmpty ? widget.subTitle! : widget.subChapter!,
          style: TextStyle(color: AppColor.black),
        ),
      ),
      body: layout(),
    );
  }

  Widget layout() {
    if (isInternet != null && isInternet!) {
      if (!isError) {
        if (isLoading != null && isLoading! == true) {
          callApi();
        } else if (isLoading != null && isLoading! == false) {
          return mainLayout();
        }
      } else {
        return const ErrorScreenPage();
      }
    } else if (isInternet != null && isInternet!) {
      return NoInternetScreen(
        onPressedRetyButton: () {
          internetConnection();
        },
      );
    }
    return PleaseWait();
  }

  callApi() async {
    if (isInternet == null) {
      isInternet = await internetConnection();
    }

    if (isInternet == true) {
      await getSharedPreferences();
      try {
        await callApiForParashaListVerses();
        await _init();
      } catch (e) {}
      isLoading = false;
      setState(() {});
    }
  }

  Future getSharedPreferences() async {}

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    isLoading = isInternet;
    if (mounted) {
      setState(() {});
    }
  }

  Widget mainLayout() {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              versesInChapter.isNotEmpty
                  ? Expanded(
                      flex: 12,
                      child: Container(
                        color: isdark == true
                            ? AppColor.mainbg
                            : AppColor.grey1.shade200,
                        child: StreamBuilder<PlayerState>(
                          stream: _player.playerStateStream,
                          initialData: _player.playerState,
                          builder: (context, snapshot) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Visibility(
                                          visible: isFastForwardVisible,
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.fast_rewind_rounded),
                                            onPressed: () async {
                                              callNextChapter("+");
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              chapterModel?.subTitle ??
                                                  "" +
                                                      "(${chapterModel!.subTitle.toString() + " - " + chapterModel!.name})",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: isdark == true
                                                      ? AppColor.white
                                                      : AppColor.black),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isFastRevindVisible,
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.fast_forward_rounded),
                                            onPressed: () async {
                                              callNextChapter("-");
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: AppColor.grey1,
                                    thickness: 0.5,
                                    endIndent: 10,
                                    indent: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      itemCount: versesInChapter.length,
                                      primary: false,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        if (lang == "ah") {
                                          return Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: Html(
                                                          data: versesInChapter[
                                                                  index]
                                                              .verseHebrew
                                                              .toString(),
                                                          style: {
                                                            "body": Style(
                                                              color: isdark ==
                                                                      true
                                                                  ? AppColor
                                                                      .white
                                                                  : AppColor
                                                                      .black,
                                                              fontSize: hfont,
                                                              fontFamily:
                                                                  "drugulinclm",
                                                            )
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Html(
                                                    data:
                                                        versesInChapter[index]!
                                                            .verseEnglish,
                                                    style: {
                                                      "body": Style(
                                                          color: isdark == true
                                                              ? AppColor.white
                                                              : AppColor.black,
                                                          fontSize: font)
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else if (lang == "h") {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Html(
                                                    data:
                                                        versesInChapter[index]!
                                                            .verseHebrew,
                                                    style: {
                                                      "body": Style(
                                                        color: isdark == true
                                                            ? AppColor.white
                                                            : AppColor.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: hfont,
                                                        fontFamily:
                                                            "drugulinclm",
                                                      )
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 0, right: 20),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${index + 1}",
                                                    style: TextStyle(
                                                        color: isdark == true
                                                            ? AppColor
                                                                .appColorSecondaryValue
                                                            : AppColor
                                                                .appColorPrimaryValue),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else if (lang == "a") {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 0, right: 10),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${index + 1}",
                                                        style: TextStyle(
                                                            color: isdark ==
                                                                    true
                                                                ? AppColor
                                                                    .appColorSecondaryValue
                                                                : AppColor
                                                                    .appColorPrimaryValue),
                                                      ))),
                                              Expanded(
                                                flex: 8,
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Html(
                                                    data:
                                                        versesInChapter[index]!
                                                            .verseEnglish,
                                                    style: {
                                                      "body": Style(
                                                          color: isdark == true
                                                              ? AppColor
                                                                  .appColorPrimaryValue
                                                              : AppColor.black,
                                                          fontSize: font)
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 0, right: 10),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${index + 1}",
                                                        style: TextStyle(
                                                            color: isdark ==
                                                                    true
                                                                ? AppColor
                                                                    .appColorSecondaryValue
                                                                : AppColor
                                                                    .appColorPrimaryValue),
                                                      ))),
                                              Expanded(
                                                flex: 8,
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Html(
                                                    data:
                                                        versesInChapter[index]!
                                                            .verseEnglish,
                                                    style: {
                                                      "body": Style(
                                                          color: isdark == true
                                                              ? AppColor
                                                                  .appColorPrimaryValue
                                                              : AppColor
                                                                  .appColorSecondaryValue,
                                                          fontSize: font)
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 12,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text('Audio only',
                            style: TextStyle(
                                color: isdark == true
                                    ? AppColor.appColorPrimaryValue
                                    : AppColor.black,
                                fontSize: 16)),
                      ),
                    ),
              Expanded(
                flex: 3,
                child: Container(
                  color: AppColor.grey1.shade800,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        backgroundColor: AppColor.appColorSecondaryValue,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                        value: 0.8,
                      ),
                      ControlButtons(
                          _player,
                          christianLyrics,
                          getUrl,
                          context,
                          bookName,
                          isCompleted,
                          markChapterComplete,
                          callApiForBookmarksAdd,
                          updateDownloadProgress),
                      StreamBuilder<PositionData>(
                        stream: _positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;

                          if (positionData != null) {
                            christianLyrics.setPositionWithOffset(
                                position: positionData.position.inMilliseconds,
                                duration: positionData.duration.inMilliseconds);
                          }

                          return Theme (
                            data: ThemeData (
                              splashColor: Colors.black,
                              textTheme: TextTheme (
                                subtitle1: TextStyle(color: Colors.black),
                                button: TextStyle(color: Colors.black),
                              ),
                              colorScheme: ColorScheme.light (
                                primary: AppColor.appColorPrimaryValue,
                              ),
                              dialogBackgroundColor: AppColor.grey600,
                            ),
                            child: SeekBar(
                              duration: positionData?.duration ?? Duration.zero,
                              position: positionData?.position ?? Duration.zero,
                              bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                              onChangeEnd: (Duration d) {
                                christianLyrics.resetLyric();
                                christianLyrics.setPositionWithOffset(
                                    position: d.inMilliseconds,
                                    duration:
                                        positionData!.duration.inMilliseconds);
                                _player.seek(d);
                              },
                            ),
                            //
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          isclick == true
              ? Container(
                  height: 100,
                  child: Card(
                    elevation: 5,
                    color: isdark == true
                        ? AppColor.mainbg
                        : AppColor.grey1.shade200,
                    margin: EdgeInsets.only(top: 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Language",
                                style: TextStyle(
                                    color: AppColor.appColorPrimaryValue),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.grey1.shade300)),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: Text(
                                        "A",
                                        style: TextStyle(
                                          color: isdark == true
                                              ? AppColor.white
                                              : AppColor.black,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        lang = "a";
                                        isclick = false;
                                      });
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        lang = "ah";
                                        isclick = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.grey1.shade300)),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: Text(
                                        "א/A",
                                        style: TextStyle(
                                          color: isdark == true
                                              ? AppColor.white
                                              : AppColor.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        lang = "h";
                                        isclick = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.grey1.shade300)),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: Text(
                                        "א",
                                        style: TextStyle(
                                          color: isdark == true
                                              ? AppColor.white
                                              : AppColor.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Font",
                                style: TextStyle(
                                    color: AppColor.appColorPrimaryValue),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        font = FontSize(font!.value - 1);
                                        hfont = FontSize(hfont!.value - 1);
                                        isclick = !isclick!;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.grey1.shade300)),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: Text(
                                        "A",
                                        style: TextStyle(
                                            color: isdark == true
                                                ? AppColor.white
                                                : AppColor.black,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        font = FontSize(font!.value + 1);
                                        hfont = FontSize(hfont!.value + 1);
                                        isclick = !isclick!;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.grey1.shade300)),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: Text(
                                        "A",
                                        style: TextStyle(
                                            color: isdark == true
                                                ? AppColor.white
                                                : AppColor.black,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  int fullLengthOfVideo = 0;

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());

    // _player.playbackEventStream.listen((event) {},
    //     onError: (Object e, StackTrace stackTrace) {
    //   print('A stream error occurred: $e');
    // });

    try {
      if (chapterModel != null) {
        String rootUrl = chapterModel!.rootUrl;
        String fileUrl = chapterModel!.fileUrl;
        getUrl = rootUrl + fileUrl;
      }

      if (getUrl != null && getUrl.toString().isNotEmpty) {
        await _player.setAudioSource(AudioSource.uri(Uri.parse(getUrl.toString()),
            tag: MediaItem (
                  id: '11',
                  album: chapterModel != null ? (chapterModel?.name ??
                      "" + "(${chapterModel!.subTitle.toString() + " - " + chapterModel!.name})")
                      : widget.subTitle!.isNotEmpty
                      ? widget.subTitle! : widget.subChapter!,
                  title: chapterModel?.subTitle ??
                      "" + "(${chapterModel!.subTitle.toString() + " - " + chapterModel!.name})",
                  // artUri: Uri.parse("https://source.unsplash.com/user/c_v_r/1900x800"),
                  artUri: await getImageFileFromAssets(),
                  // artist: ,
                  displayTitle:  chapterModel?.subTitle ??
                      "" + "(${chapterModel!.subTitle.toString() + " - " + chapterModel!.name})",
                  displaySubtitle: chapterModel != null ? (chapterModel?.name ??
                      "" + "(${chapterModel!.subTitle.toString() + " - " + chapterModel!.name})")
                      : widget.subTitle!.isNotEmpty
                      ? widget.subTitle! : widget.subChapter!,

            ),
        ));

        Duration? duration = await _player.setUrl(getUrl.toString());
        fullLengthOfVideo = duration?.inSeconds ?? 0;
        setState(() {});
      } else {
        Fluttertoast.showToast(
          msg: "error found",
          timeInSecForIosWeb: 3,
        );
      }
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Future<Uri> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/images/app_icon.png');
    final buffer = byteData.buffer;
    Directory tempDir =  await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/file_01.png'; // file_01.tmp is dump file, can be anything
    return (await File(filePath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes))).uri;
  }

  Future<void> callApiForParashaListVerses() async {
    reference.requestParam = {
      'ChaptersId': currentSelectedChapterId.toString(),
    };
    reference.shouldIParse = true;
    await ApiHandler.callApiForParashaListVerses(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        ChapterVerses chapterVerses = reference.responseParam;
        chapterModel = chapterVerses.versesChapterModel[0];
        versesInChapter = chapterVerses.versesInChapter;
      } catch (e) {
        print('object');
      }
    }
  }

  double downloadProgress = 0;
  Future<void> updateDownloadProgress() async {
    downloadProgress = 0.8;
  }

  Future<void> callApiForBookmarksAdd() async {
    reference.requestParam = {
      'ChaptersId': currentSelectedChapterId.toString(),
      'MembersId': CurrentUserInfo.currentUserId,
    };
    reference.shouldIParse = true;
    await ApiHandler.callApiForBookmarksAdd(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text("chapter added in bookmark"),
          ),
        );
      } catch (e) {
        print('object');
      }
    }
  }

  ReferenceWrapper reference = ReferenceWrapper(null, null);
  Future<void> markChapterComplete() async {
    setState(
      () {
        isCompleted = !isCompleted;
        if (isCompleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("chapter is completed"),
            ),
          );
        } else {
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text("chapter marked in complete"),
              ),
            );
          }
        }
      },
    );
    CompletedModel completedModel = new CompletedModel(
      membersId: int.tryParse(CurrentUserInfo.currentUserId),
      chaptersId: currentSelectedChapterId,
    );
    reference.requestParam = completedModel;
    reference.shouldIParse = true;
    await ApiHandler.markChapterComplete(reference);

    if (reference.isError) {
      reference.isError = false;
    } else {
      try {} catch (e) {}
    }
  }

  Future<void> chaptersUpdateTime() async {
    UpdateTimeModel completedModel = new UpdateTimeModel(
      membersId: int.tryParse(CurrentUserInfo.currentUserId),
      chaptersId: currentSelectedChapterId,
      noOfSecondsAudio: _player.position.inSeconds,
      noOfSecondsRead: _timer?.tick,
    );
    reference.requestParam = completedModel;
    reference.shouldIParse = true;
    await ApiHandler.chaptersUpdateTime(reference);

    if (reference.isError) {
      reference.isError = false;
    } else {
      try {} catch (e) {}
    }
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Timer? _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          _start--;
        }
      },
    );
  }

  bool isFastRevindVisible = true;
  bool isFastForwardVisible = true;
  void callNextChapter(String operator) {
    try {
      if (chapterModel != null) {
        setState(
          () {
            if (chapterModel!.nextChaptersId == 0) {
              isFastRevindVisible = true;
              isFastForwardVisible = false;
            }
            if (chapterModel!.previousChaptersId == 0) {
              isFastForwardVisible = true;
              isFastRevindVisible = false;
            }

            isLoading = true;
            callApi();
          },
        );
      }
    } catch (e) {
      if (operator == "+") {
        isFastForwardVisible = false;
      } else if (operator == "-") {
        isFastRevindVisible = false;
      }
    }
  }
}
