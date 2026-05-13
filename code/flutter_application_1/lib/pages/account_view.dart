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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],

//       appBar: AppBar(
//         title: const Text("Mitt konto"),
//         backgroundColor: Colors.grey[900],
//         foregroundColor: Colors.white,
//       ),

//       // 🚀 SCROLL FIX (VIKTIGT)
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             width: 600,
//             margin: const EdgeInsets.symmetric(vertical: 20),
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: const [
//                 BoxShadow(color: Colors.black12, blurRadius: 10),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Personuppgifter",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),

//                 const SizedBox(height: 20),

//                 field("Förnamn", firstName),
//                 field("Efternamn", lastName),
//                 field("Email", email),
//                 field("Telefon", phone),
//                 field("Mobil", mobile),

//                 const SizedBox(height: 20),

//                 const Divider(),

//                 const SizedBox(height: 20),

//                 const Text(
//                   "Adress",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),

//                 const SizedBox(height: 10),

//                 field("Adress", address),
//                 field("Postnummer", postCode),
//                 field("Stad", city),

//                 const SizedBox(height: 30),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[900],
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       if (isEditing) {
//                         save();
//                       } else {
//                         setState(() => isEditing = true);
//                       }
//                     },
//                     child: Text(isEditing ? "Spara" : "Redigera"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:provider/provider.dart';

// class AccountView extends StatefulWidget {
//   final VoidCallback onBack;

//   const AccountView({super.key, required this.onBack});

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
//           filled: !isEditing,
//           fillColor: isEditing ? Colors.white : Colors.grey[50],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Mitt konto"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: widget.onBack,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: TextButton.icon(
//                   onPressed: widget.onBack,
//                   icon: const Icon(Icons.chevron_left),
//                   label: const Text("Tillbaka till sortimentet"),
//                   style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
//                 ),
//               ),
//               Container(
//                 width: 600,
//                 margin: const EdgeInsets.only(bottom: 40, top: 10),
//                 padding: const EdgeInsets.all(32),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5)),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Personuppgifter",
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         ActionChip(
//                           label: Text(isEditing ? "Avbryt" : "Redigera"),
//                           onPressed: () => setState(() => isEditing = !isEditing),
//                           avatar: Icon(isEditing ? Icons.close : Icons.edit, size: 16),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//                     field("Förnamn", firstName),
//                     field("Efternamn", lastName),
//                     field("Email", email),
//                     field("Telefon", phone),
//                     field("Mobil", mobile),
//                     const SizedBox(height: 24),
//                     const Divider(),
//                     const SizedBox(height: 24),
//                     const Text(
//                       "Adress",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 16),
//                     field("Adress", address),
//                     field("Postnummer", postCode),
//                     field("Stad", city),
//                     const SizedBox(height: 40),
//                     if (isEditing)
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green[700],
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                           ),
//                           onPressed: save,
//                           child: const Text("Spara ändringar", style: TextStyle(fontSize: 16)),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:provider/provider.dart';

// class AccountView extends StatefulWidget {
//   final VoidCallback onBack;

//   const AccountView({super.key, required this.onBack});

//   @override
//   State<AccountView> createState() => _AccountViewState();
// }

// class _AccountViewState extends State<AccountView> {
//   bool isEditing = false;
//   final ScrollController _scrollController = ScrollController(); // Controller för scrollbar

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
//           filled: !isEditing,
//           fillColor: isEditing ? Colors.white : Colors.grey[50],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       // Statisk AppBar som aldrig scrollar bort
//       appBar: AppBar(
//         title: const Text(
//           "Mitt konto", 
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1, // Ger en liten skugga för att separera från innehållet
//         foregroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: widget.onBack,
//         ),
//       ),
//       body: Scrollbar(
//         controller: _scrollController,
//         thumbVisibility: true, // Gör scrollbaren alltid synlig
//         thickness: 8.0,
//         radius: const Radius.circular(10),
//         child: SingleChildScrollView(
//           controller: _scrollController,
//           child: Center(
//             child: Column(
//               children: [
//                 const SizedBox(height: 20), // Luft i toppen
//                 Container(
//                   width: 600,
//                   margin: const EdgeInsets.only(bottom: 40),
//                   padding: const EdgeInsets.all(32),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12, 
//                         blurRadius: 15, 
//                         offset: Offset(0, 5)
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Personuppgifter",
//                             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                           ),
//                           ActionChip(
//                             label: Text(isEditing ? "Avbryt" : "Redigera"),
//                             onPressed: () => setState(() => isEditing = !isEditing),
//                             avatar: Icon(isEditing ? Icons.close : Icons.edit, size: 16),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                       field("Förnamn", firstName),
//                       field("Efternamn", lastName),
//                       field("Email", email),
//                       field("Telefon", phone),
//                       field("Mobil", mobile),
//                       const SizedBox(height: 24),
//                       const Divider(),
//                       const SizedBox(height: 24),
//                       const Text(
//                         "Adress",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 16),
//                       field("Adress", address),
//                       field("Postnummer", postCode),
//                       field("Stad", city),
//                       const SizedBox(height: 40),
//                       if (isEditing)
//                         SizedBox(
//                           width: double.infinity,
//                           height: 50,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green[700],
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8)
//                               ),
//                             ),
//                             onPressed: save,
//                             child: const Text("Spara ändringar", style: TextStyle(fontSize: 16)),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:provider/provider.dart';

// class AccountView extends StatefulWidget {
//   final VoidCallback onBack;

//   const AccountView({super.key, required this.onBack});

//   @override
//   State<AccountView> createState() => _AccountViewState();
// }

// class _AccountViewState extends State<AccountView> {
//   bool isEditing = false;
//   final ScrollController _scrollController = ScrollController();

//   late TextEditingController firstName;
//   late TextEditingController lastName;
//   late TextEditingController email;
//   late TextEditingController phone;
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
//           filled: !isEditing,
//           fillColor: isEditing ? Colors.white : Colors.grey[50],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Column(
//         children: [
//           // ========================
//           // STATISK HEADER (Följer INTE med vid scroll)
//           // ========================
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               bottom: false,
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: widget.onBack,
//                   ),
//                   const SizedBox(width: 8),
//                   const Text(
//                     "Mitt konto",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ========================
//           // SCROLLBART INNEHÅLL
//           // ========================
//           Expanded(
//             child: Scrollbar(
//               controller: _scrollController,
//               thumbVisibility: true, // Alltid synlig
//               trackVisibility: true, // Visa spåret bakom för extra tydlighet
//               thickness: 10,
//               radius: const Radius.circular(10),
//               child: SingleChildScrollView(
//                 controller: _scrollController,
//                 physics: const AlwaysScrollableScrollPhysics(), // Tillåt scroll även om kort
//                 padding: const EdgeInsets.symmetric(vertical: 30),
//                 child: Center(
//                   child: Container(
//                     width: 600,
//                     padding: const EdgeInsets.all(32),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 15,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Personuppgifter",
//                               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                             ),
//                             ActionChip(
//                               label: Text(isEditing ? "Avbryt" : "Redigera"),
//                               onPressed: () => setState(() => isEditing = !isEditing),
//                               avatar: Icon(isEditing ? Icons.close : Icons.edit, size: 16),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 24),
//                         field("Förnamn", firstName),
//                         field("Efternamn", lastName),
//                         field("Email", email),
//                         field("Telefon", phone), // Endast telefon kvar
                        
//                         const SizedBox(height: 24),
//                         const Divider(),
//                         const SizedBox(height: 24),
                        
//                         const Text(
//                           "Adress",
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 16),
//                         field("Adress", address),
//                         field("Postnummer", postCode),
//                         field("Stad", city),
                        
//                         const SizedBox(height: 40),
                        
//                         if (isEditing)
//                           SizedBox(
//                             width: double.infinity,
//                             height: 55,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green[700],
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 elevation: 2,
//                               ),
//                               onPressed: save,
//                               child: const Text(
//                                 "Spara ändringar",
//                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:provider/provider.dart';

// class AccountView extends StatefulWidget {
//   final VoidCallback onBack;

//   const AccountView({super.key, required this.onBack});

//   @override
//   State<AccountView> createState() => _AccountViewState();
// }

// class _AccountViewState extends State<AccountView> {
//   bool isEditing = false;
//   final ScrollController _scrollController = ScrollController();

//   late TextEditingController firstName;
//   late TextEditingController lastName;
//   late TextEditingController email;
//   late TextEditingController phone;
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
//         style: const TextStyle(fontSize: 16),
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           filled: !isEditing,
//           fillColor: isEditing ? Colors.white : Colors.grey[50],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Column(
//         children: [
//           // ========================
//           // STATISK RUBRIK (Ligger utanför scrollen)
//           // ========================
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey[300]!, width: 1),
//               ),
//             ),
//             child: SafeArea(
//               bottom: false,
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, size: 28),
//                     onPressed: widget.onBack,
//                   ),
//                   const SizedBox(width: 16),
//                   const Text(
//                     "Mitt konto",
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: -0.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ========================
//           // SCROLLBART FORMULÄR
//           // ========================
//           Expanded(
//             child: Theme(
//               // Tvingar scrollbaren att alltid vara synlig och tydlig
//               data: Theme.of(context).copyWith(
//                 scrollbarTheme: ScrollbarThemeData(
//                   thumbColor: WidgetStateProperty.all(Colors.grey[400]),
//                   thickness: WidgetStateProperty.all(12),
//                   radius: const Radius.circular(10),
//                   thumbVisibility: WidgetStateProperty.all(true),
//                 ),
//               ),
//               child: Scrollbar(
//                 controller: _scrollController,
//                 thumbVisibility: true,
//                 trackVisibility: true,
//                 child: SingleChildScrollView(
//                   controller: _scrollController,
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//                   child: Center(
//                     child: Container(
//                       width: 700, // Något bredare för bättre layout på desktop
//                       padding: const EdgeInsets.all(40),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.08),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Personuppgifter",
//                                 style: TextStyle(
//                                   fontSize: 22, 
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               OutlinedButton.icon(
//                                 icon: Icon(isEditing ? Icons.close : Icons.edit, size: 18),
//                                 label: Text(isEditing ? "Avbryt" : "Redigera"),
//                                 onPressed: () => setState(() => isEditing = !isEditing),
//                                 style: OutlinedButton.styleFrom(
//                                   foregroundColor: isEditing ? Colors.red : Colors.blueGrey[800],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 24),
//                           field("Förnamn", firstName),
//                           field("Efternamn", lastName),
//                           field("Email", email),
//                           field("Telefon", phone),
                          
//                           const SizedBox(height: 32),
//                           const Divider(height: 1),
//                           const SizedBox(height: 32),
                          
//                           const Text(
//                             "Adressuppgifter",
//                             style: TextStyle(
//                               fontSize: 22, 
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           field("Adress", address),
//                           field("Postnummer", postCode),
//                           field("Stad", city),
                          
//                           const SizedBox(height: 48),
                          
//                           if (isEditing)
//                             SizedBox(
//                               width: double.infinity,
//                               height: 60,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green[600],
//                                   foregroundColor: Colors.white,
//                                   elevation: 0,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 onPressed: save,
//                                 child: const Text(
//                                   "Spara ändringar",
//                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:imat_app/app_theme.dart'; // Se till att sökvägen stämmer
// import 'package:provider/provider.dart';

// class AccountView extends StatefulWidget {
//   final VoidCallback onBack;

//   const AccountView({super.key, required this.onBack});

//   @override
//   State<AccountView> createState() => _AccountViewState();
// }

// class _AccountViewState extends State<AccountView> {
//   bool isEditing = false;
//   final ScrollController _scrollController = ScrollController();

//   late TextEditingController firstName;
//   late TextEditingController lastName;
//   late TextEditingController email;
//   late TextEditingController phone;
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
//     customer.address = address.text;
//     customer.postCode = postCode.text;
//     customer.postAddress = city.text;

//     iMat.setCustomer(customer);
//     setState(() => isEditing = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Uppgifter sparade"),
//         backgroundColor: AppTheme.primaryGreen,
//       ),
//     );
//   }

//   Widget field(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingSmall),
//       child: TextField(
//         controller: controller,
//         enabled: isEditing,
//         style: const TextStyle(color: AppTheme.textMain),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: AppTheme.textSecondary),
//           border: const OutlineInputBorder(),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.textSecondary.withOpacity(0.3)),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.primaryGreen, width: 2),
//           ),
//           filled: true,
//           fillColor: isEditing ? Colors.white : AppTheme.backgroundLight,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundLight,
//       body: Column(
//         children: [
//           // ========================
//           // STATISK NAVBAR (Rubrik i mitten, pil till vänster)
//           // ========================
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(
//               horizontal: AppTheme.paddingLarge, 
//               vertical: AppTheme.paddingMedium
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey.shade300, width: 1),
//               ),
//             ),
//             child: SafeArea(
//               bottom: false,
//               child: Stack( // Stack används för att centrera rubriken oberoende av knappen
//                 alignment: Alignment.center,
//                 children: [
//                   // Tillbaka-knapp till vänster
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back, color: AppTheme.textMain, size: 28),
//                       onPressed: widget.onBack,
//                     ),
//                   ),
//                   // Rubrik i mitten
//                   const Text(
//                     "Mitt konto",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: AppTheme.textMain,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ========================
//           // SCROLLBART FORMULÄR
//           // ========================
//           Expanded(
//             child: Scrollbar(
//               controller: _scrollController,
//               thumbVisibility: true,
//               trackVisibility: true,
//               thickness: 10,
//               radius: const Radius.circular(10),
//               // Anpassar scrollbarens färg efter AppTheme
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                   scrollbarTheme: ScrollbarThemeData(
//                     thumbColor: MaterialStateProperty.all(AppTheme.primaryGreen.withOpacity(0.6)),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   controller: _scrollController,
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: const EdgeInsets.all(AppTheme.paddingHuge),
//                   child: Center(
//                     child: Container(
//                       width: 700,
//                       padding: const EdgeInsets.all(AppTheme.paddingHuge),
//                       decoration: BoxDecoration(
//                         color: AppTheme.cardBackground,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Sektion: Personuppgifter
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Personuppgifter",
//                                 style: TextStyle(
//                                   fontSize: 20, 
//                                   fontWeight: FontWeight.bold,
//                                   color: AppTheme.textMain
//                                 ),
//                               ),
//                               TextButton.icon(
//                                 icon: Icon(isEditing ? Icons.close : Icons.edit, size: 18),
//                                 label: Text(isEditing ? "Avbryt" : "Redigera"),
//                                 onPressed: () => setState(() => isEditing = !isEditing),
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: isEditing ? AppTheme.accentRed : AppTheme.primaryGreen,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: AppTheme.paddingMedium),
//                           field("Förnamn", firstName),
//                           field("Efternamn", lastName),
//                           field("Email", email),
//                           field("Telefon", phone),
                          
//                           const SizedBox(height: AppTheme.paddingHuge),
//                           const Divider(),
//                           const SizedBox(height: AppTheme.paddingHuge),
                          
//                           // Sektion: Adress
//                           const Text(
//                             "Adressuppgifter",
//                             style: TextStyle(
//                               fontSize: 20, 
//                               fontWeight: FontWeight.bold,
//                               color: AppTheme.textMain
//                             ),
//                           ),
//                           const SizedBox(height: AppTheme.paddingMedium),
//                           field("Adress", address),
//                           field("Postnummer", postCode),
//                           field("Stad", city),
                          
//                           const SizedBox(height: AppTheme.paddingHuge),
                          
//                           // Spara-knapp
//                           if (isEditing)
//                             SizedBox(
//                               width: double.infinity,
//                               height: 50,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppTheme.primaryGreen,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 onPressed: save,
//                                 child: const Text(
//                                   "Spara ändringar",
//                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:imat_app/model/imat_data_handler.dart';
// import 'package:imat_app/app_theme.dart';
// import 'package:provider/provider.dart';

// class AccountView extends StatefulWidget {
//   final VoidCallback onBack;

//   const AccountView({super.key, required this.onBack});

//   @override
//   State<AccountView> createState() => _AccountViewState();
// }

// class _AccountViewState extends State<AccountView> {
//   bool isEditing = false;
//   final ScrollController _scrollController = ScrollController();

//   late TextEditingController firstName;
//   late TextEditingController lastName;
//   late TextEditingController email;
//   late TextEditingController phone;
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
//     customer.address = address.text;
//     customer.postCode = postCode.text;
//     customer.postAddress = city.text;

//     iMat.setCustomer(customer);
//     setState(() => isEditing = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Uppgifter sparade"),
//         backgroundColor: AppTheme.primaryGreen,
//       ),
//     );
//   }

//   Widget field(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingSmall),
//       child: TextField(
//         controller: controller,
//         enabled: isEditing,
//         style: const TextStyle(color: AppTheme.textMain),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: AppTheme.textSecondary),
//           border: const OutlineInputBorder(),
//           filled: true,
//           fillColor: isEditing ? Colors.white : AppTheme.backgroundLight.withOpacity(0.5),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundLight,
//       body: Column(
//         children: [
//           // ========================
//           // STATISK TOPP (Rubrik & Pil)
//           // Denna sektion scrollar INTE
//           // ========================
//           Container(
//             width: double.infinity,
//             color: AppTheme.backgroundLight,
//             padding: const EdgeInsets.only(top: AppTheme.paddingLarge, bottom: AppTheme.paddingSmall),
//             child: SafeArea(
//               child: Center(
//                 child: Container(
//                   width: 700, // Samma bredd som formuläret för att linjera
//                   padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingSmall),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.arrow_back, color: AppTheme.textMain, size: 28),
//                         onPressed: widget.onBack,
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 8.0, top: 8.0),
//                         child: Text(
//                           "Mitt konto",
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: AppTheme.textMain,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // ========================
//           // SCROLLBART FORMULÄR
//           // ========================
//           Expanded(
//             child: Scrollbar(
//               controller: _scrollController,
//               thumbVisibility: true,
//               trackVisibility: true,
//               thickness: 10,
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                   scrollbarTheme: ScrollbarThemeData(
//                     thumbColor: WidgetStateProperty.all(AppTheme.primaryGreen.withOpacity(0.5)),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   controller: _scrollController,
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: const EdgeInsets.only(bottom: AppTheme.paddingHuge),
//                   child: Center(
//                     child: Container(
//                       width: 700,
//                       padding: const EdgeInsets.all(AppTheme.paddingHuge),
//                       decoration: BoxDecoration(
//                         color: AppTheme.cardBackground,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Sektion: Personuppgifter + TYDLIG REDIGERA-KNAPP
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Personuppgifter",
//                                 style: TextStyle(
//                                   fontSize: 22, 
//                                   fontWeight: FontWeight.bold,
//                                   color: AppTheme.textMain
//                                 ),
//                               ),
//                               // Förbättrad och tydligare knapp
//                               FilledButton.tonal(
//                                 onPressed: () => setState(() => isEditing = !isEditing),
//                                 style: FilledButton.styleFrom(
//                                   backgroundColor: isEditing ? AppTheme.accentRed.withOpacity(0.1) : AppTheme.primaryGreen.withOpacity(0.1),
//                                   foregroundColor: isEditing ? AppTheme.accentRed : AppTheme.primaryGreen,
//                                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(isEditing ? Icons.close : Icons.edit, size: 20),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       isEditing ? "Avbryt" : "Redigera profil",
//                                       style: const TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: AppTheme.paddingLarge),
                          
//                           field("Förnamn", firstName),
//                           field("Efternamn", lastName),
//                           field("Email", email),
//                           field("Telefon", phone),
                          
//                           const SizedBox(height: AppTheme.paddingHuge),
//                           const Divider(),
//                           const SizedBox(height: AppTheme.paddingHuge),
                          
//                           const Text(
//                             "Adressuppgifter",
//                             style: TextStyle(
//                               fontSize: 22, 
//                               fontWeight: FontWeight.bold,
//                               color: AppTheme.textMain
//                             ),
//                           ),
//                           const SizedBox(height: AppTheme.paddingLarge),
                          
//                           field("Adress", address),
//                           field("Postnummer", postCode),
//                           field("Stad", city),
                          
//                           const SizedBox(height: AppTheme.paddingHuge),
                          
//                           if (isEditing)
//                             SizedBox(
//                               width: double.infinity,
//                               height: 55,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppTheme.primaryGreen,
//                                   foregroundColor: Colors.white,
//                                   elevation: 2,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 onPressed: save,
//                                 child: const Text(
//                                   "SPARA ÄNDRINGAR",
//                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/app_theme.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  final VoidCallback onBack;

  const AccountView({super.key, required this.onBack});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool isEditing = false;
  final ScrollController _scrollController = ScrollController();

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

    firstName = TextEditingController(text: customer.firstName);
    lastName = TextEditingController(text: customer.lastName);
    email = TextEditingController(text: customer.email);
    phone = TextEditingController(text: customer.phoneNumber);
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
    customer.address = address.text;
    customer.postCode = postCode.text;
    customer.postAddress = city.text;

    iMat.setCustomer(customer);
    setState(() => isEditing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Uppgifter sparade"),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  Widget field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingSmall),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        style: const TextStyle(color: AppTheme.textMain),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppTheme.textSecondary),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: isEditing ? Colors.white : AppTheme.backgroundLight.withOpacity(0.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          // ========================
          // STATISK TOPP (Pil vänster, Rubrik mitten)
          // ========================
          Container(
            width: double.infinity,
            color: AppTheme.backgroundLight,
            padding: const EdgeInsets.only(top: AppTheme.paddingLarge, bottom: AppTheme.paddingSmall),
            child: SafeArea(
              child: Center(
                child: SizedBox(
                  width: 700, // Linjerar med formulärets bredd
                  height: 80, // Fast höjd för att rymma pil och text
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Pilen längst till vänster
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppTheme.textMain, size: 28),
                          onPressed: widget.onBack,
                        ),
                      ),
                      // Rubriken exakt i mitten
                      const Text(
                        "Mitt konto",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textMain,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ========================
          // SCROLLBART FORMULÄR
          // ========================
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 10,
              child: Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: WidgetStateProperty.all(AppTheme.primaryGreen.withOpacity(0.5)),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: AppTheme.paddingHuge),
                  child: Center(
                    child: Container(
                      width: 700,
                      padding: const EdgeInsets.all(AppTheme.paddingHuge),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sektion: Personuppgifter + Tydlig knapp
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Personuppgifter",
                                style: TextStyle(
                                  fontSize: 22, 
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMain
                                ),
                              ),
                              FilledButton.tonal(
                                onPressed: () => setState(() => isEditing = !isEditing),
                                style: FilledButton.styleFrom(
                                  backgroundColor: isEditing 
                                      ? AppTheme.accentRed.withOpacity(0.1) 
                                      : AppTheme.primaryGreen.withOpacity(0.1),
                                  foregroundColor: isEditing ? AppTheme.accentRed : AppTheme.primaryGreen,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(isEditing ? Icons.close : Icons.edit, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      isEditing ? "Avbryt" : "Redigera profil",
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.paddingLarge),
                          
                          field("Förnamn", firstName),
                          field("Efternamn", lastName),
                          field("Email", email),
                          field("Telefon", phone),
                          
                          const SizedBox(height: AppTheme.paddingHuge),
                          const Divider(),
                          const SizedBox(height: AppTheme.paddingHuge),
                          
                          const Text(
                            "Adressuppgifter",
                            style: TextStyle(
                              fontSize: 22, 
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textMain
                            ),
                          ),
                          const SizedBox(height: AppTheme.paddingLarge),
                          
                          field("Adress", address),
                          field("Postnummer", postCode),
                          field("Stad", city),
                          
                          const SizedBox(height: AppTheme.paddingHuge),
                          
                          if (isEditing)
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryGreen,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: save,
                                child: const Text(
                                  "SPARA ÄNDRINGAR",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}