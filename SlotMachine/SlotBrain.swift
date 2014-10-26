//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by ob_club on 14/10/26.
//  Copyright (c) 2014年 wangweiclub. All rights reserved.
//

import Foundation

class SlotBrain{
    //遍历整个数组，先把每个数组进行分组，然后遍历每个数组
    class func unpackSlotsIntoSlotrows(slots:[[Slot]])->[[Slot]]{
        
        //var slotRows: [[Slot]] = [] 和下方相同
        var slotrow:[Slot]=[]
        var slotrow2:[Slot]=[]
        var slotrow3:[Slot]=[]
        
        for slotarray in slots{
            for var index=0;index<slotarray.count;++index{
                let slot=slotarray[index]
                if index==0{
                    slotrow.append(slot)
                }
                else if index==1{
                    slotrow2.append(slot)
                }
                else if index==2{
                    slotrow3.append(slot)
                }
                else {
                    println("Error")
                }
            }
        }
        var slotINrows:[[Slot]]=[slotrow,slotrow2,slotrow3]
        return slotINrows
    }
    
    
    
    
}