import 'package:flutter/material.dart';

class AzkarListScreen extends StatefulWidget {
  List? list;
  String? titleName;
  AzkarListScreen({Key? key, this.list, this.titleName}) : super(key: key);

  @override
  State<AzkarListScreen> createState() => _AzkarListScreenState();
}

class _AzkarListScreenState extends State<AzkarListScreen> {
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
                  itemBuilder: (context, index) {
                    return itemOfList(
                      list: widget.list!,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20.0,
                      ),
                  itemCount: widget.list!.length),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemOfList({
    required List list,
    required int index,
  }) {
    // int? num = int.parse(list[index]['num']);

    return InkWell(
      onTap: () {
        setState(() {
          if ((int.parse(list[index]['num'])) > 0) {
            list[index]['num'] = '${(int.parse(list[index]['num'])) - 1}';
          }
        });
      },
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
                  shadowColor: Colors.orange,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Align(
                      alignment: AlignmentDirectional.topCenter,
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
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 80.0, top: 80.0),
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
    );
  }
}
