import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workshop_kampus/main.dart';

void main() {
  testWidgets('Workshop app smoke test', (WidgetTester tester) async {
    // Build app dan trigger frame
    await tester.pumpWidget(const WorkshopApp());

    // Verify AppBar title muncul
    expect(find.text('🎓 Workshop Kampus'), findsOneWidget);

    // Verify section label muncul
    expect(find.text('Workshop Tersedia'), findsOneWidget);

    // Verify tombol daftar pertama ada
    expect(find.text('Daftar Sekarang'), findsWidgets);
  });

  testWidgets('Tombol daftar bisa diklik', (WidgetTester tester) async {
    await tester.pumpWidget(const WorkshopApp());
    await tester.pumpAndSettle();

    // Tap tombol daftar pertama
    final daftarBtn = find.text('Daftar Sekarang').first;
    await tester.tap(daftarBtn);
    await tester.pumpAndSettle();

    // Dialog konfirmasi muncul
    expect(find.text('Konfirmasi Pendaftaran'), findsOneWidget);
    expect(find.text('Ya, Daftar!'), findsOneWidget);

    // Tap konfirmasi
    await tester.tap(find.text('Ya, Daftar!'));
    await tester.pumpAndSettle();

    // Setelah daftar, tombol berubah jadi "Sudah Terdaftar"
    expect(find.text('Sudah Terdaftar'), findsOneWidget);
  });
}
