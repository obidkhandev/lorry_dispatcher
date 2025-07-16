import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/core/usecases/use_case.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/settings.dart';



class SetAppOnboardUseCase extends UseCase<bool, AppOnboardParam> {
  final ISettingRepository _settingRepository;

  SetAppOnboardUseCase(this._settingRepository);

  @override
  Future<Either<Failure, bool>> call(AppOnboardParam params) =>
      _settingRepository.setOnBoarding(params.onboard);
}

class AppOnboardParam {
  final bool onboard;
  AppOnboardParam(this.onboard);
}
