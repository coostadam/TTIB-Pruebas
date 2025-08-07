package examples.testBCP.helpers.Generador;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class GeneradorDeCSV {
    static Random random = new Random();

    private static AV2Message ultimoAV2;
    private static AV3Message ultimoAV3;
    private static CT2Message ultimoCT2;
    private static CT3Message ultimoCT3;

    public static void generarAV(Map<String, Object> av2Map) {
        AV2Message av2 = AV2Message.fromMap(av2Map);
        AV3Message av3 = new AV3Message(av2);

        ultimoAV2 = av2;
        ultimoAV3 = av3;

        guardarEnCSV("src/test/java/examples/testBCP/data/csv/dataAV2.csv", AV2Message.returnCSVHeaders(), List.of(av2));
        guardarEnCSV("src/test/java/examples/testBCP/data/csv/dataAV3.csv", AV3Message.returnCSVHeaders(), List.of(av3));
    }

    public static void generarCT2yCT3() {
        if (ultimoAV2 == null || ultimoAV3 == null) {
            throw new IllegalStateException("Debe generarse AV2 y AV3 antes de CT2 y CT3");
        }

        CT2Message ct2 = new CT2Message(ultimoAV2, ultimoAV3);
        CT3Message ct3 = new CT3Message(ultimoAV2, ultimoAV3, ct2);

        ultimoCT2 = ct2;
        ultimoCT3 = ct3;

        guardarEnCSV("src/test/java/examples/testBCP/data/csv/dataCT2.csv", CT2Message.returnCSVHeaders(), List.of(ct2));
        guardarEnCSV("src/test/java/examples/testBCP/data/csv/dataCT3.csv", CT3Message.returnCSVHeaders(), List.of(ct3));
    }

    public static void generarCT5() {
        if (ultimoAV2 == null || ultimoAV3 == null || ultimoCT2 == null || ultimoCT3 == null) {
            throw new IllegalStateException("Debe generarse AV2, AV3, CT2 y CT3 antes de CT5");
        }

        CT5Message ct5 = new CT5Message(ultimoAV2, ultimoAV3, ultimoCT2, ultimoCT3);

        guardarEnCSV("src/test/java/examples/testBCP/data/csv/dataCT5.csv", CT5Message.returnCSVHeaders(), List.of(ct5));
    }

    private static void guardarEnCSV(String nombreArchivo, String header, List<?> mensajes) {
        try (FileWriter writer = new FileWriter(nombreArchivo, StandardCharsets.UTF_8)) {
            writer.write(header + "\n");
            for (Object msg : mensajes) {
                if (msg instanceof AV2Message) writer.write(((AV2Message) msg).toCSV() + "\n");
                else if (msg instanceof AV3Message) writer.write(((AV3Message) msg).toCSV() + "\n");
                else if (msg instanceof CT2Message) writer.write(((CT2Message) msg).toCSV() + "\n");
                else if (msg instanceof CT3Message) writer.write(((CT3Message) msg).toCSV() + "\n");
                else if (msg instanceof CT5Message) writer.write(((CT5Message) msg).toCSV() + "\n");
            }
        } catch (IOException e) {
            System.err.println("Error al escribir el archivo " + nombreArchivo + ": " + e.getMessage());
        }
    }
}