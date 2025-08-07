package examples.testBCP.helpers;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;

public class CsvReader {
    private Path csvPath;

    public CsvReader(String csvFilePath) {
        this.csvPath = Paths.get(csvFilePath);
    }

    /**
     * Lee la primera fila de datos del CSV y devuelve un Map campo-> valor.
     * NO borra la línea leída.
     */
    public Map<String, String> pollRowAsMap() throws IOException {
        List<String> lines = Files.readAllLines(csvPath, StandardCharsets.UTF_8);

        if (lines.size() <= 1) {
            return null; // No hay datos
        }

        String headerLine = lines.get(0);
        String[] headers = headerLine.split(",");

        String dataLine = lines.get(1);
        String[] values = dataLine.split(",");

        Map<String, String> result = new LinkedHashMap<>();
        for (int i = 0; i < headers.length && i < values.length; i++) {
            result.put(headers[i].trim(), values[i].trim());
        }

        return result;
    }

    /**
     * Lee el CSV indicado y devuelve un Map<String, Object> con los valores convertidos
     * según el esquema JSON asociado.
     * @param csvFileName nombre del archivo CSV, por ejemplo "dataAV2.csv"
     */
    public static Map<String, Object> pollRowTyped(String csvFileName) throws IOException {
        // Extraer baseName sin extensión .csv
        String baseName = csvFileName.toLowerCase().endsWith(".csv")
                ? csvFileName.substring(0, csvFileName.length() - 4)
                : csvFileName;

        // Cargar esquema JSON
        Map<String, String> karateSchema = loadTypeSchema(baseName);
        Map<String, String> typeSchema = parseKarateSchema(karateSchema);

        // Leer CSV
        String csvPath = "src/test/java/examples/testBCP/data/csv/" + csvFileName;
        CsvReader reader = new CsvReader(csvPath);
        Map<String, String> rawRow = reader.pollRowAsMap();
        if (rawRow == null) return null;

        Map<String, Object> typedRow = new LinkedHashMap<>();

        for (Map.Entry<String, String> entry : rawRow.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            String type = typeSchema.getOrDefault(key, "string");

            Object typedValue;
            try {
                typedValue = switch (type) {
                    case "number" -> {
                        try {
                            // Si tiene decimales → Double
                            if (value.contains(".")) {
                                yield Double.parseDouble(value);
                            }
                            // Si no tiene decimales → intentar Long directamente
                            yield Long.parseLong(value);
                        } catch (NumberFormatException ex) {
                            // Si falla (por ejemplo, número muy grande o con ceros a la izquierda), dejar como String
                            yield value;
                        }
                    }
                    default -> value;
                };
            } catch (Exception e) {
                throw new RuntimeException("Error al convertir campo '" + key + "' con valor '" + value + "' a tipo '" + type + "'", e);
            }

            typedRow.put(key, typedValue);

        }

        return typedRow;
    }

    /**
     * Carga el esquema JSON desde la ruta correcta, usando baseName sin extensión.
     */
    private static Map<String, String> loadTypeSchema(String baseName) throws IOException {
        String schemaPath = "src/test/java/examples/testBCP/data/jsonData/schemas/" + baseName + ".json";
        String json = Files.readString(Paths.get(schemaPath), StandardCharsets.UTF_8);
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(json, new TypeReference<Map<String, String>>() {});
    }

    /**
     * Extrae el tipo real del esquema Karate.
     * Por ejemplo, "#number? ... " => "number", "#string? ... " => "string"
     */
    private static Map<String, String> parseKarateSchema(Map<String, String> karateSchema) {
        Map<String, String> result = new HashMap<>();
        for (Map.Entry<String, String> entry : karateSchema.entrySet()) {
            String key = entry.getKey();
            String rawType = entry.getValue();
            String cleanType = "string"; // default

            if (rawType != null) {
                if (rawType.toLowerCase().contains("number")) cleanType = "number";
                else if (rawType.toLowerCase().contains("boolean")) cleanType = "boolean";
                else cleanType = "string";
            }
            result.put(key, cleanType);
        }
        return result;
    }

    public static void main(String[] args) throws IOException {
        Map<String, Object> datos = CsvReader.pollRowTyped("dataCT2.csv");

        for (Map.Entry<String, Object> entry : datos.entrySet()) {
            System.out.println(entry.getKey() + " = " + entry.getValue() + " (tipo: " + entry.getValue().getClass().getSimpleName() + ")");
        }
    }
}
