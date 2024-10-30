// VoiceModel.pde
import ddf.minim.*;
import processing.core.*;

class VoiceModel {
    PApplet parent;
    Minim minim;
    AudioInput mic;
    AudioRecorder sampleRecorder;
    boolean isRecording = false;

    VoiceModel(PApplet parent) {
        this.parent = parent;
        minim = new Minim(parent);
        mic = minim.getLineIn(Minim.MONO, 2048);
      
    }

    void startRecording() {

        isRecording = true;
        sampleRecorder = minim.createRecorder(mic, "recording.wav", true);
        sampleRecorder.beginRecord();
    }

    void stopRecording() {

        isRecording = false;
        sampleRecorder.endRecord();
        sampleRecorder.save();
    }

    float getVolume() {

        return mic.mix.level();
    }
}