import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ybt_driver/config/constants/app_constants.dart';
import 'package:ybt_driver/config/constants/app_extensions.dart';
import 'package:ybt_driver/config/constants/app_functions.dart';
import 'package:ybt_driver/config/constants/app_svgs.dart';
import 'package:ybt_driver/config/constants/app_theme.dart';
import 'package:ybt_driver/config/route/route_names.dart';
import 'package:ybt_driver/core/api/api_repo.dart';
import 'package:ybt_driver/core/shared_preferances/sp_keys.dart';
import 'package:ybt_driver/core/utils/dialog_service.dart';
import 'package:ybt_driver/src/controllers/app_data_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtPhone = TextEditingController(text: "");
  TextEditingController txtPassword = TextEditingController(text: "");
  ValueNotifier<bool> xObsecuredPassword = ValueNotifier(false);
  ValueNotifier<bool> xRememberLogin = ValueNotifier(false);

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  initLoad() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    txtPhone.text = sharedPreferences.getString(SpKeys.loginEmail) ?? "";
    txtPassword.text = sharedPreferences.getString(SpKeys.loginPassword) ?? "";

    if (txtPhone.text.isNotEmpty && txtPassword.text.isNotEmpty) {
      xRememberLogin.value = true;
    }
  }

  Future<void> proceedLogin() async {
    DialogService().showLoadingDialog(context: context);
    ApiRepoController apiRepoController = Get.find();
    AppDataController appDataController = Get.find();
    final response = await apiRepoController.postLogin(
        phone: txtPhone.text, password: txtPassword.text);
    DialogService().dismissDialog(context: Get.context!);

    if (response.xSuccess) {
      if (xRememberLogin.value) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(SpKeys.loginEmail, txtPhone.text);
        await sharedPreferences.setString(
            SpKeys.loginPassword, txtPassword.text);
      } else {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.remove(SpKeys.loginEmail);
        await sharedPreferences.remove(SpKeys.loginPassword);
      }
      //
      appDataController.apiToken =
          response.bodyData["data"]["token"].toString();
      Get.offAllNamed(RouteNames.homePage);
    } else {
      DialogService()
          .showConfirmDialog(label: response.message, context: Get.context!);
    }
  }

  Future<void> toggleCheckBox({required bool value}) async {
    xRememberLogin.value = value;
  }

  Future<void> togglePasswordVisibility() async {
    xObsecuredPassword.value = !xObsecuredPassword.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.basePadding),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "Welcome to Yangon Bus Tracking System",
                style: TextStyle(fontSize: AppConstants.baseFontSizeXL),
              ),
              (AppConstants.basePadding / 2).heightBox(),
              SizedBox(
                height: AppConstants.baseButtonHeight,
                child: TextField(
                  controller: txtPhone,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
              ),
              (AppConstants.basePadding / 2).heightBox(),
              ValueListenableBuilder(
                valueListenable: xObsecuredPassword,
                builder: (context, xObsecuredPassword, child) {
                  return SizedBox(
                    height: AppConstants.baseButtonHeight,
                    child: TextField(
                      controller: txtPassword,
                      obscureText: xObsecuredPassword,
                      decoration: InputDecoration(
                          labelText: "Password",
                          suffix: InkWell(
                            onTap: () {
                              togglePasswordVisibility();
                            },
                            child: AppFunctions.getSvgIcon(
                                svgData: xObsecuredPassword
                                    ? AppSvgs.showPassword
                                    : AppSvgs.hidePassword,
                                color: AppTheme.darkTheme.primaryColor,
                                size: const Size(25, 25)),
                          )),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: xRememberLogin,
                    builder: (context, xRememberLogin, child) {
                      return Checkbox(
                        value: xRememberLogin,
                        onChanged: (value) => toggleCheckBox(value: value!),
                      );
                    },
                  ),
                  (AppConstants.basePadding / 2).widthBox(),
                  const Text("Remember Me?")
                ],
              ),
              SizedBox(
                  width: double.infinity,
                  height: AppConstants.baseButtonHeight,
                  child: OutlinedButton(
                      onPressed: () {
                        proceedLogin();
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          side: BorderSide(color: AppTheme.primary)),
                      child: Text(
                        "Log In Now",
                        style: TextStyle(
                            color: AppTheme.darkTheme.colorScheme.onPrimary),
                      ))),
              Get.mediaQuery.padding.bottom.heightBox(),
            ],
          ),
        ),
      ),
    );
  }
}
