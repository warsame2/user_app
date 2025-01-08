import 'package:flutter/material.dart';
import 'package:user_app/localization/language_constrants.dart';
import 'package:user_app/utill/custom_themes.dart';
import 'package:user_app/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:user_app/features/chat/controllers/chat_controller.dart';

class ConversationListTabview extends StatelessWidget {
  final TabController? tabController;
  const ConversationListTabview({super.key, this.tabController});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(builder: (context, chatProvider, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
        child: Row(
          children: [
            TabBar(
              controller: tabController,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              labelStyle: textMedium,
              indicatorWeight: 1,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.only(
                right: chatProvider.isActiveSuffixIcon &&
                        chatProvider.messageList.isNotEmpty
                    ? 10
                    : 25,
              ),
              indicatorPadding: const EdgeInsets.only(right: 10),
              tabs: [
                SizedBox(
                  height: 35,
                  child: Center(
                    child: Row(
                      children: [
                        Text(getTranslated('delivery-man', context)!),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: Center(
                    child: Row(
                      children: [
                        Text(getTranslated('vendor', context)!),
                      ],
                    ),
                  ),
                ),
              ],
              onTap: (index) {
                if (chatProvider.isActiveSuffixIcon) {
                  chatProvider.setUserTypeIndex(context, tabController!.index,
                      searchActive: true);
                } else {
                  chatProvider.setUserTypeIndex(context, tabController!.index);
                }
              },
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      );
    });
  }
}
