

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../model/country_model.dart';
import '../../services/countries.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc({required this.countries})
      : super(CountryInitialState()) {
    on<LoadCountryEvent>((event, emit) async {
      emit(CountryLoadingState());
      try {
        List<CountryModel>? countryList = await countries!.getCountries();
        emit(
          CountryLoadedState(
            countryList: countryList,
            sortingStatus: 'Name',
            groupingStatus: 'Ungrouped',
          ),
        );
      } catch (error) {
        emit(CountryErrorState(error: error.toString()));
      }
    });
    on<ChangeGroupAndSortEvent>(
          (event, emit) {
        emit((state as CountryLoadedState).copyWith(
            groupingStatus: event.groupValue, sortingStatus: event.sortValue));
      },
    );
  }

  final Countries? countries;
}