import 'package:flutter/material.dart';
import 'package:flutter_desktop/components/app_style.dart';
import 'package:flutter_desktop/components/login/login_controller.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final TextEditingController passwardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFormController(),
      builder: (ctx, child) {
        bool passwordVisible = ctx.watch<LoginFormController>().passwordVisible;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset("assets/images/avatar.png",
                  height: 200, width: 200, fit: BoxFit.cover),
            ),
            Text("xiaoshuyui",
                style: TextStyle(color: AppStyle.light2, fontSize: 35)),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppStyle.passwordInputBackground,
                  borderRadius: BorderRadius.circular(5)),
              width: 250,
              height: 40,
              child: TextField(
                  enabled: ctx.select<LoginFormController, bool>(
                      (value) => !value.isLoading),
                  onSubmitted: (value) async {
                    await ctx
                        .read<LoginFormController>()
                        .submit(passwardController.text);
                  },
                  obscuringCharacter: "*",
                  style: TextStyle(fontSize: 16, color: AppStyle.light2),
                  controller: passwardController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 5, top: 8.5),
                    hintText: "密码",
                    hintStyle: TextStyle(fontSize: 16, color: AppStyle.light2),
                    border: InputBorder.none,
                    suffixIcon: SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              //根据passwordVisible状态显示不同的图标
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppStyle.light2,
                              size: 20,
                            ),
                            onTap: () {
                              //更新状态控制密码显示或隐藏
                              ctx
                                  .read<LoginFormController>()
                                  .changePasswordStatus();
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.chevron_right,
                              color: AppStyle.light2,
                              size: 20,
                            ),
                            onTap: () async {
                              await ctx
                                  .read<LoginFormController>()
                                  .submit(passwardController.text);
                            },
                          )
                        ],
                      ),
                    ),
                  )),
            )
          ],
        );
      },
    );
  }
}
