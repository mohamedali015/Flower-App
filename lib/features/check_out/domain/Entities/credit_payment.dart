import 'package:equatable/equatable.dart';

class CreditPaymentEntity extends Equatable {
  final String? message;
  final SessionEntity? session;

  const CreditPaymentEntity({this.message, this.session});

  @override
  List<Object?> get props => [message, session];
}

class SessionEntity extends Equatable {
  final String? id;
  final String? url;

  const SessionEntity({this.id, this.url});

  @override
  List<Object?> get props => [id, url];
}
