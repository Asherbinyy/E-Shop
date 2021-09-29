import 'package:e_shop/shared/components/reusable/text_field/default_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/modules/landing/landing_screen.dart';
import '/modules/product_details/product_details.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'myConditional_builder.dart';
// class ProductTextStyle {
//   static const TextStyle title = TextStyle(fontSize: 14);
//   static const TextStyle subTitle = TextStyle(fontSize: 12);
//   static const TextStyle price = TextStyle(fontSize: 12,fontWeight: FontWeight.bold);
//   static const TextStyle oldPrice = TextStyle(fontSize: 12,color: Colors.red,decoration: TextDecoration.lineThrough);
//   static const TextStyle discount = TextStyle(fontSize: 12);
// }
const double kTitleFontSize = 12 ;

class ProductCard extends StatelessWidget {
  final bool isGrid;
  final bool isCartScreen;
  final bool isFavouritesScreen;
  /// used in cart screen
  final int ? quantity;
  final String name;
  final String seller;
  final String image;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final int id;
  final int ? cartId;
  const ProductCard({
  Key? key,
  required this.isGrid,
  required this.name,
  required this.seller,
  required this.image,
  required this.price,
  required this.id,
  required this.oldPrice,
  required this.discount,
    this.cartId,
    this.isCartScreen=false,
    this.isFavouritesScreen=false,
    this.quantity=1,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TextStyles Used is :
    /// Title : fontSize 12
    return BlocConsumer <HomeCubit, HomeStates> (
        listener: (context, state) {},
        builder: (context, state) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          TextTheme textTheme =Theme.of(context).textTheme;
          bool isDark = AppCubit.get(context).isDark;
          HomeCubit cubit = HomeCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: productCardDecoration(isDark),
              child: MaterialButton(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: EdgeInsets.zero,
                splashColor: Colors.white,
                onPressed: () {
                  cubit.getProductDetails(id);
                  navigateTo(context, ProductDetailsScreen(id));
                },
                child:isGrid?
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        // image and offer
                        Expanded(
                          child: _imageStack(isDark,textTheme),
                        ),
                        // product info
                        Expanded(
                          child: _productInfo(cubit,isDark,width, textTheme, height,),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (!isFavouritesScreen)_likeButton(cubit,isDark),
                        const Spacer(),
                        if(isCartScreen) _CardAmount(cubit, isDark, quantity!,cartId!),
                      ],),
                  ],
                ):
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          _imageStack(isDark,textTheme),
                          // Like
                        Row(
                          children: [
                          if (!isFavouritesScreen)_likeButton(cubit,isDark),
                           const Spacer(),
                            if(isCartScreen) _CardAmount(cubit,isDark,quantity!,cartId!)
                        ],)
                        ],
                      ),
                    ),
                    // product info
                    Expanded(
                      child: _productInfo(cubit,isDark,width, textTheme, height,),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }



  Widget _imageStack(bool isDark,TextTheme textTheme) =>Stack(
    children: [
      ColorFiltered(
        colorFilter: ColorFilter.mode(
          isDark ? Colors.black12 : Colors.black,
          BlendMode.difference,
        ),
        child: Opacity(
          opacity: isDark ? 0.8 : 1,
          child: Hero(
            tag: '$id',
            child: Image.network(
              image ,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: AlignmentDirectional.topCenter,
            ),
          ),
        ),
      ),
      if (discount != 0)
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 15.0),
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(-30 / 360),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade800,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: FittedBox(
                child: Text(
                  '$discount % OFF',
                  style: textTheme
                      .bodyText2
                      ?.copyWith(
                    fontSize: kTitleFontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
    ],
  );
  Widget _productInfo(HomeCubit cubit,bool isDark,double width, TextTheme textTheme, double height ) => Container(
    width: width,
    padding:const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color:
      isDark ? kDarkSecondaryColor : kLightSecondaryColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(isGrid?10:0),
        bottomRight:const Radius.circular(10.0),
        topRight:  Radius.circular(isGrid?0:10),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
           name ,
          style: textTheme.bodyText2?.copyWith(fontSize: kTitleFontSize),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        // SizedBox(height:height*0.002),
        Text(
          'by : $seller',
          style: textTheme.caption?.copyWith(fontSize: 8),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: FittedBox(
            child: discount != 0
                ? RichText(
              text: TextSpan(
                style:textTheme
                    .bodyText2
                    ?.copyWith(
                    fontSize: kTitleFontSize,
                    fontWeight: FontWeight.bold),
                text: 'EGP ${price.toString()}  ',
                children: [
                  TextSpan(
                    text: ' ${oldPrice.toString()}',
                    style: textTheme
                        .overline
                        ?.copyWith(
                        decoration: TextDecoration
                            .lineThrough,
                        color: kLikeButtonColor),
                  ),
                ],
              ),
            )
                : Text(
              'EGP ${price.toString()}',
              style: textTheme
                  .bodyText2
                  ?.copyWith(
                fontSize: kTitleFontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        //cart
        // SizedBox(height:height*0.006),
       MyConditionalBuilder (
         condition: isCartScreen,
         builder: _buildCartAmount(textTheme, height, isDark,cubit),
         feedback:  _addToCartButton(cubit, width, height, textTheme),
       ),
      ],
    ),
  );
  Widget _buildCartAmount(TextTheme textTheme, double height, bool isDark,HomeCubit cubit) {



    return Align(
         alignment: AlignmentDirectional.bottomCenter,
         child: Column(
           children: [
             FittedBox(
               child: Text(
                 'Amount ',
                 style: textTheme.caption?.copyWith(fontSize: 10),
                 overflow: TextOverflow.ellipsis,
                 maxLines: 1,
               ),
             ),
             YSpace.normal,
             Container(
               height: height * 0.03,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 border: Border.all(
                     color: isDark
                         ? kThirdColor.withOpacity(0.5)
                         : kThirdColor.withOpacity(0.2)),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   MaterialButton(
                     padding: EdgeInsets.zero,
                     minWidth: 10,
                     onPressed: ()=> cubit.updateCart(cartId!, CartOperation.DECREMENT),
                     child: Icon(
                       Icons.arrow_left_rounded,
                       color: isDark? Colors.white:Colors.black87,
                     ),
                   ),
                   FittedBox(
                     child : InkWell(
                       child: Text(
                         '${quantity??'1'} ',
                         style: textTheme.subtitle2?.copyWith(fontSize: kTitleFontSize),
                         overflow: TextOverflow.ellipsis,
                         maxLines: 1,
                       ),
                     ),
                   ),
                   MaterialButton(
                     padding: EdgeInsets.zero,
                     minWidth: 10.0,
                     onPressed: ()=> cubit.updateCart(cartId!, CartOperation.INCREMENT),
                     child: Icon(
                       Icons.arrow_right_rounded,
                       color: isDark? Colors.white:Colors.black87,
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       );
  }









  Widget _addToCartButton(HomeCubit cubit, double width, double height, TextTheme textTheme) {
    return FittedBox(
         fit: BoxFit.contain,
         child: OutlinedButton(
           onPressed: () {
             cubit.changeCarts(id);
           },
           style: OutlinedButton.styleFrom(
             minimumSize: Size(width, height * 0.08),
             backgroundColor: cubit.carts?[id]==true ?kPrimaryColor : null,
           ),
           child: cubit.carts?[id]==true
               ? Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               Icon(
                 Icons.check,
                 color: Colors.white,
                 size: 40,
               ),
               XSpace.normal,
               Text('Added To Cart',style: textTheme.headline5?.copyWith(color: Colors.white),),
             ],
           )
               : Icon(
             Icons.add_shopping_cart,
             size: 40,
           ),
         ),
       );
  }
  Widget _likeButton(cubit,isDark) {
    return InkWell(
      onTap: () => cubit.changeFavourites(id),
      child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 5.0,bottom: 4),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color:
              isDark ? kDarkPrimaryColor : kLightSecondaryColor,
              // borderRadius: BorderRadius.circular(20.0),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  offset: Offset(0, 0),
                  spreadRadius: 0.5,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
            child: (cubit.favourites?[id] == true)
                ? Icon(
              Icons.favorite,
              color: kLikeButtonColor,
            )
                : Icon(Icons.favorite_outline,
                color: (isDark
                    ? kLightPrimaryColor
                    : kDarkPrimaryColor),
            ),
          ),
      ),
    );
  }


}
class _CardAmount extends StatefulWidget {
    final HomeCubit cubit;
    final bool isDark;
    final int quantity;
    final int cartID;
  const _CardAmount(this.cubit,this.isDark,this.quantity,this.cartID,{Key? key}) : super(key: key);

  @override
  State<_CardAmount> createState() => _CardAmountState();

}

class _CardAmountState extends State<_CardAmount> {


  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (context) {
        int oldValue = widget.quantity ;
        return InkWell(
          onTap: (){
            showDialog(context: context, builder: (context)=>Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Amount'),
                SizedBox(
                  width: 50,
                  child: DropdownButtonFormField<int>(
                    style: Theme.of(context).textTheme.subtitle1,
                    dropdownColor: AppCubit.get(context).isDark?kDarkSecondaryColor:kLightSecondaryColor,
                    value: oldValue,
                    items: List.generate(15, (index) =>index+1 ).toList()
                        .map((e) => DropdownMenuItem(
                      child: Text(e.toString(),style: Theme.of(context).textTheme.subtitle2,),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        oldValue =value! ;
                        widget.cubit.updateCart(widget.cartID, CartOperation.ONCHANGE,dropDownAmount: oldValue);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          );
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5.0,bottom: 4),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color:
                widget.isDark ? kDarkPrimaryColor : kLightSecondaryColor,
                borderRadius: BorderRadius.circular(5.0),
                // shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    offset: Offset(0, 0),
                    spreadRadius: 0.5,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
              ),
              child:Text('x ${widget.quantity}',style: Theme.of(context).textTheme.bodyText2,),
            ),
          ),
        );
      }
    );
  }
}


