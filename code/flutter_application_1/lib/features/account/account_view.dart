import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';
import '../checkout/checkout_widgets.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool isEditing = false;

  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController mobile;
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
    mobile = TextEditingController(text: customer.mobilePhoneNumber);
    address = TextEditingController(text: customer.address);
    postCode = TextEditingController(text: customer.postCode);
    city = TextEditingController(text: customer.postAddress);
  }

  void save() {
    final iMat = context.read<ImatDataHandler>();
    final customer = iMat.getCustomer();

    customer.firstName = firstName.text;
    customer.lastName = lastName.text;
    customer.email = email.text;
    customer.phoneNumber = phone.text;
    customer.mobilePhoneNumber = mobile.text;
    customer.address = address.text;
    customer.postCode = postCode.text;
    customer.postAddress = city.text;

    iMat.setCustomer(customer);

    setState(() => isEditing = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Uppgifter sparade")));
  }

  Widget field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldLabel(label),
          CheckoutTextField(controller: controller, enabled: isEditing),
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
                          fontSize: AppTheme.fontSizeHeading,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.paddingInset),
                      field("Förnamn", firstName),
                      field("Efternamn", lastName),
                      field("Email", email),
                      field("Telefon", phone),
                      field("Mobil", mobile),
                      const SizedBox(height: AppTheme.paddingInset),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                            foregroundColor: AppTheme.colorWhite,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.paddingLarge,
                              vertical: AppTheme.paddingSmall,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusFull,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (isEditing) {
                              save();
                            } else {
                              setState(() => isEditing = true);
                            }
                          },
                          child: Text(isEditing ? "Spara" : "Redigera"),
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
