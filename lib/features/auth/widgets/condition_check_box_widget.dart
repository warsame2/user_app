import 'package:flutter/material.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/features/more/screens/html_screen_view.dart';
import 'package:user_app/features/splash/controllers/splash_controller.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ConditionCheckBox extends StatelessWidget {
  const ConditionCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController =
        Provider.of<SplashController>(context, listen: false);

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Consumer<AuthController>(builder: (ctx, authController, _) {
        return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 24.0,
            child: Checkbox(
              activeColor: Theme.of(context).colorScheme.primary,
              value: authController.isAcceptTerms,
              onChanged: (bool? isChecked) => authController.toggleTermsCheck(),
            ),
          ),
          Text(getTranslated('i_agree_with_the', context)!,
              style: textMedium.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).colorScheme.primary,
              )),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => HtmlViewScreen(
                          title: getTranslated('terms_condition', context),
                          url: splashController.configModel?.termsConditions,
                        ))),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Text(getTranslated('terms_condition', context)!,
                  style: textBold.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  )),
            ),
          ),
        ]);
      }),
    );
  }
}
