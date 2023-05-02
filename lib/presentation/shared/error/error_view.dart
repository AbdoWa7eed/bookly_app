import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:bookly_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String text;
  final Function function;

  const ErrorScreen({
    required this.text,
    required this.function,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: ColorManager.error,
          ),
          const SizedBox(
            height: AppSize.s14,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(
            height: AppSize.s14,
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: ColorManager.orange),
            onPressed: () {
              function.call();
            },
            child: const Text('Retry Again'),
          )
        ],
      ),
    );
  }

}
