import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageService _service;

  LanguageRepositoryImpl(this._service);

  @override
  void setLanguageCode(String code){
    _service.setLanguageCode(code);
  }
}