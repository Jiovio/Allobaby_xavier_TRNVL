import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

List<String> yamlabelss = ['Speech', 'Child speech, kid speaking', 'Conversation', 'Narration, monologue', 'Babbling', 'Speech synthesizer', 'Shout', 'Bellow', 'Whoop', 'Yell', 'Children shouting', 'Screaming', 'Whispering', 'Laughter', 'Baby laughter', 'Giggle', 'Snicker', 'Belly laugh', 'Chuckle, chortle', 'Crying, sobbing', 'Baby cry, infant cry', 'Whimper', 'Wail, moan', 'Sigh', 'Singing', 'Choir', 'Yodeling', 'Chant', 'Mantra', 'Child singing', 'Synthetic singing', 'Rapping', 'Humming', 'Groan', 'Grunt', 'Whistling', 'Breathing', 'Wheeze', 'Snoring', 'Gasp', 'Pant', 'Snort', 'Cough', 'Throat clearing', 'Sneeze', 'Sniff', 'Run', 'Shuffle', 'Walk, footsteps', 'Chewing, mastication', 'Biting', 'Gargling', 'Stomach rumble', 'Burping, eructation', 'Hiccup', 'Fart', 'Hands', 'Finger snapping', 'Clapping', 'Heart sounds, heartbeat', 'Heart murmur', 'Cheering', 'Applause', 'Chatter', 'Crowd', 'Hubbub, speech noise, speech babble', 'Children playing', 'Animal', 'Domestic animals, pets', 'Dog', 'Bark', 'Yip', 'Howl', 'Bow-wow', 'Growling', 'Whimper (dog)', 'Cat', 'Purr', 'Meow', 'Hiss', 'Caterwaul', 'Livestock, farm animals, working animals', 'Horse', 'Clip-clop', 'Neigh, whinny', 'Cattle, bovinae', 'Moo', 'Cowbell', 'Pig', 'Oink', 'Goat', 'Bleat', 'Sheep', 'Fowl', 'Chicken, rooster', 'Cluck', 'Crowing, cock-a-doodle-doo', 'Turkey', 'Gobble', 'Duck', 'Quack', 'Goose', 'Honk', 'Wild animals', 'Roaring cats (lions, tigers)', 'Roar', 'Bird', 'Bird vocalization, bird call, bird song', 'Chirp, tweet', 'Squawk', 'Pigeon, dove', 'Coo', 'Crow', 'Caw', 'Owl', 'Hoot', 'Bird flight, flapping wings', 'Canidae, dogs, wolves', 'Rodents, rats, mice', 'Mouse', 'Patter', 'Insect', 'Cricket', 'Mosquito', 'Fly, housefly', 'Buzz', 'Bee, wasp, etc.', 'Frog', 'Croak', 'Snake', 'Rattle', 'Whale vocalization', 'Music', 'Musical instrument', 'Plucked string instrument', 'Guitar', 'Electric guitar', 'Bass guitar', 'Acoustic guitar', 'Steel guitar, slide guitar', 'Tapping (guitar technique)', 'Strum', 'Banjo', 'Sitar', 'Mandolin', 'Zither', 'Ukulele', 'Keyboard (musical)', 'Piano', 'Electric piano', 'Organ', 'Electronic organ', 'Hammond organ', 'Synthesizer', 'Sampler', 'Harpsichord', 'Percussion', 'Drum kit', 'Drum machine', 'Drum', 'Snare drum', 'Rimshot', 'Drum roll', 'Bass drum', 'Timpani', 'Tabla', 'Cymbal', 'Hi-hat', 'Wood block', 'Tambourine', 'Rattle (instrument)', 'Maraca', 'Gong', 'Tubular bells', 'Mallet percussion', 'Marimba, xylophone', 'Glockenspiel', 'Vibraphone', 'Steelpan', 'Orchestra', 'Brass instrument', 'French horn', 'Trumpet', 'Trombone', 'Bowed string instrument', 'String section', 'Violin, fiddle', 'Pizzicato', 'Cello', 'Double bass', 'Wind instrument, woodwind instrument', 'Flute', 'Saxophone', 'Clarinet', 'Harp', 'Bell', 'Church bell', 'Jingle bell', 'Bicycle bell', 'Tuning fork', 'Chime', 'Wind chime', 'Change ringing (campanology)', 'Harmonica', 'Accordion', 'Bagpipes', 'Didgeridoo', 'Shofar', 'Theremin', 'Singing bowl', 'Scratching (performance technique)', 'Pop music', 'Hip hop music', 'Beatboxing', 'Rock music', 'Heavy metal', 'Punk rock', 'Grunge', 'Progressive rock', 'Rock and roll', 'Psychedelic rock', 'Rhythm and blues', 'Soul music', 'Reggae', 'Country', 'Swing music', 'Bluegrass', 'Funk', 'Folk music', 'Middle Eastern music', 'Jazz', 'Disco', 'Classical music', 'Opera', 'Electronic music', 'House music', 'Techno', 'Dubstep', 'Drum and bass', 'Electronica', 'Electronic dance music', 'Ambient music', 'Trance music', 'Music of Latin America', 'Salsa music', 'Flamenco', 'Blues', 'Music for children', 'New-age music', 'Vocal music', 'A capella', 'Music of Africa', 'Afrobeat', 'Christian music', 'Gospel music', 'Music of Asia', 'Carnatic music', 'Music of Bollywood', 'Ska', 'Traditional music', 'Independent music', 'Song', 'Background music', 'Theme music', 'Jingle (music)', 'Soundtrack music', 'Lullaby', 'Video game music', 'Christmas music', 'Dance music', 'Wedding music', 'Happy music', 'Sad music', 'Tender music', 'Exciting music', 'Angry music', 'Scary music', 'Wind', 'Rustling leaves', 'Wind noise (microphone)', 'Thunderstorm', 'Thunder', 'Water', 'Rain', 'Raindrop', 'Rain on surface', 'Stream', 'Waterfall', 'Ocean', 'Waves, surf', 'Steam', 'Gurgling', 'Fire', 'Crackle', 'Vehicle', 'Boat, Water vehicle', 'Sailboat, sailing ship', 'Rowboat, canoe, kayak', 'Motorboat, speedboat', 'Ship', 'Motor vehicle (road)', 'Car', 'Vehicle horn, car horn, honking', 'Toot', 'Car alarm', 'Power windows, electric windows', 'Skidding', 'Tire squeal', 'Car passing by', 'Race car, auto racing', 'Truck', 'Air brake', 'Air horn, truck horn', 'Reversing beeps', 'Ice cream truck, ice cream van', 'Bus', 'Emergency vehicle', 'Police car (siren)', 'Ambulance (siren)', 'Fire engine, fire truck (siren)', 'Motorcycle', 'Traffic noise, roadway noise', 'Rail transport', 'Train', 'Train whistle', 'Train horn', 'Railroad car, train wagon', 'Train wheels squealing', 'Subway, metro, underground', 'Aircraft', 'Aircraft engine', 'Jet engine', 'Propeller, airscrew', 'Helicopter', 'Fixed-wing aircraft, airplane', 'Bicycle', 'Skateboard', 'Engine', 'Light engine (high frequency)', "Dental drill, dentist's drill", 'Lawn mower', 'Chainsaw', 'Medium engine (mid frequency)', 'Heavy engine (low frequency)', 'Engine knocking', 'Engine starting', 'Idling', 'Accelerating, revving, vroom', 'Door', 'Doorbell', 'Ding-dong', 'Sliding door', 'Slam', 'Knock', 'Tap', 'Squeak', 'Cupboard open or close', 'Drawer open or close', 'Dishes, pots, and pans', 'Cutlery, silverware', 'Chopping (food)', 'Frying (food)', 'Microwave oven', 'Blender', 'Water tap, faucet', 'Sink (filling or washing)', 'Bathtub (filling or washing)', 'Hair dryer', 'Toilet flush', 'Toothbrush', 'Electric toothbrush', 'Vacuum cleaner', 'Zipper (clothing)', 'Keys jangling', 'Coin (dropping)', 'Scissors', 'Electric shaver, electric razor', 'Shuffling cards', 'Typing', 'Typewriter', 'Computer keyboard', 'Writing', 'Alarm', 'Telephone', 'Telephone bell ringing', 'Ringtone', 'Telephone dialing, DTMF', 'Dial tone', 'Busy signal', 'Alarm clock', 'Siren', 'Civil defense siren', 'Buzzer', 'Smoke detector, smoke alarm', 'Fire alarm', 'Foghorn', 'Whistle', 'Steam whistle', 'Mechanisms', 'Ratchet, pawl', 'Clock', 'Tick', 'Tick-tock', 'Gears', 'Pulleys', 'Sewing machine', 'Mechanical fan', 'Air conditioning', 'Cash register', 'Printer', 'Camera', 'Single-lens reflex camera', 'Tools', 'Hammer', 'Jackhammer', 'Sawing', 'Filing (rasp)', 'Sanding', 'Power tool', 'Drill', 'Explosion', 'Gunshot, gunfire', 'Machine gun', 'Fusillade', 'Artillery fire', 'Cap gun', 'Fireworks', 'Firecracker', 'Burst, pop', 'Eruption', 'Boom', 'Wood', 'Chop', 'Splinter', 'Crack', 'Glass', 'Chink, clink', 'Shatter', 'Liquid', 'Splash, splatter', 'Slosh', 'Squish', 'Drip', 'Pour', 'Trickle, dribble', 'Gush', 'Fill (with liquid)', 'Spray', 'Pump (liquid)', 'Stir', 'Boiling', 'Sonar', 'Arrow', 'Whoosh, swoosh, swish', 'Thump, thud', 'Thunk', 'Electronic tuner', 'Effects unit', 'Chorus effect', 'Basketball bounce', 'Bang', 'Slap, smack', 'Whack, thwack', 'Smash, crash', 'Breaking', 'Bouncing', 'Whip', 'Flap', 'Scratch', 'Scrape', 'Rub', 'Roll', 'Crushing', 'Crumpling, crinkling', 'Tearing', 'Beep, bleep', 'Ping', 'Ding', 'Clang', 'Squeal', 'Creak', 'Rustle', 'Whir', 'Clatter', 'Sizzle', 'Clicking', 'Clickety-clack', 'Rumble', 'Plop', 'Jingle, tinkle', 'Hum', 'Zing', 'Boing', 'Crunch', 'Silence', 'Sine wave', 'Harmonic', 'Chirp tone', 'Sound effect', 'Pulse', 'Inside, small room', 'Inside, large room or hall', 'Inside, public space', 'Outside, urban or manmade', 'Outside, rural or natural', 'Reverberation', 'Echo', 'Noise', 'Environmental noise', 'Static', 'Mains hum', 'Distortion', 'Sidetone', 'Cacophony', 'White noise', 'Pink noise', 'Throbbing', 'Vibration', 'Television', 'Radio', 'Field recording'];

class AudioClassifier {
  late Interpreter _interpreter;
  late Interpreter classification_interpreter;

  late List<int> inputShape;
  late List<int> outputShape;
  
  Future<void> initializeModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/ml/yamnet93600.tflite');
      inputShape = _interpreter.getInputTensor(0).shape;
      outputShape = _interpreter.getOutputTensor(0).shape;
      
      print('Model loaded successfully');
      print('Input Tensor Shape: $inputShape');
      print('Output Tensor Shape: $outputShape');
      print('Input Tensor Type: ${_interpreter.getInputTensor(0).type}');
      print('Output Tensor Type: ${_interpreter.getOutputTensor(0).type}');

      classification_interpreter = await Interpreter.fromAsset("assets/ml/ml1.tflite");

      print("Classification Model Loaded Successfully");
    } catch (e) {
      print('Error loading model: $e');
      rethrow;
    }
  }

  Future<List<String>> processAudio(String audioPath, Function setPrediction) async {


    try {
      
      File audioFile = File(audioPath);
      final bytes = await audioFile.readAsBytes();
      // final bytes = await fetchAudio();

      final buffer = bytes.buffer;
      final byteData = ByteData.view(buffer);
      
   
      Float32List waveform = Float32List(93600);
      for (int i = 0; i < 93600 && i < byteData.lengthInBytes ~/ 2; i++) {
        waveform[i] = byteData.getInt16(i * 2, Endian.little) / 32768.0;
      }


      
      var inputArray = [waveform.toList()];
      
    
      var outputBuffer = Float32List(12 * 521).reshape([12,521]);

      _interpreter.run(inputArray, outputBuffer);

      




      


      List<String> outputs = [];

      for(List<double> d in outputBuffer){
          outputs.add(yamlabelss[_softmax(d)!]);
      }

      print(outputs);

      // print(sortByFrequency(outputs));


            print("------------------------------------------");
     String pred =  runClassification(audioPath)!;
     print(pred);
     setPrediction(pred,audioPath, sortByFrequency(outputs));
    print("------------------------------------------");


      
      return sortByFrequency(outputs);
    } catch (e) {
      print('Error during processing: $e');
      print('Stack trace: ${StackTrace.current}');
      rethrow;
    }
  }

  String? runClassification(String path){

    // const CATEGORIES = ["belly_pain", "burping", "discomfort", "hungry", "tired"];
    const CATEGORIES = ["1", "2", "3", "4", "5"];

    Map<String, String> cats = {
      "1" : "Pain Cry",
      "2" : "Burping Cry",
      "3" : "Discomfort Cry",
      "4" : "Hunger Cry",
      "5" : "Sleepy Cry"
    };



      final out = _interpreter.getOutputTensor(1);
      var chk = Float32List(12*1024).reshape([12,1024]);
      final fin = (out.copyTo(chk));

      final data = (calculateMean(fin as List<List<double>>));

      print(data);

      var outp = Float32List(5).reshape([1,5]);

      classification_interpreter.run(data,outp);
      final t = outp.toList();
      
      String key = (CATEGORIES[_softmax(t[0])!]);


      return cats[key];

  }


  void dispose() {
    _interpreter.close();
    classification_interpreter.close();
  }



Future<void> testModelWithFakeData(Interpreter interpreter) async {
  try {
    print('Step 1: Verifying interpreter');
    if (interpreter == null) {
      print('Interpreter is null!');
      return;
    }
    print('Interpreter is valid');

    print('\nStep 2: Getting tensor details');
    var inputTensor = interpreter.getInputTensor(0);
    var outputTensor = interpreter.getOutputTensor(0);
    print('Input tensor type: ${inputTensor.type}');
    print('Output tensor type: ${outputTensor.type}');

    print('\nStep 3: Creating input data');
    // Create a single Float32List for input
    var inputBuffer = Float32List(93600);
    inputBuffer.fillRange(0, 93600, 0.1);
    var inputs = [inputBuffer];  // Wrap in list but keep as Float32List
    print('Input data created with shape: [${inputs.length}, ${inputs[0].length}]');

    print('\nStep 4: Creating output buffer');
    // Create output buffer as a single Float32List
    var outputBuffer = Float32List(12 * 521).reshape([12,521]);  // Flattened buffer with correct length
    
    print('Output buffer created with length: ${outputBuffer.length}');
    
    // interpreter.runInference(inputs);
    print(interpreter.getOutputTensors()[1]);
    print('\nStep 5: Running inference');
    interpreter.run(inputs, outputBuffer);
    print('Inference completed successfully');

    print('\nStep 6: Verifying output');
    // Convert the flat buffer back to 2D for display

    print(yamlabelss[_softmax(outputBuffer[0])!]);


    

    // var outputAs2D = List.generate(
    //   12,
    //   (i) => outputBuffer.sublist(i * 521, (i + 1) * 521),
    //   growable: false
    // );
    // print('First few values of output: ${outputAs2D[0].take(5).toList()}');
    
  } catch (e, stackTrace) {
    print('Error during test!');
    print('Error type: ${e.runtimeType}');
    print('Error message: $e');
    print('Stack trace:\n$stackTrace');
  }
}


  int _softmax(List<double> logits) {
    double max = -1;

    int? mi;

    for(int i=0;i<logits.length;i++){

      if(logits[i] > max){
        mi = i;
        max = logits[i];
      }

    }
    return mi ?? 0;
  }

  List<String> sortByFrequency(List<String> input) {
  // Count occurrences
  Map<String, int> frequency = {};
  for (var item in input) {
    frequency[item] = (frequency[item] ?? 0) + 1;
  }

  // Sort by frequency (descending)
  List<String> sortedList = input.toSet().toList()
    ..sort((a, b) => frequency[b]!.compareTo(frequency[a]!));

  return sortedList;
}


List<double> calculateMean(List<List<double>> data) {
  int numRows = data.length;
  int numCols = data[0].length;
  
  // Initialize a list to hold the mean of each column
  List<double> meanAxis0 = List.filled(numCols, 0.0);
  
  // Sum values column-wise
  for (int col = 0; col < numCols; col++) {
    double sum = 0.0;
    for (int row = 0; row < numRows; row++) {
      sum += data[row][col];
    }
    meanAxis0[col] = sum / numRows;  // Calculate the mean for the current column
  }
  
  return meanAxis0;
}

Future<Uint8List> fetchAudio() async {

  final file = await rootBundle.load("assets/ml/tired.wav");

  final data = file.buffer.asUint8List();

  return data;


}


}





