
import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTabs()
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = .gray
        navigationItem.hidesBackButton = true
    }
    
    private func setUpTabs() {
        let tremorVC = TremorAnalizeViewController()
        let resultVC = ResultViewController()
       
        let nav1 = UINavigationController(rootViewController: tremorVC)
        let nav2 = UINavigationController(rootViewController: resultVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Analysis",
                                       image: UIImage(systemName: "gyroscope"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Results", image: UIImage(systemName: "newspaper"), tag: 2)
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
