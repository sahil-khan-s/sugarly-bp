import 'package:bpcheck/shared/parent_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../config/translation_keys.dart';
import '../../interfaces/widget_operations.dart';
import '../../utils/widget_types.dart';
import '../config/app_string.dart';
import '../utils/app_constants.dart';

class CustomTextField extends ParentWidget implements WidgetOperations {
  EdgeInsets _inputPadding =
  const EdgeInsets.symmetric(horizontal: 14, vertical: 18);
  String _label = "";
  String _hint = "";
  int _fieldStyle = TextFieldStyle.OUTLINED;
  int _fieldType = TextFieldType.SIMPLE_TEXTFIELD;
  String _error = TranslationKeys.TEXT_THIS_FIELD_IS_REQUIRED;
  TextInputType _keyboardType = TextInputType.text;
  List<TextInputFormatter> _inputValidators = const [];
  final TextEditingController _tfController = TextEditingController();
  final GlobalKey<FormFieldState> _refKey = GlobalKey<FormFieldState>();

  Color _bgColor = AppColors.white;
  Color _borderColor = AppColors.primaryColor;
  Color _errorBgColor = AppColors.tfErrorBgColor;
  Color _errorBorderColor = AppColors.tfErrorBorderColor;
  Color _enabledBorderColor = AppColors.labelColor;
  bool _isEnabled = true;

  TextStyle _labelStyle = AppTextStyles.labelTextStyle;
  TextStyle _hintStyle = AppTextStyles.hintTextStyle;
  TextStyle _errorStyle = AppTextStyles.errorTextStyle;
  TextStyle _inputStyle = AppTextStyles.tfInputTextStyle;
  bool _isError = false;
  BorderRadius _borderRadius = BorderRadius.all(Radius.circular(4));
  IconData _suffixIcon = AppAssets.person;
  bool _suffixIconVisible = true;
  bool _isEmailField = false;

  CustomTextField setSuffixIcon(IconData suffixIcon) {
    _suffixIcon = suffixIcon;
    return this;
  }
  CustomTextField setSuffixIconVisible(bool suffixIconVisible) {
    _suffixIconVisible = suffixIconVisible;
    return this;
  }
  CustomTextField setIsEnabled(bool value) {
    _isEnabled = value;
    return this;
  }

  TextEditingController get tfController => _tfController;
  final int _minLines = 1;
  int _maxLines = 1;

  CustomTextField setTag(String key, Object value) {
    tags[key] = value;
    return this;
  }
  CustomTextField setEmailField(bool value) {
    _isEmailField = value;
    return this;
  }

  Object? getTag(String key) {
    return tags[key];
  }

  @override
  bool validate(Widget widget) {
    CustomTextField textField = widget as CustomTextField;
    textField._refKey.currentState!.validate();
    return textField._isError;
  }

  CustomTextField setInputPadding(value) {
    _inputPadding = value;
    return this;
  }

  CustomTextField setEnabledBorderColor(Color value) {
    _enabledBorderColor = value;
    return this;
  }

  CustomTextField setMaxLines(value) {
    _maxLines = value;
    return this;
  }

  CustomTextField setLabel(String value) {
    _label = value;
    return this;
  }

  CustomTextField setWidgetType(int type) {
    _fieldStyle = type;
    return this;
  }

  CustomTextField setHint(String value) {
    _hint = value;
    return this;
  }

  CustomTextField setError(String value) {
    _error = value;
    return this;
  }

  CustomTextField setKeyboardType(TextInputType value) {
    _keyboardType = value;
    return this;
  }

  CustomTextField setInputValidators(List<TextInputFormatter> value) {
    _inputValidators = value;
    return this;
  }

  CustomTextField setBgColor(Color value) {
    _bgColor = value;
    return this;
  }

  CustomTextField setBorderColor(value) {
    _borderColor = value;
    return this;
  }

  CustomTextField setErrorBgColor(value) {
    _errorBgColor = value;
    return this;
  }

  CustomTextField setErrorBorderColor(value) {
    _errorBorderColor = value;
    return this;
  }

  CustomTextField setLabelStyle(TextStyle value) {
    _labelStyle = value;
    return this;
  }

  CustomTextField setHintStyle(TextStyle value) {
    _hintStyle = value;
    return this;
  }

  CustomTextField setErrorStyle(value) {
    _errorStyle = value;
    return this;
  }

  CustomTextField setInputStyle(value) {
    _inputStyle = value;
    return this;
  }

  CustomTextField setIsError(bool value) {
    _isError = value;
    return this;
  }

  CustomTextField setBorderRadius(BorderRadius value) {
    _borderRadius = value;
    return this;
  }

  CustomTextField setFieldType(int value) {
    _fieldType = value;
    return this;
  }

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<CustomTextField> {
  late Color _bgColor;
  late Color _borderColor;
  bool passwordVisible = true;
  setTextFieldColors() {
    _bgColor = widget._bgColor;
    _borderColor = widget._borderColor;
  }

  String? validate(String value) {
    setState(() {
      _bgColor = widget._errorBgColor;
      _borderColor = widget._errorBorderColor;
      widget._isError = true;
    });
  }

  setValidation(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _bgColor = widget._bgColor;
        _borderColor = widget._borderColor;
        widget._isError = false;
      });
    }
  }

  @override
  void initState() {
    setTextFieldColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.setTag(AppConstants.FIELD_TYPE, WidgetTypes.CUSTOM_EDIT_TEXT);
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          validate(value);
        }else
        if(widget._isEmailField) {
          if(!EmailValidator.validate(value)){
            widget._error=AppStrings.notAValidEmail;
            validate(value);
          };
        }
      },
      minLines: widget._minLines,
      maxLines: widget._maxLines,
      enabled: widget._isEnabled,
      key: widget._refKey,
      keyboardType: widget._keyboardType,
      inputFormatters: widget._inputValidators,
      style: widget._inputStyle,
      controller: widget._tfController,
      onChanged: (value) {
        setValidation(value);
      },
      obscureText:
          widget._fieldType == TextFieldType.PASSWORD ? passwordVisible : false,
      decoration: InputDecoration(
          filled: true,
          fillColor: _bgColor,
          errorStyle: widget._errorStyle,
          errorText:
              widget._isError ? widget._error : null,
          contentPadding: widget._inputPadding,
          isDense: true,
          border: _getEnabledBorder(),
          focusedBorder: _getFocusedBorder(),
          enabledBorder: _getEnabledBorder(),
          errorBorder: _getErrorBorder(),
          focusedErrorBorder: _getFocusedErrorBorder(),
          labelText: widget._label.isEmpty
              ? null
              : widget._label,
          suffixIcon: widget._fieldType == TextFieldType.PASSWORD
              ? IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    passwordVisible
                        ? AppAssets.passwordHide
                        : AppAssets.passwordVisible,
                    color: AppColors.labelColor,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )
              : widget._suffixIconVisible ? IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(
              size: 25,
              widget._suffixIcon,
              color: AppColors.labelColor,
            ),
          ) : null,
          suffixIconConstraints: BoxConstraints(maxHeight: 20),
          labelStyle: widget._labelStyle,
          hintText: widget._hint,
          hintStyle: widget._hintStyle),
    );
  }

  InputBorder _getFocusedBorder() {
    return getBorder(_borderColor);
  }

  InputBorder _getEnabledBorder() {
    return getBorder(widget._enabledBorderColor);
  }

  InputBorder _getErrorBorder() {
    return getBorder(_borderColor);
  }

  InputBorder _getFocusedErrorBorder() {
    return getBorder(_borderColor);
  }

  InputBorder getBorder(Color color) {
    InputBorder defBorder = UnderlineInputBorder(
      borderRadius: widget._borderRadius,
      borderSide: BorderSide(
        color: color,
      ),
    );

    if (widget._fieldStyle == TextFieldStyle.OUTLINED) {
      return OutlineInputBorder(
        borderRadius: widget._borderRadius,
        borderSide: BorderSide(
          color: color,
        ),
      );
    }
    return defBorder;
  }
}

class TextFieldStyle {
  static const int OUTLINED = 1;
  static const int UNDERLINE = 2;
}

class TextFieldType {
  static const int PASSWORD = 1;
  static const int SIMPLE_TEXTFIELD = 2;
}
