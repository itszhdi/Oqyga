part of '../ticket_detail_view.dart';

class _EventPoster extends StatelessWidget {
  final String? posterUrl;
  const _EventPoster({this.posterUrl});

  @override
  Widget build(BuildContext context) {
    final url = posterUrl;
    final content = (url != null && url.isNotEmpty)
        ? Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const _PosterPlaceholder();
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          )
        : const _PosterPlaceholder();

    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: content,
    );
  }
}
