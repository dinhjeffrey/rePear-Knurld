/* Copyright Sara D. */


import Foundation
import Chatto
import ChattoAdditions

/*
extension Array {
func randomItem() -> Element {
let index = Int(arc4random_uniform(UInt32(self.count)))
return self[index]
}
}
*/
func createTextMessageModel(uid: String, text: String, isIncoming: Bool) -> TextMessageModel {
    let messageModel = createMessageModel(uid, isIncoming: isIncoming, type: TextMessageModel.chatItemType)
    let textMessageModel = TextMessageModel(messageModel: messageModel, text: text)
    return textMessageModel
}

func createMessageModel(uid: String, isIncoming: Bool, type: String) -> MessageModel {
    let senderId = isIncoming ? "1" : "2"
    
    let messageModel = MessageModel(uid: uid, senderId: senderId, type: type, isIncoming: isIncoming, date: NSDate(), status: MessageStatus.Success)
    return messageModel
}


class WarningMessageFactory {
    static var messageindex = 0
    
    static let demoTexts = [
        "Hi! I see that you would like to know more about the warning signs of relapsing. Whether it is yourself or a loved one you're concerned about, these warning signs are important to watch out for 😯 (Say anything to continue)", //0
        "Do you want to learn about the signs? (Yes or No)", //1
        //Yes
            "Great! 😁", //2
            //Internal
            "There are seven internal signs you should be aware of! (Say 'Stop' when you wish me to discontinue, 'More' for more info, or 'OK' to continue", //3
            "You start slipping back into old habits", //4
                "Ambivalence to change associates, daily activities, or environments often accompanies the person as they seek treatment for substance abuse, but, avoiding “triggers” or cues that remind you of using or places undue amounts of stress in your life are crucial factors that influence cravings and promote substance abuse behaviors. You may think that you can handle the situations through sheer determination, but, letting down your guard and slipping back into old habits is recipe for relapse.", //5
            "You are plagued with delusional thinking", //6
                "Delusional thinking is a common warning sign of relapse when you become complacent in remembering the consequences of your substance abuse and the power that substance had over you before. Even when drugs are unavailable for long periods or when users are successful in curbing their drug use for extended periods, individuals remain vulnerable to events that precipitate relapse.", //7
            "You have too much time on your hands", //8
                "Our minds are capable of processing thousands of thoughts per minute we may not be aware of. Drug activities can also become hard-wired in your brain and the more time you have on your hands, the easier it is to allow the reminders of past drug experiences, effects, and cravings to creep in. According to the NIDA,” Addiction changes the brain in fundamental ways, disturbing a person’s normal hierarchy of needs and desires and substituting new priorities connected with procuring and using the drug. The resulting compulsive behaviors that weaken the ability to control impulses, despite the negative consequences, are similar to hallmarks of other mental illnesses.”", //9
            "You become isolated from your close ones", //10
                "Isolation is a warning sign of relapse that often leads to depression increasing the relapse risks. Combined with having too much time alone and lack of encouragement from a positive support system, this is a dangerous path to be on. According to SAMHSA, “In 2012, adults aged 18 or older who used illicit drugs in the past year had higher rates of serious thoughts, plans, and attempts of suicide compared with all adults in the general population (i.e., including users and nonusers of illicit drugs in the past year).", //11
            "You start to disregard you health", //12
                "Disregarding hygiene, physical, emotional, or mental health are common warnings signs of relapse that reflect a sense of disassociation from things that can really harm you. Recovery involves improving your health and not tearing it down. The more you let slide, the less able you will be to ward off the temptations of relapse when they occur.", //13
            "You romanticize your days of substance abuse", //14
                "It’s difficult to undergo the changes you need to make in order to remain abstinent and there may come a time when you think the treatment was ineffective or that life seemed easier when you had a substance to rely on. Although you know that there’s still work that needs to be done, a common warning sign of relapse is romanticizing those days of substance abuse and selectively disregarding the consequences of it.", //15
            "You start feeling discontented inside", //16
                "Internal feelings of discontent are not always bad as long as they motivate you toward achieving positive and healthy goals, but, letting them take over your emotions, thoughts, and behaviors in a negative way is a sure sign of impending relapse. Moodiness, anger, frustration, anxiety, and depression are significant signs that more healing needs to occur can easily point you in the directions of relapse or the abuse of other substances to be able to “get a grip on things.”", //17
        //No
        "Do you want to know what you can do when you see those signs? (Yes or No)", //18
        
            "Distract yourself. When you think about using, do something to occupy yourself. Call a friend. Go to a meeting. Get up and go for a walk. If you just sit there with your urge and don't do anything, you're giving your mental relapse room to grow. (Remember to say 'OK' to continue and 'Stop' to stop)", //19
            "Make relaxation part of your recovery. Relaxation is an important part of relapse prevention, because when you're tense you tend to do what’s familiar and wrong, instead of what's new and right. When you're tense you tend to repeat the same mistakes you made before. When you're relaxed you are more open to change.", //19
            "Tell someone that you're having urges to use. Call a friend, a support, or someone in recovery. Share with them what you're going through. The magic of sharing is that the minute you start to talk about what you're thinking and feeling, your urges begin to disappear. They don't seem quite as big and you don't feel as alone.", //20
        //Didn't understand: Repeat
        "Sorry, I didn't understand that 😔 Could you please pick a word to respond with?", //21
        //Bye bye
        "Thanks for talking to me today! Do what you love to stay healthy and stay happy 🍐" //22
        
    ]
    
    
    class func createChatItem(uid: String) -> MessageModelProtocol {
        //let isIncoming: Bool = arc4random_uniform(100) % 2 == 0
        return self.createChatItem("3-\(index)", isIncoming: true)
    }
    
    class func createChatItem(uid: String, isIncoming: Bool) -> MessageModelProtocol {
        return self.createTextMessageModel("3-\(index)", isIncoming: isIncoming)
    }
    
    
    class func createTextMessageModel(uid: String, isIncoming: Bool) -> TextMessageModel {
        //let incomingText: String = isIncoming ? "incoming" : "outgoing"
        let text = self.demoTexts[messageindex]
        return rePear.createTextMessageModel("3-\(index)", text: text, isIncoming: isIncoming)
    }
    
    
    
}

extension TextMessageModel {
    static var chatItemType: ChatItemType {
        return "text"
    }
}


class ChatMessageFactory {
    static var messageindex = 0
    
    
    static let demoTexts = [
        "Hi! It's a beautiful day today ☀️ How are you feeling? (Positive or Negative)", //0
        //Default Something Else
        "Let all your feelings out! You can trust me for sure! 😀",//1
        //Positive
        "That's great! 👏🏻 How do you think you were able to improve? 😁", //2
        "Would you like to share that advice with others? (Yes or No)",//3
            //No
            "That's okay, keep staying healthy!",//4
            //Yes
            "Great! Keep it up and soon the world will become a better place 🌏",//5
        //Negative
        "I'm so sorry to hear that 😞 Why are you feeling like this? (Not sure or other reason)", //6
            //Not sure
            "Well I think it would be best to talk to your loved ones about this. Mental support is the best cure for these things ♥️", //7
            //Other reason
            "I see... from what you've told me, I think it would be most beneficial if you consulted somebody you trust about this.", //8
        //Anything else?
        "Is there anything else you would like me to know? (Yes or No)", //9
        //Nothing Else
        "Please take care of yourself! Think of the positive things that are in your life 😌. Remember: Stay healthy, stay happy 🍐", //10
        //Didn't understand: Repeat
        "Sorry, I didn't understand that 😔 Could you please pick a word to respond with?" //11
    ]
    
    
    class func createChatItem(uid: String) -> MessageModelProtocol {
        //let isIncoming: Bool = arc4random_uniform(100) % 2 == 0
        return self.createChatItem(uid, isIncoming: true)
    }
    
    class func createChatItem(uid: String, isIncoming: Bool) -> MessageModelProtocol {
        return self.createTextMessageModel(uid, isIncoming: isIncoming)
    }
    
    
    class func createTextMessageModel(uid: String, isIncoming: Bool) -> TextMessageModel {
        //let incomingText: String = isIncoming ? "incoming" : "outgoing"
        let text = self.demoTexts[messageindex]
        return rePear.createTextMessageModel("2-\(index)", text: text, isIncoming: isIncoming)
    }
}
class TriggerMessageFactory {
    static var messageindex = 0
    
    
    static var demoTexts = [
        "Hi! The best way to learn about your triggers is to first take a little quiz! OK?",//0
        "Would you be comfortable taking it? (Yes or No)", //1
        //No
        "Thanks for talking to me today! Have a great day: Stay healthy, stay happy 🍐", //2
        //Quiz
        "Do you want these responses recorded for your use at a later date? (Yes or No)", //3
            //Yes
            "When you want to see them just say 'I want to see my previous responses'", //4
            //No
            "That's ok!",//5
            "Cool 👍🏻 Let's begin (Say 'Stop' at any time to stop the quiz)", //6
            "What do you think was your the trigger?", //7
            "How were you feeling just before you felt like drinking or drugging?", //8
            "What were you telling yourself just before you started to drink or drug? (Look for additional, hidden thoughts.)", //9
            "What did you do?", //10
            "Which thoughts led to which addictive feelings and behaviors?", //11
            "What was the chain of thoughts, feelings, and actions?", //12
            "What could you have told yourself?", //13
            "What could you have done?", //14
            "What emotions could you have pushed yourself to feel?", //15
            "How do you feel now about what happened?", //16
        //Sharing pictures
        "Some triggers are caused by seeing a picture of hearing somebody's name. If this is applicable to you (and you are comfortable with it) would you like to share these things with me? (Yes or No)", //17
        //Yes
        "Thank you for going out of your comfort zone to do this! By discussing, you will be on your way to a definitive cure ☺️. Now, why do you think this might be a trigger?", //18
        "What types of feelings did you experience?", //19
        "What could you have done to prevent yourself from being overcome with these feelings?", //20
        //No
        "That's okay, there are always other times you can face your triggers", //21
        //Didn't understand: Repeat
        "Sorry, I didn't understand that 😔 Could you please pick a word to respond with?" //22

    ]
    
    
    class func createChatItem(uid: String) -> MessageModelProtocol {
        //let isIncoming: Bool = arc4random_uniform(100) % 2 == 0
        return self.createChatItem(uid, isIncoming: true)
    }
    
    class func createChatItem(uid: String, isIncoming: Bool) -> MessageModelProtocol {
        return self.createTextMessageModel(uid, isIncoming: isIncoming)
    }
    
    
    class func createTextMessageModel(uid: String, isIncoming: Bool) -> TextMessageModel {
        //let incomingText: String = isIncoming ? "incoming" : "outgoing"
        let text = self.demoTexts[messageindex]
        return rePear.createTextMessageModel("1-\(index)", text: text, isIncoming: isIncoming)
    }
}
class MotivationMessageFactory {
    static var messageindex = 0
    
    
    static let demoTexts = [
        "Hi! I see that you are in serious need of motivation 😇", //0
        "First let me just say that you have to take responsibility for making yourself happy 😜", //1
        "Now, would you like to know the keys 🔑 to a healthy life? (Yes or No)", //2
        //Yes
        "Great! Just FYI, you can say 'Why' for more information, 'OK' to continue, or 'Stop' to end my droning 😆", //3
        "First, you need to take healthy risks", //4
            "Emotionally healthy people choose to take risks and have a spirit of adventure in trying to do what they want to do, without being foolhardy.", //5
        "Accept yourself", //6
            "Healthy people choose to accept themselves unconditionally, rather than measure or rate themselves or try to prove themselves.", //7
        "Get high frustration tolerance", //8
            "Healthy people recognize that there are only two sorts of problems they are likely to encounter: those they can do something about and those they cannot. Once this discrimination has been made, the goal is to modify those obnoxious conditions we can change, and to accept (or lump) those we cannot change.", //9
        "Take responsibility for your feelings", //10
            "Rather than blaming others, the world, or fate for their distress, healthy individuals accept a good deal of responsibility for their own thoughts, feelings, and behavior.", //11
        "Have some self-interest", //12
            "Emotionally healthy people tend to put their own interests at least a little above the interests of others. They sacrifice themselves to some degree for those for whom they care, but not overwhelmingly or completely.", //13
        "Be socially interested", //14
            "Most people choose to live in social groups, and to do so most comfortably and happily, they would be wise to act morally, protect the rights of others, and aid in the survival of the society in which we live.", //15
        "Have a sense of self direction", //16
            "We would do well to cooperate with others, but it would be better for us to assume primary responsibility for our own lives rather than to demand or need most of our support or nurturance from others.", //17
        "Be tolerant", //18
            "It is helpful to allow humans (oneself and others) the right to be wrong. It is not appropriate to like obnoxious behavior, but it is not necessary to damn oneself or others for acting badly.", //19
        "Accept uncertainties", //20
            "We live in a fascinating world of probability and chance; absolute certainties probably do not exist. The healthy individual strives for a degree of order, but does not demand perfect certainty.", //21
        "Commit yourself", //22
            "Most people tend to be happier when vitally absorbed in something outside themselves. At least one strong creative interest and some important human involvement seem to provide structure for a happy daily existence.", //23
        //No & after listing
        "There are so many reasons to live a healthier life! Would you like to know about some activities you may enjoy? (Yes or No)", //24
        "Again, say 'More' for more info, 'OK' to continue, and 'Stop' to stop the flow of information!", //25
        "Exercises like Jogging, Nautilus, Walking, Aerobic Dancing, Stretching or Aerobic Exercises, Shadow Boxing, Skipping Rope, Yoga, or Weightlifting", //26
            "Not only do these things strengthen your body, but it has been scientifically proven that they make you mentally healthier too!",//27
        "Playing board games like Bridge, Checkers, Chess, or Go",//28
            "Hone your skills and become a champion! There are many apps out there you can even install on your phone to play",//29
        "Outdoor activities like Birdwatching, Gardening, Crabbing, Fishing, Canoeing, Sailing, Hunting, or Walking",//30
            "Get that Vitamin D; it doesn't matter what you do, just go outside for the fresh air!",//31
        "Reading Fiction, Novels, Plays, or Poems",//32
            "Get cozy in front of the fireplace and settle down with a relazing novel 😊", //33
        "Learning something new!",//34
            "Try learning to code 😉",//35
        //Didn't understand: Repeat
        "Sorry, I didn't understand that 😔 Could you please pick a word to respond with?", //36
        //Bye bye
        "Thanks for talking to me today! Do what you love to stay healthy and stay happy 🍐", //37
        
    ]
    
    
    class func createChatItem(uid: String) -> MessageModelProtocol {
        return self.createChatItem(uid, isIncoming: true)
    }
    
    class func createChatItem(uid: String, isIncoming: Bool) -> MessageModelProtocol {
        return self.createTextMessageModel(uid, isIncoming: isIncoming)
    }
    
    
    class func createTextMessageModel(uid: String, isIncoming: Bool) -> TextMessageModel {
        let text = self.demoTexts[messageindex]
        return rePear.createTextMessageModel("4-\(index)", text: text, isIncoming: isIncoming)
    }
}

