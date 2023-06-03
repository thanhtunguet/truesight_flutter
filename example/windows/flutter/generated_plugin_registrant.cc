//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>
#include <truesight_flutter/truesight_flutter_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ObjectboxFlutterLibsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ObjectboxFlutterLibsPlugin"));
  TruesightFlutterPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("TruesightFlutterPluginCApi"));
}
