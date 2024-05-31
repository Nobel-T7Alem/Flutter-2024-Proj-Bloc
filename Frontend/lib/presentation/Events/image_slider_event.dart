import 'package:equatable/equatable.dart';

abstract class ImageSliderEvent extends Equatable {
  const ImageSliderEvent();

  @override
  List<Object> get props => [];
}

class StartSliding extends ImageSliderEvent {}

class SlideNextImage extends ImageSliderEvent {}
