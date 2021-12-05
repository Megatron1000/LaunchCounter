import XCTest
import LaunchCounter

class LaunchCounterTests: XCTestCase {
    
    var userDefaults: UserDefaults!
    let userDefaultsSuiteName = "TestDefaults"
    var launchCounter: LaunchCounter!
    
    override func setUp() {
        super.setUp()
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        userDefaults = UserDefaults(suiteName: userDefaultsSuiteName)!
        launchCounter = LaunchCounter(userDefaults: userDefaults)
    }
    
    override func tearDown() {
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        super.tearDown()
    }
    
    func testLaunchCountIsOneOnFirstLaunch() {
        launchCounter.trackLaunch()
        XCTAssertEqual(launchCounter.launchCount, 1)
    }
    
    func testLaunchCountIsTwoOnSecondLaunch() {
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        XCTAssertEqual(launchCounter.launchCount, 2)
    }

    func testIsFirstLaucnhIsTrueOnFirstLaunch() {
        launchCounter.trackLaunch()
        XCTAssertTrue(launchCounter.isFirstLaunch)
    }
    
    func testIsFirstLaucnhIsFalseOnSecondLaunch() {
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        XCTAssertFalse(launchCounter.isFirstLaunch)
    }
    
    func testResetResetsBackToZero() {
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        launchCounter.reset()
        launchCounter.trackLaunch()
        XCTAssertTrue(launchCounter.isFirstLaunch)
    }
    
    func testDateOfFirstLaunchIsNilOnFirstLaunch() {
        XCTAssertNil(launchCounter.dateOfFirstLaunch)
    }
    
    func testDateOfFirstLaunchIsNotNilAfterLaunch() {
        launchCounter.trackLaunch()
        XCTAssertNotNil(launchCounter.dateOfFirstLaunch)
    }
    
    func testDateOfFirstLaunchIsNilAfterLaunchAndReset() {
        launchCounter.trackLaunch()
        launchCounter.reset()
        XCTAssertNil(launchCounter.dateOfFirstLaunch)
    }
    
    func testDateOfFirstLaunchIsTheSameAfterSubsequentLaunches() {
        launchCounter.trackLaunch()
        let originalDateOfFirstLaunch = launchCounter.dateOfFirstLaunch
        launchCounter.trackLaunch()
        XCTAssertEqual(originalDateOfFirstLaunch, launchCounter.dateOfFirstLaunch)
    }
    
    func testDaysSinceFirstLaunch() {
        let dateOneDayinThePast = Date().addingTimeInterval(-(60*60*24))
        launchCounter.userDefaults.set(dateOneDayinThePast.timeIntervalSince1970, forKey: launchCounter.firstLaunchDateKey)
        XCTAssertEqual(launchCounter.daysSinceFirstLaunch, 1)
    }
    
    func testLaunchCountOnNewVersion() {
        let launchCounter = LaunchCounter(userDefaults: userDefaults, appVersion: "1.0")
        launchCounter.trackLaunch()
        XCTAssertTrue(launchCounter.isFirstLaunchOnNewVersion)
        
        launchCounter.trackLaunch()
        XCTAssertFalse(launchCounter.isFirstLaunchOnNewVersion)
        
        let launchCounter2 = LaunchCounter(userDefaults: userDefaults, appVersion: "1.1")        
        launchCounter2.trackLaunch()
        XCTAssertTrue(launchCounter2.isFirstLaunchOnNewVersion)
        
        launchCounter2.trackLaunch()
        XCTAssertFalse(launchCounter2.isFirstLaunchOnNewVersion)
    }
    
    func testLaunchCountFirstLaunchVersion() {
        let launchCounter = LaunchCounter(userDefaults: userDefaults, appVersion: "1.0")
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        
        let launchCounter2 = LaunchCounter(userDefaults: userDefaults, appVersion: "1.1")
        launchCounter2.trackLaunch()
        launchCounter2.trackLaunch()
        
        XCTAssertEqual(launchCounter2.firstLaunchVersion, "1.0")
    }
    
    func testHasUpgradedFalse() {
        let launchCounter = LaunchCounter(userDefaults: userDefaults, appVersion: "1.0")
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        
        let launchCounter2 = LaunchCounter(userDefaults: userDefaults, appVersion: "1.0")
        launchCounter2.trackLaunch()
        launchCounter2.trackLaunch()
        
        XCTAssertFalse(launchCounter2.hasUpgraded)
    }
    
    func testHasUpgradedTrue() {
        let launchCounter = LaunchCounter(userDefaults: userDefaults, appVersion: "1.0")
        launchCounter.trackLaunch()
        launchCounter.trackLaunch()
        
        let launchCounter2 = LaunchCounter(userDefaults: userDefaults, appVersion: "1.1")
        launchCounter2.trackLaunch()
        launchCounter2.trackLaunch()
        
        XCTAssertTrue(launchCounter2.hasUpgraded)
    }
        
}

