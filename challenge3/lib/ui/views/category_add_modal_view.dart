import 'package:challenge3/core/viewmodels/category_viewmodel.dart';
import 'package:challenge3/ui/components/task_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryAddModalView {

  static Future show(BuildContext context) {

    TextEditingController controller = TextEditingController();
    FocusNode focus = FocusNode();

    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (_) {
          focus.requestFocus();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  "Adicione uma categoria:",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.purple),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controller,
                  focusNode: focus,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TaskButton(
                      title: "Cancelar",
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: 16),
                    Consumer<CategoryViewModel>(builder: (context, vm, child) {

                      controller.addListener(() {
                        vm.setButtonAddActive(controller.text.isEmpty);
                      });

                      return TaskButton(
                        title: "Adicionar",
                        onTap: vm.isButtonAddActive
                            ? null
                            : () {
                          vm.save(controller.text);
                          Navigator.of(context).pop();
                        },
                      );
                    }),
                  ],
                ),
              )
            ],
          );
        });
  }
}
