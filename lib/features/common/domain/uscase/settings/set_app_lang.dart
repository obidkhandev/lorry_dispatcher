import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/core/usecases/use_case.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/settings.dart';




class SetAppLangUseCase extends UseCase<String, AppLangParam> {
  final ISettingRepository _settingRepository;

  SetAppLangUseCase(this._settingRepository);

  @override
  Future<Either<Failure, String>> call(AppLangParam params) =>
      _settingRepository.setAppLang(params.lang);
}

class AppLangParam {
  final String lang;
  AppLangParam(this.lang);
}
