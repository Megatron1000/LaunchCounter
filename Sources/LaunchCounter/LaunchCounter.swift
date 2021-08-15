//    MIT License
//
//    Copyright (c) 2018 Mark Bridges
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation

public class LaunchCounter {
    
    public let userDefaults: UserDefaults
    public let launchCountKey: String
    public let firstLaunchDateKey: String
    public let appVersionsKey: String
    public let appVersion: String
    
    /// Initialise the class
    ///
    /// - Parameters:
    ///   - userDefaults: custom user defaults, if you don't wish to store the count in the standard ones
    ///   - launchCountKey: a custom key, if you don't wish to use the default one (derived from the app's bundle identifier)
    ///   - appVersionsKey: a custom key, if you don't wish to use the default one (derived from the app's bundle identifier)
    ///   - appVersion: the current marketing version of the app

    public init(userDefaults: UserDefaults = UserDefaults.standard,
                launchCountKey: String = (Bundle.main.bundleIdentifier ?? "unknown.bundle.identifier") + "launchCount",
                firstLaunchDateKey: String = (Bundle.main.bundleIdentifier ?? "unknown.bundle.identifier") + "firstLaunchDate",
                appVersionsKey: String = (Bundle.main.bundleIdentifier ?? "unknown.bundle.identifier") + "appVersions",
                appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown.app.version") {
        self.userDefaults = userDefaults
        self.launchCountKey = launchCountKey
        self.firstLaunchDateKey = firstLaunchDateKey
        self.appVersionsKey = appVersionsKey
        self.appVersion = appVersion
    }
    
    /// Call this inside applicationWillFinishLaunching or applicationDidFinishLaunching. Make sure you call it before checking the launchCount
    public func trackLaunch() {
        let currentLaunchCount = getLaunchCount()
        userDefaults.set(currentLaunchCount.advanced(by: 1), forKey: launchCountKey)
        
        if dateOfFirstLaunch == nil {
            userDefaults.set(Date().timeIntervalSince1970, forKey: firstLaunchDateKey)
        }
        
        var launchesForEachVersion = userDefaults.value(forKey: appVersionsKey) as? [String: Int] ?? [String: Int]()
        var launchCountForCurrentVersion = launchesForEachVersion[appVersion] ?? 0
        launchCountForCurrentVersion = launchCountForCurrentVersion.advanced(by: 1)
        launchesForEachVersion[appVersion] = launchCountForCurrentVersion
        userDefaults.set(launchesForEachVersion, forKey: appVersionsKey)
        
    }
    
    /// the number of times the app was launched (1 on first launch)
    public var launchCount: Int {
        let currentLaunchCount = getLaunchCount()
        guard currentLaunchCount != 0 else {
            assertionFailure("trackLaunch hasn't been called. Please ensure you call trackLaunch before querying the launchCount.")
            return currentLaunchCount
        }
        return currentLaunchCount
    }
    
    /// convenience for check if the launch count is 1
    public var isFirstLaunch: Bool {
        return launchCount == 1
    }
    
    /// true if this is the first time the app has been launched with this marketing version
    public var isFirstLaunchOnNewVersion: Bool {
        let launchesForEachVersion = userDefaults.value(forKey: appVersionsKey) as? [String: Int] ?? [String: Int]()
        let launchCountForCurrentVersion = launchesForEachVersion[appVersion] ?? 0
        return launchCountForCurrentVersion == 1
    }
    
    /// reset back to zero. Make sure you remember to call trackLaunch afterwards, if doing this as part of initialisation
    public func reset() {
        userDefaults.removeObject(forKey: launchCountKey)
        userDefaults.removeObject(forKey: firstLaunchDateKey)
        userDefaults.removeObject(forKey: appVersionsKey)
    }
    
    private func getLaunchCount() -> Int {
        return userDefaults.integer(forKey: launchCountKey)
    }
    
    public var dateOfFirstLaunch: Date? {
        guard userDefaults.object(forKey: firstLaunchDateKey) != nil else {
            return nil
        }
            
        let timeIntervalSince1970 = userDefaults.double(forKey: firstLaunchDateKey)
        let dateOfFirstLaunch = Date(timeIntervalSince1970: timeIntervalSince1970)
        return dateOfFirstLaunch
    }
    
    public var daysSinceFirstLaunch: Int {
        guard let dateOfFirstLaunch = self.dateOfFirstLaunch else {
            return 0
        }
        
        let components = Calendar.current.dateComponents([.day], from: dateOfFirstLaunch, to: Date())

        return components.day ?? 0
    }
    
}
