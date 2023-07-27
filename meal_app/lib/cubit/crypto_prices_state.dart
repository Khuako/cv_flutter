part of 'crypto_prices_cubit.dart';

@immutable
abstract class CryptoPricesState extends Equatable {}

class CryptoPricesInitial extends CryptoPricesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CryptoPricesLoading extends CryptoPricesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CryptoPricesLoaded extends CryptoPricesState {
  final CryptoPrices cryptoPrices;
  CryptoPricesLoaded({required this.cryptoPrices});
  @override
  // TODO: implement props
  List<Object?> get props => [cryptoPrices];
}

class CryptoPricesFailure extends CryptoPricesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
