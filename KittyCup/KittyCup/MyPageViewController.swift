//
//  MyPageViewController.swift
//  KittyCup
//
//  Created by Scott Kuhn on 3/31/17.
//  Copyright © 2017 kuhn. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var currentHole = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let initialHoleController = storyboard?.instantiateViewController(withIdentifier: "HoleViewController") as! HoleViewController
        initialHoleController.holeNumber = 1
        self.setViewControllers([initialHoleController], direction: .forward, animated: true, completion: nil)
        self.dataSource = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHoleViewController(forHoleNumber hole: Int) -> UIViewController? {
        print ("GetHoleViewController forHoleNumber: \(hole)")
        let vc = storyboard?.instantiateViewController(withIdentifier: "HoleViewController")as! HoleViewController
        vc.holeNumber = hole
        return vc
    }
    
    // @TODO: This method and the next should not assume 18 holes - might be a 9 hole scorecard; check model.
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        print("viewController Before!")
        var prevHoleNumber = ((viewController as! HoleViewController).holeNumber! - 1)
        if (prevHoleNumber < 1) {
            prevHoleNumber = 18
        }
        let prevViewController = getHoleViewController(forHoleNumber: prevHoleNumber)
        return prevViewController;
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("viewController After !")

        var nextHoleNumber = ((viewController as! HoleViewController).holeNumber! + 1)
        if (nextHoleNumber > 18) {
            nextHoleNumber = 1
        }
        let nextViewController = getHoleViewController(forHoleNumber: nextHoleNumber)
        return nextViewController;
    }


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
