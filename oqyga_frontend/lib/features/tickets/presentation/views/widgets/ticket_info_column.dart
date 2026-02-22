part of '../ticket_detail_view.dart';

class _TicketInfoColumn extends StatelessWidget {
  final String title;
  final Widget content;

  const _TicketInfoColumn({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.jura(
              fontSize: 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          content,
        ],
      ),
    );
  }
}
