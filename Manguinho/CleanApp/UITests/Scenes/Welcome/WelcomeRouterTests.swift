import XCTest
import UIKit
import Presentation
import UI

public final class WelcomeRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    
    public init (nav: NavigationController, loginFactory: @escaping () -> LoginViewController){
        self.nav = nav
        self.loginFactory = loginFactory
    }
    
    public func gotoLogin(){
        nav.pushViewController(loginFactory())
    }
}


class WelcomeRouterTests: XCTestCase {
    
    func test_gotoLogin_calls_nav_with_correct_viewController(){
        let nav = NavigationController()
        let loginFactorySpy = LoginFactorySpy()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin)
        sut.gotoLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
    
    class LoginFactorySpy {
        func makeLogin () -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }
}
