package examples.testBCP.helpers.Generator;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class JsonReader {
    public static Map<String, Object> readTypedJson(String jsonFileName) throws IOException {
        // Quitar extensión si la tiene
        String baseName = jsonFileName.toLowerCase().endsWith(".json")
                ? jsonFileName.substring(0, jsonFileName.length() - 5)
                : jsonFileName;

        // Leer archivo JSON original con datos
        String jsonPath = "src/test/java/examples/testBCP/data/jsonData/examples/" + jsonFileName;
        String rawJson = Files.readString(Paths.get(jsonPath), StandardCharsets.UTF_8);
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> rawMap = mapper.readValue(rawJson, new TypeReference<Map<String, String>>() {});

        // Leer esquema y parsearlo
        Map<String, String> karateSchema = loadTypeSchema(baseName);
        Map<String, String> typeSchema = parseKarateSchema(karateSchema);

        // Convertir valores al tipo indicado
        Map<String, Object> typedMap = new LinkedHashMap<>();

        for (Map.Entry<String, String> entry : rawMap.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            String type = typeSchema.getOrDefault(key, "string");

            Object typedValue;
            try {
                typedValue = switch (type) {
                    case "number" -> {
                        try {
                            if (value.contains(".")) {
                                yield Double.parseDouble(value);
                            }
                            yield Long.parseLong(value);
                        } catch (NumberFormatException ex) {
                            yield value;
                        }
                    }
                    default -> value;
                };
            } catch (Exception e) {
                throw new RuntimeException("Error parsing '" + key + "' to type '" + type + "'", e);
            }

            typedMap.put(key, typedValue);
        }

        return typedMap;
    }

    private static Map<String, String> loadTypeSchema(String baseName) throws IOException {
        String schemaPath = "src/test/java/examples/testBCP/data/jsonData/schemas/" + baseName + ".json";
        String json = Files.readString(Paths.get(schemaPath), StandardCharsets.UTF_8);
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(json, new TypeReference<Map<String, String>>() {});
    }

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
}
