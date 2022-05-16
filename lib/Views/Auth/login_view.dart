import 'package:app_in/Controllers/Auth/login_controller.dart';
import 'package:app_in/Helper/app_button.dart';
import 'package:app_in/Helper/auth_divider_helper.dart';
import 'package:app_in/Helper/auth_field_helper.dart';
import 'package:app_in/Helper/images_helper.dart';
import 'package:app_in/Helper/sizer_helper.dart';
import 'package:app_in/Helper/snack_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:app_in/Views/Auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Helper/navigator_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sizer.vSpace(context, 0.08),
              Text(
                Const.authWelcome.toUpperCase(),
                textScaleFactor: 1.6,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Sizer.vSpace(context, 0.07),
              controller.isMobileLogin.value
                  ? AuthTextField(
                      controller: phoneController,
                      title: Const.phone,
                      hint: Const.phoneHint,
                    )
                  : AuthTextField(
                      controller: emailController,
                      title: Const.email,
                      hint: Const.emailHint,
                    ),

              Sizer.vSpace(context, 0.05),
              AuthTextField(
                controller: passwordController,
                title: Const.password,
                hint: Const.passwordHint,
              ),
              Sizer.vSpace(context, 0.05),
              //
              login(),
              //
              Sizer.vSpace(context, 0.02),
              //
              registerText(),
              //
              Visibility(
                visible: !controller.isMobileLogin.value,
                child: Column(
                  children: [
                    const AuthDivider(text: Const.or),
                    //
                    Sizer.vSpace(context, 0.02),
                    //
                    socialLogin(),
                  ],
                ),
              ),
              //
              Sizer.vSpace(context, 0.02),
              //
              const AuthDivider(text: Const.otherMethod),
              //
              Sizer.vSpace(context, 0.02),
              //
              byMobile(),
              //
              Sizer.vSpace(context, 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget login() {
    return Appbutton(
      onTap: () {
        if (emailController.text.trim().isEmpty) {
          Snack.show('Pleas enter the email', Colors.black);
        } else if (!emailController.text.trim().isEmail) {
          Snack.show('Pleas enter a valid email', Colors.black);
        } else if (passwordController.text.trim().isEmpty) {
          Snack.show('Pleas enter the password', Colors.black);
        } else if (passwordController.text.trim().length < 6) {
          Snack.show('Pleas enter a valid password', Colors.black);
        } else {
          controller.loginUser(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
        }
      },
      text: Const.login,
    );
  }

  Widget registerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Const.newUser,
          textScaleFactor: 1,
        ),
        TextButton(
          onPressed: () => Nav.to(context, const RegisterView()),
          child: const Text(
            Const.register,
            textScaleFactor: 1,
          ),
        )
      ],
    );
  }

  Widget socialLogin() {
    return Column(
      children: [
        const Text(
          Const.socialLogin,
          textScaleFactor: 1,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Sizer.vSpace(context, 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset(
                Img.google,
                filterQuality: FilterQuality.medium,
                height: 25,
              ),
            ),
            Sizer.hSpace(context, 0.05),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset(
                Img.fb,
                filterQuality: FilterQuality.medium,
                height: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget byMobile() {
    return GestureDetector(
      onTap: () => controller.changeMobileLogin(),
      child: Center(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                controller.isMobileLogin.value ? Img.byEmail : Img.byMobile,
                height: 25,
              ),
              Sizer.vSpace(context, 0.02),
              Text(
                controller.isMobileLogin.value ? Const.byEmail : Const.byMobile,
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
