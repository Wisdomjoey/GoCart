import 'package:flutter/material.dart';

import '../../CONSTANTS/constants.dart';
import '../utils/dimensions.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final String? error;
  final int? helpMax;
  final Widget? icon;
  final Widget? suffix;
  final bool obscureTxt;
  final FocusNode? node;
  final TextEditingController? controller;
  final bool Function()? val;
  final bool Function()? val2;

  const TextFormFieldWidget(
      {super.key,
      required this.label,
      this.icon,
      this.suffix,
      this.obscureTxt = false,
      this.hint,
      this.node,
      this.val,
      this.controller,
      this.error,
      this.help,
      this.helpMax,
      this.val2});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  String? err;
  double? bt = 20;

  @override
  void initState() {
    widget.node!.addListener(() {
      if (widget.node!.hasFocus) {
        setState(() {
          err = null;
          bt = 20;
        });
      } else {
        if (widget.controller!.text == '') {
          setState(() {
            err = Constants.err;
            bt = null;
          });
        } else {
          if (widget.controller!.text != '' && widget.val != null) {
            if (widget.val!()) {
              setState(() {
                err = null;
                bt = 20;
              });
            } else {
              setState(() {
                err = widget.error;
                bt = null;
              });
            }
          } else {
            setState(() {
              err = null;
              bt = 20;
            });
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: bt != null ? Dimensions.sizedBoxWidth10 * 2 : 5),
      child: TextFormField(
        focusNode: widget.node,
        controller: widget.controller,
        validator: (value) {
          if (value == '') {
            setState(() {
              bt = null;
            });
            return Constants.err;
          } else {
            if (err != null) {
              setState(() {
                bt = null;
              });
              return err;
            } else {
              setState(() {
                bt = 20;
              });
              return null;
            }
          }
        },
        onEditingComplete: () {
          if (widget.controller!.text != '') {
            setState(() {
              err = null;
              bt = 20;
            });
            widget.node?.nextFocus();
          } else {
            setState(() {
              err = Constants.err;
              bt = null;
            });
          }
        },
        onChanged: (value) {
          if (value != '' && widget.val != null) {
            if (widget.val!()) {
              if (widget.val2 != null) {
                if (widget.val2!()) {
                  setState(() {
                    err = null;
                    bt = 20;
                  });
                } else {
                  setState(() {
                    err = 'Passwords do not match';
                    bt = null;
                  });
                }
              } else {
                setState(() {
                  err = null;
                  bt = 20;
                });
              }
            } else {
              setState(() {
                err = widget.error;
                bt = null;
              });
            }
          } else {
            setState(() {
              err = null;
              bt = 20;
            });
          }
        },
        obscureText: widget.obscureTxt,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius:
                    BorderRadius.circular(Dimensions.sizedBoxWidth15 * 2),
                borderSide: const BorderSide(color: Colors.transparent)),
            filled: true,
            errorText: err,
            helperText: widget.help,
            helperMaxLines: widget.helpMax ?? 1,
            labelStyle: TextStyle(fontSize: Dimensions.font15),
            hintText: widget.hint,
            fillColor: Constants.formFillColor,
            icon: widget.icon,
            suffixIcon: widget.suffix,
            contentPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.sizedBoxWidth10 * 2),
            floatingLabelStyle: const TextStyle(color: Constants.tetiary),
            focusColor: Constants.tetiary,
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.sizedBoxWidth15 * 2),
                borderSide: const BorderSide(color: Constants.tetiary)),
            errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.sizedBoxWidth15 * 2),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.sizedBoxWidth15 * 2),
                borderSide: const BorderSide(color: Colors.red)),
            labelText: widget.label),
        cursorColor: Constants.tetiary,
      ),
    );
  }
}
