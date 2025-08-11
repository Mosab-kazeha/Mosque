import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/widget/custom_card.dart';
import 'package:saas_mosque/core/widget/custom_snack_bar.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/routes_config.dart';

class GroupsList extends StatelessWidget {
  final List<GroupModel> groups;
  const GroupsList({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      itemBuilder:
          (context, index) => CustomCard(
            index: index,
            title: groups[index].title,
            subTitle: 'عدد الطلاب: ${groups[index].students.length}',
            onTap:
                groups[index].students.isEmpty
                    ? () {
                      CustomSnackBar.show(context, 'لا يوجد طلاب في الحلقة');
                    }
                    : () async {
                      await serviceLocater.get<SharedPreferences>().setInt(
                        'group-id',
                        groups[index].id,
                      );
                      // ignore: use_build_context_synchronously
                      context.push(AppRoutes.kRoomScreen, extra: groups[index]);
                    },
          ),
    );
  }
}
