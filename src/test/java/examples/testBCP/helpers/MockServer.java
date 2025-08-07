package examples.testBCP.helpers;

import com.intuit.karate.netty.Main;

public class MockServer {
    public static void main(String[] args) {
        String[] karateArgs = {"classpath:examples/testBCP/mocks/mockServer.feature", "-p", "8080"};
        Main.main(karateArgs);
    }
}