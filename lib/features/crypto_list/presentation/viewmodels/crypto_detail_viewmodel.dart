

import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_event.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_state.dart';

class CryptoDetailViewmodel {

  final CryptoDetailBloc bloc; 

  CryptoDetailViewmodel({required this.bloc});

  void loadCryptoDetail(String cryptoId){
    bloc.add(GetCryptoDetailEvent(cryptoId: cryptoId));
  }

  void refreshCryptoDetail(String cryptoId){
    bloc.add(RefreshCryptoDetailEvent(cryptoId: cryptoId));
  }

  CryptoDetailState get currentState => bloc.state;

  Stream<CryptoDetailState> get stateStream => bloc.stream;

}