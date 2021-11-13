part of 'cart_imports.dart';

/// REVIEWED
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        bool showSpinner = false;
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is GetCartSuccessState && HomeCubit.get(context).showCartsDialogue)
              showDialog(
                  context: context,
                  builder: (context) {
                    return const SwipeToDeleteDialog();
                  });
            if (state is ChangeCartSuccessState) {
              if (state.changeCartModel?.status == true)
                DefaultDialogue.showSnackBar(
                  context,
                  '${state.changeCartModel?.message}',
                  labelColor:
                      AppCubit.get(context).isDark ? Colors.white : Colors.black,
                  dialogueStates: DialogueStates.NONE,
                  isDark: AppCubit.get(context).isDark,
                );
              else
                DefaultDialogue.showSnackBar(
                  context,
                  '${state.changeCartModel?.message}',
                  dialogueStates: DialogueStates.ERROR,
                );
            }

            if (state is UpdateCartLoadingState) showSpinner = true;
            else showSpinner = false;
            if (state is UpdateCartErrorState)
              DefaultDialogue.showSnackBar(
                context,
                'error_try_again'.tr(),
                dialogueStates: DialogueStates.ERROR,
              );
            if (state is UpdateCartSuccessState) if (!state
                .updateCartModel!.status!)
              DefaultDialogue.showSnackBar(context, state.updateCartModel!.message!,
                  dialogueStates: DialogueStates.ERROR);
          },
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            var carts = cubit.getCartsModel?.data?.cartItems;

            return Scaffold(
              persistentFooterButtons: [
                cubit.getCartsModel?.data?.total != null
                    ? FooterBuilder(cubit)
                    : const SizedBox()
              ],
              appBar: SecondaryAppBar(
                  title: 'cart'.tr(), actions: [
                ExpandCollapseButton(cubit: cubit),
              ]),
              body: MyConditionalBuilder(
                condition: carts != null,
                onBuild: MyConditionalBuilder(
                    condition: carts != null && carts.length > 0,
                    onBuild: ProductBuilder(cubit, carts, showSpinner),
                    onError:const NoItemsAdded()),
                onError:const Center(child: kLoadingFadingCircle),
              ),
            );
          },
        );
      }
    );
  }
}




