//
//  ViewController.swift
//  SlotMachine
//
//  Created by ob_club on 14/10/18.
//  Copyright (c) 2014年 wangweiclub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var firstContainer:UIView!
    var secondContainer:UIView!
    var thirdContainer:UIView!
    var fourthContainer:UIView!
    
    var titleLable:UILabel!
    
    var creditsLable:UILabel!
    var betLable:UILabel!
    var winnerPaidLable:UILabel!
    var creditstitleLable:UILabel!
    var bettitleLable:UILabel!
    var winnerPaidtitleLable:UILabel!
    
    var credits=0
    var currentbet=0
    var winnings=0
    
    var resetButton:UIButton!
    var betOneButton:UIButton!
    var betMaxButton:UIButton!
    var spinButton:UIButton!
    
    var slots:[[Slot]]=[]//slots array
    
    let kMarginForView:CGFloat=10.0
    let kSixth:CGFloat=1.0/6.0
    
    let kThird:CGFloat=1.0/3.0
    let kMarginForSolt:CGFloat=2.0
    
    let kHalf:CGFloat=1.0/2.0
    let kEighth:CGFloat=1.0/8.0
    
    let kNumberOfContainers=3
    let kNumberOfSlots=3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupContainerView()
        self.setupfirstContainer(self.firstContainer)
        
        self.setupthirdContainer(self.thirdContainer)
        self.setupfourth(self.fourthContainer)
        
        hardReset()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ResetButtonPressed(button:UIButton){
        //println("ResetButtonPressed:")
        hardReset()
    }
    
    func BetOneButtonPressed(button:UIButton){
        //println("BetOneButtonPressed:")
        if credits<=0{
            showAlertWithText(header: "No More Credits", message: "Reset Game")
        }
        else{
            if currentbet<5{
                currentbet+=1
                credits-=1
                updateMainView()
            }
            else{
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
    }
    
    func BetMaxButtonPressed(button:UIButton){
    
        if credits<=5{
            showAlertWithText(header: "Not Enough Credits", message: "Bet Less")
        }
        else {
            if currentbet<5{
                var creditsToBetMax=5-currentbet
                credits-=creditsToBetMax
                currentbet+=creditsToBetMax
                updateMainView()
            }
            else{
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
    }
    
    func SpinButtonPressed(button:UIButton){
        removeSlotImageViews()
        slots=Factary.creatSlots()
        setupscondContainer(self.secondContainer)
        
        var winningsMultiplier=SlotBrain.computeWinnings(slots)
        winnings=winningsMultiplier*currentbet
        credits+=winnings
        currentbet=0
        updateMainView()
        
        
    }

    func setupContainerView(){
            self.firstContainer=UIView(frame: CGRect(x: self.view.bounds.origin.x+kMarginForView, y: self.view.bounds.origin.y, width: self.view.bounds.width-(kMarginForView*2), height: self.view.bounds.height*kSixth))
            self.firstContainer.backgroundColor=UIColor.redColor()
            self.view.addSubview(self.firstContainer)
        
            self.secondContainer=UIView(frame: CGRect(x: self.view.bounds.origin.x+kMarginForView, y:self.firstContainer.frame.height , width: self.view.bounds.width-(kMarginForView*2), height:self.view.bounds.height*kSixth*3))
            self.secondContainer.backgroundColor=UIColor.blackColor()
            self.view.addSubview(self.secondContainer)
        
            self.thirdContainer=UIView(frame: CGRect(x: self.view.bounds.origin.x+kMarginForView, y: self.firstContainer.frame.height+self.secondContainer.frame.height, width: self.view.bounds.width-(kMarginForView*2), height: self.view.bounds.height*kSixth))
            self.thirdContainer.backgroundColor=UIColor.lightGrayColor()
            self.view.addSubview(self.thirdContainer)
        
            self.fourthContainer=UIView(frame: CGRect(x: self.view.bounds.origin.x+kMarginForView, y: self.firstContainer.frame.height+self.secondContainer.frame.height+self.thirdContainer.frame.height, width: self.view.bounds.width-(kMarginForView*2), height: self.view.bounds.height*kSixth))
            self.fourthContainer.backgroundColor=UIColor.blackColor()
            self.view.addSubview(self.fourthContainer)
    }
    
    func setupfirstContainer(containerView:UIView){
            self.titleLable=UILabel()
            self.titleLable.text="Super Slots"
            self.titleLable.textColor=UIColor.yellowColor()
            self.titleLable.font=UIFont(name: "MarkerFelt-Wide", size: 40)
            self.titleLable.sizeToFit()
            self.titleLable.center=containerView.center
            containerView.addSubview(self.titleLable)
    }
    
    func setupscondContainer(containerView:UIView){
        for var ContainerNumber=0;ContainerNumber<kNumberOfContainers;++ContainerNumber{
            for var SoltNumber=0;SoltNumber<kNumberOfSlots;++SoltNumber{
               
                var slotImageView=UIImageView()
                var slot:Slot
                if slots.count != 0{
                    let slotContainer=slots[ContainerNumber]
                        slot=slotContainer[SoltNumber]
                    slotImageView.image=slot.image
                }else{
                    slotImageView.image=UIImage(named: "1.jpg")
                }
                //第一次打开则显示规定图片，if后面不理解!
                
                slotImageView.backgroundColor=UIColor.yellowColor()
                slotImageView.frame=CGRect(x: containerView.bounds.origin.x+containerView.bounds.size.width*CGFloat(ContainerNumber)*kThird, y: containerView.bounds.origin.y+containerView.bounds.size.height*CGFloat(SoltNumber)*kThird, width: containerView.bounds.width*kThird-kMarginForSolt, height: containerView.bounds.height*kThird-kMarginForSolt)
                containerView.addSubview(slotImageView)
            }
        }
    }
    
    func setupthirdContainer(containerView:UIView){
            self.creditsLable=UILabel()
            self.creditsLable.text="00000"
            self.creditsLable.textColor=UIColor.redColor()
            self.creditsLable.font=UIFont(name: "Menlo-Bold", size: 16)
            self.creditsLable.sizeToFit()
            self.creditsLable.center=CGPoint(x:containerView.frame.width*kSixth , y: containerView.frame.height*kThird)
            self.creditsLable.textAlignment=NSTextAlignment.Center
            self.creditsLable.backgroundColor=UIColor.darkGrayColor()
            containerView.addSubview(self.creditsLable)
        
            self.betLable=UILabel()
            self.betLable.text="0000"
            self.betLable.textColor=UIColor.redColor()
            self.betLable.font=UIFont(name: "Menlo-Bold", size: 16)
            self.betLable.sizeToFit()
            self.betLable.center=CGPoint(x: containerView.frame.width*kSixth*3, y:containerView.frame.height*kThird)
            self.betLable.textAlignment=NSTextAlignment.Center
            self.betLable.backgroundColor=UIColor.darkGrayColor()
            containerView.addSubview(self.betLable)
        
            self.winnerPaidLable=UILabel()
            self.winnerPaidLable.text="000000"
            self.winnerPaidLable.textColor=UIColor.redColor()
            self.winnerPaidLable.font=UIFont(name: "Menlo-Bold", size: 16)
            self.winnerPaidLable.sizeToFit()
            self.winnerPaidLable.center=CGPoint(x: containerView.frame.width*kSixth*5, y: containerView.frame.height*kThird)
            self.winnerPaidLable.textAlignment=NSTextAlignment.Center
            self.winnerPaidLable.backgroundColor=UIColor.darkGrayColor()
            containerView.addSubview(self.winnerPaidLable)
        
            self.creditstitleLable=UILabel()
            self.creditstitleLable.text="Credits"
            self.creditstitleLable.textColor=UIColor.blackColor()
            self.creditstitleLable.font=UIFont(name: "AmericanTypewriter", size:14 )
            self.creditstitleLable.sizeToFit()
            self.creditstitleLable.center=CGPoint(x: containerView.frame.width*kSixth, y: containerView.frame.height*kThird*2)
            //self.creditstitleLable.textAlignment=NSTextAlignment.Center
            //self.creditstitleLable.backgroundColor=UIColor.darkGrayColor()
            containerView.addSubview(self.creditstitleLable)
        
            self.bettitleLable=UILabel()
            self.bettitleLable.text="Bet"
            self.bettitleLable.textColor=UIColor.blackColor()
            self.bettitleLable.font=UIFont(name: "AmericanTypewriter", size: 14)
            self.bettitleLable.sizeToFit()
            self.bettitleLable.center=CGPoint(x: containerView.frame.width*kSixth*3, y: containerView.frame.height*kThird*2)
            containerView.addSubview(self.bettitleLable)
        
            self.winnerPaidtitleLable=UILabel()
            self.winnerPaidtitleLable.text="Winner Paid"
            self.winnerPaidtitleLable.textColor=UIColor.blackColor()
            self.winnerPaidtitleLable.font=UIFont(name: "AmericanTypewriter", size: 14)
            self.winnerPaidtitleLable.sizeToFit()
            self.winnerPaidtitleLable.center=CGPoint(x: containerView.frame.width*kSixth*5, y: containerView.frame.height*kThird*2)
            containerView.addSubview(self.winnerPaidtitleLable)
    }
    
    func setupfourth(containerView:UIView){
            self.resetButton=UIButton()
            self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
            self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.resetButton.titleLabel?.font=UIFont(name: "Superclarendon-Bold", size: 12)
            self.resetButton.backgroundColor=UIColor.darkGrayColor()
            self.resetButton.sizeToFit()
            self.resetButton.center=CGPoint(x: containerView.frame.width*kEighth, y: containerView.frame.height*kHalf)
            self.resetButton.addTarget(self, action:"ResetButtonPressed:" , forControlEvents:UIControlEvents.TouchUpInside)
            containerView.addSubview(self.resetButton)
        
            self.betOneButton=UIButton()
            self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
            self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.betOneButton.titleLabel?.font=UIFont(name: "Superclarendon-Bold", size: 12)
            self.betOneButton.backgroundColor=UIColor.greenColor()
            self.betOneButton.sizeToFit()
            self.betOneButton.center=CGPoint(x: containerView.frame.width*kEighth*3, y: containerView.frame.height*kHalf)
            self.betOneButton.addTarget(self, action: "BetOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.betOneButton)
        
            self.betMaxButton=UIButton()
            self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
            self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.betMaxButton.titleLabel?.font=UIFont(name: "Superclarendon-Bold", size: 12)
            self.betMaxButton.backgroundColor=UIColor.redColor()
            self.betMaxButton.sizeToFit()
            self.betMaxButton.center=CGPoint(x: containerView.frame.width*kEighth*5, y: containerView.frame.height*kHalf)
            self.betMaxButton.addTarget(self, action: "BetMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.betMaxButton)
        
            self.spinButton=UIButton()
            self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
            self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.spinButton.titleLabel?.font=UIFont(name: "Superclarendon-Bold", size: 12)
            self.spinButton.sizeToFit()
            self.spinButton.backgroundColor=UIColor.yellowColor()
            self.spinButton.center=CGPoint(x: containerView.frame.width*kEighth*7, y: containerView.frame.height*kHalf)
            self.spinButton.addTarget(self, action: "SpinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.spinButton)
    }

    func removeSlotImageViews(){
        
        //清除上一次图片缓存？
        
        if self.secondContainer != nil{
            let container:UIView?=self.secondContainer
            let subViews:Array=container!.subviews
            for view in subViews{
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset(){
            removeSlotImageViews()
            slots.removeAll(keepCapacity: true)
            self.setupscondContainer(self.secondContainer)
            credits=50
            currentbet=0
            winnings=0
        
            updateMainView()
    }
    
    func updateMainView(){
            self.creditsLable.text="\(credits)"
            self.betLable.text="\(currentbet)"
            self.winnerPaidLable.text="\(winnings)"
    }
    
    
    func showAlertWithText(header:String="Warning",message:String){
            var alert=UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}

