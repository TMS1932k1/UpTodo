import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/business_logic/cubits/home/add_loading_cubit.dart';
import 'package:todo_app/business_logic/cubits/home/add_loading_state.dart';
import 'package:todo_app/constants/dimen_constant.dart';
import 'package:todo_app/data/models/category.dart';
import 'package:todo_app/data/repositories/task_firbase.dart';
import 'package:todo_app/presentation/widgets/cus_text_field.dart';
import 'package:todo_app/presentation/widgets/home/bottom_sheet/categories_dialog.dart';
import 'package:todo_app/presentation/widgets/home/category_tag.dart';
import 'package:todo_app/presentation/widgets/home/datetime_tag.dart';
import 'package:todo_app/presentation/widgets/home/flag_tag.dart';
import 'package:todo_app/presentation/widgets/home/bottom_sheet/flags_dialog.dart';

class NewTaskBtnSheet extends StatefulWidget {
  const NewTaskBtnSheet({super.key});

  @override
  State<NewTaskBtnSheet> createState() => _NewTaskBtnSheetState();
}

class _NewTaskBtnSheetState extends State<NewTaskBtnSheet> {
  String? _title;
  String? _description;
  Category? _category;
  int? _flag;
  DateTime? _datetime;

  final GlobalKey<FormState> _form = GlobalKey();

  /// Show dialog show [categories] list to add task's category
  void showAddCategoryDialog() async {
    await showDialog(
      context: context,
      builder: (context) => CategoriesDialog(
        category: _category,
        selectCategory: (selected) {
          setState(() {
            _category = selected;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// Show dialog show [flags] list to add task's flag
  void showAddFlagDialog() async {
    await showDialog(
      context: context,
      builder: (context) => FlagsDialog(
        flag: _flag,
        onSaved: (selected) {
          setState(() {
            _flag = selected;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showSnackBarError(String mes) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mes),
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Validate value then up Firebase cloundstore
  void submitTask() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Set add loading to start loading
    BlocProvider.of<AddLoadingCubit>(context).startLoading();

    final error = await upNewTask(
      title: _title!,
      user: FirebaseAuth.instance.currentUser!,
      description: _description,
      flag: _flag,
      datetime: _datetime,
      idCategory: _category == null ? null : _category!.id,
    );

    if (mounted) {
      if (error == null) {
        Navigator.of(context).pop();
      } else {
        _showSnackBarError(error);
      }

      // Set add loading to stop loading
      BlocProvider.of<AddLoadingCubit>(context).stopLoading();
    }
  }

  /// Set [_datetime] with [date] and [time] to add task's datetime
  void showAddDateTimePicker() async {
    // Set date
    DateTime? date = _datetime;
    date = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 30),
      ),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (date == null) return;

    // Set time
    TimeOfDay? time =
        _datetime != null ? TimeOfDay.fromDateTime(_datetime!) : null;
    time = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (time == null) return;

    // Set datetime
    setState(() {
      _datetime = DateTime(
        date!.year,
        date.month,
        date.day,
        time!.hour,
        time.minute,
      );
    });
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
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CusTextField(
                    maxLength: 30,
                    isObscure: false,
                    hint: "Enter task's title",
                    onSaved: (value) {
                      _title = value;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
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
                    maxLength: 100,
                    isObscure: false,
                    hint: "Enter decription",
                    onSaved: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        _description = value;
                      }
                    },
                    validator: (value) {
                      if (value != null && value.trim().length > 100) {
                        return 'Lenght of desciption must be less 100 char';
                      }
                      return null;
                    },
                  ),
                  if (_category != null || _flag != null || _datetime != null)
                    const SizedBox(height: kPaddingSmall),
                  if (_category != null)
                    // Category tag
                    Row(
                      children: [
                        Text(
                          'Category:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: kPaddingSmall),
                        CategoryTag(category: _category!),
                        IconButton(
                          onPressed: () => setState(() {
                            _category = null;
                          }),
                          icon: const FaIcon(
                            FontAwesomeIcons.x,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  if (_flag != null)
                    // Flag tag
                    Row(
                      children: [
                        Text(
                          'Flag:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: kPaddingSmall),
                        FlagTag(flag: _flag!),
                        IconButton(
                          onPressed: () => setState(() {
                            _flag = null;
                          }),
                          icon: const FaIcon(
                            FontAwesomeIcons.x,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  if (_datetime != null)
                    // Datetime tag
                    Row(
                      children: [
                        Text(
                          'Date:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: kPaddingSmall),
                        DateTimeTag(dateTime: _datetime!),
                        IconButton(
                          onPressed: () => setState(() {
                            _datetime = null;
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
                      // Button add date
                      BlocBuilder<AddLoadingCubit, AddLoadingState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              IconButton(
                                onPressed: !state.isLoading
                                    ? showAddDateTimePicker
                                    : null,
                                icon: const FaIcon(
                                  FontAwesomeIcons.clock,
                                  size: 24,
                                ),
                              ),
                              // Button add category
                              IconButton(
                                onPressed: !state.isLoading
                                    ? showAddCategoryDialog
                                    : null,
                                icon: const FaIcon(
                                  FontAwesomeIcons.tag,
                                  size: 24,
                                ),
                              ),
                              // Button add flag
                              IconButton(
                                onPressed:
                                    !state.isLoading ? showAddFlagDialog : null,
                                icon: const FaIcon(
                                  FontAwesomeIcons.flag,
                                  size: 24,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      BlocBuilder<AddLoadingCubit, AddLoadingState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const CircularProgressIndicator();
                          }

                          return IconButton(
                            onPressed: submitTask,
                            icon: FaIcon(
                              FontAwesomeIcons.play,
                              size: 24,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
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
