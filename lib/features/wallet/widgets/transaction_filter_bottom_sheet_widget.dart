import 'package:flutter/material.dart';
import 'package:user_app/features/wallet/controllers/wallet_controller.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:provider/provider.dart';

class TransactionFilterBottomSheetWidget extends StatelessWidget {
  const TransactionFilterBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletController>(
        builder: (context, transactionProvider, child) {
      return Container(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Dimensions.paddingSizeDefault))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20))),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                itemCount: transactionProvider.filterTypes.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        transactionProvider.setSelectedFilterType(
                            transactionProvider.filterTypes[index], index);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color:
                                  transactionProvider.selectedIndexForFilter ==
                                          index
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.1)
                                      : Theme.of(context).cardColor),
                          child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: Row(children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: transactionProvider
                                                    .selectedIndexForFilter ==
                                                index
                                            ? Dimensions.paddingSizeSmall
                                            : 0),
                                    child: Text(
                                        transactionProvider.filterTypes[index],
                                        style: textRegular.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault,
                                            color: transactionProvider
                                                        .selectedIndexForFilter ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color)))
                              ]))));
                }),
          ],
        ),
      );
    });
  }
}
