import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'welcome_page_event.dart';
part 'welcome_page_state.dart';

class WelcomePageBloc extends Bloc<WelcomePageEvent, WelcomePageState> {
  WelcomePageBloc() : super(WelcomePageInitial()) {
    on<TypingEvent>(onTyping);
    on<NotTypingEvent>(onNotTyping);
  }

  void onTyping(TypingEvent event, Emitter<WelcomePageState> emitter){
    // ignore: invalid_use_of_visible_for_testing_member
    emit(const Typing());
  }

  void onNotTyping(NotTypingEvent event, Emitter<WelcomePageState> emitter){
    // ignore: invalid_use_of_visible_for_testing_member
    emit(const NotTyping());
  }
}
