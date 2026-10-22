import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController(); // _ = private
  final _tbController = TextEditingController(); 

  double? _hasilBMI; // ? apakah terisi atau tidak
  String _keterangan = "Masukan Data LO!";

  void _hitungBMI(){
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if(bb > 0 && tbCm > 0){
        final double tbM = tbCm / 100;
        final double hasil = bb / (tbM * tbM);

        _hasilBMI = hasil;
        if(hasil < 18.5){
          _keterangan = "Kicill amat";
        }else if(hasil < 25){
          _keterangan = "Anjayy Ideal";
        }else if(hasil < 30){
          _keterangan = "Lebih teuing euy";
        }else {
          _keterangan = "Obesitas bos";
        }
      }else {
        _hasilBMI = null;
        _keterangan = "Data tidaks validd!!!!";
      }
    });
  }

  @override
  void dispose(){
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalkulator BMI',
          style: TextStyle(
            fontWeight: .bold,
            letterSpacing: 5
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 91, 146),
        leading: Icon(Icons.accessibility),
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              TextField(
                controller: _bbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  icon: Icon(Icons.monitor_weight, size: 30,),
                  labelText: 'Berat Badan',
                  labelStyle: TextStyle(letterSpacing: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),

              SizedBox(height: 15,),
              TextField(
                controller: _tbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  icon: Icon(Icons.height, size: 30,),
                  labelText: 'Tinggi Badan',
                  labelStyle: TextStyle(letterSpacing: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),

              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: _hitungBMI, 
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(40)
                ),
                child: Text(
                  'Hitung BMI',
                   style: TextStyle(fontSize: 20),
                )
              ),

              SizedBox(height: 15,),
              Text(
                'Hasil : ',
                textAlign: .center,
              ),

              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 149, 184),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? 'Nilai kosong',
                      style: TextStyle(fontSize: 40, fontWeight: .bold, color: Colors.pinkAccent),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      _keterangan,
                      style: TextStyle(fontSize: 20, color: Colors.pinkAccent),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}