import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/prints/Print.dart';
import '../cubits/create_model_cubit.dart';

typedef CreatedCallback = void Function(CreateModelCubit cubit);
typedef ModelCreated<Model> = Function(Model model);

class CreateModel<Model> extends StatefulWidget {
  final ModelCreated<Model>? onSuccess;
  final double? loadingHeight;
  final RepositoryCallBack? repositoryCallBack;
  final CreatedCallback? onCubitCreated;
  final Widget child;

  const CreateModel(
      {Key? key,
      this.repositoryCallBack,
      this.onCubitCreated,
      required this.child,
      this.onSuccess,
      this.loadingHeight})
      : super(key: key);

  @override
  State<CreateModel<Model>> createState() => _GetModelState<Model>();
}

class _GetModelState<Model> extends State<CreateModel<Model>> {
  CreateModelCubit<Model>? cubit;

  @override
  void initState() {
    cubit = CreateModelCubit<Model>(widget.repositoryCallBack!);
    if (widget.onCubitCreated != null) {
      widget.onCubitCreated!(cubit!);
    }
    //cubit.createModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateModelCubit, CreateModelState>(
      bloc: cubit,
      builder: (context, state) {
        if (widget.onCubitCreated != null) {
          widget.onCubitCreated!(cubit!);
        }


        if (state is CreateModelInitial) {
          return widget.child;
        } else if (state is Loading) {
          return Opacity(
              opacity: 0.1,
            child: Shimmer.fromColors(

              baseColor: AppColors.grey,
              highlightColor: AppColors.primaryColor,
              child: widget.child,
            ),
          );
        }
         else {
          if (state is CreateModelSuccessfully) {
          return widget.child;
        }
        else {
            return widget.child;
          }
        }
      },
      listener: (context, state) {
        if (state is CreateModelSuccessfully) {
          if(widget.onSuccess != null) {
            widget.onSuccess!(state.model);
          }
        }
        if (state is Error) {
          Print.showSnackBar(
              message: state.message.toString(),
              typeSnackBar: AnimatedSnackBarType.error);
        }
      },
    );
  }
}
