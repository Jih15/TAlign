import 'package:Cek_Tugas_Akhir/utils/theme_app.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isAutoCorrect;
  final String? hintText;
  final bool? isFilled;
  final bool isReadOnly;
  final bool isEnable;
  final bool obscureText;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? suffixText;
  final bool? suffixIconState;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final String? errorText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.focusNode,
    this.isAutoCorrect = false,
    this.hintText,
    this.isFilled = false,
    this.isReadOnly = false,
    this.isEnable = true,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.words,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixText,
    this.suffixIconState,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget? builderSuffixIcon() {
      if (suffixIcon != null) {
        return suffixIcon;
      } else {
        if (suffixIconState != null) {
          if (suffixIconState!) {
            return IconButton(
              onPressed: () => controller?.clear(),
              icon: const Icon(
                Icons.cancel_outlined,
              ),
            );
          }
        }
      }
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: isAutoCorrect,
          obscureText: obscureText,
          textAlign: textAlign,
          textCapitalization: textCapitalization,
          maxLines: (keyboardType == TextInputType.multiline) ? null : maxLines,
          maxLength:
          (keyboardType == TextInputType.multiline) ? null : maxLength,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) =>
          null,
          readOnly: isReadOnly,
          enabled: isEnable,
          // decoration: InputDecoration(
          //   hintText: hintText,
          //   hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
          //   filled: isFilled,
          //   fillColor: colorScheme.surface,
          //   errorMaxLines: 2,
          //   errorText: errorText,
          //   prefixIcon: (prefixIcon != null) ? Icon(prefixIcon, color: colorScheme.primary) : null,
          //   suffixIcon: builderSuffixIcon(),
          //   suffixText: suffixText,
          //   suffixStyle: TextStyle(color: colorScheme.onSurface),
          //   enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //       color: colorScheme.onSurface.withValues(),
          //     ),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //       color: colorScheme.primary,
          //       width: 1.8,
          //     ),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   errorBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //       color: colorScheme.error,
          //     ),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   focusedErrorBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //       color: colorScheme.error,
          //       width: 1.8,
          //     ),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          // ),
          style: theme.textTheme.bodyMedium,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }
}
