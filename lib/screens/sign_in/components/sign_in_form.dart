import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/home/home_screen.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:app_shipper/utils/keyboard.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _prefs = PreferencesService();

  String? phone;
  String? password;
  bool? remember = false;
  bool _isRefreshToken = false;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  Future<void> getUserInfo() async {
    if (await _prefs.getIsLogging()) {
      setState(() => _isRefreshToken = !_isRefreshToken);
      try {
        await context.read<AuthProvider>().refreshToken(context);
      } catch (e) {
        setState(() => _isRefreshToken = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: _isRefreshToken
              ? isRefreshTokenWidget()
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: size20, vertical: 36),
                    child: Column(
                      children: [
                        buildPhoneFormField(provider),
                        SizedBox(
                            height:
                                getProportionateScreenHeight(size8)),
                        buildPasswordFormField(provider),
                        SizedBox(
                            height:
                                getProportionateScreenHeight(size8)),
                        // GestureDetector(
                        //   // onTap: () => Navigator.pushNamed(
                        //   //     context, ForgotPasswordScreen.routeName),
                        //   child: const Text(
                        //     "Quên mật khẩu",
                        //     style: TextStyle(decoration: TextDecoration.underline),
                        //   ),
                        // ),
                        // SizedBox(height: getProportionateScreenHeight(20)),
                        provider.isLogin
                            ? const LoadingWidget(color: kPrimaryLightColor)
                            : SizedBox(
                                width: getProportionateScreenWidth(
                                    double.infinity),
                                height: getProportionateScreenHeight(40),
                                child: DefaultButton(
                                  text: "Đăng nhập",
                                  press: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      KeyboardUtil.hideKeyboard(context);
                                      await provider.signIn(
                                          phone!, password!, context);
                                    }
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  TextFormField buildPasswordFormField(AuthProvider provider) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 4) {
          return kShortPassError;
        }
        return null;
      },
      onFieldSubmitted: (value) async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          KeyboardUtil.hideKeyboard(context);
          await provider.signIn(phone!, password!, context);
        }
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: "Nhập mật khẩu",
        labelText: kPassword,
        focusColor: kPrimaryLightColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneFormField(AuthProvider provider) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (newValue) => phone = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return kPhoneNumberNullError;
        }
        return null;
      },
      onFieldSubmitted: (value) async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          KeyboardUtil.hideKeyboard(context);
          await provider.signIn(phone!, password!, context);
        }
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        labelText: kPhone,
        counterText: '',
        hintText: "Nhập số điện thoại",
        focusColor: kPrimaryLightColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget isRefreshTokenWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        LoadingWidget(color: kPrimaryColor),
        SizedBox(
          width: size8,
        ),
        Text('Đang đăng nhập vào hệ thống...',
            style: TextStyle(color: kPrimaryColor))
      ],
    );
  }
}
