import 'dart:developer';

import 'package:http/http.dart' as http; // VAI PERMITIR AS REQUISIÇÕES;
import 'dart:async'; // VAI ME PERMITIR QUE FAZEMOS AS REQUISIÇÕES E NÃO FIQUE ESPERANDO (REQ ASYNC).
import 'dart:convert'; // Pacote para converter para JSON

class HomeRepository {
  final String request =
      'https://api.hgbrasil.com/finance?format=json-cors&key=73e31034';

  // FUNÇÃO QUE IRÁ ME RETORNAR UM DADO FUTURO

  Future<Map> getData() async {
    http.Response response =
        await http.get(Uri.parse(request)); // Resposta da minha API
    return jsonDecode(response.body);
  }
}
