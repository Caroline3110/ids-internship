public class DrawBox{
    public static String drawBox(int width, int height){
        String box = "";
        box+= "+";
        for ( int i =0; i<width;i++){
            box+="-";
        }
        box+="+\n";

        for(int i=0;i<height;i++){
            box+="|";
            for(int j=0;j<width;j++){
                box+=" ";
            }
        box+="|\n";
        }

        box+="+";
        for(int i=0;i<width;i++){
            box+="-";
        }
        box += "+";

        return box;
    }
    static void assertThat(String name, String actual, String expected) {
         System.out.println(name + ": " + (expected.trim().equals(actual.trim()) ? "PASS" : "FAIL: \n" + actual));
  }

    public static void main(String[] args) {
        System.out.println("==== NEW TEST RUN ====");

        assertThat("should draw a 2x2 box", drawBox(2, 2),
            """
            +--+
            |  |
            |  |
            +--+""");

            assertThat("should draw a 6x3 box", drawBox(6, 3),
            """
            +------+
            |      |
            |      |
            |      |
            +------+""");
        }

}