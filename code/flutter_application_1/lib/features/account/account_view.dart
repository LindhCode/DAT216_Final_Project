import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

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

    firstName = TextEditingController(text: customer.firstName);
    lastName = TextEditingController(text: customer.lastName);
    email = TextEditingController(text: customer.email);
    phone = TextEditingController(text: customer.phoneNumber);
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
      child: TextField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Mitt konto"),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),

      // 🚀 SCROLL FIX (VIKTIGT)
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 600,
            margin: const EdgeInsets.symmetric(vertical: AppTheme.paddingInset),
            padding: const EdgeInsets.all(AppTheme.paddingLarge),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Personuppgifter",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: AppTheme.paddingInset),

                field("Förnamn", firstName),
                field("Efternamn", lastName),
                field("Email", email),
                field("Telefon", phone),
                field("Mobil", mobile),

                const SizedBox(height: AppTheme.paddingInset),

                const Divider(),

                const SizedBox(height: AppTheme.paddingInset),

                const Text(
                  "Adress",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: AppTheme.paddingCompact),

                field("Adress", address),
                field("Postnummer", postCode),
                field("Stad", city),

                const SizedBox(height: AppTheme.paddingSection),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      foregroundColor: Colors.white,
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
        ),
      ),
    );
  }
}
