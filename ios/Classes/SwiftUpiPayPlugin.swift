import Flutter
import UIKit

public class SwiftUpiPayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "upi_pay", binaryMessenger: registrar.messenger())
    let instance = SwiftUpiPayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Void {
    let arguments = call.arguments as? NSDictionary
    switch(call.method) {
    case "canLaunch":
      let uri = (arguments!["uri"] as? String)!
      result(self.canLaunch(uri: uri))
      return
    case "launch":
      let uri = (arguments!["uri"] as? String)!
      self.launchUri(uri: uri, result: result)
      return
    default:
      result(FlutterMethodNotImplemented)
      return
    }
  }

  private func canLaunch(uri: String) -> Bool {
    let url = URL(string: uri)
    return UIApplication.shared.canOpenURL(url!)
  }

  private func launchUri(uri: String, result: @escaping FlutterResult) -> Bool {
    if(canLaunch(uri: uri)) {
      let url = URL(string: uri)
      if #available(iOS 10, *) {
        UIApplication.shared.open(url!, completionHandler: { (ret) in
            result(ret)
        })
      } else {
        result(UIApplication.shared.openURL(url!))
      }
    }
    return false
  }
}
