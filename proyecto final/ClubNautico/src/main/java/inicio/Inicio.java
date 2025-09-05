package inicio;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Inicio extends Application {
    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/xml/inicio.fxml"));

        if (loader.getLocation() == null) {
            throw new RuntimeException("No se pudo encontrar el archivo FXML en: /xml/inicio.fxml");
        }

        Parent root = loader.load();
        Scene scene = new Scene(root);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Club Náutico");
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
//FXMLLoader fxmlLoader = new FXMLLoader(Inicio.class.getResource("/xml/inicio.fxml"));
//Scene scene = new Scene(fxmlLoader.load());
//stage.setTitle("Hello!");
//stage.setScene(scene);
//stage.show();