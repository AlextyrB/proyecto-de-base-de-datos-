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
import modelo.Patron;
import javafx.util.Callback;
import mysql.Conexion;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class PatronController implements Initializable {

    @FXML
    private TableView<Patron> tblTablaPtron;

    @FXML
    private TableColumn<Patron, String> comando;

    @FXML
    private TableColumn<Patron, String> patronCorreo;

    @FXML
    private TableColumn<Patron, Integer> patronID;

    @FXML
    private TableColumn<Patron, String> patronMaterno;

    @FXML
    private TableColumn<Patron, String> patronNombre;

    @FXML
    private TableColumn<Patron, String> patronPaterno;

    @FXML
    private TableColumn<Patron, String> patronTelefono;

    @FXML
    void nuevoPatron(MouseEvent event) {
        try {
            Parent parent = FXMLLoader.load(getClass().getResource("/xml/NuevoPatron.fxml"));
            Scene escena = new Scene(parent);
            Stage escenario = new Stage();
            escenario.setScene(escena);
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
        this.patronID.setCellValueFactory(new PropertyValueFactory<>("id"));
        this.patronNombre.setCellValueFactory(new PropertyValueFactory<>("nombre"));
        this.patronPaterno.setCellValueFactory(new PropertyValueFactory<>("apellidoPaterno"));
        this.patronMaterno.setCellValueFactory(new PropertyValueFactory<>("apellidoMaterno"));
        this.patronTelefono.setCellValueFactory(new PropertyValueFactory<>("telefono"));
        this.patronCorreo.setCellValueFactory(new PropertyValueFactory<>("correo"));

        Callback<TableColumn<Patron, String>, TableCell<Patron, String>> celda = new Callback<>() {
            @Override
            public TableCell<Patron, String> call(TableColumn<Patron, String> parametros) {
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
                                Patron patron = getTableView().getItems().get(getIndex());
                                System.out.println("Borrar patrón: " + patron.getNombre());

                                Alert confirmacion = new Alert(Alert.AlertType.CONFIRMATION);
                                confirmacion.setTitle("Confirmar Eliminación");
                                confirmacion.setHeaderText("¿Está seguro que desea eliminar este patrón?");
                                confirmacion.setContentText("Patrón: " + patron.getNombre() + " " + patron.getApellidoPaterno());

                                confirmacion.showAndWait().ifPresent(response -> {
                                    if (response == ButtonType.OK) {
                                        eliminarPatron(patron.getId());
                                    }
                                });
                            });

                            modificarIcono.setOnMouseClicked(event -> {
                                Patron patron = getTableView().getItems().get(getIndex());
                                System.out.println("Editar patrón: " + patron.getNombre());
                                patron = tblTablaPtron.getSelectionModel().getSelectedItem();
                                modificarPatron(patron);
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

    private void traerDatos() {
        try {
            Conexion cnn = new Conexion();
            this.tblTablaPtron.setItems(cnn.todosPatrones());
        } catch (Exception e) {
            Alert alert = new Alert(Alert.AlertType.WARNING);
            alert.setTitle("Problema en B.D.");
            alert.setHeaderText("Error en la aplicación");
            alert.setContentText("Consulta al fabricante, por favor");
            alert.showAndWait();
            e.printStackTrace();
        }
    }

    private void eliminarPatron(int id) {
        try {
            Conexion cnn = new Conexion();
            boolean eliminado = cnn.eliminarPatron(id);

            if (eliminado) {
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Eliminación Exitosa");
                alert.setHeaderText("Patrón eliminado");
                alert.setContentText("El patrón ha sido eliminado exitosamente junto con sus barcos asociados (si los tenía).");
                alert.showAndWait();

                this.traerDatos(); // Refrescar la tabla
            } else {
                Alert alert = new Alert(Alert.AlertType.WARNING);
                alert.setTitle("Eliminación Fallida");
                alert.setHeaderText("No se pudo eliminar");
                alert.setContentText("No se pudo eliminar el patrón.");
                alert.showAndWait();
            }

        } catch (SQLException e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error de Base de Datos");
            alert.setHeaderText("Error al eliminar patrón");

            if (e.getMessage().contains("no existe")) {
                alert.setContentText("El patrón seleccionado no existe en la base de datos.");
            } else if (e.getMessage().contains("barcos asociados")) {
                alert.setContentText("No se puede eliminar el patrón porque tiene barcos asociados.");
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

    private void modificarPatron(Patron patron) {
        try {
            FXMLLoader alta = new FXMLLoader(getClass().getResource("/xml/NuevoPatron.fxml"));
            Parent parent = (Parent) alta.load();
            ((NuevoPatronController) alta.getController()).modificarPatron(patron);
            Scene escena = new Scene(parent);
            Stage escenario = new Stage();
            escenario.setScene(escena);
            escenario.initStyle(StageStyle.UTILITY);
            escenario.show();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
