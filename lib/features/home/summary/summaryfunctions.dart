


import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Controller/MainController.dart';

Future<String> generateHomePageSummary(String typeOfPregnancy, String lmpDate , String edDate, String deliveryDate, String averageCycleLength, int daysPassed,
Maincontroller cont
) async {
  
  print("generate summary started");

  if(typeOfPregnancy=="skip")
  {
    return "No Summary Available";
  }


  String prompt = "";


  switch(typeOfPregnancy){
    case "Iam trying to conceive":
    int avglen = int.tryParse(averageCycleLength) ?? 30;
    int cday = DateTime.parse(lmpDate).difference(DateTime.now()).inDays;
    int days = cday % avglen;
    

      prompt = "health tips for women on their ${daysPassed}th day of ${avglen}th day period cycle window .give short summary of 3 line";
    break;

    case "Iam pregnant":
    prompt = """women with ${daysPassed}th day of pregnancy - ${daysPassed/7}th week with the health 
    status of ${cont.healthStatus} . summarize this with heath tips . give short summary 3 lines""";
    break;


    case "I have a baby":
    prompt="iam a women with baby aged ${daysPassed /30} month . summarize this with heath tips for the baby, give short summary 3 lines";
    break;
  }

  print(prompt);
  

  final res = await OurFirebase.getTextResonse(prompt);

  return res ?? "No Summary Available";

}

