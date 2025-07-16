import 'package:dartz/dartz.dart';
import 'package:lorry_dispatcher/core/error/failure.dart';
import 'package:lorry_dispatcher/core/usecases/use_case.dart';
import 'package:lorry_dispatcher/features/common/domain/repository/settings.dart';


class GetAppOnboardUseCase extends UseCase<bool, NoParams> {
  final ISettingRepository _settingRepository;

  GetAppOnboardUseCase(this._settingRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) =>
      _settingRepository.getOnBoarding();
}
