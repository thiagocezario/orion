import 'package:flutter/material.dart';
import 'package:orion/components/commom_items/commom_items.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _description;
  final Function _validate;
  final Function _onChanged;
  final bool _isPasswordField;

  CustomTextFormField(this._controller, this._description, this._validate,
      this._onChanged, this._isPasswordField);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return _validate(value);
      },
      controller: _controller,
      style: textStyle,
      obscureText: _isPasswordField,
      decoration: InputDecoration(
        errorMaxLines: 3,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: _description,
        fillColor: Colors.white,
        filled: true,
        errorStyle: errorStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onChanged: (value) => _onChanged(value),
    );
  }
}
