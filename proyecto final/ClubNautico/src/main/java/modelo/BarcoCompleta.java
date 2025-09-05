package modelo;

import javafx.beans.property.*;

public class BarcoCompleta {
    private final StringProperty nMatricula;
    private final StringProperty nombreBarco;
    private final DoubleProperty mensualidad;
    private final StringProperty nombreCompletoSocio;
    private final StringProperty telefonoSocio;
    private final StringProperty correoSocio;
    private final StringProperty muelle;
    private final IntegerProperty amarre;

    public BarcoCompleta() {
        this.nMatricula = new SimpleStringProperty();
        this.nombreBarco = new SimpleStringProperty();
        this.mensualidad = new SimpleDoubleProperty();
        this.nombreCompletoSocio = new SimpleStringProperty();
        this.telefonoSocio = new SimpleStringProperty();
        this.correoSocio = new SimpleStringProperty();
        this.muelle = new SimpleStringProperty();
        this.amarre = new SimpleIntegerProperty();
    }

    public String getNMatricula() {
        return nMatricula.get();
    }

    public void setNMatricula(String nMatricula) {
        this.nMatricula.set(nMatricula);
    }

    public StringProperty nMatriculaProperty() {
        return nMatricula;
    }

    public String getNombreBarco() {
        return nombreBarco.get();
    }

    public void setNombreBarco(String nombreBarco) {
        this.nombreBarco.set(nombreBarco);
    }

    public StringProperty nombreBarcoProperty() {
        return nombreBarco;
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

    public String getNombreCompletoSocio() {
        return nombreCompletoSocio.get();
    }

    public void setNombreCompletoSocio(String nombreCompletoSocio) {
        this.nombreCompletoSocio.set(nombreCompletoSocio);
    }

    public StringProperty nombreCompletoSocioProperty() {
        return nombreCompletoSocio;
    }

    public String getTelefonoSocio() {
        return telefonoSocio.get();
    }

    public void setTelefonoSocio(String telefonoSocio) {
        this.telefonoSocio.set(telefonoSocio);
    }

    public StringProperty telefonoSocioProperty() {
        return telefonoSocio;
    }

    public String getCorreoSocio() {
        return correoSocio.get();
    }

    public void setCorreoSocio(String correoSocio) {
        this.correoSocio.set(correoSocio);
    }

    public StringProperty correoSocioProperty() {
        return correoSocio;
    }

    public String getMuelle() {
        return muelle.get();
    }

    public void setMuelle(String muelle) {
        this.muelle.set(muelle);
    }

    public StringProperty muelleProperty() {
        return muelle;
    }

    public int getAmarre() {
        return amarre.get();
    }

    public void setAmarre(int amarre) {
        this.amarre.set(amarre);
    }

    public IntegerProperty amarreProperty() {
        return amarre;
    }

    @Override
    public String toString() {
        return "BarcoCompleta{" +
                "nMatricula='" + getNMatricula() + '\'' +
                ", nombreBarco='" + getNombreBarco() + '\'' +
                ", mensualidad=" + getMensualidad() +
                ", nombreCompletoSocio='" + getNombreCompletoSocio() + '\'' +
                ", telefonoSocio='" + getTelefonoSocio() + '\'' +
                ", correoSocio='" + getCorreoSocio() + '\'' +
                ", muelle='" + getMuelle() + '\'' +
                ", amarre=" + getAmarre() +
                '}';
    }
}