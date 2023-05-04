import 'package:flutter/material.dart';

class AzkarThreeListScreen extends StatefulWidget {
  List? list;
  String? titleName;

  AzkarThreeListScreen({Key? key, this.list, this.titleName}) : super(key: key);

  @override
  State<AzkarThreeListScreen> createState() => _AzkarThreeListScreenState();
}

class _AzkarThreeListScreenState extends State<AzkarThreeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.titleName!,
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.orange.shade300,
          ],
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      itemOfList(list: widget.list!, index: index),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5.0,
                      ),
                  itemCount: widget.list!.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemOfList({required List list, required int index}) {
    return InkWell(
      onTap: () {setState(() {
        if ((int.parse(list[index]['num'])) > 0) {
          list[index]['num'] = '${(int.parse(list[index]['num'])) - 1}';
        }
      });},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33.0),
                    color: Colors.orange),
                width: double.infinity,
                child: Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${list[index]['title']}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            color: Colors.grey[300],
                            height: 1,
                            width: double.infinity,
                          ),
                        ),
                        Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${list[index]['wird']}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(end: 80.0, top: 80.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${list[index]['num']}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Text(
                            'التكرار ',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Align(
              //   alignment: AlignmentDirectional.topStart,
              //   child: CircleAvatar(
              //       backgroundColor: Colors.orange,
              //       radius: 20.0,
              //       child: IconButton(onPressed: (){},icon: Icon(Icons.share,color: Colors.white,))
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
