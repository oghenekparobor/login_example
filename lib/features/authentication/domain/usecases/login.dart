import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:kexze_logistics/core/usecases/usecases.dart';
import 'package:kexze_logistics/features/authentication/domain/repository/auth.dart';

import '../../../../core/failure/failure.dart';

class LoginUsecase extends Usecase<void, Map> {
  LoginUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(Map params) async =>
      await repository.login(params);
}
