//
//  ScreebWrapper.swift
//  ScreebReactDemoApp
//
//  Created by Quaquin Clément on 13/12/2021.
//

import Foundation
import Screeb
import UIKit

@objc(ScreebWrapper)
class ScreebWrapper: NSObject {

  @objc(initScreeb:)
  func initScreeb(context: UIViewController) {
    Screeb.initSdk(context: context, channelId: "5c62c145-91f1-4abd-8aa2-63d7847db1e1", identity: nil, visitorProperty: [:])
  }

  @objc func setIdentity(_ userId: String, properties properties_: [String: Any]?) {
    var map: [String: AnyEncodable?] = [:]
    if (properties_ != nil) {
        map = self.mapToAnyEncodable(map: properties_!)
    }
    Screeb.setIdentity(uniqueVisitorId: userId, visitorProperty: map)
  }

  @objc func trackEvent(_ eventId: String, properties properties_: [String: Any]?) {
    var map: [String: AnyEncodable?] = [:]
    if (properties_ != nil) {
        map = self.mapToAnyEncodable(map: properties_!)
    }
    Screeb.trackEvent(name: eventId, trackingEventProperties: map)
  }

  @objc func trackScreen(_ screen: String, properties properties_: [String: Any]?) {
    var map: [String: AnyEncodable?] = [:]
    if (properties_ != nil) {
        map = self.mapToAnyEncodable(map: properties_!)
    }
    Screeb.trackScreen(name: screen, trackingEventProperties: map)
  }

  @objc(setProperties:)
  func setVisitorPropertiesImpl(_ properties: [String: Any]) {
    let map = self.mapToAnyEncodable(map: properties)
    Screeb.visitorProperty(visitorProperty: map)
  }

  private func mapToAnyEncodable(map: [String: Any]) -> [String: AnyEncodable?] {
      return map.mapValues{
          value in
          switch value {
          case is String:
              return AnyEncodable(value as! String)
          case is Bool:
              return AnyEncodable(value as! Bool)
          case is Float:
              return AnyEncodable(value as! Float)
          case is Int:
              return AnyEncodable(value as! Int)
          default: break
          }
          return nil
      }
  }

}
