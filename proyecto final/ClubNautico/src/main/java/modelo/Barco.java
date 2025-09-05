package modelo;

public class Barco {
    private String nMatricula;
    private String socio;
    private String muelle;
    private int cantidadViajes;
    private String nombreBarco;
    private double mensualidad;

    public Barco() {
    }

    public Barco(String nMatricula, String socio, String muelle, int cantidadViajes,
                 String nombreBarco, double mensualidad) {
        this.nMatricula = nMatricula;
        this.socio = socio;
        this.muelle = muelle;
        this.cantidadViajes = cantidadViajes;
        this.nombreBarco = nombreBarco;
        this.mensualidad = mensualidad;
    }

    public String getNMatricula() {
        return nMatricula;
    }

    public void setNMatricula(String nMatricula) {
        this.nMatricula = nMatricula;
    }

    public String getSocio() {
        return socio;
    }

    public void setSocio(String socio) {
        this.socio = socio;
    }

    public String getMuelle() {
        return muelle;
    }

    public void setMuelle(String muelle) {
        this.muelle = muelle;
    }

    public int getCantidadViajes() {
        return cantidadViajes;
    }

    public void setCantidadViajes(int cantidadViajes) {
        this.cantidadViajes = cantidadViajes;
    }

    public String getNombreBarco() {
        return nombreBarco;
    }

    public void setNombreBarco(String nombreBarco) {
        this.nombreBarco = nombreBarco;
    }

    public double getMensualidad() {
        return mensualidad;
    }

    public void setMensualidad(double mensualidad) {
        this.mensualidad = mensualidad;
    }
}