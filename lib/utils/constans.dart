enum AlertAction {
  cancel,
  discard,
  disagree,
  agree,
}

const bool devMode = false;
const String apiURL = devMode == false ? "http://utama-trans.com/new/api":"http://192.168.43.110/api";
const double textScaleFactor = 1.0;