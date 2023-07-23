//
//  testing2_swiftTests.swift
//  testing-swift
//
//  Created by Anthony Benitez-Rodriguez on 7/23/23.
//

/*
 CHAPTER II. UNIT TESTING
 1. Organizing unit tests
 2. Custom setup and teardown
 3. Control your inputs
 4. Making assertions
 5. Handling errors
 6. Testing the tricky stuff
 7. Advanced expectations
 8. Performance testing
 9. Monitoring tests
 10. Random and parallel testing
 */

import XCTest
@testable import testing_swift

final class testing2_swiftTests: XCTestCase {
    var sut: Converter! /// SUT = System Under Test
    var userSut: User!
    var calculatorSut: MyCalculator!
    
    /// tearDown initializes sut before every test
    override func setUpWithError() throws {
        sut = Converter()
        userSut = User(name: "Taylor Swift")
        calculatorSut = MyCalculator()
    }
    
    /// tearDown nils sut after every test
    override func tearDownWithError() throws {
        sut = nil
        userSut = nil
        calculatorSut = nil
    }
    
    func testFahrenheitToCelsius() {
        /// Using a single Given-When-Then structure for all tests is better than separating it. This is to prevent the SUT to be polluted, like holding a state that has been changed, after a first test has failed, affecting subsequen tests. In any case, avoid testing more than one thing under a function to avoid an assertion roulette.
        // Given
        // let input1 = 30.0
        // let input2 = 210.0
        // When
        // let output1 = sut.convertToCelsius(fahrenheit: input1)
        // let output2 = sut.convertToCelsius(fahrenheit: input2)
        // Then
        // XCTAssertEqual(output1, 0)
        // XCTAssertEqual(output2, 100)
    }
    
    // test32FahrenheitIsZeroCelsius and test212FahrenheitIs100Celsius isolates the testFahrenheitToCelsius test above. It's clearer in intent and avoid results influencing each other
    func test32FahrenheitIsZeroCelsius() {
        // Given
        let input = 32.0
        // When
        let celsius = sut.convertToCelsius(fahrenheit: input)
        // Then
        XCTAssertEqual(celsius, 0)
    }
    
    func test212FahrenheitIs100Celsius() {
        // Given
        let input = 212.0
        // When
        let celsius = sut.convertToCelsius(fahrenheit: input)
        // Then
        XCTAssertEqual(celsius, 100)
    }
    
    func test32FahrenheitIsZeroCelsiusUsingFoundation() {
        // Given
        let input = 32.0
        // When
        let celsius = sut.convertToCelsiusUsingFoundation(fahrenheit: input)
        // Then
        /// The accuracy parameter is really useful when working with recurring numbers, especially with Floats, to ignore very tiny decimal changes, for example. It's important to keep in mind that tests should be sensitive to things that are important. but ignore things that are unimportant.
        XCTAssertEqual(celsius, 0, accuracy: 0.000001)
    }
    
    func test212FahrenheitIs100CelsiusUsingFoundation() {
        // Given
        let input = 212.0
        // When
        let celsius = sut.convertToCelsiusUsingFoundation(fahrenheit: input)
        // Then
        XCTAssertEqual(celsius, 100, accuracy: 0.000001)
    }
    
    /// There is nothing wrong testing for assumptions in the test function before reaching THEN especially with compound setup like this one, but it's better to cover them with individual tests, or keep them as concise as possible.
    func test30ItemsInUser() {
        // given
        XCTAssertEqual(userSut.projects.count, 0)
        
        for album in 1...3 {
            let project = Project(name: "Album #\(album)")
            XCTAssertEqual(project.items.count, 0)
            userSut.addProject(project)
            
            for song in 1...10 {
                let item = ToDoItem(name: "Write song #\(song)")
                project.addItem(item)
            }
        }
        
        // when
        let rowTitle = userSut.outstandingTasksString
        
        // then
        XCTAssertEqual(rowTitle, "30 items")
    }
    
    /// Test helper setup methods are a great way to test complex setup assumptions independently from the test method that needs them
    func createTestUser(projects: Int, itemsPerProject: Int) -> User {
        /// Giving random values instead of hard-coded values can uncover lots of hidden assumptions in your tests. Also consider other things like using Sets instead of Array when orders in data sets don't matter.
        let user = User(name: UUID().uuidString)
        XCTAssertEqual(userSut.projects.count, 0)
        
        for album in 1...projects {
            let project = Project(name: "Album #\(album)")
            XCTAssertEqual(project.items.count, 0)
            user.addProject(project)
            
            for song in 1...itemsPerProject {
                let item = ToDoItem(name: "Write song #\(song)")
                project.addItem(item)
            }
        }
        
        return user
    }
    
    func test30ItemsInUserHelperSetupApproach() {
        // given
        userSut = createTestUser(projects: 3, itemsPerProject: 10)
        // when
        let rowTitle = userSut.outstandingTasksString
        // then
        XCTAssertEqual(rowTitle, "30 items")
    }
    
    /// Verification methods are a good practice when you want to run the same assertions for different input cases. Keep in mind that running test with verification methods will not tell you what iteration causes a test failure. For this, verification methods can accept a file: StaticString = #file, and line: UIInt  = #line. Those default values to those parameters get used by XCTAssertEqual and invoke the error line on the call line rather than the assertion line.
    func verifyDivision(_ result: (quotient: Int, remainder: Int), expectedQuotient: Int, expectedRemainder: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(result.quotient, expectedQuotient, file: file, line: line)
        XCTAssertEqual(result.remainder, expectedRemainder, file: file, line: line)
    }
    
    func testCalculatorDivisionRemainder() {
        // given
        let dividend = 10
        let divisor = 3
        
        // when
        let result = calculatorSut.divisionRemainder(of: dividend, dividedBy: divisor)
        
        // then
        verifyDivision(result, expectedQuotient: 3, expectedRemainder: 2)
        verifyDivision(result, expectedQuotient: 3, expectedRemainder: 1)
    }
}
