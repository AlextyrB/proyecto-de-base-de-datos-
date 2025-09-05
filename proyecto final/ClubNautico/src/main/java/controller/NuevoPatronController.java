package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import modelo.Patron;
import mysql.Conexion;

import java.sql.SQLException;

public class NuevoPatronController {
    private Patron patron;
    private boolean modoEdicion = false;

    @FXML
    private TextField txtAMaterno;

    @FXML
    private TextField txtAPaterno;

    @FXML
    private TextField txtCorreo;

    @FXML
    private TextField txtNombre;

    @FXML
    private TextField txtTelefono;

    @FXML
    void accionLimpiar(ActionEvent event) {
        limpiarCampos();
        modoEdicion = false;
        patron = null;
    }

    @FXML
    void guardarAccion(ActionEvent event) {
        try {
            if (txtNombre.getText().trim().isEmpty() || txtCorreo.getText().trim().isEmpty()) {
                System.out.println("Error: Complete al menos el nombre y correo");
                return;
            }

            Conexion cnn = new Conexion();

            if (modoEdicion && patron != null) {
                boolean resultado = cnn.modificarPatron(
                        patron.getId(),
                        txtNombre.getText().trim(),
                        txtAPaterno.getText().trim(),
                        txtAMaterno.getText().trim(),
                        txtTelefono.getText().trim(),
                        txtCorreo.getText().trim()
                );

                if (resultado) {
                    System.out.println("Patrón modificado exitosamente");
                } else {
                    System.out.println("No se pudo modificar el patrón");
                }

            } else {
                Patron nuevoPatron = new Patron();
                nuevoPatron.setNombre(txtNombre.getText().trim());
                nuevoPatron.setApellidoPaterno(txtAPaterno.getText().trim());
                nuevoPatron.setApellidoMaterno(txtAMaterno.getText().trim());
                nuevoPatron.setTelefono(txtTelefono.getText().trim());
                nuevoPatron.setCorreo(txtCorreo.getText().trim());

                cnn.almacenarPatron(nuevoPatron);
                System.out.println("Patrón guardado exitosamente");
            }

            limpiarCampos();
            modoEdicion = false;
            patron = null;

        } catch (SQLException e) {
            System.err.println("Error de base de datos: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error inesperado: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void limpiarCampos() {
        txtNombre.clear();
        txtAPaterno.clear();
        txtAMaterno.clear();
        txtTelefono.clear();
        txtCorreo.clear();
    }


    public void modificarPatron(Patron patron) {
        this.patron = patron;
        this.modoEdicion = true;

        this.txtNombre.setText(patron.getNombre());
        this.txtAPaterno.setText(patron.getApellidoPaterno());
        this.txtAMaterno.setText(patron.getApellidoMaterno());
        this.txtTelefono.setText(patron.getTelefono());
        this.txtCorreo.setText(patron.getCorreo());

        System.out.println("Modo edición activado para patrón ID: " + patron.getId());
    }


    public void nuevoPatron() {
        this.modoEdicion = false;
        this.patron = null;
        limpiarCampos();
        System.out.println("Modo crear patrón activado");
    }
}