import 'dart:math';
import 'package:flutter/material.dart';
enum FlipCardMode {horizontal,vertical}
class FlippingCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final FlipCardMode flipMode;
  const FlippingCard({Key? key,required this.front,required this.back, this.flipMode=FlipCardMode.horizontal}) : super(key: key);
  factory FlippingCard.icon({required Icon frontIcon,required Icon backIcon}) {
    return FlippingCard(front: frontIcon, back: backIcon);
  }
  factory FlippingCard.image({required Image frontImage, required Image backImage}) {
    return FlippingCard(front: frontImage, back: backImage);
  }
  @override
  _FlippingCardState createState() => _FlippingCardState();
}
class _FlippingCardState extends State<FlippingCard> with SingleTickerProviderStateMixin {
  bool _isFront = true;
  bool _isFrontStart = true;
  double _dragPosition = 0;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {

    super.initState();
    _controller = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    _controller.addListener(() {
      setState(() {
        _dragPosition= _animation.value;
        setImageSide();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _angle = (_dragPosition/180)*pi;
    final _xAxisTransform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(_angle) //for x-axis flip
        ;
    final _yAxisTransform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(_angle) //for Y-axis flip
        ;
    return GestureDetector(
      onTap: (){
        _dragPosition = 180.0*_controller.value ;
        final double _end =_isFront?   180:(_dragPosition>180?360:0);
        _animation= _isFront?Tween(begin:_dragPosition ,end: _end).animate(_controller):Tween(begin:_end ,end: _dragPosition).animate(_controller);
        _isFront? _controller.forward(from: 0):_controller.reverse(from: 1);
        setState(() {
          setImageSide();
        });
      },
      onHorizontalDragStart: (details){
        _controller.stop();
        _isFrontStart = _isFront;
      },
      onHorizontalDragEnd: (details){
        final velocity = details.velocity.pixelsPerSecond.dx.abs();
        if (velocity>=100){
          _isFront = ! _isFrontStart;
        }
        final double _end =_isFront? (_dragPosition>180?360:0) : 180;
        _animation=Tween(begin:_dragPosition ,end: _end).animate(_controller);
        _controller.forward(from: 0);
      },
      onHorizontalDragUpdate: (details){
        setState(() {
          _dragPosition -= details.delta.dx;// for x - axis
          _dragPosition %=360;
          setImageSide();
        });
      },
      onVerticalDragStart: (details){
        _controller.stop();
        _isFrontStart = _isFront;
      } ,
      onVerticalDragEnd: (details){
        final velocity = details.velocity.pixelsPerSecond.dx.abs();
        if (velocity>=100){
          _isFront = ! _isFrontStart;
        }
        final double _end =_isFront? (_dragPosition>180?360:0) : 180;
        _animation=Tween(begin:_dragPosition ,end: _end).animate(_controller);
        _controller.forward(from: 0);
      } ,
      onVerticalDragUpdate: (details){
        setState(() {
          _dragPosition += details.delta.dy;// for y - axis
          _dragPosition %=360;
        });
        setImageSide();
      },
      child: Transform(
        alignment: Alignment.center,
        transform: widget.flipMode==FlipCardMode.horizontal?_xAxisTransform:_yAxisTransform,
        child:_isFront? widget.front:Transform(transform: Matrix4.identity()..rotateY(pi),
          alignment: Alignment.center,
          child: widget.back,
        ),
      ),
    );
  }
  void setImageSide (){
    if (_dragPosition <= 90 || _dragPosition >= 270) {
      _isFront=true;
    } else {
      _isFront=false;
    }
  }
}
