import 'package:challenge3/core/viewmodels/category_viewmodel.dart';
import 'package:challenge3/core/viewmodels/task_viewmodel.dart';
import 'package:challenge3/ui/components/task_appbar.dart';
import 'package:challenge3/ui/components/task_fab.dart';
import 'package:challenge3/ui/views/category_add_modal_view.dart';
import 'package:challenge3/ui/views/category_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  CategoryViewModel _categoryViewModel;

  @override
  Widget build(BuildContext context) {

    _categoryViewModel = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      appBar: _appBar(),
      body: CategoryGridView(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _appBar() => TaskAppBar(
        title: "Categorias",
      );

  _floatingActionButton() => TaskFAB(
        onPressed: () => CategoryAddModalView.show(context).then((_) {
          _categoryViewModel.updateList();
        }),
        icon: Icons.add,
        tooltip: "Adicionar categoria",
      );
}
