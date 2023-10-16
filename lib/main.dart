import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Venda de Arma'),
          backgroundColor: const Color.fromARGB(255, 81, 15, 83),
        ),
        body: const AutocompleteBasicUserExample(),
      ),
    );
  }
}


@immutable
class Arma {
  const Arma(
      {required this.nome, required this.elemento, required this.material});

  final String nome;
  final String elemento;
  final String material;

  @override
  String toString() {
    return '$nome, $elemento, $material';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Arma &&
        other.nome == nome &&
        other.elemento == elemento &&
        other.material == material;
  }

  @override
  int get hashCode => Object.hash(nome, elemento, material);
}

class AutocompleteBasicUserExample extends StatefulWidget {
  const AutocompleteBasicUserExample({Key? key}) : super(key: key);

  @override
  AutocompleteBasicUserExampleState createState() =>
      AutocompleteBasicUserExampleState();
}

class AutocompleteBasicUserExampleState
    extends State<AutocompleteBasicUserExample> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _elementoController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();

  static const List<Arma> _armaTypes = <Arma>[
    Arma(nome: 'Espada Asgard', elemento: 'Terra', material: 'Bronze'),
    Arma(nome: 'Cajado Ruby', elemento: 'Fogo', material: 'Ferro'),
    Arma(nome: 'Faca Cthulhu', elemento: 'Água', material: 'Platina'),
    Arma(nome: 'Arco e Flecha', elemento: 'Fogo', material: 'Ouro'),
    Arma(nome: 'Machado Hibernal', elemento: 'Gelo', material: 'Estanho'),
    Arma(nome: 'Faca Hibernal', elemento: 'Gelo', material: 'Estanho'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            '⚔️ 🏹 🪓 Selecione a Arma ❄️ 🔥 💧',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
            width: 300,
            child: Autocomplete<Arma>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<Arma>.empty();
                }
                final String lowercaseText =
                    textEditingValue.text.toLowerCase();
                return _armaTypes.where((Arma option) {
                  final String optionText = option.nome.toLowerCase();
                  return optionText.contains(lowercaseText);
                });
              },
              onSelected: (Arma selection) {
                _nomeController.text = selection.nome;
                _elementoController.text = selection.elemento;
                _materialController.text = selection.material;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'Arma: ${selection.nome}\nElemento: ${selection.elemento}\nMaterial: ${selection.material}\n\nSelecionada!',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
              displayStringForOption: (Arma option) => option.nome,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            width: 300,
            child: TextField(
              readOnly: true,
              controller: _elementoController,
              decoration: const InputDecoration(labelText: 'Elemento'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            width: 300,
            child: TextField(
              readOnly: true,
              controller: _materialController,
              decoration: const InputDecoration(labelText: 'Material'),
            ),
          ),
        ),
      ],
    )
    );
    
  }
}