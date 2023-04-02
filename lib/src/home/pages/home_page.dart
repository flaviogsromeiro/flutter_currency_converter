import 'package:conversor_moeda/src/home/services/home_repository.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController realController = TextEditingController();
  final TextEditingController dolarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();

  late double dolar;
  late double euro;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          '\$ Conversor \$',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: HomeRepository().getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text(
                  "Erro ao Carregar Dados :(",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados..",
                  style: TextStyle(color: primaryColor, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final Map source = snapshot.data ?? {};
              dolar = source['results']['currencies']['USD']['buy'];
              euro = source['results']['currencies']['EUR']['buy'];
              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        child: Icon(
                          Icons.monetization_on,
                          color: primaryColor,
                          size: 120,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          children: [
                            buildTextField(
                                " Reais", "R\$ ", realController, _realChanged),
                            const Divider(),
                            buildTextField(" Dólares", "US\$ ", dolarController,
                                _dolarChanged),
                            const Divider(),
                            buildTextField(
                                " Euros", "€ ", euroController, _euroChanged)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  void _realChanged(String text) {
    if (text == '') {
      text = '0';
    }

    if (text.contains(',') == true) {
      text.replaceAll(',', '.');
    }

    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text == '') {
      text = '0';
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text == '') {
      text = '0';
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  Widget buildTextField(
      String label, String prefix, TextEditingController c, Function f) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return TextField(
      controller: c,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        labelText: label,
        prefix: Text(
          prefix,
        ),
        hintStyle: const TextStyle(color: Colors.yellow, fontSize: 25),
        labelStyle: const TextStyle(
          color: Colors.yellow,
          fontSize: 25,
        ),
      ),
      onChanged: (String text) {
        f(text);
      },
    );
  }
}
