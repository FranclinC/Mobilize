//
//  IntroViewController.swift
//  Mobilize
//
//  Created by Miguel Araújo on 11/6/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit

class IntroViewController: AnimatedPagingScrollViewController {
    
    private let bigMobi = UIImageView(image: UIImage(named: "bigMobi"))
    private let castle1 = UIImageView(image: UIImage(named: "castle1"))
    private let cellphone = UIImageView(image: UIImage(named: "cellphone"))
    private let iconWithFlag = UIImageView(image: UIImage(named: "iconWithFlag"))
    private let listField = UIImageView(image: UIImage(named: "listField"))
    private let mobiWithText = UIImageView(image: UIImage(named: "mobiWithText"))
    private let mobiWithText2 = UIImageView(image: UIImage(named: "mobiWithText2"))
    private let pen = UIImageView(image: UIImage(named: "pen"))
    private let text1 = UIImageView(image: UIImage(named: "text1"))
    private let text2 = UIImageView(image: UIImage(named: "text2"))
    private let textWithPointers = UIImageView(image: UIImage(named: "textWithPointers"))
    private let wave = UIImageView(image: UIImage(named: "wave"))
    
    override func numberOfPages() -> Int {
        return 6
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 70/255.0, green: 97/255.0, blue: 157/255.0, alpha: 1.0)
        prefersStatusBarHidden()
        
        configureViews()
        configureAnimations()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func configureViews() {
        contentView.addSubview(cellphone)
        contentView.addSubview(iconWithFlag)
        contentView.addSubview(listField)
        contentView.addSubview(pen)
        
        /*
        contentView.addSubview(castle1)
        contentView.addSubview(bigMobi)
        contentView.addSubview(mobiWithText)
        contentView.addSubview(mobiWithText2)
        contentView.addSubview(text1)
        contentView.addSubview(text2)
        contentView.addSubview(textWithPointers)
        contentView.addSubview(wave)
        */
    }
    
    private func configureAnimations() {
        configureOne()
        configureTwo()
    }
    
    private func configureOne() {
        scrollView.addConstraint(NSLayoutConstraint(item: cellphone, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 50))
        keepView(cellphone, onPages: [0])
        let cellphoneHideAnimation = AlphaAnimation(view: cellphone)
        animator.addAnimation(cellphoneHideAnimation)
    }
    
    private func configureTwo() {
        scrollView.addConstraint(NSLayoutConstraint(item: iconWithFlag, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 10))
        keepView(iconWithFlag, onPages: [1])
        let iconWithFlagHideAnimation = AlphaAnimation(view: iconWithFlag)
        animator.addAnimation(iconWithFlagHideAnimation)
        
        scrollView.addConstraint(NSLayoutConstraint(item: listField, attribute: .Top, relatedBy: .Equal, toItem: iconWithFlag, attribute: .Bottom, multiplier: 1, constant: 50))
        keepView(listField, onPages: [1])
        let listFieldHideAnimation = AlphaAnimation(view: listField)
        animator.addAnimation(listFieldHideAnimation)
        
        scrollView.addConstraint(NSLayoutConstraint(item: pen, attribute: .Top, relatedBy: .Equal, toItem: listField, attribute: .Bottom, multiplier: 1, constant: 50))
        keepView(pen, onPages: [1])
        let penHideAnimation = AlphaAnimation(view: pen)
        animator.addAnimation(penHideAnimation)
    }
}
