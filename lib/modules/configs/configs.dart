import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class ConfigService {
  static load() async {
    await DotEnv.load(fileName: '.env');
  }

  String get apiUrl {
    return DotEnv.env['API_URL'];
  }

  String get reduxDevtoolsUrl {
    return DotEnv.env['REDUX_DEVTOOLS_URL'];
  }

  String get mode {
    return DotEnv.env['MODE'];
  }
}
