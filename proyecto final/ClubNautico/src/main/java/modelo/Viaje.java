package modelo;

public class Viaje {
    private int numero;
    private int idViaje;
    private String fechaHoraSalida;
    private String fechaHoraEntrada;
    private String destino;
    private String nombreCompletoPatron;
    private String telefonoPatron;
    private String correoPatron;
    private String matriculaBarco;
    private String nombreBarco;
    private String nombreCompletoSocio;
    private String telefonoSocio;

    public Viaje() {
    }

    // Getters y Setters
    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public int getIdViaje() {
        return idViaje;
    }

    public void setIdViaje(int idViaje) {
        this.idViaje = idViaje;
    }

    public String getFechaHoraSalida() {
        return fechaHoraSalida;
    }

    public void setFechaHoraSalida(String fechaHoraSalida) {
        this.fechaHoraSalida = fechaHoraSalida;
    }

    public String getFechaHoraEntrada() {
        return fechaHoraEntrada;
    }

    public void setFechaHoraEntrada(String fechaHoraEntrada) {
        this.fechaHoraEntrada = fechaHoraEntrada;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public String getNombreCompletoPatron() {
        return nombreCompletoPatron;
    }

    public void setNombreCompletoPatron(String nombreCompletoPatron) {
        this.nombreCompletoPatron = nombreCompletoPatron;
    }

    public String getTelefonoPatron() {
        return telefonoPatron;
    }

    public void setTelefonoPatron(String telefonoPatron) {
        this.telefonoPatron = telefonoPatron;
    }

    public String getCorreoPatron() {
        return correoPatron;
    }

    public void setCorreoPatron(String correoPatron) {
        this.correoPatron = correoPatron;
    }

    public String getMatriculaBarco() {
        return matriculaBarco;
    }

    public void setMatriculaBarco(String matriculaBarco) {
        this.matriculaBarco = matriculaBarco;
    }

    public String getNombreBarco() {
        return nombreBarco;
    }

    public void setNombreBarco(String nombreBarco) {
        this.nombreBarco = nombreBarco;
    }

    public String getNombreCompletoSocio() {
        return nombreCompletoSocio;
    }

    public void setNombreCompletoSocio(String nombreCompletoSocio) {
        this.nombreCompletoSocio = nombreCompletoSocio;
    }

    public String getTelefonoSocio() {
        return telefonoSocio;
    }

    public void setTelefonoSocio(String telefonoSocio) {
        this.telefonoSocio = telefonoSocio;
    }

    @Override
    public String toString() {
        return "Viaje{" +
                "numero=" + numero +
                ", idViaje=" + idViaje +
                ", fechaHoraSalida='" + fechaHoraSalida + '\'' +
                ", fechaHoraEntrada='" + fechaHoraEntrada + '\'' +
                ", destino='" + destino + '\'' +
                ", nombreCompletoPatron='" + nombreCompletoPatron + '\'' +
                ", telefonoPatron='" + telefonoPatron + '\'' +
                ", correoPatron='" + correoPatron + '\'' +
                ", matriculaBarco='" + matriculaBarco + '\'' +
                ", nombreBarco='" + nombreBarco + '\'' +
                ", nombreCompletoSocio='" + nombreCompletoSocio + '\'' +
                ", telefonoSocio='" + telefonoSocio + '\'' +
                '}';
    }
}