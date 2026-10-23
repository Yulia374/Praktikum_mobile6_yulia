import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController(); // _ = private
  final _tbController = TextEditingController();

  static const Color _warnaUtama = Color(0xFFFF5B92);

  String _gender = 'Laki-laki';
  double? _hasilBMI; // ? apakah terisi atau tidak
  String _keterangan = 'Masukkan data dulu ya!';
  String _infoGender = '';
  Color _warnaHasil = _warnaUtama;

  void _hitungBMI() {
    FocusScope.of(context).unfocus();

    final double bb = double.tryParse(_bbController.text.replaceAll(',', '.')) ?? 0;
    final double tbCm = double.tryParse(_tbController.text.replaceAll(',', '.')) ?? 0;

    setState(() {
      if (bb > 0 && tbCm > 0) {
        final double tbM = tbCm / 100;
        final double hasil = bb / (tbM * tbM);
        final bool pria = _gender == 'Laki-laki';

        // Batas kategori dibedakan berdasarkan jenis kelamin
        final double batasKurus = pria ? 17 : 18;
        final double batasNormal = pria ? 23 : 25;
        const double batasGemuk = 27;

        _hasilBMI = hasil;
        _infoGender = 'Kategori untuk $_gender';

        if (hasil < batasKurus) {
          _keterangan = 'Kicill amat';
          _warnaHasil = Colors.blue;
        } else if (hasil < batasNormal) {
          _keterangan = 'Anjayy Ideal';
          _warnaHasil = Colors.green;
        } else if (hasil < batasGemuk) {
          _keterangan = 'Lebih teuing euy';
          _warnaHasil = Colors.orange;
        } else {
          _keterangan = 'Obesitas bos';
          _warnaHasil = Colors.red;
        }
      } else {
        _hasilBMI = null;
        _infoGender = '';
        _keterangan = 'Data tidak valid!';
        _warnaHasil = Colors.grey;
      }
    });
  }

  void _resetBMI() {
    FocusScope.of(context).unfocus();
    _bbController.clear();
    _tbController.clear();

    setState(() {
      _hasilBMI = null;
      _infoGender = '';
      _keterangan = 'Masukkan data dulu ya!';
      _warnaHasil = _warnaUtama;
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  InputDecoration _inputStyle(String label, IconData icon, String suffix) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: _warnaUtama),
      labelText: label,
      suffixText: suffix,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _warnaUtama, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: _warnaUtama,
        elevation: 0,
        leading: const Icon(Icons.accessibility_new, color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF5B92), Color(0xFFFFE0EB), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.monitor_heart, size: 70, color: Colors.white),
                const SizedBox(height: 8),
                const Text(
                  'Cek berat badan idealmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                // ===== Kartu input =====
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Jenis Kelamin',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'Laki-laki',
                              label: Text('Laki-laki'),
                              icon: Icon(Icons.male),
                            ),
                            ButtonSegment(
                              value: 'Perempuan',
                              label: Text('Perempuan'),
                              icon: Icon(Icons.female),
                            ),
                          ],
                          selected: {_gender},
                          onSelectionChanged: (pilihan) {
                            setState(() {
                              _gender = pilihan.first;
                            });
                          },
                          style: SegmentedButton.styleFrom(
                            selectedBackgroundColor: _warnaUtama,
                            selectedForegroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _bbController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: _inputStyle('Berat Badan', Icons.monitor_weight, 'kg'),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _tbController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: _inputStyle('Tinggi Badan', Icons.height, 'cm'),
                        ),
                        const SizedBox(height: 20),

                        // ===== Tombol Hitung & Reset =====
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton.icon(
                                onPressed: _hitungBMI,
                                icon: const Icon(Icons.calculate),
                                label: const Text(
                                  'Hitung BMI',
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _warnaUtama,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _resetBMI,
                                icon: const Icon(Icons.refresh),
                                label: const Text(
                                  'Reset',
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _warnaUtama,
                                  side: const BorderSide(color: _warnaUtama, width: 2),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Hasil',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // ===== Kartu hasil =====
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _warnaHasil.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _warnaHasil, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _hasilBMI?.toStringAsFixed(1) ?? 'Nilai kosong',
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: _warnaHasil,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _keterangan,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: _warnaHasil,
                        ),
                      ),
                      if (_infoGender.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Chip(
                          avatar: Icon(
                            _gender == 'Laki-laki' ? Icons.male : Icons.female,
                            size: 18,
                          ),
                          label: Text(_infoGender),
                          backgroundColor: Colors.white,
                        ),
                      ],
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