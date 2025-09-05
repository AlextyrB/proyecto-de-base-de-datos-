package controller;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import modelo.Viaje;
import mysql.Conexion;

import java.net.URL;
import java.util.ResourceBundle;

public class MuelleController implements Initializable {

    @FXML
    private TableView<Viaje> tblViajes;

    @FXML
    private TableColumn<Viaje, Integer> colNumero;

    @FXML
    private TableColumn<Viaje, Integer> colIdViaje;

    @FXML
    private TableColumn<Viaje, String> colFechaHoraSalida;

    @FXML
    private TableColumn<Viaje, String> colFechaHoraEntrada;

    @FXML
    private TableColumn<Viaje, String> colDestino;

    @FXML
    private TableColumn<Viaje, String> colNombreCompletoPatron;

    @FXML
    private TableColumn<Viaje, String> colTelefonoPatron;

    @FXML
    private TableColumn<Viaje, String> colCorreoPatron;

    @FXML
    private TableColumn<Viaje, String> colMatriculaBarco;

    @FXML
    private TableColumn<Viaje, String> colNombreBarco;

    @FXML
    private TableColumn<Viaje, String> colNombreCompletoSocio;

    @FXML
    private TableColumn<Viaje, String> colTelefonoSocio;

    private Conexion conexion;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        conexion = new Conexion();

        // Configurar las columnas con los PropertyValueFactory
        colNumero.setCellValueFactory(new PropertyValueFactory<>("numero"));
        colIdViaje.setCellValueFactory(new PropertyValueFactory<>("idViaje"));
        colFechaHoraSalida.setCellValueFactory(new PropertyValueFactory<>("fechaHoraSalida"));
        colFechaHoraEntrada.setCellValueFactory(new PropertyValueFactory<>("fechaHoraEntrada"));
        colDestino.setCellValueFactory(new PropertyValueFactory<>("destino"));
        colNombreCompletoPatron.setCellValueFactory(new PropertyValueFactory<>("nombreCompletoPatron"));
        colTelefonoPatron.setCellValueFactory(new PropertyValueFactory<>("telefonoPatron"));
        colCorreoPatron.setCellValueFactory(new PropertyValueFactory<>("correoPatron"));
        colMatriculaBarco.setCellValueFactory(new PropertyValueFactory<>("matriculaBarco"));
        colNombreBarco.setCellValueFactory(new PropertyValueFactory<>("nombreBarco"));
        colNombreCompletoSocio.setCellValueFactory(new PropertyValueFactory<>("nombreCompletoSocio"));
        colTelefonoSocio.setCellValueFactory(new PropertyValueFactory<>("telefonoSocio"));

        cargarDatos();
    }

    @FXML
    void refrescar(MouseEvent event) {
        cargarDatos();
        System.out.println("Datos de viajes actualizados");
    }

    private void cargarDatos() {
        try {
            tblViajes.setItems(conexion.todosViajes());
        } catch (Exception e) {
            System.err.println("Error al cargar los datos de viajes: " + e.getMessage());
            e.printStackTrace();
        }
    }
}