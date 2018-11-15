//
//  CalculationController.swift
//  yhnote
//
//  Created by 韦海峰 on 2018/11/15.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

class CalculationController: UIViewController {

    
    // MARK: - 属性
    var firstNum : Float = 2.13
    var secondNum: Float = 2.13
    
    // MARK: - LazyLoad
//   private lazy var problemsCountLabel : UILabel = { [weak self] in
//        let problemsCountLabel = self?.yh_creatLabel(string: "第一题  共15题", font: UIFont.systemFont(ofSize: 15.0), textColor: UIColor.init(white: 0.1, alpha: 0.9))
//        return problemsCountLabel!
//    }()
    
//   private lazy var timerCountLabel : UILabel = { [weak self] in
//        let timerCountLabel = self?.yh_creatLabel(string: "00:00:00", font: UIFont.systemFont(ofSize: 15.0), textColor: UIColor.init(white: 0.1, alpha: 0.9))
//        return timerCountLabel!
//        }()
    
    lazy var answerBtn : UIButton = { [weak self] in
        let answerBtn = self?.yh_creatButton(string: "获取答案", font: UIFont.systemFont(ofSize: 15), textColor: blucolor, action: #selector(answerBtnClick))
        return answerBtn!
        }()
    
    lazy var nextQuestionBtn : UIButton = { [weak self] in
        let nextQuestionBtn = self?.yh_creatButton(string: "下一题", font: UIFont.systemFont(ofSize: 15), textColor: blucolor, action: #selector(nextQuestionBtnClick))
        return nextQuestionBtn!
        }()
    
    
   private lazy var equstionLabel : UILabel = { [weak self] in
        let equstionLabel = self?.yh_creatLabel(string: "120 + 21 =", font: UIFont.systemFont(ofSize: 30.0), textColor: UIColor.init(white: 0.1, alpha: 0.9))
        return equstionLabel!
        }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension CalculationController {
    func setupUI()  {
        title = "计算测试界面"
        view.backgroundColor = UIColor.white
        
//        view.addSubview(self.problemsCountLabel)
//        self.problemsCountLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(view.snp_topMargin).offset(10.0)
//            make.left.equalTo(view.snp_leftMargin).offset(5.0)
//        }
//
//        view.addSubview(self.timerCountLabel)
//        self.timerCountLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(view.snp_topMargin).offset(10.0)
//            make.right.equalTo(view.snp_rightMargin).offset(-5.0)
//        }
        
        view.addSubview(self.answerBtn)
        self.answerBtn.sizeToFit()
        self.answerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp_topMargin).offset(10.0)
            make.left.equalTo(view.snp_leftMargin).offset(5.0)
            make.height.equalTo(answerBtn.frame.height)
            make.width.equalTo(answerBtn.frame.width)
        }
        
        view.addSubview(self.nextQuestionBtn)
        self.nextQuestionBtn.sizeToFit()
        self.nextQuestionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp_topMargin).offset(10.0)
            make.right.equalTo(view.snp_rightMargin).offset(-5.0)
            make.height.equalTo(nextQuestionBtn.frame.height)
            make.width.equalTo(nextQuestionBtn.frame.width)
        }
        
        view.addSubview(self.equstionLabel)
        self.equstionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp_topMargin).offset(100)
            make.centerX.equalTo(view.snp_centerXWithinMargins)
        }
        
        creatNumbers()
    }
    
    func yh_creatLabel(string:String, font:UIFont, textColor:UIColor) -> UILabel {
        let label : UILabel = UILabel()
        label.text = string
        label.font = font
        label.textColor = textColor;
        return label;
    }
    
    func yh_creatButton(string:String, font:UIFont, textColor:UIColor, action: Selector) -> UIButton {
        let button : UIButton = UIButton()
        button.setTitle(string, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.addTarget(secondNum, action: action, for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = font
        return button;
    }
}


// MARK: - 数据构造方法
extension CalculationController {
    func creatNumbers() {
        firstNum  = Float(arc4random_uniform(999))/100.0
        secondNum = Float(arc4random_uniform(999))/100.0
        
        let firstString = String(format: "%.2f", firstNum)
        firstNum = Float(firstString) ?? 0
        
        let secondString = String(format: "%.2f", secondNum)
        secondNum = Float(secondString) ?? 0
        
        let string = firstString + " / " + secondString
        equstionLabel.text = string
    }
    
    func getanswer() {
        let answerNum = firstNum/secondNum
        
        let answerString = String(format: "%.2f", answerNum)
        let firstString  = String(format: "%.2f", firstNum)
        let secondString = String(format: "%.2f", secondNum)
        
        let string = firstString + " / " + secondString + " = " + answerString
        equstionLabel.text = string
        
    }
}


extension  CalculationController {
    @objc func answerBtnClick() {
        getanswer()
    }
    
    @objc func nextQuestionBtnClick() {
        creatNumbers()
    }
    
    
}
