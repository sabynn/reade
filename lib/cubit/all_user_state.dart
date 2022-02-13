part of 'all_user_cubit.dart';

abstract class AllUserState extends Equatable {
  const AllUserState();

  @override
  List<Object> get props => [];
}

class AllUserInitial extends AllUserState {}

class AllUserLoading extends AllUserState {}

class AllUserSuccess extends AllUserState {
  final List<UserModel> allUsers;

  const AllUserSuccess(this.allUsers);

  @override
  List<Object> get props => [allUsers];
}

class AllUserFailed extends AllUserState {
  final String error;

  const AllUserFailed(this.error);

  @override
  List<Object> get props => [error];
}
