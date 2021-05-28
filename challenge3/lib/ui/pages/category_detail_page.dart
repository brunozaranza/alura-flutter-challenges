import 'package:challenge3/core/models/category.dart';
import 'package:challenge3/core/models/task.dart';
import 'package:challenge3/core/viewmodels/task_viewmodel.dart';
import 'package:challenge3/ui/components/task_fab.dart';
import 'package:challenge3/ui/views/task_add_modal_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDetailPage extends StatelessWidget {
  final Category category;
  bool isLoaded;

  CategoryDetailPage({@required this.category}) {
    isLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    String title = category.name;
    TaskViewModel viewModel = Provider.of<TaskViewModel>(context);

    viewModel.setCategory(category);
    if (!isLoaded) {
      isLoaded = true;
      viewModel.updateList();
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
            ),
            actions: [
              PopupMenuButton<int>(
                onSelected: (index) {
                  if(index == 2) {
                    viewModel.category.reference.delete();
                    Navigator.of(context).pop();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<int>(value: 0, child: Text("Editar")),
                  PopupMenuItem<int>(value: 1, child: Text("Trocar ícone")),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Deletar"),
                  ),
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      viewModel.list.isEmpty
                          ? "Sem tarefas"
                          : viewModel.list[index].description,
                      maxLines: 2,
                      textAlign: viewModel.list.isEmpty
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                    trailing: viewModel.list.isEmpty
                        ? Container(width: 1)
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.purple,
                            ),
                            onPressed: () {
                              if (viewModel.list.isNotEmpty) {
                                viewModel.delete(viewModel.list[index].id);
                              }
                            },
                          ),
                  ),
                );
              },
              childCount: viewModel.list.isEmpty ? 1 : viewModel.list.length,
            ),
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(context, viewModel),
    );
  }

  _floatingActionButton(BuildContext context, TaskViewModel viewModel) =>
      TaskFAB(
        onPressed: () => TaskAddModalView.show(context, category).then((_) {
          viewModel.updateList();
        }),
        icon: Icons.add,
        tooltip: "Adicionar tarefa",
      );

  _dropDownMenu() => DropdownButton<String>(
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {},
        items: <String>['Editar', 'Trocar ícone', 'Apagar']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          );
        }).toList(),
      );
}
