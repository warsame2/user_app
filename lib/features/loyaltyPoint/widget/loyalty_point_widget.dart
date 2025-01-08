import 'package:flutter/material.dart';
import 'package:user_app/features/loyaltyPoint/domain/models/loyalty_point_model.dart';
import 'package:user_app/helper/date_converter.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/utill/color_resources.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:user_app/utill/images.dart';

class LoyaltyPointWidget extends StatelessWidget {
  final LoyaltyPointList? loyaltyPointModel;
  final bool isLastItem;
  const LoyaltyPointWidget(
      {super.key, this.loyaltyPointModel, required this.isLastItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Image(
                        image: AssetImage(loyaltyPointModel!.credit! > 0
                            ? Images.coinDebit
                            : Images.coinCredit),
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeEight,
                      ),
                      Text(
                        loyaltyPointModel!.credit! > 0 ? '+' : '-',
                        style: robotoBold.copyWith(
                            color: ColorResources.getTextTitle(context),
                            fontSize: Dimensions.fontSizeLarge),
                      ),
                      Text(
                          '${loyaltyPointModel!.credit! > 0 ? loyaltyPointModel!.credit : loyaltyPointModel!.debit}',
                          style: textRegular.copyWith(
                              color: ColorResources.getTextTitle(context),
                              fontSize: Dimensions.fontSizeLarge)),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text(getTranslated('points', context)!,
                          style: textRegular.copyWith(
                              color: ColorResources.getHint(context)))
                    ]),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      getTranslated(
                          loyaltyPointModel?.transactionType ?? '', context)!,
                      style: textRegular.copyWith(
                          color: ColorResources.getHint(context)),
                    ),
                  ]),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                DateConverter.estimatedDateYear(
                    DateTime.parse(loyaltyPointModel!.createdAt!)),
                style: textRegular.copyWith(
                    color: ColorResources.getHint(context),
                    fontSize: Dimensions.fontSizeDefault),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraSmall,
              ),
              Text(
                  getTranslated(
                      (loyaltyPointModel?.credit ?? 0) > 0 ? 'credit' : 'debit',
                      context)!,
                  style: textRegular.copyWith(
                      color: loyaltyPointModel!.credit! > 0
                          ? Colors.green
                          : Colors.red)),
            ]),
          ]),
          !isLastItem
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Divider(
                      thickness: .4,
                      color: Theme.of(context).hintColor.withOpacity(.8)),
                )
              : const SizedBox(height: 80),
        ],
      ),
    );
  }
}
