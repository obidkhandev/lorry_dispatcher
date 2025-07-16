import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/core/usecases/use_case.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/settings.dart';



class GetAppLangUseCase extends UseCase<String, NoParams> {
  final ISettingRepository _settingRepository;

  GetAppLangUseCase(this._settingRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      _settingRepository.getAppLang();
}
