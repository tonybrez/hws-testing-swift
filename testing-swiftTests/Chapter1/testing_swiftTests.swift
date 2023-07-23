//
//  testing_swiftTests.swift
//  testing-swiftTests
//
//  Created by Anthony Benitez-Rodriguez on 7/16/23.
//

/*
 CHAPTER I. THE BASICS OF TESTING
   1. Why test?
   2. Your first test
   3. The anatomy of a test
   4. The testing pyramid
   5. So what's the problem?
 */

import XCTest
@testable import testing_swift /// @testable makes the test have the same encapsulation access as the class it's importing

/*
 The TESTING PYRAMID GOES from the structural Base - Unit Tests, to the middle layer - Integration Tests, to the top - UI tests.
 
 First, Compiler evaluates your codes with data types, return values, misuse optionals, forget enum cases. etc
 Then, Unit Tests evaluate the code's intent.
 Then, Integration Tests the program case flows are reliant.
 Lastly, UI Tests captures differences visually or navigationally on the UI.
 
 Errors on the bottom of the pyramid will be more impactful than errors on the top.
 
 UNIT TESTS  verify specific details in your code and should be FIRST:
 Fast: you should be able to run dozens of them every second, if not hundreds. As they say in the article, “the faster your tests run, the more often you’ll run them.”
 Isolated: they should not depend on another test having run, or any sort of external state.
 Repeatable: they should always give the same result when they are run, regardless of how many times or when they are run. If unit tests intermittently fail – usually called “flaky tests” – developers stop trusting them as being an accurate measure of code health.
 Self-verifying: the test must unambiguously say whether it passed or failed, with no room for interpretation.
 Timely: they should be written before or alongside the production code that you are testing. This leads into test-driven development, which is covered much later in this book.”

 INTEGRATION TESTS verify parts of the program combined together, where A and B leads to C, and are _IR__:
 - They can’t always be fast, because the nature of integration tests is that they are doing real work using real components.
 - They can and should be isolated: one integration test should not affect another.
 - They can and should be repeatable: we want integration tests to yield the same tests whenever they are run.
 - They can’t always be self-verifying, because sometimes humans need to check the results by hand.
 - They are rarely timely, at least by the standards of Ottinger and Langr – it’s unlikely you’ll write them alongside your production code.”

UI TESTS are done through UITest and/or manually to do what a user would.
 The technology itself is less mature, so it might take more work to make your tests pass.
 It’s harder to track what caused the error when a test fails. Should have swiped when it tapped, or vice versa? Whenever you change your user interface a little you might break tests.
 Visual verification – known as snapshot or screenshot tests – relies on two images being absolutely identical. If iOS changes font rendering just a tiny amount between releases, your snapshot tests will fail.
 
 The same way we as developers don't ask clients if they want their app on developed in Scrum or Kanban methodologies, or MVC or MVVM architecture, we don't ask if they want tests on their app. It's on us as developers to create sustainable programs - our reputation relies on shipping high-quality software, on spec, and on time, which includes high-quality tests.
 
 Always write enough unit tests so that they're FIRST and are self-documenting, if it becomes unreadable, slow, convoluted, you might be overdoing it. Nobody wants to go through long minutes on waiting unit tests to run, or unreadable tests that lose their purpose.
 */
final class testing_swiftTests: XCTestCase {

    /// setUp() and tearDown() run before and after every test, respectively
    /// For optimal performance, it's best to create test properties as Optionals, and create/destroy them in these lifecycle methods
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    /// XCTestCase runs your tests in alphabetical order; not the written order.
    /* XCTestCase naming convention for tests is testMethodName. Having anything before it eliminates it as a test. It's good practice to use "DISABLED", "INACTIVE", "SKIP", "DEAD", and "BROKEN" to turn off tests and communicate intent, such as SKIP_testHaterStartsNicely(), for example.
     */
    /// It's also convention to name test methods to convey their purpose with keywords such as "Should", "Is", etc, such as testEmptyTableRowAndColumnCountShouldBeZero(), for example.
    func testHaterStartsNicely() {
        let hater = Hater()

        /// Testing is part of documentation, so be sure to use XCTAssert functions that best describe the intent of the testing item.
        XCTAssertFalse(hater.hating, "New Haters should not be hating.")
    }
    
    func testHaterHatesAfterBadDay() {
        var hater = Hater()

        hater.hadABadDay()

        XCTAssertTrue(hater.hating)
    }

    /// Test method should always have the structure in here
    func testHaterHappyAfterGoodDay() {
        // 1. GIVEN
        var hater = Hater()

        // 2. WHEN
        hater.hadAGoodDay()

        // 3. THEN
        XCTAssertFalse(hater.hating)
    }
}
