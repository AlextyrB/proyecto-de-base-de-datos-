package controller;

import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.util.Callback;
import modelo.BarcoCompleta;
import mysql.Conexion;
import de.jensd.fx.glyphs.fontawesome.FontAwesomeIcon;
import de.jensd.fx.glyphs.fontawesome.FontAwesomeIconView;

import java.net.URL;
import java.util.ResourceBundle;

public class BarcoCompletoController implements Initializable {

    @FXML
    private TableColumn<BarcoCompleta, Double> mensualidad;

    @FXML
    private TableColumn<BarcoCompleta, String> muelle;

    @FXML
    private TableColumn<BarcoCompleta, String> nombreCompletoSocio;

    @FXML
    private TableColumn<BarcoCompleta, String> telefonoSocio;

    @FXML
    private TableColumn<BarcoCompleta, String> correoSocio;

    @FXML
    private TableColumn<BarcoCompleta, Integer> amarre;

    @FXML
    private TableColumn<BarcoCompleta, String> nMatricula;

    @FXML
    private TableColumn<BarcoCompleta, String> nombreBarco;

    @FXML
    private TableView<BarcoCompleta> tblTablaBarco;

    private Conexion conexion;
    private ObservableList<BarcoCompleta> listaBarcos;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        conexion = new Conexion();
        configurarColumnas();
        cargarDatos();
    }

    private void configurarColumnas() {
        nMatricula.setCellValueFactory(new PropertyValueFactory<>("nMatricula"));
        nombreBarco.setCellValueFactory(new PropertyValueFactory<>("nombreBarco"));
        mensualidad.setCellValueFactory(new PropertyValueFactory<>("mensualidad"));
        nombreCompletoSocio.setCellValueFactory(new PropertyValueFactory<>("nombreCompletoSocio"));
        telefonoSocio.setCellValueFactory(new PropertyValueFactory<>("telefonoSocio"));
        correoSocio.setCellValueFactory(new PropertyValueFactory<>("correoSocio"));
        muelle.setCellValueFactory(new PropertyValueFactory<>("muelle"));
        amarre.setCellValueFactory(new PropertyValueFactory<>("amarre"));

        mensualidad.setCellFactory(tc -> new TableCell<BarcoCompleta, Double>() {
            @Override
            protected void updateItem(Double item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null) {
                    setText(null);
                } else {
                    setText(String.format("$%.2f", item));
                }
            }
        });

        telefonoSocio.setCellFactory(tc -> new TableCell<BarcoCompleta, String>() {
            @Override
            protected void updateItem(String item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null || item.trim().isEmpty()) {
                    setText("N/A");
                } else {
                    setText(item);
                }
            }
        });

        correoSocio.setCellFactory(tc -> new TableCell<BarcoCompleta, String>() {
            @Override
            protected void updateItem(String item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null || item.trim().isEmpty()) {
                    setText("N/A");
                } else {
                    setText(item);
                }
            }
        });
    }

    private void cargarDatos() {
        try {
            listaBarcos = conexion.barcosCompleta();
            tblTablaBarco.setItems(listaBarcos);

            if (listaBarcos.isEmpty()) {
                mostrarAlerta(Alert.AlertType.INFORMATION, "Sin datos",
                        "No se encontraron barcos registrados en la base de datos.");
            } else {
                System.out.println("Se cargaron " + listaBarcos.size() + " barcos en la tabla.");
            }
        } catch (Exception e) {
            mostrarAlerta(Alert.AlertType.ERROR, "Error al cargar datos",
                    "Error al cargar los barcos: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @FXML
    void nuevoBarco(MouseEvent event) {
        System.out.println("Agregar nuevo barco");
        mostrarAlerta(Alert.AlertType.INFORMATION, "Nuevo Barco",
                "Funcionalidad de nuevo barco pendiente de implementar");
    }

    @FXML
    void refrescar(MouseEvent event) {
        cargarDatos();
        mostrarAlerta(Alert.AlertType.INFORMATION, "Actualización",
                "La tabla ha sido actualizada con " + listaBarcos.size() + " registros.");
    }

    private void mostrarAlerta(Alert.AlertType tipo, String titulo, String mensaje) {
        Alert alerta = new Alert(tipo);
        alerta.setTitle(titulo);
        alerta.setHeaderText(null);
        alerta.setContentText(mensaje);
        alerta.showAndWait();
    }
}