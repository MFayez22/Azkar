import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50,
                Colors.white,
              ],
            )),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w900),
                      ),
                      Image.asset(
                        'AzkarHomeCubit.get(context).changeWeatherIcon()',
                        width: 80.0,
                        height: 80.0,
                      ),
                      Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ' °C',
                              style: TextStyle(
                                  color: Colors.orange[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'درجة الحرارة',
                              style: TextStyle(
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.orange[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'حالة الطقس',
                              style: TextStyle(
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        // getCurrentLocation(context: context);
                      },
                      splashColor: Colors.blue,
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.deepOrange,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
