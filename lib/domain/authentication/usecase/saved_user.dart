

import '../../../config/services/local_storage.dart';
import '../../../core/usecase/usecase.dart';

class SavedUser implements UseCase<void, String> {
  @override
  Future<String> call({void params}) async {
    LocalStorage.init();
    return LocalStorage.getString("key");
  }
}
