import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockscan/Model/stockmodel.dart';
import 'package:stockscan/Repository/stockapis.dart';
part 'stockscan_event.dart';
part 'stockscan_state.dart';

class StockscanBloc extends Bloc<StockscanEvent, StockscanState> {
  final Repository repository;

  StockscanBloc(this.repository) : super(StockscanLoadingState()) {
    on<FetchPostEvent>((event, emit) async {
      emit(StockscanLoadingState()); // initial state
      try {
        final data = await repository.fetchData();
        emit(StockscanLoadedState(data)); // data loaded
      } catch (error) {
        emit(StockscanErrorState(error.toString())); // Error Occured
      }
    });
  }
}
