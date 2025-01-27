
class LanguageService {
  String _languageCode;

  LanguageService(this._languageCode);

  String get languageCode => _languageCode;

  void setLanguageCode(String code){
    _languageCode = code;
  }
}