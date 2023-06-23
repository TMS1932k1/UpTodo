import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/category.dart';
import 'package:todo_app/presentation/widgets/cus_text_field.dart';
import 'package:todo_app/presentation/widgets/home/categories_dialog.dart';
import 'package:todo_app/presentation/widgets/home/category_tag.dart';

class NewTaskBtnSheet extends StatefulWidget {
  const NewTaskBtnSheet({super.key});

  @override
  State<NewTaskBtnSheet> createState() => _NewTaskBtnSheetState();
}

class _NewTaskBtnSheetState extends State<NewTaskBtnSheet> {
  Category? category;

  /// Show dialog show [categories] list to add task's category
  void showAddCategoryDialog() async {
    await showDialog(
      context: context,
      builder: (context) => CategoriesDialog(
        category: category,
        selectCategory: (selected) {
          setState(() {
            category = selected;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kPaddingSmall,
        right: kPaddingSmall,
        top: kPaddingMedium,
        bottom: kPaddingSmall + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: kPaddingSmall),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CusTextField(
                    isObscure: false,
                    hint: "Enter task's title",
                    onSaved: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }

                      if (value.trim().length > 30) {
                        return 'Lenght of title must be less 30 char';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: kPaddingSmall),
                  CusTextField(
                    isObscure: false,
                    hint: "Enter decription",
                    onSaved: (value) {},
                    validator: (value) {
                      if (value != null && value.trim().length > 100) {
                        return 'Lenght of desciption must be less 100 char';
                      }
                      return null;
                    },
                  ),
                  if (category != null) const SizedBox(height: kPaddingSmall),
                  if (category != null)
                    Row(
                      children: [
                        CategoryTag(
                          category: category!,
                          onClick: showAddCategoryDialog,
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            category = null;
                          }),
                          icon: const FaIcon(
                            FontAwesomeIcons.x,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: kPaddingMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Set date
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.clock,
                              size: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: showAddCategoryDialog,
                            icon: const FaIcon(
                              FontAwesomeIcons.tag,
                              size: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Add flag
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.flag,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          // Add new task
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.play,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
