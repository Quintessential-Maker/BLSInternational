import 'package:app_in/Controllers/Auth/login_controller.dart';
import 'package:app_in/Controllers/Auth/register_controller.dart';
import 'package:app_in/Helper/app_button.dart';
import 'package:app_in/Helper/auth_divider_helper.dart';
import 'package:app_in/Helper/auth_field_helper.dart';
import 'package:app_in/Helper/images_helper.dart';
import 'package:app_in/Helper/logger_helper.dart';
import 'package:app_in/Helper/navigator_helper.dart';
import 'package:app_in/Helper/sizer_helper.dart';
import 'package:app_in/Helper/snack_helper.dart';
import 'package:app_in/Helper/string_helper.dart';
import 'package:app_in/Views/Auth/otp_view.dart';
import 'package:app_in/Views/Dashboard/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final LoginController loginController = Get.put(LoginController());
  final RegisterController controller = Get.put(RegisterController());

  @override
  void initState() {
    debugPrint('reg');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
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
            AuthTextField(
              controller: nameController,
              title: Const.name,
              hint: Const.nameHint,
            ),
            Sizer.vSpace(context, 0.02),
            AuthTextField(
              controller: phoneController,
              title: Const.phone,
              hint: Const.phoneHint,
            ),
            Sizer.vSpace(context, 0.02),
            AuthTextField(
              controller: emailController,
              title: Const.email,
              hint: Const.emailHint,
            ),
            Sizer.vSpace(context, 0.02),
            AuthTextField(
              controller: passwordController,
              title: Const.password,
              hint: Const.passwordHint,
            ),
            Sizer.vSpace(context, 0.05),
            //
            register(),
            //
            Sizer.vSpace(context, 0.02),
            //
            registerText(),
            //

            const AuthDivider(text: Const.or),
            //
            Sizer.vSpace(context, 0.02),
            //
            socialLogin(),

            //
            Sizer.vSpace(context, 0.02),
            //
          ],
        ),
      ),
    );
  }

  Widget register() {
    return Appbutton(
      onTap: () {
        FocusScope.of(context).unfocus();

       // controller.register(url, map)
        //Nav.to(context, const OtpView());
        if (nameController.text.trim().isEmpty ||
            nameController.text.trim().length <= 2) {
          Snack.show('Please Enter a valid username', Colors.black);
        } else if (phoneController.text.trim().isEmpty ||
            phoneController.text.trim().length < 10) {
          Snack.show('Please enter a valid phonenumber', Colors.black);
        } else if (emailController.text.trim().isEmpty) {
          Snack.show('Please enter a email', Colors.black);
        } else if (!emailController.text.trim().isEmail) {
          Snack.show('Please enter a valid email', Colors.black);
        } else if (passwordController.text.trim().isEmpty) {
          Snack.show('Please enter a password', Colors.black);
        } else if (passwordController.text.trim().length < 6) {
          Snack.show('Password Should be minimum 6 characters', Colors.black);
        } else {
          controller.registerUser(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            mobile: phoneController.text.trim(),
            password: passwordController.text.trim(),
          );
        }
      },
      text: Const.register,
    );
  }

  Widget registerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Const.haveAccount,
          textScaleFactor: 1,
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            Const.loginNow,
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
          Const.socialRegister,
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
      onTap: () => loginController.changeMobileLogin(),
      child: Center(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                loginController.isMobileLogin.value
                    ? Img.byEmail
                    : Img.byMobile,
                height: 25,
              ),
              Sizer.vSpace(context, 0.02),
              Text(
                loginController.isMobileLogin.value
                    ? Const.byEmail
                    : Const.byMobile,
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
