import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomOTPField extends StatefulWidget {
  final int length;
  final VoidCallback? onCodeEnd;
  final bool Function(String?)? validator;
  final TextEditingController? controller;
  const CustomOTPField({
    super.key,
    this.length = 6,
    this.onCodeEnd,
    this.validator,
    this.controller,
  });

  @override
  State<CustomOTPField> createState() => _CustomOTPFieldState();
}

class _CustomOTPFieldState extends State<CustomOTPField> {
  @override
  void initState() {
    widget.controller?.addListener(_controllerListener);
    super.initState();
  }

  void _controllerListener() {
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: 2,
      runSpacing: 4,
      children: List.generate(
        widget.length,
        (index) {
          return _OTPField(
            key: UniqueKey(),
            index: index,
            length: widget.length,
            controller: widget.controller,
            onCodeEnd: index == widget.length - 1 ? widget.onCodeEnd : null,
            validator: (s) {
              if (widget.validator != null) {
                bool isValid = widget.validator!(s);
                return isValid ? null : '';
              }
              return null;
            },
          );
        },
      ),
    );
  }
}

class _OTPField extends StatelessWidget {
  final int index, length;
  final String? Function(String?)? validator;
  final VoidCallback? onCodeEnd;
  final TextEditingController? controller;
  const _OTPField({
    super.key,
    required this.index,
    required this.length,
    this.validator,
    this.onCodeEnd,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 64,
      child: TextFormField(
        validator: validator,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        maxLength: 1,
        onChanged: (String value) {
          FocusScopeNode node = FocusScope.of(context);

          if (value.isNotEmpty) {
            if (index == 0) {
              controller?.clear();
              controller?.text = value;
            } else {
              controller?.text += value;
            }
            node.nextFocus();
            if (onCodeEnd != null) {
              if (controller?.text.length == length) {
                onCodeEnd!();
              }
            }
          } else {
            if (index == 0) {
              controller?.clear();
            } else {
              String res = '';
              for (int i = 0; i < controller!.text.length; i++) {
                if (i == index) {
                  continue;
                }
                res += controller!.text.split('')[i];
              }
              controller?.text = res;
            }
            node.previousFocus();
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counter: const SizedBox.shrink(),
          filled: true,
          fillColor: lighterGrey.withOpacity(0.3),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
