/* import 'package:flutter/material.dart';

class PagesWidgetTest extends StatelessWidget {
  final Function navigate;
  PagesWidgetTest(this.navigate);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: InfoPageModel.data
          .map((data) => InkWell(
              onTap: () {
                navigate(
                  'CnadidatureForm',
                  flagArrow: true,
                );
              },
              child: Container(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      data.color.withOpacity(0.7),
                      data.color,
                      // Colors.white,
                      // data.color,
                      // data.color,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              )))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 4 / 6,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.all(16),
    //   child:

    //   ListView.builder(
    //       itemCount: InfoPageModel.data.length,
    //       itemBuilder: (context, index) {
    //         var page = InfoPageModel.data[index];
    //         return InkWell(
    //           onTap: () {
    //             navigate('pageContentTest', flagArrow: true, pageIndex: index);
    //           },
    //           child: Card(
    //             // color: Colors.pink,
    //             elevation: 14.0,
    //             shape: Border.all(
    //               color: Colors.black26,
    //               width: 4,
    //             ),
    //             child: Padding(
    //                 padding: EdgeInsets.all(16),
    //                 child: Column(
    //                   children: [
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     Container(
    //                       width: double.infinity,
    //                       padding: EdgeInsets.all(10),
    //                       decoration: BoxDecoration(
    //                           color: Style.primaryColor),
    //                       child: Center(
    //                         child: Text(page.title,
    //                             style: TextStyle(
    //                                 shadows: [
    //                                   BoxShadow(
    //                                     color: Colors.grey,
    //                                     spreadRadius: 2,
    //                                     blurRadius: 5,
    //                                     offset: Offset(0, 0),
    //                                   )
    //                                 ],
    //                                 color: Colors.white,
    //                                 fontSize: 28,
    //                                 fontWeight: FontWeight.bold)),
    //                       ),
    //                     ),
    //                   ],
    //                 )),
    //           ),
    //         );
    //       }),
    // );
  }
}
 */