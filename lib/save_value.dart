import 'package:shared_preferences/shared_preferences.dart';

class SaveValue {
  static String GOOGLE_ID = "google_id";
  static String PERIOD = "first_date_of_period";
  static String PERIOD_DURATION = "duration_of_the_period";
  static String ACCESS_CODE = "access_code";
  static String SAFE_ACCESS = "safe_access";
  static String SHOW_FERTILE_WINDOE = "fertile window";
  static String LOCK_ON = "lock_on";
  static String OVULATION = "ovulation";
  static String CYCLE_LENGTH = "cycle_length";
  static final String LOGIN_WITH_GOOGLE = "login_with_google";
  static final String FIRST_TIME = "first_time_lunch";
  // static final String IS_PURCHASED = "is_purchased";



  // static Future<void> setIsPurchased(bool b) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(IS_PURCHASED, b);
  // }
  //
  // static Future<bool> isPurchased() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(IS_PURCHASED);
  // }

  static Future<void> setOvulation(String i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(OVULATION, i);
  }

  static Future<String> getOvulation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(OVULATION);
  }





  static Future<void> setGoogleId(String i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GOOGLE_ID, i);
  }

  static Future<String> getGoogleId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(GOOGLE_ID);
  }

  static Future<String> getLastPeriodDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PERIOD);
  }

  static Future<void> saveLastPeriodDate(String period) async {
    print(period);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PERIOD, period);
  }

  static Future<void> savePeriodDuration(int duration) async {
    print(duration);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PERIOD_DURATION, duration);
  }

  static Future<int> getPeriodDuration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PERIOD_DURATION ?? 0);
  }

  static Future<void> saveCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCESS_CODE, code);
  }

  static Future<String> getCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESS_CODE ?? "");
  }

  static Future<void> setLockOn(bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOCK_ON, b);
  }

  static Future<bool> isLockOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LOCK_ON);
  }

  static Future<void> setFertileWindow(bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SHOW_FERTILE_WINDOE, b);
  }

  static Future<bool> isShowFertileWindow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SHOW_FERTILE_WINDOE);
  }



  static Future<void> saveCycleLength(int cycleValue) async {
    print(cycleValue);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(CYCLE_LENGTH, cycleValue);
  }

  static Future<int> getCycleLength() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(CYCLE_LENGTH);
  }

  static Future<void> setLoginWithGoogle(bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGIN_WITH_GOOGLE, b);
  }

  static Future<bool> isLoginWithGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LOGIN_WITH_GOOGLE);
  }

  static Future<void> setFirstTime(bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(FIRST_TIME, b);
  }

  static Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(FIRST_TIME);
  }

}
