import '../../domain/entities/driver_entity.dart';
import '../models/response/driver_model.dart';

extension DriverModelMapper on DriverModel? {
  DriverEntity toEntity() {
    return DriverEntity(
      firstName: this?.firstName ?? '',
      lastName: this?.lastName ?? '',
      email: this?.email ?? '',
      phone: this?.phone ?? '',
    );
  }
}
