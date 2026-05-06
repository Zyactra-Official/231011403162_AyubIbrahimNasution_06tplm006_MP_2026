import 'package:flutter/material.dart';

void main() {
  runApp(const WorkshopApp());
}

class WorkshopApp extends StatelessWidget {
  const WorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A73E8),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const WorkshopHomePage(),
    );
  }
}

// ─── Data Model ───────────────────────────────────────────────────────────────

class Workshop {
  final String id;
  final String judul;
  final String tanggal;
  final String lokasi;
  final int kuotaTerisi;
  final int kuotaTotal;
  final String kategori;
  final Color warna;
  bool sudahDaftar;

  Workshop({
    required this.id,
    required this.judul,
    required this.tanggal,
    required this.lokasi,
    required this.kuotaTerisi,
    required this.kuotaTotal,
    required this.kategori,
    required this.warna,
    this.sudahDaftar = false,
  });

  bool get tersedia => kuotaTerisi < kuotaTotal;
  double get persenKuota => kuotaTerisi / kuotaTotal;
}

// ─── Home Page ────────────────────────────────────────────────────────────────

class WorkshopHomePage extends StatefulWidget {
  const WorkshopHomePage({super.key});

  @override
  State<WorkshopHomePage> createState() => _WorkshopHomePageState();
}

class _WorkshopHomePageState extends State<WorkshopHomePage> {
  final List<Workshop> _workshops = [
    Workshop(
      id: '1',
      judul: 'Workshop Flutter Dasar',
      tanggal: 'Senin, 10 Mei 2026 • 09.00–12.00 WIB',
      lokasi: 'Gedung A, Lantai 3, Lab Komputer',
      kuotaTerisi: 30,
      kuotaTotal: 50,
      kategori: 'Mobile Dev',
      warna: const Color(0xFF1A73E8),
    ),
    Workshop(
      id: '2',
      judul: 'Workshop UI/UX Design',
      tanggal: 'Rabu, 15 Mei 2026 • 13.00–16.00 WIB',
      lokasi: 'Aula Utama, Gedung Rektorat',
      kuotaTerisi: 38,
      kuotaTotal: 40,
      kategori: 'Design',
      warna: const Color(0xFFE91E63),
    ),
    Workshop(
      id: '3',
      judul: 'Workshop Machine Learning',
      tanggal: 'Jumat, 17 Mei 2026 • 08.00–12.00 WIB',
      lokasi: 'Ruang Seminar, Gedung B Lt. 2',
      kuotaTerisi: 15,
      kuotaTotal: 35,
      kategori: 'AI / ML',
      warna: const Color(0xFF43A047),
    ),
    Workshop(
      id: '4',
      judul: 'Workshop Web Development',
      tanggal: 'Sabtu, 18 Mei 2026 • 10.00–14.00 WIB',
      lokasi: 'Lab Internet, Gedung C Lt. 1',
      kuotaTerisi: 25,
      kuotaTotal: 25,
      kategori: 'Web Dev',
      warna: const Color(0xFFFF6F00),
    ),
    Workshop(
      id: '5',
      judul: 'Workshop Cyber Security',
      tanggal: 'Senin, 20 Mei 2026 • 13.00–17.00 WIB',
      lokasi: 'Ruang Kelas 301, Gedung D',
      kuotaTerisi: 10,
      kuotaTotal: 30,
      kategori: 'Security',
      warna: const Color(0xFF6A1B9A),
    ),
  ];

  void _daftar(Workshop workshop) {
    if (!workshop.tersedia || workshop.sudahDaftar) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Pendaftaran'),
        content: Text('Apakah kamu yakin ingin mendaftar workshop\n"${workshop.judul}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: workshop.warna,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => workshop.sudahDaftar = true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ Berhasil mendaftar: ${workshop.judul}'),
                  backgroundColor: Colors.green.shade700,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            child: const Text('Ya, Daftar!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎓 Workshop Kampus',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Universitas Pamulang',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Stats ──
          Container(
            color: const Color(0xFF1A73E8),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              children: [
                _StatChip(label: 'Total Workshop', value: '${_workshops.length}', icon: Icons.event),
                const SizedBox(width: 12),
                _StatChip(
                  label: 'Sudah Daftar',
                  value: '${_workshops.where((w) => w.sudahDaftar).length}',
                  icon: Icons.check_circle_outline,
                ),
                const SizedBox(width: 12),
                _StatChip(
                  label: 'Tersedia',
                  value: '${_workshops.where((w) => w.tersedia && !w.sudahDaftar).length}',
                  icon: Icons.pending_outlined,
                ),
              ],
            ),
          ),

          // ── Section Label ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'Workshop Tersedia',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),

          // ── List Workshop ──
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: _workshops.length,
              itemBuilder: (context, index) {
                final workshop = _workshops[index];
                return WorkshopCard(
                  workshop: workshop,
                  onDaftar: () => _daftar(workshop),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stat Chip ────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatChip({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 9),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// ─── Workshop Card ────────────────────────────────────────────────────────────

class WorkshopCard extends StatelessWidget {
  final Workshop workshop;
  final VoidCallback onDaftar;

  const WorkshopCard({super.key, required this.workshop, required this.onDaftar});

  @override
  Widget build(BuildContext context) {
    final sisaKuota = workshop.kuotaTotal - workshop.kuotaTerisi;
    final penuh = !workshop.tersedia;
    final sudahDaftar = workshop.sudahDaftar;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shadowColor: workshop.warna.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Color Header Strip ──
          Container(
            decoration: BoxDecoration(
              color: workshop.warna,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kategori badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          workshop.kategori,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Judul
                      Text(
                        workshop.judul,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                if (sudahDaftar)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.check, color: workshop.warna, size: 16),
                  )
                else if (penuh)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('PENUH',
                        style: TextStyle(
                            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
          ),

          // ── Info Body ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Column(
              children: [
                _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: workshop.tanggal,
                    warna: workshop.warna),
                const SizedBox(height: 8),
                _InfoRow(
                    icon: Icons.location_on_outlined,
                    text: workshop.lokasi,
                    warna: workshop.warna),
                const SizedBox(height: 12),

                // ── Kuota Bar ──
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 16, color: workshop.warna),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kuota: ${workshop.kuotaTerisi}/${workshop.kuotaTotal} peserta',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade700),
                              ),
                              Text(
                                penuh ? 'Penuh' : '$sisaKuota sisa',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: penuh ? Colors.red : Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: workshop.persenKuota,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                workshop.persenKuota >= 1.0
                                    ? Colors.red
                                    : workshop.persenKuota >= 0.8
                                        ? Colors.orange
                                        : workshop.warna,
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Tombol Daftar ──
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: (penuh || sudahDaftar) ? null : onDaftar,
                    icon: Icon(
                      sudahDaftar
                          ? Icons.check_circle
                          : penuh
                              ? Icons.block
                              : Icons.app_registration,
                      size: 18,
                    ),
                    label: Text(
                      sudahDaftar
                          ? 'Sudah Terdaftar'
                          : penuh
                              ? 'Kuota Penuh'
                              : 'Daftar Sekarang',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          sudahDaftar ? Colors.green.shade600 : workshop.warna,
                      disabledBackgroundColor: penuh
                          ? Colors.red.shade300
                          : Colors.green.shade400,
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Info Row ─────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color warna;

  const _InfoRow({required this.icon, required this.text, required this.warna});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: warna),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
          ),
        ),
      ],
    );
  }
}
