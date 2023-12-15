//Library: use Sketch / Import Library / Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
Minim minim; //creates object to access all functions
int numberOfSongs = 8; //Number of Files in Folder, OS to count
int numberOfSoundEffects = 4; //Number of Files in Folder, OS to count
AudioPlayer[] song = new AudioPlayer[ numberOfSongs ]; //creates "Play List" variable holding extensions WAV, AIFF, AU, SND, and MP3
AudioPlayer[] soundEffect = new AudioPlayer[ numberOfSoundEffects ]; //Playlist for Sound Effects
AudioMetaData[] songMetaData = new AudioMetaData[ numberOfSongs ]; //Stores everything from PlayList Properties TAB (.mp3)
PFont generalFont;
color purple = #C71DDB;
int appWidth,appHeight;
float backgroundImage1, backgroundImage2, backgroundImageHeight, backgroundImageWidth;
PImage pictureImage;
//String 
//
void setup() { //
  size( 800, 600) ;
  background(0);
  //Display Algorithm
  minim = new Minim(this); //load from data directory, loadFile should also load from project folder, like loadImage
  String Yaosobi = "YaosobiOshinoko.mp3";
  String extension = ".mp3";
  String pathway = "FreeWareMusic/MusicDownload/"; //Relative Path
  String path = sketchPath( pathway + Yaosobi ); //Absolute Path
  // See: https://poanchen.github.io/blog/2016/11/15/how-to-add-background-music-in-processing-3.0
  println(path);
  println(pathway);
  song[0] = minim.loadFile( path );
  songMetaData1 = song[0].getMetaData();
  generalFont = createFont ("FrenchScriptM", 55); //Must also Tools / Create Font / Find Font / Do Not Press "OK"
  
  //Meta Data Println Testing
  //For Prototyping, pritn all information to the console first
  //Verifying Meta Data, 18 println's
  //println("?"songMetaData.?());
  println( "File Name: ", songMetaData1.fileName() ); //Data Correct, Verified in Console
  //Must use pure Java at OS Level to list fileName before loading Playlist
  println( "Song Length (in milliseconds): ", songMetaData1.length() );
  println( "Song Length (in seconds): ", songMetaData1.length()/1000 );
  println( "Song Length (in minutes & seconds): ", (songMetaData1.length()/1000)/60, " minute", (songMetaData1.length()/1000)-((songMetaData1.length()/1000)/60 * 60), " seconds" );
  println( "Song Title: ", songMetaData1.title() );
  println( "Author: ", songMetaData1.author() ); //Song Writer or Performer
  println( "Composer: ", songMetaData1.composer() ); //Song Writer
  println( "Orchestra: ", songMetaData1.orchestra() );
  println( "Album: ", songMetaData1.album() );
  println( "Disk: ", songMetaData1.disc() );
  println( "Publisher: ", songMetaData1.publisher() );
  println( "Date Release: ", songMetaData1.date() );
  println( "Copyright: ", songMetaData1.copyright() );
  println( "Comment: ", songMetaData1.comment() );
  println( "Lyrics: ", songMetaData1.lyrics() );
  println( "Track: ", songMetaData1.track() );
  println( "Genre: ", songMetaData1.genre() );
  println( "Encoded: ", songMetaData1.encoded() ); //how a computer reads the file
  //
  //population
  backgroundImage1 = appWidth*1;
  backgroundImage1 = appHeight*1;
  backgroundImageWidth = appWidth;
  backgroundImageHeight = appHeight;
  String imagesPath = "../music_Program/ImagesUsed";
  String Image = "YoasobiOshiNoKo";
  //
  
} //End setup
//
void draw() {
  if ( song[0].isLooping() && song[0].loopCount()!=-1 ) println("There are", song[0].loopCount(), "loops left.");
  if ( song[0].isLooping() && song[0].loopCount()==-1 ) println("Looping Infinitely");
  if ( song[0].isPlaying() && !song[0].isLooping() ) println("Play Once");
 //
  //Debugging Fast Forward and Fast Rewind
  //println( "Song Position", song[0].position(), "Song Length", song[0].length() );
  //
  // songMetaData1.title()
  rect(width*1/4, height*0, width*1/2, height*3/10); //mistake
  fill(purple); //Ink
  textAlign (CENTER, CENTER); //Align X&Y, see Processing.org / Reference
  //Values: [LEFT | CENTER | RIGHT] & [TOP | CENTER | BOTTOM | BASELINE]
  int size = 10; //Change this font size
  textFont(generalFont, 30); //Change the number until it fits, largest font size
  text(songMetaData1.title(), width*1/4, height*0, width*1/2, height*3/10);
  fill(255); //Reset to white for rest of the program
} //End draw
void keyPressed() {
  if (key == 'P' || key == 'p') song[0].play () ; //Parameter is milli-seconds from start of audio file to start playing ( illustrate with examples)
  //
  //
  if (key >= '1' || key <= '9' ) { //Loop Button, previous (key == '1' || key == '9')
  //Note: "9" is asumed to be massive! "Stimulate Infinite"
    String keystr = String.valueOf(key);
    println (keystr ) ;
    int loopNum = int(keystr); //Java, strongly formatted need casting
    song[0].loop(loopNum) ; //Parameter is number of repeats
    //
    }
    if(key == 'L' || key == 'l') song[0].loop(); //Infinite Loop, no parameter OR -1
    //
    if( key == 'M' || key =='m'); { //MUTE Button
     //MUTE Behaviour: stops electricty to speakers, does not stop file
    //NOTE: MUTE has NO built-in PAUSE button, NO built-in   REWIND button
    //ERROR: if song near end of file, user will not know song is at the end
    //Known ERROR: once song plays, MUTE acts like it doesn't work
      if ( song[0].isMuted() ) {
      //ERROR: song might not be playing
      //CATCH: ask .isPlaying() or !.isPlaying()
      song[0].unmute();
    } else {
      //Possible ERROR: Might rewind the song
      song[0].mute();
    }
    } 
}//End MUTE
  //
  //Possible ERROR: FF rewinds to parameter milliseconds from SONG Start
  //Possible ERROR: FR rewinds to parameter milliseconds from SONG Start
  //How does this get to be a true ff and fr button
  //Actual .skip() allows for varaible ff & fr using .position()+-
    if ( key=='F' || key=='f' ) song[0].skip( 0 ); //SKIP forward 1 second (1000 milliseconds)
  if ( key=='R' || key=='r' ) song[0].skip( 1000 ); //SKIP  backawrds 1 second, notice negative, (-1000 milliseconds)
  //
  //Simple STOP Behaviour: ask if .playing() & .pause() & .rewind(), or .rewind()
  if ( key=='S' | key=='s' ) {
    if ( song[0].isPlaying() ) {
      song[0].pause(); //auto .rewind()
    } else {
      song[0].rewind(); //Not Necessary
    }
  }
  //
  //Simple Pause Behaviour: .pause() & hold .position(), then PLAY
  if ( key=='Y' | key=='y' ) {
    if ( song[0].isPlaying()==true ) {
      song[0].pause(); //auto .rewind()
    } else {
      song[0].play(); //ERROR, doesn't play
    }
  }
} //End keyPressed
//
void mousePressed()  {
} //End mousePressed
//
//End MAIN Program
