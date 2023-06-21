import Flutter
import UIKit

public class TruesightFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "truesight_flutter", binaryMessenger: registrar.messenger())
        let instance = TruesightFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public static func loadEnv() -> [String: String]? {
        guard let envFileURL = Bundle.main.url(forResource: ".env", withExtension: nil),
              let envContent = try? String(contentsOf: envFileURL) else {
            return nil
        }
        
        var envDictionary = [String: String]()
        let lines = envContent.components(separatedBy: .newlines)
        
        for line in lines {
            let components = line.components(separatedBy: "=")
            if components.count == 2 {
                let key = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let value = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                envDictionary[key] = value
            }
        }
        
        return envDictionary
    }
}
