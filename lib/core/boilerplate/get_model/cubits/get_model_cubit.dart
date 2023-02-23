import 'package:bloc/bloc.dart';

import '../../../api/core_models/base_response_model.dart';
import '../../../api/core_models/base_result_model.dart';
import '/core/api/errors/base_error.dart';
import 'package:meta/meta.dart';

part 'get_model_state.dart'; 
typedef RepositoryCallBack  = Future<BaseResultModel> Function( dynamic data);

class GetModelCubit<Model> extends Cubit<GetModelState> {

  final RepositoryCallBack getData;
  GetModelCubit(this.getData) : super(GetModelInitial());

  getModel({ Map<String,dynamic>? params   })async{
    emit(Loading ());
    var response = await getData(params);
    if(response is Model)
    {
      emit(GetModelSuccessfully (response ));
    }
    else if(response is BaseError)  emit(Error( response.message));
    else if (response is ServerError) emit(Error(response.message! ));

  }

}
