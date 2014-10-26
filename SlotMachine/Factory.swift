//
//  Factory.swift
//  SlotMachine
//
//  Created by ob_club on 14/10/22.
//  Copyright (c) 2014年 wangweiclub. All rights reserved.
//

import Foundation
import UIKit

class Factary{
    class func creatSlots()->[[Slot]] {
        
        var kNumberOfSlots=3
        var kNumberOfContainers=3
        var slots:[[Slot]]=[]//声明空数组，然后才能加入数据
        
        //slots=[[slot1,slot2],[slot3],[slot4,slot5]]
        
        for var ContainerNumber=0;ContainerNumber<kNumberOfContainers;++ContainerNumber{
            
            var slotarray:[Slot]=[]//声明空数组然后才能加入数据
            for var SlotsNumber=0;SlotsNumber<kNumberOfSlots;++SlotsNumber{
                
                var slot=Factary.creatSlots(slotarray)
                slotarray.append(slot)//找了两个小时的bug！
            }
            slots.append(slotarray)
        }
        return slots
    }
    
    class func creatSlots(currentCards:[Slot])->Slot {
        var currentValue:[Int]=[]
        
        for slot in currentCards{
            currentValue.append(slot.value)
        }
        
        var randomNumber=Int(arc4random_uniform(UInt32(13)))
        while contains(currentValue, randomNumber+1){
             randomNumber=Int(arc4random_uniform(UInt32(13)))
        }//如果生成的随机数在currentValue中已经存在，则生成另外一个，直到把数组填满为止
       
        var slot:Slot
        switch randomNumber{
        case 0:
            slot=Slot(value: 1, image: UIImage(named: "1.jpg"), isRed: true)
        case 1:
            slot=Slot(value: 2, image: UIImage(named: "2.jpg"), isRed: true)
        case 2:
            slot=Slot(value: 3, image: UIImage(named: "3.jpg"), isRed: true)
        case 3:
            slot=Slot(value: 4, image: UIImage(named: "4.jpg"), isRed: true)
        case 4:
            slot=Slot(value: 5, image: UIImage(named: "5.jpg"), isRed: false)
        case 5:
            slot=Slot(value: 6, image: UIImage(named: "6.jpg"), isRed: false)
        case 6:
            slot=Slot(value: 7, image: UIImage(named: "7.jpg"), isRed: true)
        case 7:
            slot=Slot(value: 8, image: UIImage(named: "8.jpg"), isRed: false)
        case 8:
            slot=Slot(value: 9, image: UIImage(named: "9.jpg"), isRed: false)
        case 9:
            slot=Slot(value: 10, image: UIImage(named: "10.jpg"), isRed: true)
        case 10:
            slot=Slot(value: 11, image: UIImage(named: "11.jpg"), isRed: false)
        case 11:
            slot=Slot(value: 12, image: UIImage(named: "12.jpg"), isRed: false)
        case 12:
            slot=Slot(value: 13, image: UIImage(named: "13.jpg"), isRed: true)
        default:
            slot=Slot(value: 0, image: UIImage(named: "1.jpg"), isRed: true)
        }
        return slot
    }
    
    
    
    
    
    
    
    
}



