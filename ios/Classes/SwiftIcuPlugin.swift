import Flutter
import UIKit

public class SwiftIcuPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "icu", binaryMessenger: registrar.messenger())
        let instance = SwiftIcuPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getGraphemeList":
            
            if let args = call.arguments as? String {
                if true {
                    result(getGraphemeSequence(args));
                    
                } else {
                    result(FlutterError.init(code: "BAD_ARGS",
                                             message: "Wrong arg count (getGraphemeList expects 2 args): " + args.count.description,
                                             details: nil))
                }
            } else {
                result(FlutterError.init(code: "BAD_ARGS",
                                         message: "Wrong argument types",
                                         details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func  getGraphemeSequence(_ original: String) -> [String] {
        return Array(original).map({ (c) -> String in
            String(c)
        });
        //    return [original[0], original[1]];
    }
}

