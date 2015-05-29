//
//  PostViewController.swift
//  Snapper
//
//  Created by John Rees on 4/20/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//

import UIKit

import Parse
import Photos
class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    var photo = UIImage()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptoin: UITextField!
    let captureSession = AVCaptureSession()
    let locationManager = CLLocationManager()
    var currLocation : CLLocationCoordinate2D?
    var cities = []
    var postID = ""
    var postal = PFObject(className: "Post")
    
    @IBOutlet weak var OverViewLabel: UILabel!
    @IBOutlet weak var overViewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        OverViewLabel.hidden = true
        overViewView.hidden = true
        descriptoin.delegate = self
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func post(sender: AnyObject) {
        let post = PFObject(className:"Post")
        
        if(imageView.image != nil){
            if(descriptoin != nil){
        
        let imageData = imageView.image
        
        post.setObject(PFFile(data: UIImagePNGRepresentation(photo)), forKey: "Photo")
        post.setObject(descriptoin.text, forKey: "Description")
        post.setObject(NSDate(), forKey: "PostDate")
        if currLocation != nil{
        post["PostLocation"] = PFGeoPoint(latitude: currLocation!.latitude , longitude: currLocation!.longitude)
        }
        post.setObject(1, forKey: "Votes")
        var commentArray : [NSObject] = []
        post.setObject(commentArray, forKey: "Comments")
       println(locationManager.location)
        //post.saveInBackground()
        post.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
               // self.postID = post.objectId
                println(self.postID)
                
                
                self.postal = post
                self.segueToPost()
            }
        }
        }
        }else{
            let alertController = UIAlertController(title: "Please Take Picture", message:
                "Please add a picture if you would like to post", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
      
       
    }
    func segueToPost(){
        self.performSegueWithIdentifier("Segue12", sender: nil)
        
    }
    
    @IBAction func getPhoto(sender: AnyObject) {
        var picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        
        picker.allowsEditing = true
               // var photoPicker = UIImagePickerController()
        //photoPicker.delegate = self
        //photoPicker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: nil)
      
    }
       func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image2: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image2 as UIImage
        photo = image2
        imageView.image = image2 as UIImage
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
        
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationManager.stopUpdatingLocation()
        if(locations.count > 0){
            let location = locations[0] as! CLLocation
            println(location.coordinate)
            currLocation = location.coordinate
        } else {
            //alert("Cannot fetch your location")
        }
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue12"{
            var largeVc = segue.destinationViewController as! LargeViewController;
            largeVc.posted = true
            largeVc.setUp(postal)
          //  largeVc.objId = self.postID
           // largeVc.postObj = postal
        
        //Implement new method
        }
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        OverViewLabel.text = descriptoin.text
        overViewView.hidden = false
        OverViewLabel.hidden = false
        return false
    }
    }


    

 


