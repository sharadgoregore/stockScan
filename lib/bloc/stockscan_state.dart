part of 'stockscan_bloc.dart';

@immutable
abstract class StockscanState {}


class StockscanLoadingState extends StockscanState {}

class StockscanLoadedState extends StockscanState {
  final List<StockModel> stocks;

  StockscanLoadedState(this.stocks);
  List<Object?> get props => [stocks];
}

class StockscanErrorState extends StockscanState {
  final String errorMessage;

  StockscanErrorState(this.errorMessage);
}
