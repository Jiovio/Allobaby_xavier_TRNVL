import 'package:get/get.dart';

final Map<String, dynamic> crydata = {
  "Hunger Cry": {
    "heading": "Hunger Crying".tr,
    "shortdesc": "Rhythmic, repetitive cries that grow louder if the baby isn't fed. Often accompanied by hand-sucking and rooting behavior.".tr,
    "img": "assets/babyicons/hc.png",
    "audio": "Baby/hungry.wav",
    "description": [
      {"bold": true, "text": "Hunger cries are rhythmic, repetitive, and grow louder if the baby isn't fed.".tr},
      {"bold": true, "text": "Babies may also:".tr},
      {"bold": false, "text": "• Suck on hands or fingers".tr},
      {"bold": false, "text": "• Smack lips, root (turn head searching for a nipple)".tr},
      {"bold": false, "text": "• Get fussy even after being comforted".tr}
    ],
    "recommendations": [
      "Feed Promptly – Responding early prevents excessive crying and makes feeding easier.".tr,
      "Watch for Hunger Cues – Crying is a late sign; look for early signs like lip-smacking, rooting, sticking out tongue, or sucking on hands.".tr,
      "Ensure Proper Latch – If breastfeeding, ensure a deep latch to avoid discomfort.".tr,
      "Check Feeding Schedule – Newborns need feeding every 2-3 hours.".tr,
      "Burp Baby After Feeding – Helps prevent gas and fussiness.".tr
    ]
  },
  "Sleepy Cry": {
    "heading": "Sleepy Crying".tr,
    "shortdesc": "A whiny, nasal cry that sounds weaker than a hunger cry, often accompanied by yawning and eye-rubbing.".tr,
    "img": "assets/babyicons/sc.png",
    "audio": "Baby/sleepy.wav",
    "description": [
      {"bold": true, "text": "A whiny, nasal cry that may sound weaker than a hunger cry.".tr},
      {"bold": true, "text": "Babies may also:".tr},
      {"bold": false, "text": "• Yawn frequently".tr},
      {"bold": false, "text": "• Rub their eyes or pull their ears".tr},
      {"bold": false, "text": "• Become fussy and harder to soothe".tr}
    ],
    "recommendations": [
      "Look for Sleep Cues Early – Yawning, zoning out, or rubbing eyes signal it's time to sleep.".tr,
      "Create a Calm Sleep Environment – Dim lights, reduce noise, and use white noise if needed.".tr,
      "Use Gentle Rocking – Motion, swaddling, or a pacifier can help.".tr,
      "Follow a Sleep Routine – A consistent bedtime routine helps babies recognize sleep time.".tr,
      "Avoid Overstimulation – Too much activity before bed can make sleep harder.".tr
    ]
  },
  "Pain Cry": {
    "heading": "Pain Crying".tr,
    "shortdesc": "A sudden, high-pitched, intense cry that comes in bursts with breathing pauses. Often accompanied by physical tension.".tr,
    "img": "assets/babyicons/pc.png",
    "audio": "Baby/pain.wav",
    "description": [
      {"bold": true, "text": "A sudden, high-pitched, intense cry that may come in bursts with pauses for breath.".tr},
      {"bold": true, "text": "Babies may also:".tr},
      {"bold": false, "text": "• Clench fists or arch their back".tr},
      {"bold": false, "text": "• Become stiff or tense".tr},
      {"bold": false, "text": "• Show signs of discomfort (scrunched face, difficulty calming down)".tr}
    ],
    "recommendations": [
      "Check for Obvious Issues – Look for diaper rash, teething pain, or tight clothing.".tr,
      "Soothe with Gentle Touch – Skin-to-skin contact or holding them close can help.".tr,
      "Try Pain Relief Techniques – For teething, offer a chilled teether; for gas, try tummy massage.".tr,
      "Monitor for Fever or Illness – If crying persists with fever, vomiting, or lethargy, consult a doctor.".tr,
      "Trust Your Instincts – If the baby seems in severe pain, seek medical advice immediately.".tr
    ]
  },
  "Discomfort Cry": {
    "heading": "Discomfort Crying".tr,
    "shortdesc": "A fussy, irritated cry that typically stops when the source of discomfort is addressed.".tr,
    "img": "assets/babyicons/dc.png",
     "audio": "Baby/discomfort.wav",
    "description": [
      {"bold": true, "text": "A fussy, irritated cry that may stop when the issue is resolved.".tr},
      {"bold": true, "text": "Babies may also:".tr},
      {"bold": false, "text": "• Wiggle or squirm a lot".tr},
      {"bold": false, "text": "• Tug at their clothing or ears".tr},
      {"bold": false, "text": "• Appear restless or uneasy".tr}
    ],
    "recommendations": [
      "Check the Diaper – A wet or soiled diaper is a common cause of discomfort.".tr,
      "Ensure Comfortable Clothing – Dress baby in breathable, soft fabrics and check for tight clothing.".tr,
      "Adjust Temperature – Feel baby's neck/back to see if they are too hot or cold.".tr,
      "Check for External Irritants – Tags, rough fabric, or hair wrapped around fingers/toes can cause irritation.".tr,
      "Reposition Baby – Changing positions or holding them differently can sometimes help.".tr
    ]
  },
  "Colic Cry": {
    "heading": "Colic Crying".tr,
    "shortdesc": "Prolonged, intense crying episodes, typically in the evening, with physical signs of distress.".tr,
    "img": "assets/babyicons/cc.png",
    "audio": "Baby/discomfort.wav",
    "description": [
      {"bold": true, "text": "A prolonged, intense, high-pitched cry that often occurs in the evening.".tr},
      {"bold": true, "text": "Babies may also:".tr},
      {"bold": false, "text": "• Clench fists, arch their back, or pull up legs".tr},
      {"bold": false, "text": "• Have a tense, bloated belly".tr},
      {"bold": false, "text": "• Be difficult to soothe, even after feeding".tr}
    ],
    "recommendations": [
      "Use Gentle Motions – Rocking, swaying, or holding baby in a 'colic carry' (on their tummy along your forearm) can help.".tr,
      "Try White Noise – Rhythmic sounds, like a fan or heartbeat sound, can be soothing.".tr,
      "Burp Baby Well – Gas buildup can make colic worse. Burp frequently during feeds.".tr,
      "Massage the Tummy – A gentle circular tummy massage can relieve gas.".tr,
      "Consult a Pediatrician – If colic persists, discuss options like probiotic drops or diet changes (for breastfeeding moms).".tr
    ]
  },
  "Attention Cry": {
    "heading": "Attention Crying".tr,
    "shortdesc": "A mild cry that starts softly and increases if ignored, often accompanied by eye contact and reaching out.".tr,
    "img": "assets/babyicons/ac.png",
    "audio": "Baby/discomfort.wav",
    "description": [
      {"bold": true, "text": "A mild, whimpering cry that starts softly and gets louder if ignored.".tr},
      {"bold": true, "text": "Babies may also:".tr},
      {"bold": false, "text": "• Make eye contact while crying".tr},
      {"bold": false, "text": "• Reach out for comfort".tr},
      {"bold": false, "text": "• Stop crying quickly when picked up".tr}
    ],
    "recommendations": [
      "Respond with Reassurance – Holding, talking, or making eye contact helps babies feel secure.".tr,
      "Try Gentle Touch – A cuddle or soft pat on the back can be calming.".tr,
      "Engage with Soothing Sounds – Humming or talking in a calm voice can reassure the baby.".tr,
      "Encourage Independent Comforting – Allow baby to self-soothe briefly before immediately responding.".tr,
      "Maintain a Balance – Meeting attention needs is important, but consistency in response helps babies learn security.".tr
    ]
  }
};