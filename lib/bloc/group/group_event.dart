import 'package:equatable/equatable.dart';

sealed class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

final class GetGroups extends GroupEvent {}
