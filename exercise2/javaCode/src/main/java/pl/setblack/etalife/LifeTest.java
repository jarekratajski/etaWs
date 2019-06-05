package pl.setblack.etalife;

import java.awt.*;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Scanner;
import pl.setblack.life.LifeJ;
import eta.runtime.Runtime;

public class LifeTest {

    public static void main(String[] args) throws Exception {
        Runtime.setClearThunks(true);
        int logicalWidth = 160;
        int logicalHeight = 160;
        java.io.BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        //WritableImage image = new WritableImage(logicalWidth,logicalHeight);


        while (true) {
            int statePointer = initPlane(logicalWidth, logicalHeight);
            System.out.println("ptr:" + statePointer);
            for (int i = 0; i < 10; i++) {

                int prevState = statePointer;
                statePointer = LifeJ.newState(statePointer);
                LifeJ.freeState(prevState);
            }
            LifeJ.freeState(statePointer);
            System.out.println("enter, ct" + Runtime.shouldClearThunks());
            in.readLine();
        }
        //LifeJ.freeState(statePointer);

    }


    private static int initPlane(int logicalWidth, int logicalHeight) {
        int state = LifeJ.initEmpty(logicalWidth-1, logicalHeight-1);
        for (int i=0 ; i < logicalWidth/2; i++) {
            int prevstate = state;
            state = LifeJ.setCell(state, i+logicalWidth/4, logicalHeight/2, Color.WHITE);
            LifeJ.freeState(prevstate);
        }
        //LifeJ.fillImage(state, image.getPixelWriter());
        return state;
    }
}
