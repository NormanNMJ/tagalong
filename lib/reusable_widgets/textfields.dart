// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class ReusableTextField extends StatefulWidget {
  final Function(String)? onChanged;
  late final bool isVisible;
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final bool showSuffix;
  final TextInputType keyboardType;
  final String labelText;

  ReusableTextField({
    super.key,
    this.onChanged,
    required this.isVisible,
    required this.hintText,
    required this.controller,
    this.errorText,
    required this.showSuffix,
    required this.keyboardType, required this.labelText,
  });

  @override
  _ReusableTextFieldState createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.isVisible,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        errorStyle: const TextStyle(color: Colors.blueGrey),
        suffixIcon: widget.showSuffix
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isVisible = !widget.isVisible;
                  });
                },
                icon: !widget.isVisible
                    ? const Icon(
                        Icons.visibility,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      ),
              )
            : const SizedBox(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        hintText: widget.hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      ),
    );
  }
}

class ReusableSearchField extends StatefulWidget {
  final Function(String)? searchQuery;

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  ReusableSearchField(
      {super.key,
      required this.searchQuery,
      required this.hintText,
      required this.controller,
      required this.keyboardType});

  @override
  _ReusableSearchFieldState createState() => _ReusableSearchFieldState();
}

class _ReusableSearchFieldState extends State<ReusableSearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.searchQuery,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        hintText: widget.hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      ),
    );
  }
}
