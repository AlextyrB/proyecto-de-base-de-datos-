package controller;

import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import modelo.Barco;
import mysql.Conexion;

import java.net.URL;
import java.util.ResourceBundle;

public class BarcoController implements Initializable {

    @FXML
    private TableColumn<Barco, Double> Mensualidad;

    @FXML
    private TableColumn<Barco, String> Muelle;

    @FXML
    private TableColumn<Barco, String> Socio;

    @FXML
    private TableColumn<Barco, Integer> Viaje;

    @FXML
    private TableColumn<Barco, ?> comando;

    @FXML
    private TableColumn<Barco, String> nMatricula;

    @FXML
    private TableColumn<Barco, String> nombreBarco;

    @FXML
    private TableView<Barco> tblTablaBarco;

    private Conexion conexion = new Conexion();

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        configurarColumnas();

        cargarDatosBarcos();
    }

    private void configurarColumnas() {
        nMatricula.setCellValueFactory(new PropertyValueFactory<>("nMatricula"));
        Socio.setCellValueFactory(new PropertyValueFactory<>("socio"));
        Muelle.setCellValueFactory(new PropertyValueFactory<>("muelle"));
        Viaje.setCellValueFactory(new PropertyValueFactory<>("cantidadViajes"));
        nombreBarco.setCellValueFactory(new PropertyValueFactory<>("nombreBarco"));
        Mensualidad.setCellValueFactory(new PropertyValueFactory<>("mensualidad"));
    }

    private void cargarDatosBarcos() {
        try {
            ObservableList<Barco> listaBarcos = conexion.todosBarcos();

            tblTablaBarco.setItems(listaBarcos);

            System.out.println("Barcos cargados: " + listaBarcos.size());
        } catch (Exception e) {
            System.err.println("Error al cargar los barcos: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @FXML
    void nuevoBarco(MouseEvent event) {
    }

    @FXML
    void refrescar(MouseEvent event) {
        cargarDatosBarcos();
        System.out.println("Tabla de barcos actualizada");
    }
}
