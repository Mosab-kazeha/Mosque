import 'package:flutter/material.dart';
import 'package:saas_mosque/core/widget/listening_session_card.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';

class ListeningList extends StatelessWidget {
  final List<ListeningModel> listenings;
  const ListeningList({super.key, required this.listenings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: listenings.length,
      itemBuilder: (context, index) {
        return ListeningSessionCard(listeningData: listenings[index]);
      },
    );
  }
}
