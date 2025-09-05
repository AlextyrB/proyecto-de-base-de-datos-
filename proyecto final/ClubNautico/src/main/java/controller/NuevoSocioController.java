package controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;
import modelo.Socio;
import mysql.Conexion;

import java.sql.SQLException;

public class NuevoSocioController {
    private Socio socio; // Socio en modo edición
    private boolean modoEdicion = false; // Flag para saber si estamos editando

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
        socio = null;
    }

    @FXML
    void guardarAccion(ActionEvent event) {
        try {
            if (txtNombre.getText().trim().isEmpty() || txtCorreo.getText().trim().isEmpty()) {
                System.out.println("Error: Complete al menos el nombre y correo");
                return;
            }

            Conexion cnn = new Conexion();

            if (modoEdicion && socio != null) {
                boolean resultado = cnn.modificarSocio(
                        socio.getId(),
                        txtNombre.getText().trim(),
                        txtAPaterno.getText().trim(),
                        txtAMaterno.getText().trim(),
                        txtTelefono.getText().trim(),
                        txtCorreo.getText().trim()
                );

                if (resultado) {
                    System.out.println("Socio modificado exitosamente");
                } else {
                    System.out.println("No se pudo modificar el socio");
                }

            } else {
                Socio nuevoSocio = new Socio();
                nuevoSocio.setNombre(txtNombre.getText().trim());
                nuevoSocio.setApellidoPaterno(txtAPaterno.getText().trim());
                nuevoSocio.setApellidoMaterno(txtAMaterno.getText().trim());
                nuevoSocio.setTelefono(txtTelefono.getText().trim());
                nuevoSocio.setCorreo(txtCorreo.getText().trim());

                cnn.almacenarSocios(nuevoSocio);
                System.out.println("Socio guardado exitosamente");
            }

            limpiarCampos();
            modoEdicion = false;
            socio = null;

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


    public void modificarSocio(Socio socio) {
        this.socio = socio;
        this.modoEdicion = true;

        // Cargar datos en los campos
        this.txtNombre.setText(socio.getNombre());
        this.txtAPaterno.setText(socio.getApellidoPaterno());
        this.txtAMaterno.setText(socio.getApellidoMaterno());
        this.txtTelefono.setText(socio.getTelefono());
        this.txtCorreo.setText(socio.getCorreo());

        System.out.println("Modo edición activado para socio ID: " + socio.getId());
    }


    public void nuevoSocio() {
        this.modoEdicion = false;
        this.socio = null;
        limpiarCampos();
        System.out.println("Modo crear socio activado");
    }
}