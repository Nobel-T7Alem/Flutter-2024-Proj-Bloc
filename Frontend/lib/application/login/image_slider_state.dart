import 'package:equatable/equatable.dart';

abstract class ImageSliderState extends Equatable {
  const ImageSliderState();

  @override
  List<Object> get props => [];
}

class ImageSliderInitial extends ImageSliderState {}

class ImageSliderLoaded extends ImageSliderState {
  final int currentIndex;

  const ImageSliderLoaded(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
