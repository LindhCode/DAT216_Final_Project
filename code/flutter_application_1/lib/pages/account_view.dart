// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:provider/provider.dart';

// class AccountView extends StatefulWidget {
//   const AccountView({super.key});

//   @override
//   State<AccountView> createState() => _AccountViewState();
// }

// class _AccountViewState extends State<AccountView> {
//   bool isEditing = false;

//   late TextEditingController firstName;
//   late TextEditingController lastName;
//   late TextEditingController email;
//   late TextEditingController phone;
//   late TextEditingController mobile;
//   late TextEditingController address;
//   late TextEditingController postCode;
//   late TextEditingController city;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final iMat = context.read<ImatDataHandler>();
//     final customer = iMat.getCustomer();

//     firstName = TextEditingController(text: customer.firstName);
//     lastName = TextEditingController(text: customer.lastName);
//     email = TextEditingController(text: customer.email);
//     phone = TextEditingController(text: customer.phoneNumber);
//     mobile = TextEditingController(text: customer.mobilePhoneNumber);
//     address = TextEditingController(text: customer.address);
//     postCode = TextEditingController(text: customer.postCode);
//     city = TextEditingController(text: customer.postAddress);
//   }

//   void save() {
//     final iMat = context.read<ImatDataHandler>();
//     final customer = iMat.getCustomer();

//     customer.firstName = firstName.text;
//     customer.lastName = lastName.text;
//     customer.email = email.text;
//     customer.phoneNumber = phone.text;
//     customer.mobilePhoneNumber = mobile.text;
//     customer.address = address.text;
//     customer.postCode = postCode.text;
//     customer.postAddress = city.text;

//     iMat.setCustomer(customer);

//     setState(() => isEditing = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Uppgifter sparade")),
//     );
//   }

//   Widget field(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         controller: controller,
//         enabled: isEditing,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget info(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 140,
//             child: Text(
//               "$label:",
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//           Expanded(child: Text(value.isEmpty ? "-" : value)),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Mitt konto"),
//         backgroundColor: Colors.grey[900],
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Container(
//           width: 600,
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: const [
//               BoxShadow(color: Colors.black12, blurRadius: 10),
//             ],
//           ),
//           child: Consumer<ImatDataHandler>(
//             builder: (context, iMat, _) {
//               final c = iMat.getCustomer();

//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Personuppgifter",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 20),

//                   isEditing
//                       ? Column(
//                           children: [
//                             field("Förnamn", firstName),
//                             field("Efternamn", lastName),
//                             field("Email", email),
//                             field("Telefon", phone),
//                             field("Mobil", mobile),
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             info("Förnamn", c.firstName),
//                             info("Efternamn", c.lastName),
//                             info("Email", c.email),
//                             info("Telefon", c.phoneNumber),
//                             info("Mobil", c.mobilePhoneNumber),
//                           ],
//                         ),

//                   const SizedBox(height: 20),
//                   const Divider(),

//                   const SizedBox(height: 20),

//                   const Text(
//                     "Adress",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 10),

//                   isEditing
//                       ? Column(
//                           children: [
//                             field("Adress", address),
//                             field("Postnummer", postCode),
//                             field("Stad", city),
//                           ],
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(c.address),
//                             Text("${c.postCode} ${c.postAddress}"),
//                           ],
//                         ),

//                   const SizedBox(height: 30),

//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[900],
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         if (isEditing) {
//                           save();
//                         } else {
//                           setState(() => isEditing = true);
//                         }
//                       },
//                       child: Text(isEditing ? "Spara" : "Redigera"),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Uppgifter sparade")),
    );
  }

  Widget field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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

                const SizedBox(height: 20),

                field("Förnamn", firstName),
                field("Efternamn", lastName),
                field("Email", email),
                field("Telefon", phone),
                field("Mobil", mobile),

                const SizedBox(height: 20),

                const Divider(),

                const SizedBox(height: 20),

                const Text(
                  "Adress",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                field("Adress", address),
                field("Postnummer", postCode),
                field("Stad", city),

                const SizedBox(height: 30),

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