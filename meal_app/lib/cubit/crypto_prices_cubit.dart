import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meal_app/repository/crypto_repository.dart';
import 'package:meta/meta.dart';

import '../model/crypto_prices.dart';

part 'crypto_prices_state.dart';

class CryptoPricesCubit extends Cubit<CryptoPricesState> {
  CryptoPricesCubit() : super(CryptoPricesInitial());
  late CryptoPrices result;
  Future<void> getCryptoPrices() async {
    emit(CryptoPricesLoading());
    try {
      result = await CryptoRepository().fetchPricesList();
      emit(CryptoPricesLoaded(cryptoPrices: result));
    } catch (e) {
      emit(CryptoPricesFailure());
    }
  }
}
