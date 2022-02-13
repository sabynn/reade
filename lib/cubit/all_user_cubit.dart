import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';
import '../services/all_user_service.dart';
part 'all_user_state.dart';

class AllUserCubit extends Cubit<AllUserState> {
  AllUserCubit() : super(AllUserInitial());

  void fetchAllUser() async {
    try {
      emit(AllUserLoading());

      List<UserModel> questions =
      await AllUserService().fetchAllUser();
      emit(AllUserSuccess(questions));
    } catch (e) {
      emit(AllUserFailed(e.toString()));
    }
  }
}
