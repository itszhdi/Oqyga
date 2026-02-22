import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/cards/presentation/bloc/card_bloc.dart';
import 'package:oqyga_frontend/features/cards/utils/card_formatters.dart';
import 'package:oqyga_frontend/features/cards/utils/card_validator.dart';
import 'package:oqyga_frontend/features/cards/utils/card_assets.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/button.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

class NewCardMethodView extends StatefulWidget {
  final bool isPurchaseFlow;

  const NewCardMethodView({super.key, this.isPurchaseFlow = false});

  @override
  State<NewCardMethodView> createState() => _NewCardMethodViewState();
}

class _NewCardMethodViewState extends State<NewCardMethodView> {
  final _formKey = GlobalKey<FormState>();
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _ccvController = TextEditingController();

  String _cardType = 'Unknown';
  bool _saveCard = true;

  @override
  void initState() {
    super.initState();
    _cardController.addListener(_updateCardType);
  }

  @override
  void dispose() {
    _cardController.removeListener(_updateCardType);
    _cardController.dispose();
    _expiryController.dispose();
    _ccvController.dispose();
    super.dispose();
  }

  void _updateCardType() {
    final type = CardValidator.getCardType(_cardController.text);
    if (type != _cardType) {
      setState(() {
        _cardType = type;
      });
    }
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      context.read<CardBloc>().add(
        AddNewCardEvent(
          cardNumber: _cardController.text,
          expiryDate: _expiryController.text,
          cvc: _ccvController.text,
          saveToVault: widget.isPurchaseFlow ? _saveCard : true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<CardBloc, CardState>(
          listener: (context, state) {
            // 1. Случай разовой оплаты
            if (state is CardOneTimePaymentReady) {
              Navigator.pop(context, {
                'paymentMethodId': state.paymentMethodId,
                'saveCard': false,
              });
            }

            // 2. Случай успешного сохранения карты в БД
            if (state is CardOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translateErrorMessage(context, state.message)),
                  backgroundColor: Colors.green,
                ),
              );
              if (context.canPop()) context.pop(true);
            }

            // 3. Ошибка
            if (state is CardFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translateErrorMessage(context, state.error)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is CardLoading;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              ShadowedBackButton(
                                onPressed: () => context.pop(),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                s.newCard,
                                style: GoogleFonts.jura(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 60),

                          // Поле номера карты
                          TextFormField(
                            controller: _cardController,
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(19),
                              CardNumberInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              labelText: s.cardNumberLabel,
                              hintText: s.cardNumberHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  CardAssets.getLogoByBrand(_cardType),
                                  width: 32,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.credit_card,
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ),
                            validator: (v) {
                              final value = v ?? '';
                              final cleanValue = value.replaceAll(' ', '');
                              if (cleanValue.isEmpty) return s.enterCardNumber;
                              if (cleanValue.length < 16)
                                return s.cardNumberTooShort;
                              if (!CardValidator.validateSum52(value))
                                return s.invalidCardNumber;
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Срок действия и CVV
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _expiryController,
                                  keyboardType: TextInputType.number,
                                  enabled: !isLoading,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    ExpiryDateInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: s.expiryDateLabel,
                                    hintText: '12/25',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (v) {
                                    if (v == null || v.isEmpty)
                                      return s.fieldRequired;
                                    if (!v.contains('/'))
                                      return s.invalidFormat;
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _ccvController,
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  enabled: !isLoading,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: s.cvvLabel,
                                    hintText: '123',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (v) => (v?.length ?? 0) < 3
                                      ? s.invalidCvv
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Чекбокс сохранения
                          if (widget.isPurchaseFlow)
                            Row(
                              children: [
                                Checkbox(
                                  value: _saveCard,
                                  activeColor: Colors.black,
                                  onChanged: isLoading
                                      ? null
                                      : (v) => setState(
                                          () => _saveCard = v ?? true,
                                        ),
                                ),
                                Expanded(
                                  child: Text(
                                    s.saveCardForLater,
                                    style: GoogleFonts.jura(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Кнопка внизу экрана
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        )
                      : CustomButton(text: s.linkCard, onPressed: _onSubmit),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
