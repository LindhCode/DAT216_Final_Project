import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step2Leverans extends StatefulWidget {
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController postCodeCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController notesCtrl;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const Step2Leverans({
    super.key,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.addressCtrl,
    required this.postCodeCtrl,
    required this.cityCtrl,
    required this.notesCtrl,
    required this.onNext,
    required this.onPrev,
  });

  @override
  State<Step2Leverans> createState() => _Step2LeveransState();
}

class _Step2LeveransState extends State<Step2Leverans> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.firstNameCtrl,
        widget.lastNameCtrl,
        widget.addressCtrl,
        widget.postCodeCtrl,
        widget.cityCtrl,
      ]),
      builder: (context, _) {
        bool isValid =
            widget.firstNameCtrl.text.isNotEmpty &&
            widget.lastNameCtrl.text.isNotEmpty &&
            widget.addressCtrl.text.isNotEmpty &&
            widget.postCodeCtrl.text.isNotEmpty &&
            widget.cityCtrl.text.isNotEmpty &&
            selectedDate != null;

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              const Text(
                '2. Leverans',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              CheckoutCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vart ska vi leverera?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Förnamn'),
                              CheckoutTextField(
                                controller: widget.firstNameCtrl,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppTheme.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Efternamn'),
                              CheckoutTextField(
                                controller: widget.lastNameCtrl,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const FieldLabel('Gatuadress'),
                    CheckoutTextField(controller: widget.addressCtrl),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Postnummer'),
                              CheckoutTextField(
                                controller: widget.postCodeCtrl,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppTheme.paddingMedium),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Ort'),
                              CheckoutTextField(controller: widget.cityCtrl),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const FieldLabel('Leveransdatum'),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 30),
                            ),
                            confirmText: 'Ok',
                            cancelText: 'Avbryt',
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Theme.of(context).primaryColor,
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.black87,
                                  ),
                                  dialogBackgroundColor: Colors.white,
                                  textButtonTheme: TextButtonThemeData(
                                    style: ButtonStyle(
                                      // Gör texten svart i modalen
                                      foregroundColor: WidgetStateProperty.all(
                                        Colors.black,
                                      ),
                                      // Detta förhindrar att Flutter tvingar texten till ALL CAPS ("OK"/"AVBRYT")
                                      textStyle: WidgetStateProperty.all(
                                        const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.paddingMedium,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color:
                                selectedDate != null
                                    ? Theme.of(
                                      context,
                                    ).primaryColor.withAlpha(13)
                                    : Colors.grey[50],
                            border: Border.all(
                              color:
                                  selectedDate != null
                                      ? Theme.of(context).primaryColor
                                      : CheckoutTheme.border,
                              width: selectedDate != null ? 1.5 : 1.0,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusMedium,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate != null
                                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                    : 'Välj datum',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                      selectedDate != null
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                  color:
                                      selectedDate != null
                                          ? Colors.black87
                                          : Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 20,
                                color:
                                    selectedDate != null
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[500],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.paddingMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavButton(
                    label: '< Tillbaka',
                    onPressed: widget.onPrev,
                    outlined: true,
                  ),
                  NavButton(
                    label: 'Betalning >',
                    onPressed: isValid ? widget.onNext : null,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
