import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step2Leverans extends StatefulWidget {
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController postCodeCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController notesCtrl;
  final DateTime? selectedDate;
  final String deliveryTime;
  final ValueChanged<DateTime?> onDeliveryDateChanged;
  final ValueChanged<String> onDeliveryTimeChanged;
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
    required this.selectedDate,
    required this.deliveryTime,
    required this.onDeliveryDateChanged,
    required this.onDeliveryTimeChanged,
    required this.onNext,
    required this.onPrev,
  });

  @override
  State<Step2Leverans> createState() => _Step2LeveransState();
}

class _Step2LeveransState extends State<Step2Leverans> {
  DateTime? selectedDate;
  String? selectedDeliveryTime;
  String selectedDeliveryMethod = 'standard';

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
    selectedDeliveryTime = widget.deliveryTime.isNotEmpty ? widget.deliveryTime : null;
    _prefillCustomerData();
  }

  void _prefillCustomerData() {
    final iMat = context.read<ImatDataHandler>();
    final customer = iMat.getCustomer();

    if (widget.firstNameCtrl.text.isEmpty && customer.firstName.isNotEmpty) {
      widget.firstNameCtrl.text = customer.firstName;
    }
    if (widget.lastNameCtrl.text.isEmpty && customer.lastName.isNotEmpty) {
      widget.lastNameCtrl.text = customer.lastName;
    }
    if (widget.addressCtrl.text.isEmpty && customer.address.isNotEmpty) {
      widget.addressCtrl.text = customer.address;
    }
    if (widget.postCodeCtrl.text.isEmpty && customer.postCode.isNotEmpty) {
      widget.postCodeCtrl.text = customer.postCode;
    }
    if (widget.cityCtrl.text.isEmpty && customer.postAddress.isNotEmpty) {
      widget.cityCtrl.text = customer.postAddress;
    }
  }

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
          constraints: const BoxConstraints(maxWidth: AppTheme.contentWidthCheckout),
          child: Column(
            children: [
              const Text(
                '2. Leverans',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeDisplaySmall,
                  fontWeight: FontWeight.bold,
                  color: CheckoutTheme.textDark,
                ),
              ),
              const SizedBox(height: AppTheme.paddingLarge),
              CheckoutCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vart ska vi leverera?',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeHeadingSmall,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textMain,
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
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
                    const SizedBox(height: AppTheme.paddingMedium),
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
                    const SizedBox(height: AppTheme.paddingMedium),
                    const FieldLabel('Leveransdatum'),
                    Material(
                      color: AppTheme.colorTransparent,
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
                                    onPrimary: AppTheme.colorWhite,
                                    surface: AppTheme.cardBackground,
                                    onSurface: AppTheme.textMutedStrong,
                                  ),
                                  dialogBackgroundColor: AppTheme.cardBackground,
                                  textButtonTheme: TextButtonThemeData(
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStateProperty.all(
                                        AppTheme.colorBlack,
                                      ),
                                      textStyle: WidgetStateProperty.all(
                                        const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppTheme.fontSizeBody,
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
                            widget.onDeliveryDateChanged(picked);
                          }
                        },
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.paddingMedium,
                            vertical: AppTheme.paddingBlock,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.grey50,
                            border: Border.all(
                              color:
                                  selectedDate != null
                                      ? AppTheme.grey700
                                      : CheckoutTheme.border,
                              width:
                                  selectedDate != null
                                      ? AppTheme.borderBold
                                      : AppTheme.borderStandard,
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
                                  fontSize: AppTheme.fontSizeBodyLarge,
                                  fontWeight:
                                      selectedDate != null
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                  color:
                                      selectedDate != null
                                          ? AppTheme.textMutedStrong
                                          : AppTheme.grey600,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_rounded,
                                size: AppTheme.iconSizeStandard,
                                color:
                                    selectedDate != null
                                        ? AppTheme.grey700
                                        : AppTheme.grey500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    const FieldLabel('Leveranstid'),
                    DropdownButtonFormField<String>(
                      value: selectedDeliveryTime,
                      hint: const Text(
                        'Välj tid',
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeBodyLarge,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizeBodyLarge,
                        color: AppTheme.colorBlack,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppTheme.grey50,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          borderSide: const BorderSide(color: CheckoutTheme.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          borderSide: BorderSide(color: AppTheme.primaryGreen),
                        ),
                      ),
                      items: const [
                        '12:00 - 14:00',
                        '14:00 - 16:00',
                        '16:00 - 18:00',
                        '18:00 - 20:00',
                      ].map((time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedDeliveryTime = value;
                          });
                          widget.onDeliveryTimeChanged(value);
                        }
                      },
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
