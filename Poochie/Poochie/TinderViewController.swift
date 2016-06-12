//
//  ViewController.swift
//  EPDeckView
//


import UIKit
import EPDeckView

class TinderViewController: UIViewController, EPDeckViewDataSource, EPDeckViewDelegate {
    
    private var cardViews: [EPCardView] = []
    @IBOutlet weak var deckView: EPDeckView!
    var numberOfCards = 5;
    
    //  MARK: - INITIALIZATION
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true

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
        deckViewAnimationManager.cardRightFinishPoint = CGPointMake(self.deckView.frame.width * 1.5, self.deckView.frame.height / 3.0)
        
        //  The deckAnimationDuration represents the duration of the animation that the card being
        //  dragged needs to return to the deck or move out of the screen. It is also the animation
        //  duration that the rest of the cards in the deck animate.
        deckViewAnimationManager.deckAnimationDuration = 0.35
        
        //  The dckAnchor represents the anchor of the deck. It can take 4 values: TopLeft, TopRight,
        //  BottomRight or BottomLeft.
        deckViewAnimationManager.deckAnchor = .BottomLeft
        
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
    
    
    //  MARK: - BUTTON ACTIONS
    @IBAction func reloadCardsButtonTapped(sender: AnyObject) {
        self.cardViews = []
        self.deckView.reloadCards()
    }
    
    @IBAction func throwRightButtonTapped(sender: AnyObject) {
        self.deckView.moveTopCardToDirection(.Right)
    }
    
    @IBAction func throwLeftButtonTapped(sender: AnyObject) {
        self.deckView.moveTopCardToDirection(.Left)
    }
    
    @IBAction func previousCardButtonTapped(sender: AnyObject) {
        self.deckView.bringBackLastCardThrown()
    }
    
    
    //  MARK: - EPDECKVIEW DATASOURCE & DELEGATE
    func numberOfCardsInDeckView(deckView: EPDeckView) -> Int {
        return 5
    }
    
    func deckView(deckView: EPDeckView, cardViewAtIndex index: Int) -> EPCardView {
        //  Create a TestView to be added as a card in the deck.
        
        let testView: TestView = TestView(frame: CGRectMake(0,0,360,360))
        testView.center = self.deckView.center
        testView.layer.masksToBounds = false;
        testView.layer.shadowOffset = CGSizeMake(0, 0);
        testView.layer.shadowRadius = 25;
        testView.layer.shadowOpacity = 0.25;
        
        if index%5 == 0 {
            testView.profileImageView.image = UIImage(named: "darth_vader")
            testView.displayNameLabel.text = "Darth Vader"
        } else if index%5 == 1 {
            testView.profileImageView.image = UIImage(named: "cthulhu")
            testView.displayNameLabel.text = "Cthulhu"
        } else if index%5 == 2 {
            testView.profileImageView.image = UIImage(named: "cylon")
            testView.displayNameLabel.text = "Cylon"
        } else if index%5 == 3 {
            testView.profileImageView.image = UIImage(named: "weeping_angel")
            testView.displayNameLabel.text = "Weeping Angel"
        } else if index%5 == 4 {
            testView.profileImageView.image = UIImage(named: "terminator")
            testView.displayNameLabel.text = "Terminator"
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
        if(numberOfCards > 0){
            print("Card at index \(index) moved to \(direction.description()).")
            numberOfCards -= 1
        }else{
            loadCards()
        }
    }
    
    func deckView(deckView: EPDeckView, didTapLeftButtonAtIndex index: Int) {
        print("Left button of card at index: \(index) tapped.")
    }
    
    func deckView(deckView: EPDeckView, didTapRightButtonAtIndex index: Int) {
        print("Right button of card at index: \(index) tapped.")
    }
    func loadCards(){
        numberOfCards = 5
    }

}





















