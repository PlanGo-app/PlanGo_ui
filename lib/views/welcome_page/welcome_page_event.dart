part of 'welcome_page_bloc.dart';

@immutable
abstract class WelcomePageEvent extends Equatable{
  @override
  List<Object?> get props => [];
  const WelcomePageEvent();
}

class TypingEvent extends WelcomePageEvent{
  const TypingEvent();
}

class NotTypingEvent extends WelcomePageEvent{
  const NotTypingEvent();
}
