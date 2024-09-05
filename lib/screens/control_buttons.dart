import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:christian_lyrics/christian_lyrics.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tanachyomi/screens/custom_checkbox.dart';
import 'package:tanachyomi/screens/progress_indicator.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import '../../apis/primitive_wrapper.dart';
import 'package:http/http.dart' as http;


class ControlButtons extends StatefulWidget {
  final void Function() callback;
  final void Function() bookmarkCallback;
  final void Function() updateDownloadProgress;
  final AudioPlayer? player;
  final ChristianLyrics? christianLyrics;
  String? _url;
  BuildContext context;
  String bookName;
  bool? isChecked;
  ControlButtons(
      this.player,
      this.christianLyrics,
      this._url,
      this.context,
      this.bookName,
      this.isChecked,
      this.callback,
      this.bookmarkCallback,
      this.updateDownloadProgress);

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  ReferenceWrapper reference = ReferenceWrapper(null, null);
  bool? isInternet = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: newBottomControlRow(context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Widget newBottomControlRow(BuildContext context) {
    return
        // Column(
        //   children: [
        Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 30,
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 50,
                  child: Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        _onBookmark(context);
                      },
                      child: Icon(Icons.favorite_border,
                          color: AppColor.appColorSecondaryValue, size: 20),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      flex: 50,
                      child: Container(
                        alignment: Alignment.center,
                        child: downloading ? SizedBox(
                                height: 25,
                                width: 25,
                                child: Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator())))
                            : InkWell (
                          onTap: () {
                            if (widget._url != null) {
                              try {
                                // download2(widget._url!, widget.bookName);
                                downloadFile(widget._url!, widget.bookName);

                              } catch (e) {
                                print('object');
                              }
                            }
                          },
                          child: Icon(
                            Icons.file_download_outlined,
                            color: AppColor.appColorSecondaryValue,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 40,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Row(
              children: [
                SizedBox(
                  width: 5.5,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous,
                    size: 30.0,
                    color: AppColor.white,
                  ),
                ),
                StreamBuilder<PlayerState>(
                  stream: widget.player!.playerStateStream,
                  initialData: widget.player!.playerState,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState!.processingState;
                    final playing = playerState.playing;
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(),
                      );
                    } else if (playing != true) {
                      return IconButton(
                        icon: Icon(Icons.play_circle_outline),
                        color: AppColor.white,
                        iconSize: 35.0,
                        onPressed: () {
                          widget.christianLyrics!.resetLyric();
                          widget.player!.play();

                        },
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return IconButton(
                        icon: Icon(Icons.pause_circle_outline),
                        iconSize: 35.0,
                        color: AppColor.white,
                        onPressed: widget.player!.pause,
                      );
                    } else {
                      return IconButton(
                        icon: Container(
                            child: Icon(
                          Icons.replay,
                          color: AppColor.appColorSecondaryValue,
                        )),
                        iconSize: 30.0,
                        color: AppColor.white,
                        onPressed: () => widget.player!.seek(Duration.zero),
                      );
                    }
                  },
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next,
                    size: 30.0,
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 15,
          child: Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                _onShare(context);
              },
              child: Icon(
                Icons.share_outlined,
                color: AppColor.appColorSecondaryValue,
                size: 20,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 15,
          child: Container(
            alignment: Alignment.center,
            child: CustomCheckbox(
              isChecked: widget.isChecked,
              color: AppColor.appColorSecondaryValue,
              checkColor: Colors.white,
              iconSize: 20,
              onChanged: (bool? checkboxState) {
                setState(
                  () {
                    markChapterComplete();
                  },
                );
              },
            ),
          ),
        ),
      ],
      // ),
      //CustomProgressIndicator(),
      //],
    );
  }

  bool markComplete = false;

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share("Tanachiyomi Audio Link: ${widget._url}",
        subject: "Tanachiyomi",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  void _onBookmark(BuildContext context) async {
    widget.bookmarkCallback();
  }

  void sampleDialog(savePath) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
              child: Icon(
                Icons.cloud_done_outlined,
                color: Colors.green,
                size: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                Constants.getValueFromKey(
                    "Download Successfully", Constants.hashMap),
                style: TextStyle(color: Colors.grey[900], fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
              height: 45.0,
              width: MediaQuery.of(widget.context).size.width,
              decoration: BoxDecoration(
                color: AppColor.appColorPrimaryValue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        //OpenFile.open(savePath);
                        Navigator.of(widget.context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          Constants.getValueFromKey("open", Constants.hashMap),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.5,
                    height: 30,
                    child: Container(color: Colors.white),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(widget.context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          Constants.getValueFromKey("close", Constants.hashMap),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: widget.context, builder: (_) => errorDialog);
  }

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future download2(String url, String savePath) async {
    try {
      Dio dio = Dio();
       Directory appDocDirectory = await getApplicationDocumentsDirectory();

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        // optional: header send with url (auth token etc)
        savedDir: appDocDirectory.path,
        showNotification: true,
        // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );

/*      try {

        Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
        print(response.headers);
        File file = File(appDocDirectory.path+savePath+".mp3");
        var raf = file.openSync(mode: FileMode.write);
        // response.data is List<int> type
        raf.writeFromSync(response.data);
        await raf.close();
      } catch (e) {
        print(e);
      }


      */ /*
      print("Test data 123");
      print(appDocDirectory.path + '/' + 'dir' + '/filem.mp3');

      new Directory(appDocDirectory.path + '/' + 'dir' + '/filem.mp3')
          .create(recursive: true)
          .then(
        (Directory directory) async {
          print('Path of New Dir: ' + directory.path);
          File file = File(directory.path);
          try {
            var raf = file.openSync(mode: FileMode.write);
            raf.writeFromSync(response.data);
            await raf.close();
          } catch (e) {
            print("heloo $e");
          }
        },
      );  */ /*

      print("saveFile ");

      DateTime _now = DateTime.now();
      String _name = DateFormat('yyyy-MM-dd').format(_now);
// String _fileName = 'surname-' + _name;
//       List<int>? fileData = response.data.save(fileName: _name);

// var fileBytes = excel.save();

      String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
      var _directory = Platform.isAndroid ? Directory('/storage/emulated/0/Download/') : await getApplicationDocumentsDirectory();
      String newPath = _directory.absolute.path;
      String saveFile = newPath + "filem_" + dateTime + ".mp3";
// showToast(msg: 'File saved successfully in Download \n $saveFile');
      print("saveFile $saveFile");
      // File(saveFile)
      //   ..createSync(recursive: true)
      //   ..writeAsBytesSync(fileData!);
   */ } catch (e) {
      print(" $e");
    }
  }



  bool downloading = false;
  var progress = "";
  var path = "No Data";
  static final Random random = Random();

  Future<void> downloadFile(String url, String fileName) async {

    downloading = true;
    setState(() { });


    Dio dio = Dio();
    Fluttertoast.showToast(msg: "Downloading...");
    PermissionStatus checkPermission1 = await Permission.storage.status;
    PermissionStatus checkPermission2 = await Permission.manageExternalStorage.status;
    if (!checkPermission1.isGranted || !checkPermission2.isGranted) {
      await [
        Permission.storage,
        Permission.manageExternalStorage,
        // Permission.manageExternalStorage,
      ].request();
      checkPermission1 = await Permission.storage.status;
      // checkPermission2 = await Permission.manageExternalStorage.status;
    }
    if (checkPermission1.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/storage/emulated/0/Download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      print("Download path => $dirloc");

      var randid = random.nextInt(10000);

      String dateTime = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        // File file = File('$dirloc${fileName}_$dateTime.mp3');
        File file = File('$dirloc/$dateTime.mp3');
        var response = await http.get(Uri.parse(url));
        var bytes = await response.bodyBytes;//close();
        await file.writeAsBytes(bytes);
        print(file.path);

        setState(() {
          downloading = false;
          progress = "Download Completed.";
          Fluttertoast.showToast(msg: "Download Completed.");
          // path = dirloc + randid.toString() + ".jpg";
        });

        /* final getData = await dio.download(
             url,
            dirloc + "${fileName}_$dateTime" + ".mp3",
            onReceiveProgress: (receivedBytes, totalBytes) {
              setState(() {
                downloading = true;
                progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
              });
            });  */
        // print(getData.data);
        // print(getData.extra);
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Download Error.");
      }


    } else {
      setState(() {
        downloading = false;
        progress = "Permission Denied!";
        Fluttertoast.showToast(msg: "Permission Denied!");
        downloadFile(url, fileName);
      });
    }
  }


  void showDownloadProgress(received, total) {
    if (total != -1) {
      var v = (received / total * 100).toStringAsFixed(0) + "%";
      Fluttertoast.showToast(
        msg: "progress $v",
        timeInSecForIosWeb: 1,
      );
    }
  }

  Future<void> markChapterComplete() async {
    widget.callback();
  }

  Future<void> addBookmark() async {
    widget.bookmarkCallback();
  }

  callApi() async {
    isInternet = await Constants.isInternetAvailable();
    if (isInternet != null && isInternet!) {
      reference.isLoading = false;
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt! > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }
}
