import 'package:just_audio/just_audio.dart';

void getAudio(url) async {
  try {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setUrl('https:$url');
    audioPlayer.play();
    print('http:$url');
  } catch (e) {
    print(e);
  }
}
