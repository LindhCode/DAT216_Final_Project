import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';
import '../checkout/checkout_widgets.dart';

class SwedishPhoneTextInputFormatter extends TextInputFormatter {
  static const int _maxDigits = 10;

  String _formatDigits(String digits) {
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}';
    }
    if (digits.length <= 8) {
      return '${digits.substring(0, 3)}-${digits.substring(3, 6)} ${digits.substring(6)}';
    }
    return '${digits.substring(0, 3)}-${digits.substring(3, 6)} ${digits.substring(6, 8)} ${digits.substring(8)}';
  }

  int _countDigitsBefore(String text, int offset) {
    final safeOffset = offset.clamp(0, text.length);
    return text
        .substring(0, safeOffset)
        .replaceAll(RegExp(r'[^0-9]'), '')
        .length;
  }

  int _cursorPositionForDigits(String formatted, int digitsBefore) {
    if (digitsBefore == 0) return 0;
    var digitsSeen = 0;
    for (var index = 0; index < formatted.length; index++) {
      if (RegExp(r'\d').hasMatch(formatted[index])) {
        digitsSeen += 1;
        if (digitsSeen == digitsBefore) {
          return index + 1;
        }
      }
    }
    return formatted.length;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final limited =
        digits.length > _maxDigits ? digits.substring(0, _maxDigits) : digits;
    final formatted = _formatDigits(limited);

    final digitsBeforeCursor = _countDigitsBefore(
      newValue.text,
      newValue.selection.end,
    );
    final cursorPosition = _cursorPositionForDigits(
      formatted,
      digitsBeforeCursor,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool isEditingPersonal = false;
  bool isEditingDelivery = false;

  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController address;
  late TextEditingController postCode;
  late TextEditingController city;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final iMat = context.read<ImatDataHandler>();
    final customer = iMat.getCustomer();
    firstName = TextEditingController(
      text: customer.firstName.isNotEmpty ? customer.firstName : 'Gjördis',
    );
    lastName = TextEditingController(
      text: customer.lastName.isNotEmpty ? customer.lastName : 'Andersson',
    );
    email = TextEditingController(
      text:
          customer.email.isNotEmpty ? customer.email : 'gjördis@andersson.com',
    );
    phone = TextEditingController(
      text:
          customer.phoneNumber.isNotEmpty
              ? customer.phoneNumber
              : '078-233 78 44',
    );
    address = TextEditingController(text: customer.address);
    postCode = TextEditingController(text: customer.postCode);
    city = TextEditingController(text: customer.postAddress);
  }

  void savePersonal() {
    final iMat = context.read<ImatDataHandler>();
    final customer = iMat.getCustomer();

    customer.firstName = firstName.text;
    customer.lastName = lastName.text;
    customer.email = email.text;
    customer.phoneNumber = phone.text;

    iMat.setCustomer(customer);

    setState(() => isEditingPersonal = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: const Text(
          "Uppgifter sparade",
          style: TextStyle(color: AppTheme.colorWhite),
        ),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  void saveDelivery() {
    final iMat = context.read<ImatDataHandler>();
    final customer = iMat.getCustomer();

    customer.address = address.text;
    customer.postCode = postCode.text;
    customer.postAddress = city.text;

    iMat.setCustomer(customer);

    setState(() => isEditingDelivery = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: const Text(
          "Uppgifter sparade",
          style: TextStyle(color: AppTheme.colorWhite),
        ),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  Widget field(
    String label,
    TextEditingController controller,
    bool isEditing, {
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldLabel(label),
          CheckoutTextField(
            controller: controller,
            enabled: isEditing,
            textColor: isEditing ? AppTheme.colorBlack : AppTheme.grey600,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey100,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: AppTheme.contentWidthNarrow,
            margin: const EdgeInsets.symmetric(vertical: AppTheme.paddingInset),
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mitt Konto',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeDisplay,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorBlack,
                  ),
                ),
                const SizedBox(height: AppTheme.paddingLarge),
                Container(
                  padding: const EdgeInsets.all(AppTheme.paddingLarge),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    boxShadow: const [
                      BoxShadow(
                        color: AppTheme.shadowBlack12,
                        blurRadius: AppTheme.shadowBlurLarge,
                        offset: AppTheme.shadowOffsetCard,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Personuppgifter",
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeHeadingSmall,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textMain,
                        ),
                      ),
                      const SizedBox(height: AppTheme.paddingInset),
                      field("Förnamn", firstName, isEditingPersonal),
                      field("Efternamn", lastName, isEditingPersonal),
                      field("Email", email, isEditingPersonal),
                      field(
                        "Telefon",
                        phone,
                        isEditingPersonal,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [SwedishPhoneTextInputFormatter()],
                      ),
                      const SizedBox(height: AppTheme.paddingInset),
                      Align(
                        alignment: Alignment.centerRight,
                        child:
                            isEditingPersonal
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    NavButton(
                                      label: 'Avbryt',
                                      onPressed: () {
                                        final iMat =
                                            context.read<ImatDataHandler>();
                                        final customer = iMat.getCustomer();

                                        firstName.text = customer.firstName;
                                        lastName.text = customer.lastName;
                                        email.text = customer.email;
                                        phone.text = customer.phoneNumber;

                                        setState(
                                          () => isEditingPersonal = false,
                                        );
                                      },
                                      outlined: true,
                                    ),
                                    const SizedBox(
                                      width: AppTheme.paddingMedium,
                                    ),
                                    ElevatedButton(
                                      onPressed: savePersonal,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.primaryGreen,
                                        foregroundColor: AppTheme.colorWhite,
                                        disabledBackgroundColor:
                                            AppTheme.buttonDisabledBackground,
                                        disabledForegroundColor:
                                            AppTheme.buttonDisabledForeground,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppTheme.paddingLarge,
                                          vertical: AppTheme.paddingMedium,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppTheme.radiusFull,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Spara',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppTheme.fontSizeBodyLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : ElevatedButton(
                                  onPressed: () {
                                    setState(() => isEditingPersonal = true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                    foregroundColor: AppTheme.colorWhite,
                                    disabledBackgroundColor:
                                        AppTheme.buttonDisabledBackground,
                                    disabledForegroundColor:
                                        AppTheme.buttonDisabledForeground,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.paddingLarge,
                                      vertical: AppTheme.paddingMedium,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusFull,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Redigera',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppTheme.fontSizeBodyLarge,
                                    ),
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.paddingLarge),
                Container(
                  padding: const EdgeInsets.all(AppTheme.paddingLarge),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    boxShadow: const [
                      BoxShadow(
                        color: AppTheme.shadowBlack12,
                        blurRadius: AppTheme.shadowBlurLarge,
                        offset: AppTheme.shadowOffsetCard,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Leveransuppgifter",
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeHeadingSmall,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textMain,
                        ),
                      ),
                      const SizedBox(height: AppTheme.paddingInset),
                      field("Gatuadress", address, isEditingDelivery),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: field(
                              "Postnummer",
                              postCode,
                              isEditingDelivery,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppTheme.paddingMedium),
                          Expanded(
                            flex: 3,
                            child: field("Ort", city, isEditingDelivery),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.paddingInset),
                      Align(
                        alignment: Alignment.centerRight,
                        child:
                            isEditingDelivery
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    NavButton(
                                      label: 'Avbryt',
                                      onPressed: () {
                                        final iMat =
                                            context.read<ImatDataHandler>();
                                        final customer = iMat.getCustomer();

                                        address.text = customer.address;
                                        postCode.text = customer.postCode;
                                        city.text = customer.postAddress;

                                        setState(
                                          () => isEditingDelivery = false,
                                        );
                                      },
                                      outlined: true,
                                    ),
                                    const SizedBox(
                                      width: AppTheme.paddingMedium,
                                    ),
                                    ElevatedButton(
                                      onPressed: saveDelivery,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.primaryGreen,
                                        foregroundColor: AppTheme.colorWhite,
                                        disabledBackgroundColor:
                                            AppTheme.buttonDisabledBackground,
                                        disabledForegroundColor:
                                            AppTheme.buttonDisabledForeground,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppTheme.paddingLarge,
                                          vertical: AppTheme.paddingMedium,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppTheme.radiusFull,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Spara',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppTheme.fontSizeBodyLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : ElevatedButton(
                                  onPressed: () {
                                    setState(() => isEditingDelivery = true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                    foregroundColor: AppTheme.colorWhite,
                                    disabledBackgroundColor:
                                        AppTheme.buttonDisabledBackground,
                                    disabledForegroundColor:
                                        AppTheme.buttonDisabledForeground,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.paddingLarge,
                                      vertical: AppTheme.paddingMedium,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusFull,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Redigera',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppTheme.fontSizeBodyLarge,
                                    ),
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
