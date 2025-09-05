module com.example.clubnautico {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.kordamp.bootstrapfx.core;
    requires de.jensd.fx.glyphs.fontawesome;
    requires java.sql;
    requires java.desktop;
    opens modelo to javafx.base;
    opens controller to javafx.fxml;


    exports inicio;
    opens inicio to javafx.fxml;
    exports controller;
    //opens controller to javafx.fxml;
}