package pl.setblack.life.jmh;

import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.infra.Blackhole;
import pl.setblack.life.LifeJ;
import java.awt.*;

public class SimpleTest {

    @Benchmark
    public void fewSteps() {
        int logicalWidth = 1600;
        int logicalHeight = 1600;


        //WritableImage image = new WritableImage(logicalWidth,logicalHeight);
        int statePointer = initPlane(logicalWidth, logicalHeight);
        for ( int i =0 ;i <10; i++ ) {
            int prevState = statePointer;
            statePointer = LifeJ.newState(statePointer);
            LifeJ.freeState(prevState);
        }
        LifeJ.freeState(statePointer);

    }


    private int initPlane(int logicalWidth, int logicalHeight) {
        int state = LifeJ.initEmpty(logicalWidth-1, logicalHeight-1);
        for (int i=0 ; i < logicalWidth/2; i++) {
            int prevState = state;
            state = LifeJ.setCell(state, i+logicalWidth/4, logicalHeight/2, Color.WHITE);
            LifeJ.freeState(state);
        }
        //LifeJ.fillImage(state, image.getPixelWriter());
        return state;
    }
}
