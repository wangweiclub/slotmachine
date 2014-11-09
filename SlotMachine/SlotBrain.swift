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
        
        //先竖着遍历数组，遇到第一个竖行数组后，执行下面的语句，为第一个竖行中每3个横行加入slot
        //然后继续便利第二个竖行，依此类推
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
    
    class func computeWinnings(slots:[[Slot]])->Int{
        var slotINrows=unpackSlotsIntoSlotrows(slots)
        
        var winnings=0
        
        var flushWinCount=0
        var threeOfAKindWinCount=0
        var straightWinCount=0
        
        for slotRow in slotINrows{
            
            if checkFlush(slotRow)==true{
                println("flush")
                flushWinCount+=1
                winnings+=1
            }
            
//            if checkThreeInARow(slotRow)==true{
//                println("three in a row")
//                straightWinCount+=1
//                winnings+=1
//            }
            
            if checkAKind(slotRow)==true{
                println("three in a kind")
                threeOfAKindWinCount+=1
                winnings+=3
            }
        }
        
        if flushWinCount==3{
            println("rayol flush")
            winnings+=15
        }
        
//        if straightWinCount==3{
//            println("Epic win")
//            winnings+=1000
//        }
        
        if threeOfAKindWinCount==3{
            println("Threes all around")
            winnings+=50
        }
        
        return winnings
    }
    
    class func checkFlush(slotRow:[Slot])->Bool{
        let slot1=slotRow[0]
        let slot2=slotRow[1]
        let slot3=slotRow[2]
        
        if slot1.isRed==true && slot2.isRed==true && slot3.isRed==true{
        
            return true
        }
//        else if slot1.isRed==false && slot2.isRed==false && slot3.isRed==false{
//        
//            return true
//        }
        else{
            return false
        }
    }
    
    class func checkThreeInARow(slotRow:[Slot])->Bool{
        let slot1=slotRow[0]
        let slot2=slotRow[1]
        let slot3=slotRow[2]
        
        if slot1.value==slot2.value-1 && slot1.value==slot3.value-2{
            return true
        }
        else if slot1.value==slot2.value+1 && slot1.value==slot3.value+2{
            return true
        }
        else{
            return false
        }
    }
    
    class func checkAKind(slotRow:[Slot])->Bool{
        let slot1=slotRow[0]
        let slot2=slotRow[1]
        let slot3=slotRow[2]
        
        if slot1.value==slot2.value && slot1.value==slot3.value{
            return true
        }
        else {
            return false
        }
    }
    
}