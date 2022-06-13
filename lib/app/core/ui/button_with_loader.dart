import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamableSource<S>, S>
    extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  final B bloc;
  final VoidCallback onPressed;
  final String label;

  const ButtonWithLoader(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.selector,
      required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: BlocSelector<B, S, bool>(
        bloc: bloc,
        selector: selector,
        builder: (context, showLoading) {
          if (!showLoading) {
            return Text(label);
          }

          return const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}
