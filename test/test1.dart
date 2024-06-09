import 'package:app_estacionamento_22104735_22107603/http/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_estacionamento_22104735_22107603/repository/estacionamento_repository.dart';

void main() {
  test('Acesso correto à API', () async {
    final parques = await EstacionamentosRepository(client: HttpClient()).getEstacionamentos(null);

    expect(parques.isNotEmpty, true);
  });


}
