import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String title;

  const Category({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = MethodHelper.getCategoryList();

    return Scaffold(
      appBar: Appbar.appbar(context, title, false),
      body: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
                title: Text(categoryList[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
                    )),
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 4),
                    children: MethodHelper.getTypeList(categoryList[index])
                        .map((type) {
                      return GestureDetector(
                        onTap: () => Navigation.men(context,
                            type == 'All' ? null : type, categoryList[index]),
                        child: Container(
                          decoration: UIHelper.customContainerDecoration(
                              Colors.white70, Colors.black54, 1.0, 6.0),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(type,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black54)),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ]);
          }),
    );
  }
}

/*[
Container(
child: GridView.builder(
itemBuilder: (context, index) {
return Card(
child: Text(MethodHelper.getTypeList(categoryList[catIndex])[index]),
);
},
itemCount: MethodHelper.getTypeList(categoryList[catIndex]).length,
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
),
)
]*/
