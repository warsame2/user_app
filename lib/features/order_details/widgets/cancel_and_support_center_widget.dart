import 'package:flutter/material.dart';
import 'package:user_app/features/order/domain/models/order_model.dart';
import 'package:user_app/features/order_details/widgets/cancel_order_dialog_widget.dart';
import 'package:user_app/features/profile/controllers/profile_contrroller.dart';
import 'package:user_app/features/reorder/controllers/re_order_controller.dart';
import 'package:user_app/features/support/screens/support_ticket_screen.dart';
import 'package:user_app/features/tracking/screens/tracking_result_screen.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/features/auth/controllers/auth_controller.dart';
import 'package:user_app/utill/color_resources.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/common/basewidget/custom_button_widget.dart';
import 'package:provider/provider.dart';

class CancelAndSupportWidget extends StatelessWidget {
  final Orders? orderModel;
  final bool fromNotification;
  const CancelAndSupportWidget(
      {super.key, this.orderModel, this.fromNotification = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeSmall,
          vertical: Dimensions.paddingSizeSmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SupportTicketScreen())),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: getTranslated(
                      'if_you_cannot_contact_with_seller_or_facing_any_trouble_then_contact',
                      context),
                  style: titilliumRegular.copyWith(
                      color: ColorResources.hintTextColor,
                      fontSize: Dimensions.fontSizeSmall),
                ),
                TextSpan(
                    text: ' ${getTranslated('SUPPORT_CENTER', context)}',
                    style: titilliumSemiBold.copyWith(
                        color: ColorResources.getPrimary(context)))
              ]))),
          const SizedBox(height: Dimensions.homePagePadding),
          (orderModel != null &&
                  (orderModel!.customerId! ==
                      int.parse(Provider.of<ProfileController>(context, listen: false)
                          .userID)) &&
                  (orderModel!.orderStatus == 'pending') &&
                  (orderModel!.orderType != "POS"))
              ? CustomButton(
                  textColor: Theme.of(context).colorScheme.error,
                  backgroundColor:
                      Theme.of(context).colorScheme.error.withOpacity(0.1),
                  buttonText: getTranslated('cancel_order', context),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: CancelOrderDialogWidget(
                                orderId: orderModel!.id)));
                  })
              : (orderModel != null &&
                      Provider.of<AuthController>(context, listen: false)
                          .isLoggedIn() &&
                      orderModel!.customerId! ==
                          int.parse(Provider.of<ProfileController>(context, listen: false)
                              .userID) &&
                      orderModel!.orderStatus == 'delivered' &&
                      orderModel!.orderType != "POS")
                  ? CustomButton(
                      textColor: ColorResources.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      buttonText: getTranslated('re_order', context),
                      onTap: () =>
                          Provider.of<ReOrderController>(context, listen: false)
                              .reorder(orderId: orderModel?.id.toString()))
                  : (Provider.of<AuthController>(context, listen: false).isLoggedIn() &&
                          orderModel!.customerId! ==
                              int.parse(Provider.of<ProfileController>(context, listen: false)
                                  .userID) &&
                          orderModel!.orderType != "POS" &&
                          (orderModel!.orderStatus != 'canceled' &&
                              orderModel!.orderStatus != 'returned' &&
                              orderModel!.orderStatus != 'fail_to_delivered'))
                      ? CustomButton(
                          buttonText: getTranslated('TRACK_ORDER', context),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => TrackingResultScreen(
                                      orderID: orderModel!.id.toString()))),
                        )
                      : const SizedBox(),
          const SizedBox(width: Dimensions.paddingSizeSmall),
        ],
      ),
    );
  }
}
