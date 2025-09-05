package controller;

import de.jensd.fx.glyphs.fontawesome.FontAwesomeIcon;
import de.jensd.fx.glyphs.fontawesome.FontAwesomeIconView;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.geometry.Insets;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.ButtonType;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import modelo.Socio;
import javafx.util.Callback;
import mysql.Conexion;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class SocioController implements Initializable {

    @FXML
    private TableView<Socio> tblTablaSocio;

    @FXML
    private TableColumn<Socio, String> comando;

    @FXML
    private TableColumn<Socio, String> socioCorreo;

    @FXML
    private TableColumn<Socio, Integer> socioID;

    @FXML
    private TableColumn<Socio, String> socioMaterno;

    @FXML
    private TableColumn<Socio, String> socioNombre;

    @FXML
    private TableColumn<Socio, String> socioPaterno;

    @FXML
    private TableColumn<Socio, String> socioTelefono;

    @FXML
    void nuevoSocio(MouseEvent event) {
        try {
            Parent parent= FXMLLoader.load(getClass().getResource("/xml/NuevoUsuario.fxml"));
            Scene esena= new Scene(parent);
            Stage escenario =new Stage();
            escenario.setScene(esena);
            escenario.initStyle(StageStyle.UTILITY);
            escenario.show();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @FXML
    void refrescar(MouseEvent event) {
        this.traerDatos();
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

        this.socioID.setCellValueFactory(new PropertyValueFactory<>("id"));
        this.socioNombre.setCellValueFactory(new PropertyValueFactory<>("nombre"));
        this.socioPaterno.setCellValueFactory(new PropertyValueFactory<>("apellidoPaterno"));
        this.socioMaterno.setCellValueFactory(new PropertyValueFactory<>("apellidoMaterno"));
        this.socioTelefono.setCellValueFactory(new PropertyValueFactory<>("telefono"));
        this.socioCorreo.setCellValueFactory(new PropertyValueFactory<>("correo"));


        Callback<TableColumn<Socio, String>, TableCell<Socio, String>> celda = new Callback<>() {
            @Override
            public TableCell<Socio, String> call(TableColumn<Socio, String> parametros) {
                return new TableCell<>() {
                    @Override
                    protected void updateItem(String item, boolean empty) {
                        super.updateItem(item, empty);

                        if (empty) {
                            setGraphic(null);
                            setText(null);
                        } else {
                            FontAwesomeIconView borrarIcono = new FontAwesomeIconView(FontAwesomeIcon.TRASH);
                            FontAwesomeIconView modificarIcono = new FontAwesomeIconView(FontAwesomeIcon.EDIT);

                            borrarIcono.setGlyphStyle("-fx-fill:RED;-glyph-size: 18px;-fx-cursor: hand;");
                            modificarIcono.setGlyphStyle("-fx-cursor: hand;-glyph-size:18px;");

                            borrarIcono.setOnMouseClicked(event -> {
                                Socio socio = getTableView().getItems().get(getIndex());
                                System.out.println("Borrar socio: " + socio.getNombre());

                                Alert confirmacion = new Alert(Alert.AlertType.CONFIRMATION);
                                confirmacion.setTitle("Confirmar Eliminación");
                                confirmacion.setHeaderText("¿Está seguro que desea eliminar este socio?");
                                confirmacion.setContentText("Socio: " + socio.getNombre() + " " + socio.getApellidoPaterno());

                                confirmacion.showAndWait().ifPresent(response -> {
                                    if (response == javafx.scene.control.ButtonType.OK) {
                                        eliminarSocio(socio.getId());
                                    }
                                });

                            });

                            modificarIcono.setOnMouseClicked(event -> {
                                Socio socio = getTableView().getItems().get(getIndex());
                                System.out.println("Editar socio: " + socio.getNombre());
                                socio = tblTablaSocio.getSelectionModel().getSelectedItem();  // Reasignación, no redeclaración
                                modificarSocio(socio);

                            });


                            HBox contenedorBotones = new HBox(5, modificarIcono, borrarIcono);
                            contenedorBotones.setStyle("-fx-alignment:center");
                            HBox.setMargin(borrarIcono, new Insets(2, 2, 0, 3));
                            HBox.setMargin(modificarIcono, new Insets(2, 3, 0, 2));

                            setGraphic(contenedorBotones);
                            setText(null);
                        }
                    }
                };
            }
        };

        comando.setCellFactory(celda);
        this.traerDatos();
    }

    private void traerDatos(){
        try {
            Conexion cnn = new Conexion();
            this.tblTablaSocio.setItems(cnn.todosSocios());
        } catch (Exception e) {
            Alert alert = new Alert(Alert.AlertType.WARNING);
            alert.setTitle("Problema en B.D.");
            alert.setHeaderText("Error en la aplicación");
            alert.setContentText("Consulta al fabricante, por favor");
            alert.showAndWait();
            e.printStackTrace();
        }
    }
    private void eliminarSocio(int id){
        try {
            Conexion cnn = new Conexion();

            boolean eliminado = cnn.eliminarSocio(id);

            if (eliminado) {
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Eliminación Exitosa");
                alert.setHeaderText("Socio eliminado");
                alert.setContentText("El socio ha sido eliminado exitosamente junto con sus barcos asociados (si los tenía).");
                alert.showAndWait();

                this.traerDatos(); // Refrescar la tabla
            } else {
                Alert alert = new Alert(Alert.AlertType.WARNING);
                alert.setTitle("Eliminación Fallida");
                alert.setHeaderText("No se pudo eliminar");
                alert.setContentText("No se pudo eliminar el socio.");
                alert.showAndWait();
            }

        } catch (SQLException e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error de Base de Datos");
            alert.setHeaderText("Error al eliminar socio");

            if (e.getMessage().contains("no existe")) {
                alert.setContentText("El socio seleccionado no existe en la base de datos.");
            } else if (e.getMessage().contains("barcos asociados")) {
                alert.setContentText("No se puede eliminar el socio porque tiene barcos asociados.");
            } else {
                alert.setContentText("Error: " + e.getMessage());
            }

            alert.showAndWait();
            e.printStackTrace();

        } catch (Exception e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error Inesperado");
            alert.setHeaderText("Error en la aplicación");
            alert.setContentText("Error inesperado: " + e.getMessage());
            alert.showAndWait();
            e.printStackTrace();
        }
    }
    private void modificarSocio (Socio socio){
        try {
            FXMLLoader alta= new FXMLLoader(getClass().getResource("/xml/NuevoUsuario.fxml"));
            Parent parent= (Parent)alta.load();
            ((NuevoSocioController)alta.getController()).modificarSocio(socio);
            Scene esena= new Scene(parent);
            Stage escenario =new Stage();
            escenario.setScene(esena);
            escenario.initStyle(StageStyle.UTILITY);
            escenario.show();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }



}
