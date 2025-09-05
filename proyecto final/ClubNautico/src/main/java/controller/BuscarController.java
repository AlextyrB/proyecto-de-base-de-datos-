package controller;

import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import modelo.BuscarResultado;
import mysql.Conexion;

import java.net.URL;
import java.util.ResourceBundle;

public class BuscarController implements Initializable {

    @FXML
    private TableColumn<BuscarResultado, Double> Mensualidad;


    @FXML
    private TableColumn<BuscarResultado, String> nMatricula;

    @FXML
    private TableColumn<BuscarResultado, String> nombreBarco;

    @FXML
    private TableColumn<BuscarResultado, Integer> socioID;

    @FXML
    private TableColumn<BuscarResultado, String> socioNombre;

    @FXML
    private TableColumn<BuscarResultado, String> socioPaterno;

    @FXML
    private TableView<BuscarResultado> tblTablaBuscar;

    @FXML
    private TextField txtBarco;

    @FXML
    private TextField txtNombre;

    @FXML
    private TextField txtPaterno;

    @FXML
    private Button btnBuscar;

    private Conexion conexion;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        conexion = new Conexion();
        configurarTabla();
        configurarEventos();

        buscarDatos();
    }

    private void configurarTabla() {
        socioID.setCellValueFactory(new PropertyValueFactory<>("idSocio"));
        socioNombre.setCellValueFactory(new PropertyValueFactory<>("nombre"));
        socioPaterno.setCellValueFactory(new PropertyValueFactory<>("apellidoPaterno"));
        nombreBarco.setCellValueFactory(new PropertyValueFactory<>("nombreBarco"));
        nMatricula.setCellValueFactory(new PropertyValueFactory<>("nMatricula"));
        Mensualidad.setCellValueFactory(new PropertyValueFactory<>("mensualidad"));


        Mensualidad.setCellFactory(column -> new TableCell<BuscarResultado, Double>() {
            @Override
            protected void updateItem(Double item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null || item == 0.0) {
                    setText("");
                } else {
                    setText(String.format("$%.2f", item));
                }
            }
        });
    }

    private void configurarEventos() {
        txtNombre.setOnAction(e -> buscarDatos());
        txtPaterno.setOnAction(e -> buscarDatos());
        txtBarco.setOnAction(e -> buscarDatos());
    }

    @FXML
    private void buscarDatos() {
        try {
            String nombre = txtNombre.getText();
            String apellidoPaterno = txtPaterno.getText();
            String nombreBarco = txtBarco.getText();

            ObservableList<BuscarResultado> resultados = conexion.buscarSociosBarcosPorCampo(nombre, apellidoPaterno, nombreBarco);
            tblTablaBuscar.setItems(resultados);

            if (resultados.isEmpty()) {
                mostrarAlerta("Información", "No se encontraron resultados con los criterios de búsqueda especificados.", Alert.AlertType.INFORMATION);
            }

        } catch (Exception e) {
            System.err.println("Error al realizar la búsqueda: " + e.getMessage());
            e.printStackTrace();
            mostrarAlerta("Error", "Error al realizar la búsqueda: " + e.getMessage(), Alert.AlertType.ERROR);
        }
    }

    @FXML
    private void limpiarCampos() {
        txtNombre.clear();
        txtPaterno.clear();
        txtBarco.clear();
        buscarDatos(); // Recargar todos los datos
    }


    private void mostrarAlerta(String titulo, String mensaje, Alert.AlertType tipo) {
        Alert alert = new Alert(tipo);
        alert.setTitle(titulo);
        alert.setHeaderText(null);
        alert.setContentText(mensaje);
        alert.showAndWait();
    }

    public void refrescarTabla() {
        buscarDatos();
    }
}