import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/presentation/bloc/event_detail/event_detail_bloc.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/themes/pallete.dart';
import 'package:oqyga_frontend/shared/views/widgets/button.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});

  bool _isEventExpired(String dateStr, String timeStr) {
    try {
      DateTime date = DateTime.parse(dateStr);

      if (timeStr.isNotEmpty && timeStr.contains(':')) {
        final parts = timeStr.split(':');
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;

        date = DateTime(date.year, date.month, date.day, hour, minute);
      } else {
        date = DateTime(date.year, date.month, date.day, 23, 59, 59);
      }

      return DateTime.now().isAfter(date);
    } catch (e) {
      debugPrint('Ошибка парсинга даты: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    // 1. Получаем код текущего языка ('ru', 'en', 'kk')
    final String currentLang = Localizations.localeOf(context).languageCode;

    return BlocBuilder<EventDetailBloc, EventDetailState>(
      builder: (context, state) {
        final event = state.event;
        final isSuccess =
            state.status == EventDetailStatus.success && event != null;

        return Scaffold(
          backgroundColor: AppPallete.backgroundColor,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: null,
            ),
          ),
          body: Builder(
            builder: (context) {
              switch (state.status) {
                case EventDetailStatus.initial:
                case EventDetailStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case EventDetailStatus.failure:
                  final errorMessage = translateErrorMessage(
                    context,
                    state.errorMessage,
                  );
                  return Center(child: Text(s.errorPrefix + errorMessage));
                case EventDetailStatus.success:
                  if (event == null) {
                    return Center(child: Text(s.eventNotFound));
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: statusBarHeight),
                    // 2. Передаем язык в контент
                    child: _buildEventContent(context, event, s, currentLang),
                  );
              }
            },
          ),
          bottomNavigationBar: isSuccess
              ? _buildBottomBar(context, event, s)
              : null,
        );
      },
    );
  }

  // Метод BottomBar не меняем, так как кнопки переведены через файл S (l10n)
  Widget _buildBottomBar(BuildContext context, Event event, S s) {
    final isExpired = _isEventExpired(event.date, event.time);
    final isSoldOut = event.isSoldOut;

    String buttonText = s.buyTicket;
    Color buttonColor = AppPallete.buttonColor;
    VoidCallback? onTapAction;

    if (isExpired) {
      buttonText = s.eventHasPassed;
      buttonColor = Colors.grey.shade700;
      onTapAction = null;
    } else if (isSoldOut) {
      buttonText = s.soldOut;
      buttonColor = Colors.redAccent.withOpacity(0.9);
      onTapAction = null;
    } else {
      onTapAction = () {
        context.pushNamed(
          'confirm-place',
          pathParameters: {'id': event.id.toString()},
          extra: event,
        );
      };
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppPallete.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: onTapAction != null
            ? CustomButton(text: buttonText, onPressed: onTapAction)
            : Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Text(
                  buttonText,
                  style: GoogleFonts.jura(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildEventContent(
    BuildContext context,
    Event event,
    S s,
    String lang,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageStack(context, event),
                // 3. Передаем язык в секцию инфо
                _buildInfoSection(context, event, s, lang),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageStack(BuildContext context, Event event) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.56,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppPallete.borderColor.withOpacity(0.1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              event.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.image, size: 50)),
              ),
            ),
          ),
        ),
        Positioned(
          top: 26,
          left: 26,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ShadowedBackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(Routes.homePage);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    Event event,
    S s,
    String lang,
  ) {
    // 4. Используем методы локализации из сущности Event
    final localizedTitle = event.getLocalizedTitle(lang);
    final localizedAddress = event.getLocalizedAddress(lang);
    final localizedDescription = event.getLocalizedDescription(lang);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ЛОКАЛИЗОВАННЫЙ ЗАГОЛОВОК
          Text(
            localizedTitle.isNotEmpty ? localizedTitle : s.untitledEvent,
            style: GoogleFonts.jura(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppPallete.borderColor,
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconText(Icons.calendar_today_outlined, event.date),
              const SizedBox(width: 16),
              Flexible(
                child: _buildIconText(
                  Icons.star,
                  event.priceRange,
                  iconColor: Colors.amber,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          _buildIconText(Icons.alarm, event.time),
          const SizedBox(height: 12),

          // ЛОКАЛИЗОВАННЫЙ АДРЕС
          _buildIconText(
            Icons.location_on_outlined,
            '${event.city.isNotEmpty ? event.city : s.cityNotSpecified}, ${localizedAddress.isNotEmpty ? localizedAddress : s.addressNotSpecified}',
            expanded: true,
          ),
          const SizedBox(height: 24),

          // ЛОКАЛИЗОВАННОЕ ОПИСАНИЕ
          Text(
            localizedDescription.isNotEmpty
                ? localizedDescription
                : s.noDescription,
            style: GoogleFonts.jura(
              fontSize: 16,
              color: AppPallete.borderColor.withOpacity(0.6),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(
    IconData icon,
    String text, {
    Color? iconColor,
    double fontSize = 16,
    bool expanded = false,
  }) {
    final textWidget = Text(
      text,
      style: GoogleFonts.jura(
        fontSize: fontSize,
        color: AppPallete.borderColor.withOpacity(0.7),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: iconColor ?? AppPallete.borderColor),
        const SizedBox(width: 8),
        expanded ? Expanded(child: textWidget) : Flexible(child: textWidget),
      ],
    );
  }
}
