import 'package:flutter_test/flutter_test.dart';
import 'package:imat_app/main.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App builds with provider', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ImatDataHandler>(
        create: (_) => ImatDataHandler(),
        child: const MyApp(),
      ),
    );

    expect(find.byType(MyApp), findsOneWidget);
  });
}
