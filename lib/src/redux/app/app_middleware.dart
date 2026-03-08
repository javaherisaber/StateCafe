import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:state_cafe/src/redux/app/app_actions.dart';
import 'package:state_cafe/src/redux/app/app_state.dart';
import 'package:state_cafe/themes/locale.dart';

ThunkAction<AppState> changeLocaleThunk(locale) {
  return (Store<AppState> store) async {
    await AppLocale.setCurrentLocale(locale);
    store.dispatch(LocaleChangedAction(locale));
  };
}
