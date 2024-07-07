part of 'quote_cubit.dart';

@immutable
abstract class QuoteStates {}

class QuoteInitialState extends QuoteStates {}

class QuoteLoadingState extends QuoteStates {}

class QuoteSuccessState extends QuoteStates {}

class QuoteFailureState extends QuoteStates {}

class AddQuoteToFavoriteState extends QuoteStates {}
