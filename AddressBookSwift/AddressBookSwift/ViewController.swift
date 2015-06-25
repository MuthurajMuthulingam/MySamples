//
//  ViewController.swift
//  AddressBookSwift
//
//  Created by Muthuraj M on 2/11/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    let contactList:NSMutableArray = NSMutableArray()
    var barButton:UIBarButtonItem!
    var duplicateBarButton:UIBarButtonItem!
    var addressBook:ABAddressBookRef!
    var selectedContacts:NSMutableArray!
    //var contactNameList:NSMutableArray!
    //var duplicateContacts:NSMutableArray!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.barButton = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Done, target: self, action: "barButtonClicked")
        self.barButton.enabled = false
        self.navigationItem.rightBarButtonItem = self.barButton
        
        self.duplicateBarButton = UIBarButtonItem(title: "Show Duplicate", style: UIBarButtonItemStyle.Plain, target: self, action: "showDuplicate")
        self.duplicateBarButton.enabled = true
        self.navigationItem.leftBarButtonItem = self.duplicateBarButton
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        self.selectedContacts = NSMutableArray()
        //self.contactNameList = NSMutableArray()
        //self.duplicateContacts = NSMutableArray()
        
        self.getAddressBookNames();
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.getContactNamesInBg()
    }
    
    func getAddressBookNames()
    {
        
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        if (authorizationStatus == ABAuthorizationStatus.NotDetermined)
            
        {
            
            NSLog("requesting access...")
            
            var emptyDictionary: CFDictionaryRef?
            
            var addressBook = !(ABAddressBookCreateWithOptions(emptyDictionary, nil) != nil)
            
            ABAddressBookRequestAccessWithCompletion(addressBook,{success, error in
                
                if success
                {
                    self.getContactNamesInBg()
                    
                    //self.getContactNames();
                    
                }
                    
                else {
                    
                    NSLog("unable to request access")
                    
                }
                
            })
            
        }
            
        else if (authorizationStatus == ABAuthorizationStatus.Denied || authorizationStatus == ABAuthorizationStatus.Restricted)
        {
            
            NSLog("access denied")
            
        }
            
        else if (authorizationStatus == ABAuthorizationStatus.Authorized)
        {
            
            NSLog("access granted")
            
            self.getContactNamesInBg()
            
        }
        
    }
    
    func barButtonClicked()
    {
        NSLog("barButton Itemclicked Called")
        
        self.deleteContactNamesInBg(self.selectedContacts)
    }
    
    func showDuplicate()
    {
        self.filterDuplicateContacts()
    }
    
    func filterDuplicateContacts()
    {
        self.getContactNames()
        
        var allContactNumbers:NSMutableArray = NSMutableArray()
        
        for record:ABRecordRef in self.contactList
        {
            let contactNumber:ABMultiValueRef = ABRecordCopyValue(record, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
            let allNumbers:NSArray = ABMultiValueCopyArrayOfAllValues(contactNumber).takeUnretainedValue() as NSArray
            
            NSLog("number \(allNumbers)")
            
            let homePhone:String = self.removeExtraCharectorsFromPhoneNumber(allNumbers.objectAtIndex(0) as String)
            
            NSLog("clean Phone number \(homePhone)")
            
            allContactNumbers.addObject(homePhone)
        }
        
        var duplicateContacts:NSArray =  self.findDuplicateEntries(allContactNumbers,fullContactList: self.contactList)
        
        if(duplicateContacts.count > 0)
        {
            self.contactList.removeAllObjects()
            self.contactList.addObjectsFromArray(duplicateContacts)
            self.tableView.reloadData()
        }
        else
        {
            var alert:UIAlertView = UIAlertView(title: "Message", message: "No Duplicate Contacts...", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        
//            for record:ABRecordRef in self.contactList
//            {
//                let contactNumber:ABMultiValueRef = ABRecordCopyValue(record, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
//                let allNumbers:NSArray = ABMultiValueCopyArrayOfAllValues(contactNumber).takeUnretainedValue() as NSArray
//                let homePhone:String = self.removeExtraCharectorsFromPhoneNumber(allNumbers.objectAtIndex(0) as String)
//                
//                
//                
//            }
        
        
       // NSLog("duplicate Numbers \(self.duplicateContacts)")
    }
    
    
    func findDuplicateEntries(phoneNumbers:NSArray,fullContactList:NSArray) -> NSArray
    {
        var duplicateContacts:NSMutableArray = NSMutableArray()
        
        var count:Int = phoneNumbers.count
        
        for var i:Int = 0; i<count;i++
        {
            if((i+1) < count)
            {
                if(phoneNumbers[i] as NSString == phoneNumbers[i+1] as NSString)
                {
                    duplicateContacts.addObject(fullContactList[i])
                    //duplicateContacts.addObject(fullContactList[i+1])
                }
            }
        }
        
        NSLog("duplicate Entries \(duplicateContacts)")
        
        return duplicateContacts
        
    }
    
    func charectorSetToBeRemovedFromPhoneNumber() -> NSCharacterSet
    {
        return NSCharacterSet(charactersInString: "-()")
    }
    
    func removeExtraCharectorsFromPhoneNumber(phoneNumber:String) -> String
    {
        var sepearetdNumber:NSArray = phoneNumber.componentsSeparatedByCharactersInSet(self.charectorSetToBeRemovedFromPhoneNumber())
        var cleanPhoneNumber:String = sepearetdNumber.componentsJoinedByString("")
        return cleanPhoneNumber
    }
    
    func deleteContacts(contactListToBeDeleted:NSMutableArray) -> Bool
    {
        var error: Unmanaged<CFErrorRef>? = nil
        for record:ABRecordRef in contactListToBeDeleted
        {
            var status:Bool = ABAddressBookRemoveRecord(self.addressBook, record, &error)
            
            if (status)
            {
                NSLog("success")
                
                contactListToBeDeleted.removeObject(record)
                if (self.contactList.containsObject(record))
                {
                    self.contactList.removeObject(record)
                }
                
                var contactName:String = ABRecordCopyCompositeName(record).takeRetainedValue() as String
                
//                if self.contactNameList.containsObject(contactName)
//                {
//                    self.contactNameList.removeObject(contactName)
//                }
                
                var st:Bool = ABAddressBookSave(self.addressBook, &error)
                if st
                {
                    NSLog("Saved")
                    return true
                }
            }
            else
            {
                NSLog("failed")
                break;
            }
        }
        
        return false
    }
    
    func getContactNames() -> Bool
        
    {
        var errorRef: Unmanaged<CFError>?
        
        self.addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
        
        self.contactList.removeAllObjects()
        self.contactList.addObjectsFromArray(ABAddressBookCopyArrayOfAllPeople(self.addressBook).takeRetainedValue());
        
       // println("number of contacts: \(self.contactList.count)")
        
        //self.contactNameList.removeAllObjects()
        
//        for record:ABRecordRef in self.contactList
//        {
//           var contactName:String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
//            
//            //self.contactNameList.addObject(contactName)
//            
//            //
//        }
        
        return true
        
    }
    
    // GCD Try
    
    func getContactNamesInBg()
    {
        
        var queue:dispatch_queue_t = dispatch_queue_create("myQueue", nil)
        
        dispatch_async(queue, { () -> Void in
            
            var status:Bool = self.getContactNames()
            
            if status
            {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        })
        
    }
    
    func deleteContactNamesInBg(contacts:NSArray)
    {
        
        var queue:dispatch_queue_t = dispatch_queue_create("myQueue2", nil)
        
        dispatch_async(queue, { () -> Void in
            
            var status:Bool = self.deleteContacts(contacts.mutableCopy() as NSMutableArray)
            
            if status
            {
                
               // self.getContactNamesInBg()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                   
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        
        if let ab = abRef {
            
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
            
        }
        
        return nil
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.contactList.count > 0)
        {
            return self.contactList.count;
        }
        else
        {
            return 0;
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cellIdentifier:String = "cellIdentifier"
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }
    
        let contact:ABRecordRef = self.contactList[indexPath.row] as ABRecordRef
        
        cell.textLabel?.text = ABRecordCopyCompositeName(contact).takeRetainedValue() as NSString
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if(cell.accessoryType == UITableViewCellAccessoryType.Checkmark)
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
            self.selectedContacts .removeObject(self.contactList.objectAtIndex(indexPath.row))
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            self.selectedContacts .addObject(self.contactList.objectAtIndex(indexPath.row))
            self.barButton.enabled = true
        }
        
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            //self.contactNameList.removeObjectAtIndex(indexPath.row)
            
            self.deleteContactNamesInBg(NSArray(arrayLiteral: self.contactList[indexPath.row]))
            
            //let indexPaths:NSArray = NSArray(object: indexPath)
            //self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Left)
            
            //self.addressBook.add
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

