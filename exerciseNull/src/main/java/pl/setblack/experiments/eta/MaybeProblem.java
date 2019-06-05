package pl.setblack.experiments.eta;

import eta.runtime.stg.Closure;
import my.HTest;

public class MaybeProblem {
    public static void main(String[] args) {
        System.out.println("ok");

        Closure obj = HTest.mkHTest(1);
        System.out.println(obj.getClass());
        System.out.println(obj);

        Closure obj2 = HTest.mkHTest(0);
        System.out.println(obj2);
    }
}
