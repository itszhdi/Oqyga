import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/organizer/domain/entities/create_event_request.dart';
import 'package:oqyga_frontend/features/organizer/domain/entities/ticket_type_request.dart';
import 'package:oqyga_frontend/features/organizer/presentation/bloc/event_form/event_form_bloc.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/city.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/button.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';
import 'package:oqyga_frontend/features/organizer/presentation/widgets/build_text_field.dart';
import 'package:oqyga_frontend/features/organizer/presentation/widgets/ticket_type_row.dart';
import 'package:oqyga_frontend/features/organizer/presentation/widgets/event_image_picker.dart';

class EventFormView extends StatefulWidget {
  final bool isEditMode;
  final String title;

  const EventFormView({
    super.key,
    required this.isEditMode,
    required this.title,
  });

  @override
  State<EventFormView> createState() => _EventFormViewState();
}

class _EventFormViewState extends State<EventFormView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<TicketTypeControllers> _ticketControllers = [];

  City? selectedCity;
  Category? selectedCategory;
  File? _posterImage;
  String? _existingPosterUrl;

  final ImagePicker _picker = ImagePicker();
  bool _isDataPopulated = false;

  final OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.black, width: 1.2),
  );

  @override
  void initState() {
    super.initState();
    if (!widget.isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_ticketControllers.isEmpty) {
          _addTicketType();
        }
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    for (var c in _ticketControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addTicketType() {
    if (_ticketControllers.length < 5) {
      setState(() {
        _ticketControllers.add(TicketTypeControllers());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).maxTicketCategoriesError)),
      );
    }
  }

  void _removeTicketType(int index) {
    if (_ticketControllers.length > 1) {
      setState(() {
        _ticketControllers[index].dispose();
        _ticketControllers.removeAt(index);
      });
    }
  }

  Future<void> _pickPoster() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (image != null) {
      setState(() {
        _posterImage = File(image.path);
        _existingPosterUrl = null;
      });
    }
  }

  Future<void> _pickDate() async {
    DateTime initialDate = DateTime.now();
    if (dateController.text.isNotEmpty) {
      try {
        initialDate = DateTime.parse(dateController.text);
      } catch (_) {}
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: Localizations.localeOf(context),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        String formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        dateController.text = formattedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay initialTime = TimeOfDay.now();
    if (timeController.text.isNotEmpty) {
      try {
        final parts = timeController.text.split(':');
        if (parts.length >= 2) {
          initialTime = TimeOfDay(
            hour: int.parse(parts[0]),
            minute: int.parse(parts[1]),
          );
        }
      } catch (_) {}
    }
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        timeController.text = "$hour:$minute:00";
      });
    }
  }

  void _saveEvent() {
    final s = S.of(context);
    if (titleController.text.isEmpty ||
        (_posterImage == null && _existingPosterUrl == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(s.addPosterAndTitleError),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }

    List<TicketTypeRequest> ticketRequests = [];
    int totalSeats = 0;

    for (var ctrl in _ticketControllers) {
      if (ctrl.nameController.text.isEmpty ||
          ctrl.priceController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s.fillAllTicketDataError),
            backgroundColor: Colors.black,
          ),
        );
        return;
      }

      final qty = int.tryParse(ctrl.quantityController.text) ?? 0;
      totalSeats += qty;

      ticketRequests.add(
        TicketTypeRequest(
          description: ctrl.nameController.text,
          price: double.tryParse(ctrl.priceController.text) ?? 0.0,
          quantity: qty,
        ),
      );
    }

    final request = CreateEventRequest(
      title: titleController.text,
      date: dateController.text.isNotEmpty ? dateController.text : null,
      time: timeController.text.isNotEmpty ? timeController.text : null,
      cityId: selectedCity?.cityId,
      categoryId: selectedCategory?.categoryId,
      address: addressController.text.isNotEmpty
          ? addressController.text
          : null,
      description: descriptionController.text.isNotEmpty
          ? descriptionController.text
          : null,
      posterImage: _posterImage,
      existingPosterUrl: _existingPosterUrl,
      ticketTypes: ticketRequests,
      seats: totalSeats.toString(),
    );

    context.read<EventFormBloc>().add(
      FormSubmitted(
        request: request,
        isEditMode: widget.isEditMode,
        eventId: widget.isEditMode
            ? context.read<EventFormBloc>().state.initialEvent?.id
            : null,
      ),
    );
  }

  void _populateFormIfNeeded(EventFormState state) {
    if (widget.isEditMode &&
        !_isDataPopulated &&
        state.status == EventFormStatus.ready) {
      final event = state.initialEvent;
      if (event != null) {
        titleController.text = event.title;
        dateController.text = event.date;
        timeController.text = event.time;
        addressController.text = event.address;
        descriptionController.text = event.description;
        _existingPosterUrl = event.imageUrl;

        if (event.ticketTypes.isNotEmpty) {
          for (var c in _ticketControllers) {
            c.dispose();
          }
          _ticketControllers.clear();
          for (var t in event.ticketTypes) {
            final ctrl = TicketTypeControllers();
            ctrl.nameController.text = t.description;
            ctrl.priceController.text = t.price.toStringAsFixed(0);
            ctrl.quantityController.text = t.quantity.toString();
            _ticketControllers.add(ctrl);
          }
        } else {
          if (_ticketControllers.isEmpty) {
            _ticketControllers.add(TicketTypeControllers());
          }
          _ticketControllers[0].priceController.text = event.minPrice;
          _ticketControllers[0].quantityController.text = event.peopleAmount
              .toString();
          _ticketControllers[0].nameController.text = S
              .of(context)
              .standardTicketName;
        }

        try {
          selectedCity = state.cities.firstWhere(
            (c) => c.cityId == event.cityId,
          );
        } catch (_) {}

        try {
          selectedCategory = state.categories.firstWhere(
            (c) => c.categoryId == event.categoryId,
          );
        } catch (_) {}

        setState(() {
          _isDataPopulated = true;
        });
      }
    }
  }

  void _clearForm() {
    titleController.clear();
    dateController.clear();
    timeController.clear();
    addressController.clear();
    descriptionController.clear();
    for (var c in _ticketControllers) c.dispose();
    _ticketControllers.clear();
    _ticketControllers.add(TicketTypeControllers());
    setState(() {
      selectedCity = null;
      selectedCategory = null;
      _posterImage = null;
      _existingPosterUrl = null;
      _isDataPopulated = false;
    });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<EventFormBloc, EventFormState>(
      listener: (context, state) {
        if (state.status == EventFormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.isEditMode
                    ? s.eventUpdatedSuccess
                    : s.eventCreatedSuccess,
              ),
            ),
          );
          _clearForm();
          if (context.mounted) {
            FocusScope.of(context).unfocus();
            Future.delayed(const Duration(milliseconds: 100), () {
              if (context.mounted) context.pop(true);
            });
          }
        }
        if (state.status == EventFormStatus.failure) {
          final message = translateErrorMessage(context, state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        }
        _populateFormIfNeeded(state);
      },
      builder: (context, state) {
        if (state.status == EventFormStatus.loading ||
            state.status == EventFormStatus.initial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        children: [
                          if (widget.isEditMode) ...[
                            ShadowedBackButton(onPressed: () => context.pop()),
                            const SizedBox(width: 16),
                          ],
                          Expanded(
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    EventImagePicker(
                      imageFile: _posterImage,
                      existingImageUrl: _existingPosterUrl,
                      onTap: _pickPoster,
                      isEditMode: widget.isEditMode,
                    ),

                    const SizedBox(height: 32),

                    _buildSectionHeader(s.basicInfoTitle),

                    buildTextField(
                      controller: titleController,
                      hintText: s.eventNameHint,
                      border: inputBorder,
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: dateController,
                            readOnly: true,
                            onTap: _pickDate,
                            decoration: InputDecoration(
                              hintText: s.dateHint,
                              prefixIcon: const Icon(
                                Icons.calendar_today_outlined,
                              ),
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: timeController,
                            readOnly: true,
                            onTap: _pickTime,
                            decoration: InputDecoration(
                              hintText: s.timeHint,
                              prefixIcon: const Icon(Icons.access_time),
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    DropdownButtonFormField<City>(
                      value: selectedCity,
                      isExpanded: true,
                      menuMaxHeight: 250,
                      decoration: InputDecoration(
                        hintText: s.chooseCityHint,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      items: state.cities
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(c.cityName),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => selectedCity = val),
                    ),
                    const SizedBox(height: 12),

                    DropdownButtonFormField<Category>(
                      value: selectedCategory,
                      isExpanded: true,
                      menuMaxHeight: 250,
                      decoration: InputDecoration(
                        hintText: s.categoryHint,
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      items: state.categories
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(c.categoryName),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => selectedCategory = val),
                    ),
                    const SizedBox(height: 12),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return state.previousVenues;
                            }
                            return state.previousVenues.where((String option) {
                              return option.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              );
                            });
                          },
                          onSelected: (String selection) {
                            addressController.text = selection;
                          },
                          fieldViewBuilder:
                              (
                                context,
                                textEditingController,
                                focusNode,
                                onFieldSubmitted,
                              ) {
                                if (addressController.text !=
                                    textEditingController.text) {
                                  textEditingController.text =
                                      addressController.text;
                                }
                                textEditingController.addListener(() {
                                  addressController.text =
                                      textEditingController.text;
                                });
                                return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    hintText: s.venueAddressHint,
                                    prefixIcon: const Icon(
                                      Icons.location_on_outlined,
                                    ),
                                    border: inputBorder,
                                    enabledBorder: inputBorder,
                                    focusedBorder: inputBorder,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                );
                              },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: constraints.maxWidth,
                                  constraints: const BoxConstraints(
                                    maxHeight: 200,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          final String option = options
                                              .elementAt(index);
                                          return InkWell(
                                            onTap: () => onSelected(option),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                16.0,
                                              ),
                                              child: Text(option),
                                            ),
                                          );
                                        },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    _buildSectionHeader(s.pricesAndTicketsTitle),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _ticketControllers.length,
                      itemBuilder: (context, index) {
                        return TicketTypeRow(
                          controllers: _ticketControllers[index],
                          index: index,
                          showDeleteButton: _ticketControllers.length > 1,
                          onRemove: () => _removeTicketType(index),
                          border: inputBorder,
                        );
                      },
                    ),

                    if (_ticketControllers.length < 5)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: _addTicketType,
                          icon: const Icon(Icons.add, color: Colors.black),
                          label: Text(
                            s.addPriceCategoryButton,
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 25),

                    _buildSectionHeader(s.descriptionTitle),

                    buildTextField(
                      controller: descriptionController,
                      hintText: s.eventDescriptionHint,
                      border: inputBorder,
                      maxLines: 6,
                      inputType: TextInputType.multiline,
                    ),

                    const SizedBox(height: 40),
                    state.status == EventFormStatus.submitting
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: s.saveButton,
                            onPressed: _saveEvent,
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
