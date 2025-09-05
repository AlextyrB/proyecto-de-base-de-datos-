package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.layout.BorderPane;
import javafx.scene.control.Alert;
import java.io.IOException;

public class PrincipalController {

    @FXML
    private BorderPane idPrincipal;

    private void cargarVista(String rutaFXML) {
        try {
            System.out.println("Cargando: " + rutaFXML); // Debug
            Contenido contenido = new Contenido(rutaFXML);
            idPrincipal.setCenter(contenido);
        } catch (IOException e) {
            mostrarError("Error al cargar vista",
                    "No se pudo cargar: " + rutaFXML + "\n" + e.getMessage());
            e.printStackTrace();
        }
    }

    @FXML
    void accionBarco(ActionEvent event) {
        cargarVista("/xml/Barco.fxml"); // Nota: Case-sensitive!
    }

    @FXML
    void accionMuelle(ActionEvent event) {
        cargarVista("/xml/Muelle.fxml");
    }

    @FXML
    void accionPatron(ActionEvent event) {
        cargarVista("/xml/Patron.fxml");
    }

    @FXML
    void accionSocio(ActionEvent event) {
        cargarVista("/xml/Socio.fxml");
    }

    @FXML
    void accionViaje(ActionEvent event) {
        cargarVista("/xml/Buscar.fxml");
    }

    @FXML
    void accionBarcoCompleto(ActionEvent event) {
        cargarVista("/xml/BarcoCompleto.fxml");
    }


    private void mostrarError(String titulo, String mensaje) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(titulo);
        alert.setHeaderText(null);
        alert.setContentText(mensaje);
        alert.showAndWait();
    }
}