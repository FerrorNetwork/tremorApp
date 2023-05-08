import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles = ["Добро пожаловать в приложение для управления тремором рук!",
                      "Улучшите свою жизнь с помощью нашего приложения.",
                      "Не дайте тремору рук ограничить вашу жизнь - начните анализировать уже сегодня!"]
    var pageImages = ["image1", "image2", "image3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.view.backgroundColor = .white

        let startingViewController = viewControllerAtIndex(index: 0)
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray

        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? SlideViewController else { return nil }
        var index = viewController.index
        if index == 0 {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? SlideViewController else { return nil }
        var index = viewController.index
        index += 1
        if index == pageTitles.count {
            return nil
        }
        return viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let viewController = pageViewController.viewControllers?.first as? SlideViewController else { return 0 }
        return viewController.index
    }
    
    // MARK: - Helper methods
    
    func viewControllerAtIndex(index: Int) -> SlideViewController {
        let slideViewController = SlideViewController()
        slideViewController.index = index
        slideViewController.titleText = pageTitles[index]
        slideViewController.imageName = pageImages[index]
        
        if index == 2 {
               slideViewController.button.isHidden = false
        } else {
            slideViewController.button.isHidden = true
        }

        return slideViewController
    }
}


