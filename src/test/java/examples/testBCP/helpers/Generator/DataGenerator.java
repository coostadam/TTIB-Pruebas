package examples.testBCP.helpers.Generator;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class DataGenerator {
    static Random random = new Random();

    private static AV2Message lastAV2;
    private static AV3Message lastAV3;
    private static CT2Message lastCT2;
    private static CT3Message lastCT3;

    public static void generateAV(Map<String, Object> av2Map) {
        AV2Message av2 = AV2Message.fromMap(av2Map);
        AV3Message av3 = new AV3Message(av2);

        lastAV2 = av2;
        lastAV3 = av3;

        save("src/test/java/examples/testBCP/data/csv/dataAV2.csv", AV2Message.returnCSVHeaders(), List.of(av2));
        save("src/test/java/examples/testBCP/data/csv/dataAV3.csv", AV3Message.returnCSVHeaders(), List.of(av3));
    }

    public static void generateCT2yCT3() {
        if (lastAV2 == null || lastAV3 == null) {
            throw new IllegalStateException("AV2 and AV3 must be generated before CT2 and CT3");
        }

        CT2Message ct2 = new CT2Message(lastAV2, lastAV3);
        CT3Message ct3 = new CT3Message(lastAV2, lastAV3, ct2);

        lastCT2 = ct2;
        lastCT3 = ct3;

        save("src/test/java/examples/testBCP/data/csv/dataCT2.csv", CT2Message.returnCSVHeaders(), List.of(ct2));
        save("src/test/java/examples/testBCP/data/csv/dataCT3.csv", CT3Message.returnCSVHeaders(), List.of(ct3));
    }

    public static void generateCT5() {
        if (lastAV2 == null || lastAV3 == null || lastCT2 == null || lastCT3 == null) {
            throw new IllegalStateException("AV2, AV3, CT2 and CT3 must be generated before CT5");
        }

        CT5Message ct5 = new CT5Message(lastAV2, lastAV3, lastCT2, lastCT3);

        save("src/test/java/examples/testBCP/data/csv/dataCT5.csv", CT5Message.returnCSVHeaders(), List.of(ct5));
    }

    private static void save(String filename, String header, List<?> messages) {
        try (FileWriter writer = new FileWriter(filename, StandardCharsets.UTF_8)) {
            writer.write(header + "\n");
            for (Object msg : messages) {
                if (msg instanceof AV2Message) writer.write(((AV2Message) msg).toCSV() + "\n");
                else if (msg instanceof AV3Message) writer.write(((AV3Message) msg).toCSV() + "\n");
                else if (msg instanceof CT2Message) writer.write(((CT2Message) msg).toCSV() + "\n");
                else if (msg instanceof CT3Message) writer.write(((CT3Message) msg).toCSV() + "\n");
                else if (msg instanceof CT5Message) writer.write(((CT5Message) msg).toCSV() + "\n");
            }
        } catch (IOException e) {
            System.err.println("Error writing file " + filename + ": " + e.getMessage());
        }
    }
}