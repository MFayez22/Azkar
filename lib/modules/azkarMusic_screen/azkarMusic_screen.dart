import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:azkar/conestant/themes/themes.dart';
import 'package:azkar/models/azkar_music_model.dart';
import 'package:flutter/material.dart';

class AudioPlayersScreen extends StatefulWidget {
  List<AzkarMusicModel>? list;
  String? titleName;

  AudioPlayersScreen({Key? key, this.list, this.titleName}) : super(key: key);

  @override
  State<AudioPlayersScreen> createState() => _AudioPlayersScreenState();
}

bool isPlaying = false;
AudioPlayer player = AudioPlayer();

Duration currentPosition = Duration();
Duration musicLength = Duration();

String name = 'اختر من القائمة';
String playName = '';
String textCurrentNum = '';

class _AudioPlayersScreenState extends State<AudioPlayersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  void setup() async {
    await player.onAudioPositionChanged.listen((event) {
      setState(() {
        currentPosition = event;
      });
    });
    await player.onDurationChanged.listen((event) {
      setState(() {
        musicLength = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      textCurrentNum =
          '${((currentPosition.inSeconds) / 60).toInt()}:${(currentPosition.inSeconds) - (((currentPosition.inSeconds) / 60).toInt()) * 60}';
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background2Color,
        title: Text(
          widget.titleName!,
          style: TextStyle(color: textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Card(
                color: container2Color,
                shadowColor: backgroundColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Text(
                      name,
                      style: TextStyle(color: text3Color),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Card(
                      color: container2Color,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'lib/images/icons/azkarMusic.png',
                          height: 90,
                          width: 90.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textCurrentNum,
                            style: TextStyle(fontSize: 12),
                          ),
                          Expanded(
                              child: Slider(
                                  value: currentPosition.inSeconds.toDouble(),
                                  max: musicLength.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    seekTo(value.toInt());
                                  })),
                          Text(
                            '${((musicLength.inSeconds) / 60).toInt()}:${(musicLength.inSeconds) - (((musicLength.inSeconds) / 60).toInt()) * 60}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                if (currentPosition.inSeconds == 0 ||
                                    currentPosition.inSeconds < 10) {
                                  seekTo(0);
                                } else if (currentPosition.inSeconds > 10) {
                                  seekTo(currentPosition.inSeconds - 10);
                                }
                              },
                              icon: Icon(
                                Icons.rotate_left,
                                size: 20,
                              )),
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                if (isPlaying) {
                                  setState(() {
                                    isPlaying = false;
                                  });
                                  stop();
                                } else {
                                  setState(() {
                                    isPlaying = true;
                                  });
                                  play(playName);
                                }
                              },
                              icon: isPlaying
                                  ? Icon(Icons.pause)
                                  : Icon(
                                      Icons.play_arrow,
                                      size: 25,
                                    )),
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                if (currentPosition <
                                    musicLength - Duration(seconds: 10)) {
                                  seekTo(currentPosition.inSeconds + 10);
                                } else {
                                  seekTo(musicLength.inSeconds);
                                  setState(() {
                                    isPlaying = false;
                                  });
                                  player.stop();
                                }
                              },
                              icon: Icon(
                                Icons.rotate_right,
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        itemOfList(list: widget.list!, index: index),
                    separatorBuilder: (context, index) => Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                    itemCount: widget.list!.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void play(String url) async {
    await player.play(url);
  }

  void stop() {
    player.pause();
  }

  void seekTo(int sec) async {
    await player.seek(Duration(seconds: sec));
  }

  Widget itemOfList({
    required List<AzkarMusicModel> list,
    required int index,
  }) {
    // int? num = int.parse(list[index]['num']);

    return InkWell(
      onTap: () {
        setState(() {
          player.stop();
          isPlaying = false;
          name = list[index].name!;
          playName = list[index].url!;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: container2Color,
          shadowColor: backgroundColor,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Card(
                color: container2Color,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'lib/images/icons/azkarMusic.png',
                    height: 40,
                  ),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${list[index].name}',
                style: TextStyle(
                    color: text3Color,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
