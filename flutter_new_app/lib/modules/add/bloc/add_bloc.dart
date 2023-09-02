import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/models/enums/category_types.dart';
import 'package:flutter_new_app/models/enums/finance_type.dart';
import 'package:flutter_new_app/models/key_value_model.dart';
import 'package:flutter_new_app/services/create_entity_service.dart';
import 'package:flutter_new_app/widgets/add_widgets/finances/add_account.dart';

import '../../../constants/constant_data_dd.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddInitialState> {
  AddBloc() : super(const AddInitialState._()) {
    on<InitAddEvent>(_onInit);
    on<ChangeCategoryEvent>(_onChangeCategory);
    on<ChangeOperationEvent>(_onChangeOperation);
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<LoadOperationsEvent>(_onLoadOperations);
  }
  
  CreateEntityService createEntityService = const CreateEntityService();

  _onInit(InitAddEvent event, Emitter<AddInitialState> emit) async {
    Widget showedWidget = createEntityService.getViewWidget(CategoryType.values[event.category.key as int], event.add.key as int, event.planId, null);

    emit(state.copyWith(showedTypeWidget: showedWidget, categories: event.categories, operations: event.operations, selectedCategory: event.category, selectedOperation: event.add));
  }

  _onChangeCategory(ChangeCategoryEvent event, Emitter<AddInitialState> emit) async {
    var categoryType = CategoryType.values[event.selectedCategory.key as int];
    List<KeyValueModel> operations;

    switch (categoryType) {
      case CategoryType.finance:
        operations = ConstantDataDropdowns.finance;
        break;
      case CategoryType.health:
        operations = ConstantDataDropdowns.health;
        break;
      default:
        operations = ConstantDataDropdowns.entry;
        break;
    }

    Widget? showedWidget = createEntityService.getViewWidget(categoryType, 0, null, null);

    emit(state.copyWith(selectedCategory: event.selectedCategory, showedTypeWidget: showedWidget, operations: operations, selectedOperation: operations[0]));
  }

  _onChangeOperation(ChangeOperationEvent event, Emitter<AddInitialState> emit) async {
    Widget showedWidget = createEntityService.getViewWidget(CategoryType.values[state.selectedCategory.key as int], event.selectedType.key, null, event.type);
    emit(state.copyWith(selectedOperation: event.selectedType, showedTypeWidget: showedWidget, isLoading: false));
  }

  _onLoadOperations(LoadOperationsEvent event, Emitter<AddInitialState> emit) async {
    emit(state.copyWith(isLoading: true));
    //Call server
    emit(state.copyWith(operations: event.operations, isLoading: false));
  }

  _onLoadCategories(LoadCategoriesEvent event, Emitter<AddInitialState> emit) async {
    emit(state.copyWith(isLoading: true));
    //Call server
    emit(state.copyWith(categories: event.categories, isLoading: false));
  }
}
