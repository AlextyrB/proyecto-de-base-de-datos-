package modelo;

import javafx.beans.property.*;

public class BuscarResultado {
    private final IntegerProperty idSocio;
    private final StringProperty nombre;
    private final StringProperty apellidoPaterno;
    private final StringProperty apellidoMaterno;
    private final StringProperty nombreBarco;
    private final StringProperty nMatricula;
    private final DoubleProperty mensualidad;

    public BuscarResultado() {
        this.idSocio = new SimpleIntegerProperty();
        this.nombre = new SimpleStringProperty();
        this.apellidoPaterno = new SimpleStringProperty();
        this.apellidoMaterno = new SimpleStringProperty();
        this.nombreBarco = new SimpleStringProperty();
        this.nMatricula = new SimpleStringProperty();
        this.mensualidad = new SimpleDoubleProperty();
    }

    public BuscarResultado(int idSocio, String nombre, String apellidoPaterno,
                           String apellidoMaterno, String nombreBarco,
                           String nMatricula, double mensualidad) {
        this();
        setIdSocio(idSocio);
        setNombre(nombre);
        setApellidoPaterno(apellidoPaterno);
        setApellidoMaterno(apellidoMaterno);
        setNombreBarco(nombreBarco);
        setNMatricula(nMatricula);
        setMensualidad(mensualidad);
    }

    public int getIdSocio() {
        return idSocio.get();
    }

    public void setIdSocio(int idSocio) {
        this.idSocio.set(idSocio);
    }

    public IntegerProperty idSocioProperty() {
        return idSocio;
    }

    public String getNombre() {
        return nombre.get();
    }

    public void setNombre(String nombre) {
        this.nombre.set(nombre);
    }

    public StringProperty nombreProperty() {
        return nombre;
    }

    public String getApellidoPaterno() {
        return apellidoPaterno.get();
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno.set(apellidoPaterno);
    }

    public StringProperty apellidoPaternoProperty() {
        return apellidoPaterno;
    }

    public String getApellidoMaterno() {
        return apellidoMaterno.get();
    }

    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno.set(apellidoMaterno);
    }

    public StringProperty apellidoMaternoProperty() {
        return apellidoMaterno;
    }

    public String getNombreBarco() {
        return nombreBarco.get();
    }

    public void setNombreBarco(String nombreBarco) {
        this.nombreBarco.set(nombreBarco != null ? nombreBarco : "");
    }

    public StringProperty nombreBarcoProperty() {
        return nombreBarco;
    }

    public String getNMatricula() {
        return nMatricula.get();
    }

    public void setNMatricula(String nMatricula) {
        this.nMatricula.set(nMatricula != null ? nMatricula : "");
    }

    public StringProperty nMatriculaProperty() {
        return nMatricula;
    }

    public double getMensualidad() {
        return mensualidad.get();
    }

    public void setMensualidad(double mensualidad) {
        this.mensualidad.set(mensualidad);
    }

    public DoubleProperty mensualidadProperty() {
        return mensualidad;
    }
}