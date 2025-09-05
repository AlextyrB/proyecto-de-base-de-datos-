package controller;

import javafx.fxml.FXMLLoader;
import javafx.scene.layout.Pane;
import java.io.IOException;
import java.net.URL;

public class Contenido extends Pane {
    public Contenido(String rutaFXML) throws IOException {
        URL fxmlUrl = getClass().getResource(rutaFXML);
        if (fxmlUrl == null) {
            throw new IOException("Archivo FXML no encontrado: " + rutaFXML +
                    "\nRuta absoluta: " + new java.io.File(".").getAbsolutePath());
        }

        FXMLLoader loader = new FXMLLoader(fxmlUrl);
        loader.setRoot(this);

        try {
            loader.load();
        } catch (IOException e) {
            throw new IOException("Error al cargar " + rutaFXML + ": " + e.getMessage(), e);
        }
    }
}