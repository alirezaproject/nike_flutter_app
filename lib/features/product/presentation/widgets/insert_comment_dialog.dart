import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/features/product/presentation/bloc/comment/comment_bloc.dart';
import 'package:nike/service_locator.dart';

class InsertCommentDialog extends StatefulWidget {
  final int productId;
  final ScaffoldMessengerState? scaffoldMessengerState;
  const InsertCommentDialog({super.key, required this.productId, this.scaffoldMessengerState});

  @override
  State<InsertCommentDialog> createState() => _InsertCommentDialogState();
}

class _InsertCommentDialogState extends State<InsertCommentDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: BlocProvider<CommentBloc>(
          create: (context) {
            final bloc = sl<CommentBloc>();
            subscription = bloc.stream.listen((state) {
              if (state is InsertCommentCompleted) {
                Navigator.of(context, rootNavigator: true).pop();
                widget.scaffoldMessengerState?.showSnackBar(
                  const SnackBar(
                    content: Text('نظر شما با موفقیت ثبت شد'),
                  ),
                );
              } else if (state is InsertCommentError) {
                widget.scaffoldMessengerState?.showSnackBar(
                  SnackBar(
                    content: Text(state.exception.message),
                  ),
                );
                Navigator.of(context, rootNavigator: true).pop();
              }
            });

            return bloc;
          },
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    'ثبت نظر',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      label: Text('عنوان'),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                      label: Text('متن مورد نطر خود را اینجا وارد کنید'),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CommentBloc>().add(
                            AddCommentEvent(
                              title: titleController.text,
                              content: contentController.text,
                              productId: widget.productId,
                            ),
                          );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                      foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                      minimumSize: const MaterialStatePropertyAll(
                        Size.fromHeight(56),
                      ),
                    ),
                    child: Row(
                      children: [
                        if (state is InsertCommentLoading)
                          CupertinoActivityIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        const Text('ذخیره'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
