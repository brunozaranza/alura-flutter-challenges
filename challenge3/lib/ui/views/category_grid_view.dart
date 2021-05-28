import 'package:challenge3/core/viewmodels/category_viewmodel.dart';
import 'package:challenge3/core/viewmodels/task_viewmodel.dart';
import 'package:challenge3/ui/pages/category_detail_page.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryGridView extends StatefulWidget {
  @override
  _CategoryGridViewState createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  CategoryViewModel _categoryViewModel;
  TaskViewModel _taskViewModel;

  int variableSet = 0;
  ScrollController _scrollController;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    _categoryViewModel = Provider.of<CategoryViewModel>(context);

    if (_categoryViewModel.list == null) {
      _categoryViewModel.updateList();
      return Container(
        width: double.maxFinite,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
              Text(
                "Carregando...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ]),
      );
    }

    if (_categoryViewModel.list.isEmpty) {
      return Center(
        child: Text(
          "Crie uma nova categoria",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DragAndDropGridView(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) =>
            Material(
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return CategoryDetailPage(
                          category: _categoryViewModel.list[index]);
                    })).then((value) => _categoryViewModel.updateList()),
                child: Card(
                  elevation: 2,
                  child: LayoutBuilder(builder: (context, constrains) {
                    if (variableSet == 0) {
                      height = constrains.maxHeight;
                      width = constrains.maxWidth;
                      variableSet++;
                    }
                    return Container(
                      width: width,
                      height: height,
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                                child: Center(
                                  child: Icon(Icons.category, size: 50,),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_categoryViewModel.list[index].name),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
        itemCount: _categoryViewModel.list.length,
        onWillAccept: (oldIndex, newIndex) => true,
        onReorder: (oldIndex, newIndex) {
          int indexOfFirstItem =
          _categoryViewModel.list.indexOf(_categoryViewModel.list[oldIndex]);
          int indexOfSecondItem =
          _categoryViewModel.list.indexOf(_categoryViewModel.list[newIndex]);

          if (indexOfFirstItem > indexOfSecondItem) {
            for (int i = _categoryViewModel.list.indexOf(
                _categoryViewModel.list[oldIndex]);
            i > _categoryViewModel.list.indexOf(
                _categoryViewModel.list[newIndex]);
            i--) {
              var tmp = _categoryViewModel.list[i - 1];
              _categoryViewModel.list[i - 1] = _categoryViewModel.list[i];
              _categoryViewModel.list[i] = tmp;
            }
          } else {
            for (int i = _categoryViewModel.list.indexOf(
                _categoryViewModel.list[oldIndex]);
            i < _categoryViewModel.list.indexOf(
                _categoryViewModel.list[newIndex]);
            i++) {
              var tmp = _categoryViewModel.list[i + 1];
              _categoryViewModel.list[i + 1] = _categoryViewModel.list[i];
              _categoryViewModel.list[i] = tmp;
            }
          }
          setState(() {});
        },
      ),
    );
  }
}
