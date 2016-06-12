//
//  ViewController.swift
//  EPDeckView
//


import UIKit
import EPDeckView
import MessageUI
class TinderViewController: UIViewController, EPDeckViewDataSource, EPDeckViewDelegate, MFMailComposeViewControllerDelegate {
    
    private var cardViews: [EPCardView] = []
    @IBOutlet weak var deckView: EPDeckView!
     var numberOfCards = 5;
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
     var finalData = [[""]]
    

    
    //  MARK: - INITIALIZATION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("START ANIMATING")
        self.activityIndicator.hidesWhenStopped = true;
        self.activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
        self.activityIndicator.startAnimating()
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 190/255, green: 144/255, blue: 212/255, alpha: 1)
        var url = NSURL(string: "https://quiet-lowlands-84063.herokuapp.com/?url=sss")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
            
            
            let urlError = false
            
            if error == nil {
                
               
                
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                
                var hacks = urlContent.componentsSeparatedByString("|")
                for i in hacks{
                    var arr = i.componentsSeparatedByString("-#-")
                    if arr.count > 6{
                        print(arr)
                        arr.removeFirst()
                        arr.removeLast()
                        arr.removeAtIndex(4)
                        print(arr)
                        self.finalData.append(arr) }
                    //0 is url
                    //1 is ids
                    //2 is money
                    //3 is title
                    //4 is location
                    
                }
                self.finalData.removeFirst()
                print(self.finalData)
                self.numberOfCards = 20
                
                
            }
            
            
            
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    print("error")
                    
                } else {
                    print("done with async")
                    
                    self.deckView.reloadCards()
                    
                    
                }}})
        
        task.resume()
        
        
        

        
        

        // Set the deckView's delegate & data source.
        self.deckView.delegate = self
        self.deckView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
               //  If you want to set custom values in the EPDeckViewAnimationManager then it should
        //  be set in the viewDidAppear func.
        let deckViewAnimationManager: EPDeckViewAnimationManager = EPDeckViewAnimationManager(frame: self.deckView.frame)
        
        //  The actionMargin is measured from the card's center x. Usually it can be set to a 
        //  bit less than half the deckView's width.
        deckViewAnimationManager.actionMargin = self.deckView.frame.size.width / 3.8
        
        //  The lower this rotationStrength gets, the faster the card rotates. This value is 
        //  also taken into account in the scaling of the card.
        deckViewAnimationManager.rotationStrength = 320.0
        
        //  This is the max angle allowed to the rotation while being dragged.
        deckViewAnimationManager.rotationMax = 360.0
        
        //  This is the angle that is reached when the distance of the card from the center equals
        //  the rotation strength. Therefore, with the above values, when the card is distanced
        //  100px from the center (1/3 of the rotation strength) of the deckView, the card will 
        //  have rotated 30 degrees (1/3 of the rotation angle).
        deckViewAnimationManager.rotationAngle = 30.0
        
        //  The smaller the scale strength, the quicker it scales down while the card is dragged, 
        //  till it reaches scaleMax.
        deckViewAnimationManager.scaleStrength = 4.0
        
        //  scaleMax should received values 0.0 ~> 1.0. It represents the max downscaling that 
        //  is allowed to be applied on the card while being dragged.
        deckViewAnimationManager.scaleMax = 0.9
        
        //  cardLeftFinishPoint & cardRightFinishPoint represent the points that the card will be 
        //  moved after being dragged, if it's left outside the actionMargin.
        deckViewAnimationManager.cardLeftFinishPoint = CGPointMake(-self.deckView.frame.width * 1.5, self.deckView.frame.height / 3.0)
        deckViewAnimationManager.cardRightFinishPoint = CGPointMake(self.deckView.frame.width * 2.5, self.deckView.frame.height / 3.0)
        
        //  The deckAnimationDuration represents the duration of the animation that the card being
        //  dragged needs to return to the deck or move out of the screen. It is also the animation
        //  duration that the rest of the cards in the deck animate.
        deckViewAnimationManager.deckAnimationDuration = 0.35
        
        //  The dckAnchor represents the anchor of the deck. It can take 4 values: TopLeft, TopRight,
        //  BottomRight or BottomLeft.
        deckViewAnimationManager.deckAnchor = .TopLeft
        
        //  deckMaxVisibleCards represents the max number of visible cards in the deck. I.e. if the
        //  deck has 52 cards but the deckMaxVisibleCards is set to 10, then card 11 to 50 will be
        //  transparent. It doesn't account for transparent cards.
        deckViewAnimationManager.deckMaxVisibleCards = 1
        
        //  deckCardAngleDelta sets the angle difference between the cards in the deck.
        deckViewAnimationManager.deckCardAngleDelta = 7.0
        
        //  deckViewCardScaleDelta sets the scale difference between the cards in the deck.
        deckViewAnimationManager.deckViewCardScaleDelta = 0.08
        
        //  deckCardAlphaDelta sets the alpha channel difference between the cards in the deck.
        deckViewAnimationManager.deckCardAlphaDelta = 0.05
        
        //  deckCardAlphaDelta sets the deck's center.
        deckViewAnimationManager.deckCenter = CGPointMake(self.deckView.center.x, self.deckView.center.y - 40.0)
        
        //  Not setting a custom EPDeckViewAnimationManager will set the default value of an
        //  EPDeckViewAnimationManager
        self.deckView.deckViewAnimationManager = deckViewAnimationManager
        
        self.deckView.reloadCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    
    
    //  MARK: - EPDECKVIEW DATASOURCE & DELEGATE
    func numberOfCardsInDeckView(deckView: EPDeckView) -> Int {
        return numberOfCards
    }
    
    func deckView(deckView: EPDeckView, cardViewAtIndex index: Int) -> EPCardView {
        //  Create a TestView to be added as a card in the deck.
        
        let testView: TestView = TestView(frame: CGRectMake(20,64,280,504))
        testView.center = self.deckView.center
        testView.layer.masksToBounds = false;
        testView.layer.shadowOffset = CGSizeMake(0, 1);
        testView.layer.shadowRadius = 25;
        testView.layer.shadowOpacity = 0.7;
        
        if finalData.count > 5 && finalData[index].count == 5{
            print(finalData)
            var data = finalData[index]
            print(data)
            var url = data[0]
            var ids = data[1]
            var money = data[2]
            var title = data[3]
            var location = data [4]
            
            
            testView.Location.text = location
            testView.displayNameLabel.text = title
            testView.Price.text = money
            
            var arrs = ids.componentsSeparatedByString(",")
            print(arrs)
            var finalId = arrs[0]
            finalId = String(finalId.characters.dropFirst())
            finalId = String(finalId.characters.dropFirst())
            print(finalId)
            var photoURL = "http://images.craigslist.org/\(finalId)_300x300.jpg"
            print(photoURL)
            
            testView.profileImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "\(photoURL)")!)!)
        }
        //  Keep a reference so you can pass the nib's buttons to the delegate functions.
        self.cardViews.append(testView)
        
        return testView
    }
    
    func deckView(deckView: EPDeckView, rightButtonForCardAtIndex index: Int) -> UIButton? {
        let rightButton: UIButton = (self.cardViews[index] as! TestView).checkButton
        return rightButton
    }
    
    func deckView(deckView: EPDeckView, leftButtonForCardAtIndex index: Int) -> UIButton? {
        let leftButton: UIButton = (self.cardViews[index] as! TestView).cancelButton
        return leftButton
    }
    
    func deckView(deckView: EPDeckView, cardAtIndex index: Int, movedToDirection direction: CardViewDirection) {
            numberOfCards--
            print("Card at index \(index) moved to \(direction.description()).")
            print("Array: \(finalData)")
        if(numberOfCards <= 0){
            self.deckView.reloadCards()
            numberOfCards = 5
        }

    }
    
    func deckView(deckView: EPDeckView, didTapLeftButtonAtIndex index: Int) {
        print("Left button of card at index: \(index) tapped.")
         self.deckView.moveTopCardToDirection(.Left)
    }
    
    func deckView(deckView: EPDeckView, didTapRightButtonAtIndex index: Int) {
        print("Right button of card at index: \(index) tapped.")
         self.deckView.moveTopCardToDirection(.Right)
    }
   
}
/*
 ata ppa par asn apt awt aba aba rbi pbi abp abo obk abf act aem amo acl acb asy psy ael agr azi pfu agm sfo aha ahv ahs ajw ama amp amc ams aph arv asg ati atl ata avg awa a
 */




















