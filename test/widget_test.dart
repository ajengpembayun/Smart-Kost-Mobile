
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_kost_mobile/main.dart';
import 'package:smart_kost_mobile/data/complaint_data.dart';

void main() {
  testWidgets('Smart Kost app test', (WidgetTester tester) async {
    await tester.pumpWidget(
      SmartKostApp(
        complaintData: ComplaintData(),
      ),
    );

    expect(find.text('Smart Kost'), findsOneWidget);
  });
}
