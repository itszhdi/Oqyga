part of '../ticket_detail_view.dart';

class _PosterPlaceholder extends StatelessWidget {
  const _PosterPlaceholder();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Text(
      s.posterNotFound,
      textAlign: TextAlign.center,
      style: GoogleFonts.jura(fontSize: 14, color: Colors.grey[600]),
    );
  }
}
