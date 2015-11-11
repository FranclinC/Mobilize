//
//  IntroViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 11/6/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class IntroViewController: AnimatedPagingScrollViewController {
    
    private let intro = UIImageView(image: UIImage(named: "Intro"))
    
    private let icon = UIImageView(image: UIImage(named: "Icon"))
    private let list = UIImageView(image: UIImage(named: "List"))
    private let pen = UIImageView(image: UIImage(named: "Pen"))
    
    private let arrows = UIImageView(image: UIImage(named: "Arrows"))
    
    private let aquarium = UIImageView(image: UIImage(named: "Aquarium"))
    private let mobi1 = UIImageView(image: UIImage(named: "Mobi1"))
    private let mobi2 = UIImageView(image: UIImage(named: "Mobi2"))
    
    private let mobi3 = UIImageView(image: UIImage(named: "Mobi3"))
    private let wave = UIImageView(image: UIImage(named: "Wave"))
    
    private let text1 = UIImageView(image: UIImage(named: "Text1"))
    private let text2 = UIImageView(image: UIImage(named: "Text2"))
    
    override func numberOfPages() -> Int {
        return 7
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MOBILIZE_BACKGROUND
        prefersStatusBarHidden()
        configureViews()
        configureAnimations()
        // self.performSegueWithIdentifier("GoToInitial", sender: self)
    }
    
    private func configureViews() {
        // Add each of the views to the contentView
        contentView.addSubview(intro)
        
        contentView.addSubview(icon)
        contentView.addSubview(list)
        contentView.addSubview(pen)
        
        contentView.addSubview(arrows)
        
        contentView.addSubview(aquarium)
        contentView.addSubview(mobi1)
        contentView.addSubview(mobi2)
        
        contentView.addSubview(mobi3)
        // contentView.addSubview(wave)
        
        contentView.addSubview(text1)
        contentView.addSubview(text2)
    }
    
    private func configureAnimations() {
        // Configure all of the animations
        configureScrollView()
        configureIntro()
        configureExplanation()
        configureUsageApp()
        configureIdea()
        configureNotes()
    }
    
    private func configureScrollView() {
        // Let's change the background color of the scroll view from dark gray to light gray to blue
        let backgroundColorAnimation = BackgroundColorAnimation(view: scrollView)
        backgroundColorAnimation[4] = MOBILIZE_BACKGROUND
        backgroundColorAnimation[4.5] = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
        backgroundColorAnimation[4.99] = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
        backgroundColorAnimation[5] = UIColor.whiteColor()
        
        backgroundColorAnimation[5] = UIColor.whiteColor()
        backgroundColorAnimation[5.5] = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
        backgroundColorAnimation[5.99] = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
        backgroundColorAnimation[6] = MOBILIZE_BACKGROUND
        
        animator.addAnimation(backgroundColorAnimation)
    }
    
    private func configureIntro() {
        scrollView.addConstraint(NSLayoutConstraint(item: intro, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 50))
        keepView(intro, onPages: [0])
        let introHideAnimation = AlphaAnimation(view: intro)
        animator.addAnimation(introHideAnimation)
    }
    
    private func configureExplanation() {
        scrollView.addConstraint(NSLayoutConstraint(item: icon, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 25))
        keepView(icon, onPages: [1])
        let iconHideAnimation = AlphaAnimation(view: icon)
        animator.addAnimation(iconHideAnimation)
        
        scrollView.addConstraint(NSLayoutConstraint(item: list, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 250))
        keepView(list, onPages: [1])
        let listHideAnimation = AlphaAnimation(view: list)
        animator.addAnimation(listHideAnimation)
        
        scrollView.addConstraint(NSLayoutConstraint(item: pen, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 425))
        keepView(pen, onPages: [1])
        let penHideAnimation = AlphaAnimation(view: pen)
        animator.addAnimation(penHideAnimation)
    }
    
    private func configureUsageApp() {
        let arrowsVerticalConstraint = NSLayoutConstraint(item: arrows, attribute: .CenterY, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1, constant: 50)
        scrollView.addConstraint(arrowsVerticalConstraint)
        scrollView.addConstraint(NSLayoutConstraint(item: arrows, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Width, multiplier: 0.78, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: arrows, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Height, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: arrows, attribute: .Height, relatedBy: .Equal, toItem: arrows, attribute: .Width, multiplier: 1, constant: 0))
        keepView(arrows, onPages: [2])
        let arrowsVerticalAnimation = ConstraintMultiplierAnimation(superview: scrollView, constraint: arrowsVerticalConstraint, attribute: .Height, referenceView: scrollView)
        arrowsVerticalAnimation[1] = -0.2
        arrowsVerticalAnimation[2] = 0.2
        animator.addAnimation(arrowsVerticalAnimation)
    }
    
    private func configureIdea() {
        scrollView.addConstraint(NSLayoutConstraint(item: aquarium, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 200))
        keepView(aquarium, onPages: [3, 4])
        let aquariumHideAnimation = AlphaAnimation(view: aquarium)
        animator.addAnimation(aquariumHideAnimation)
        
        scrollView.addConstraint(NSLayoutConstraint(item: mobi1, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 225))
        keepView(mobi1, onPages: [3])
        let mobi1HideAnimation = AlphaAnimation(view: mobi1)
        animator.addAnimation(mobi1HideAnimation)
        
        scrollView.addConstraint(NSLayoutConstraint(item: mobi2, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 225))
        keepView(mobi2, onPages: [4])
        let mobi2HideAnimation = AlphaAnimation(view: mobi2)
        animator.addAnimation(mobi2HideAnimation)
        
        
        scrollView.addConstraint(NSLayoutConstraint(item: mobi3, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 100))
        keepView(mobi3, onPages: [5])
        let mobi3HideAnimation = AlphaAnimation(view: mobi3)
        animator.addAnimation(mobi3HideAnimation)
        
        /*
        scrollView.addConstraint(NSLayoutConstraint(item: wave, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 225))
        keepView(wave, onPages: [5])
        let waveHideAnimation = AlphaAnimation(view: wave)
        animator.addAnimation(waveHideAnimation)
        */
    }
    
    private func configureNotes() {
        scrollView.addConstraint(NSLayoutConstraint(item: text1, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 100))
        keepView(text1, onPages: [6])
        let text1HideAnimation = AlphaAnimation(view: text1)
        animator.addAnimation(text1HideAnimation)
        
        scrollView.addConstraint(NSLayoutConstraint(item: text2, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 400))
        keepView(text2, onPages: [6])
        let text2HideAnimation = AlphaAnimation(view: text2)
        animator.addAnimation(text2HideAnimation)
    }
    
}
