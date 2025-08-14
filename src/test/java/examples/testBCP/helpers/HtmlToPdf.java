package examples.testBCP.helpers;

import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;

public class HtmlToPdf {
    public static void main(String[] args) throws IOException {
        String inputHtmlPath = "target/cucumber-html-reports/overview-features.html"; // Ruta a tu reporte
        String outputPdfPath = "target/cucumber-html-reports/reporte.pdf";

        String htmlContent = Files.readString(new File(inputHtmlPath).toPath());

        htmlContent = htmlContent.replace("&nbsp;", "&#160;"); // &#160; es el código numérico

        try (FileOutputStream os = new FileOutputStream(outputPdfPath)) {
            PdfRendererBuilder builder = new PdfRendererBuilder();
            builder.useFastMode();
            builder.withHtmlContent(htmlContent, new File(inputHtmlPath).getParentFile().toURI().toString());
            builder.toStream(os);
            builder.run();
        }

        System.out.println("PDF generado en: " + outputPdfPath);
    }


}
