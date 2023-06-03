#include "include/truesight_flutter/truesight_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "truesight_flutter_plugin.h"

void TruesightFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  truesight_flutter::TruesightFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
