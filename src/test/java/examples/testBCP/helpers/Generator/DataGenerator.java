package examples.testBCP.helpers.Generator;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

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

        saveJson("dataAV2.json", av2.toMap());
        saveJson("dataAV3.json", av3.toMap());
    }

    public static void generateCT2yCT3() {
        if (lastAV2 == null || lastAV3 == null) {
            throw new IllegalStateException("AV2 and AV3 must be generated before CT2 and CT3");
        }

        CT2Message ct2 = new CT2Message(lastAV2, lastAV3);
        CT3Message ct3 = new CT3Message(lastAV2, lastAV3, ct2);

        lastCT2 = ct2;
        lastCT3 = ct3;

        saveJson("dataCT2.json", ct2.toMap());
        saveJson("dataCT3.json", ct3.toMap());
    }

    public static void generateCT5() {
        if (lastAV2 == null || lastAV3 == null || lastCT2 == null || lastCT3 == null) {
            throw new IllegalStateException("AV2, AV3, CT2 and CT3 must be generated before CT5");
        }

        CT5Message ct5 = new CT5Message(lastAV2, lastAV3, lastCT2, lastCT3);

        saveJson("dataCT5.json", ct5.toMap());
    }

    public static void saveJson(String filename, Map<String, Object> data) {
        ObjectMapper mapper = new ObjectMapper();
        Path path = Paths.get("src/test/java/examples/testBCP/data/jsonData/examples/" + filename);

        try {
            Files.createDirectories(path.getParent()); // Asegura que exista el directorio
            mapper.writerWithDefaultPrettyPrinter().writeValue(path.toFile(), data);
        } catch (IOException e) {
            System.err.println("Error writing JSON to file " + filename + ": " + e.getMessage());
        }
    }
}