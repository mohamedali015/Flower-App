import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/occasions/data/data_source/remote/occasions_remote_data_source.dart';
import 'package:flower_app/features/occasions/data/mapper/occasion_mapper.dart';
import 'package:flower_app/features/occasions/data/model/response/occasions_response.dart';
import 'package:flower_app/features/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasions/domain/repositories/occasions_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionsRepo)
class OccasionsRepoImpl implements OccasionsRepo {
  final OccasionsRemoteDataSource _occasionsRemoteDataSource;

  OccasionsRepoImpl(this._occasionsRemoteDataSource);

  @override
  Future<Result<List<OccasionEntity>>> getOccasions() async {
    final response = await _occasionsRemoteDataSource.getOccasions();

    switch (response) {
      case Success<OccasionsResponse>():
        {
          return Success<List<OccasionEntity>>(
            data:
                response.data.occasions?.map((e) => e.toEntity()).toList() ??
                [],
          );
        }
      case Failure<OccasionsResponse>():
        {
          return Failure<List<OccasionEntity>>(
            errorMessage: response.errorMessage,
          );
        }
    }
  }
}
