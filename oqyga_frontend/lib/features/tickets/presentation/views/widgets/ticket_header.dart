part of '../ticket_detail_view.dart';

class _TicketHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const _TicketHeader({required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          ShadowedBackButton(onPressed: onBackPressed),
          const SizedBox(width: 16),
          Text(
            s.myTicketTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
