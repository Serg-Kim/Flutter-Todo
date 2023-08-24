import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput(
      {super.key, required this.label, required this.error, required this.controller});

  final String label;
  final String error;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8),
      child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return error;
            }
            return null;
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus
                ?.unfocus();
          },
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
              errorMaxLines: 2,
              label: Text(label, style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),),
              contentPadding: const EdgeInsets
                  .all(8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius
                    .circular(
                    10),
                borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius
                    .circular(
                    10),
                borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2),)
          )
      ),
    );
  }
}