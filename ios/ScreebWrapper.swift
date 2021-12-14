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
  func initScreebImpl(context: UIViewController) {
    Screeb.initSdk(context: context, channelId: "5c62c145-91f1-4abd-8aa2-63d7847db1e1")
  }
  
  @objc(setIdentity:)
  func setIdentity(_ userId: String) {
    Screeb.setIdentity(uniqueVisitorId: userId)
  }

  @objc(trackEvent:)
  func trackEventImpl(_ eventId: String) {
    Screeb.trackEvent(name: eventId)
  }

  @objc(trackScreen:)
  func trackScreenImpl(_ screen: String) {
    Screeb.trackScreen(name: screen, trackingEventProperties: [:])
  }

  @objc(setVisitorProperties:)
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
