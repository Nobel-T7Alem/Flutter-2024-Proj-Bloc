import 'dart:async';
import 'package:bloc/bloc.dart';
import 'image_slider_event.dart';
import 'image_slider_state.dart';

class ImageSliderBloc extends Bloc<ImageSliderEvent, ImageSliderState> {
  ImageSliderBloc() : super(ImageSliderInitial()) {
    on<StartSliding>(_onStartSliding);
    on<SlideNextImage>(_onSlideNextImage);
  }

  void _onStartSliding(StartSliding event, Emitter<ImageSliderState> emit) {
    emit(ImageSliderLoaded(0));
    _autoSlide();
  }

  void _onSlideNextImage(SlideNextImage event, Emitter<ImageSliderState> emit) {
    if (state is ImageSliderLoaded) {
      final currentIndex = (state as ImageSliderLoaded).currentIndex;
      final nextIndex = (currentIndex + 1) % 5; // Loop back to the first item
      emit(ImageSliderLoaded(nextIndex));
      _autoSlide();
    }
  }

  void _autoSlide() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      add(SlideNextImage());
    });
  }
}
