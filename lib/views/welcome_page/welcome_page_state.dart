part of 'welcome_page_bloc.dart';

@immutable
abstract class WelcomePageState extends Equatable{
  const WelcomePageState();

  @override
  List<Object?> get props => [];
}

class WelcomePageInitial extends WelcomePageState {
  const WelcomePageInitial(): super();
}

class Typing extends WelcomePageState {
  const Typing(): super();
}

class NotTyping extends WelcomePageState {
  const NotTyping(): super();
}
