/**
 * 
 * Home screen for Screeb demo react native app
 *
 * @author clement@screeb.app
 */

import React from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  StatusBar,
  StyleSheet,
  Text,
  Button,
  View,
  NativeModules
} from 'react-native';

const { ScreebModule } = NativeModules;

const App: () => Node = () => {
  const onSetIdentity = () => {
      ScreebModule.setIdentity('ReactNativeUserId', null);
  };
  const onTrackEvent = () => {
      ScreebModule.trackEvent('ReactNativeEventId', null);
  };
  const onTrackScreen = () => {
      ScreebModule.trackScreen('ReactNativeScreen', null);
  };
  const onSetVisitorProperties = () => {
      ScreebModule.setProperties(
            {
               'age': 10,
               'isReactNative': true,
               'name': 'React name',
               'price': 65.7
            }
      );
  };
  return (
    <SafeAreaView style={styles.sectionContainer}>
      <StatusBar />
      <Text style={styles.sectionTitle}>Screeb demo app</Text>
      <Button
        style={styles.sectionButton}
        title="Set identity"
        onPress={onSetIdentity}
      />
      <View style={styles.space} />
      <Button
        style={styles.sectionButton}
        title="Track event"
        onPress={onTrackEvent}
      />
      <View style={styles.space} />
      <Button
        style={styles.sectionButton}
        title="Track screen"
        onPress={onTrackScreen}
      />
      <View style={styles.space} />
      <Button
        style={styles.sectionButton}
        title="Set visitor properties"
        onPress={onSetVisitorProperties}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  sectionButton: {
    padding: 30,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    marginBottom: 32,
  },
  space: {
    width: 20,
    height: 20,
  },
});

export default App;
