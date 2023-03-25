//
//  SharedPreferencesPluginOrigin.swift
//  desktop_multi_window
//
//  Created by CJ on 2023/3/25.
//

import Foundation
import FlutterMacOS

/// Generated class from Pigeon.
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol UserDefaultsApi {
  func remove(key: String)
  func setBool(key: String, value: Bool)
  func setDouble(key: String, value: Double)
  func setValue(key: String, value: Any)
  func getAll() -> [String?: Any?]
  func clear()
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class UserDefaultsApiSetup {
  /// The codec used by UserDefaultsApi.
  /// Sets up an instance of `UserDefaultsApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: UserDefaultsApi?) {
    let removeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.remove", binaryMessenger: binaryMessenger)
    if let api = api {
      removeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let keyArg = args[0] as! String
        api.remove(key: keyArg)
        reply(wrapResult(nil))
      }
    } else {
      removeChannel.setMessageHandler(nil)
    }
    let setBoolChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setBool", binaryMessenger: binaryMessenger)
    if let api = api {
      setBoolChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let keyArg = args[0] as! String
        let valueArg = args[1] as! Bool
        api.setBool(key: keyArg, value: valueArg)
        reply(wrapResult(nil))
      }
    } else {
      setBoolChannel.setMessageHandler(nil)
    }
    let setDoubleChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setDouble", binaryMessenger: binaryMessenger)
    if let api = api {
      setDoubleChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let keyArg = args[0] as! String
        let valueArg = args[1] as! Double
        api.setDouble(key: keyArg, value: valueArg)
        reply(wrapResult(nil))
      }
    } else {
      setDoubleChannel.setMessageHandler(nil)
    }
    let setValueChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setValue", binaryMessenger: binaryMessenger)
    if let api = api {
      setValueChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let keyArg = args[0] as! String
        let valueArg = args[1]!
        api.setValue(key: keyArg, value: valueArg)
        reply(wrapResult(nil))
      }
    } else {
      setValueChannel.setMessageHandler(nil)
    }
    let getAllChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.getAll", binaryMessenger: binaryMessenger)
    if let api = api {
      getAllChannel.setMessageHandler { _, reply in
        let result = api.getAll()
        reply(wrapResult(result))
      }
    } else {
      getAllChannel.setMessageHandler(nil)
    }
    let clearChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.clear", binaryMessenger: binaryMessenger)
    if let api = api {
      clearChannel.setMessageHandler { _, reply in
        api.clear()
        reply(wrapResult(nil))
      }
    } else {
      clearChannel.setMessageHandler(nil)
    }
  }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: FlutterError) -> [Any?] {
  return [
    error.code,
    error.message,
    error.details
  ]
}


public class SharedPreferencesPluginOriginal: NSObject, FlutterPlugin, UserDefaultsApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SharedPreferencesPluginOriginal()
    // Workaround for https://github.com/flutter/flutter/issues/118103.
#if os(iOS)
    let messenger = registrar.messenger()
#else
    let messenger = registrar.messenger
#endif
    UserDefaultsApiSetup.setUp(binaryMessenger: messenger, api: instance)
  }

  func getAll() -> [String? : Any?] {
    return getAllPrefs();
  }

  func setBool(key: String, value: Bool) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func setDouble(key: String, value: Double) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func setValue(key: String, value: Any) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func remove(key: String) {
    UserDefaults.standard.removeObject(forKey: key)
  }

  func clear() {
    let defaults = UserDefaults.standard
    for (key, _) in getAllPrefs() {
      defaults.removeObject(forKey: key)
    }
  }
}

/// Returns all preferences stored by this plugin.
private func getAllPrefs() -> [String: Any] {
  var filteredPrefs: [String: Any] = [:]
  if let appDomain = Bundle.main.bundleIdentifier,
    let prefs = UserDefaults.standard.persistentDomain(forName: appDomain)
  {
    for (key, value) in prefs where key.hasPrefix("flutter.") {
      filteredPrefs[key] = value
    }
  }
  return filteredPrefs
}
