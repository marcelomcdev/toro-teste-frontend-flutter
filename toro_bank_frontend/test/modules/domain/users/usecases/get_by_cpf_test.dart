import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:toro_bank_frontend/modules/domain/entities/user.dart';
import 'package:toro_bank_frontend/modules/domain/errors/errors.dart';
import 'package:toro_bank_frontend/modules/domain/usecases/user/get_by_cpf.dart';

import '../mocks/user_repository_mock.dart';

main() {
  final repository = UserRepositoryMock();
  final useCase = GetByCPFImpl(repository);
  const String cpf = "01255544455";

  setUp(() => {});

  test('should return an users list', () async {
    when(repository.getByCpf(cpf))
        .thenAnswer((_) async => const Right(<User>[]));

    final result = await useCase(cpf);
    expect(result, isA<Right>());
    expect(result?.getOrElse(() => null), isA<List<User>>());
    //ou
    expect(result | null, isA<List<User>>());
  });

  test('deve retornar um InvalidTextError caso o cpf seja invalido', () async {
    //mock
    when(repository.getByCpf(cpf))
        .thenAnswer((_) async => const Right(<User>[]));

    var result = await useCase(null);
    //expect(result.isLeft(), true); //ou
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());

    result = await useCase("");
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });
}