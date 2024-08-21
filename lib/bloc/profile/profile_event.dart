import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class EditProfile extends ProfileEvent {
  final Map<String, dynamic> data;
  const EditProfile({required this.data});
}
