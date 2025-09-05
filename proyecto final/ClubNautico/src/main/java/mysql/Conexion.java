package mysql;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import modelo.*;

import java.sql.*;

public class Conexion {
    private static final String URL = "jdbc:mariadb://127.0.0.1:3306/club?serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String PSW = "Solotu1439";

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            return DriverManager.getConnection(URL, USUARIO, PSW);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MariaDB no encontrado", e);
        }
    }

    public ObservableList<Socio> todosSocios() {
        ObservableList<Socio> lista = FXCollections.observableArrayList();

        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call todosSocios()}");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Socio socio = new Socio();
                socio.setId(rs.getInt(1));
                socio.setNombre(rs.getString(2));
                socio.setApellidoPaterno(rs.getString(3));
                socio.setApellidoMaterno(rs.getString(4));
                socio.setTelefono(rs.getString(5));
                socio.setCorreo(rs.getString(6));
                lista.add(socio);
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener socios: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
    public void almacenarSocios(Socio socio) throws SQLException {
        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call GuardarNuevoSocio(?, ?, ?, ?, ?, ?, ?, ?)}")) {
            stmt.setString(1, socio.getNombre());
            stmt.setString(2, socio.getApellidoPaterno());
            stmt.setString(3, socio.getApellidoMaterno());
            stmt.setString(4, socio.getTelefono());
            stmt.setString(5, socio.getCorreo());
            stmt.setString(6, "");
            stmt.setString(7, "");
            stmt.setString(8, "");
            stmt.execute();
        } catch (SQLException e) {
            System.err.println("Error al almacenar socio: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    public boolean eliminarSocio(int idSocio) throws SQLException {
        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call EliminarSocio(?)}")) {
            stmt.setInt(1, idSocio);

            boolean hasResultSet = stmt.execute();

            if (hasResultSet) {
                try (ResultSet rs = stmt.getResultSet()) {
                    if (rs.next()) {
                        String mensaje = rs.getString("resultado");
                        System.out.println("Resultado: " + mensaje);
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            if (e.getMessage().contains("no existe") || e.getMessage().contains("barcos asociados")) {
                System.err.println("Error del procedimiento: " + e.getMessage());
                throw new SQLException("Error al eliminar socio: " + e.getMessage(), e);
            } else {
                System.err.println("Error al eliminar socio: " + e.getMessage());
                e.printStackTrace();
                throw e;
            }
        }
    }
    public boolean modificarSocio(int id, String nombre, String apellidoPaterno, String apellidoMaterno, String telefono, String correo) throws SQLException {
        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call ModificarSocio(?, ?, ?, ?, ?, ?)}")) {
            stmt.setInt(1, id);
            stmt.setString(2, nombre);
            stmt.setString(3, apellidoPaterno);
            stmt.setString(4, apellidoMaterno);
            stmt.setString(5, telefono);
            stmt.setString(6, correo);
            boolean hasResultSet = stmt.execute();

            if (hasResultSet) {
                try (ResultSet rs = stmt.getResultSet()) {
                    if (rs.next()) {
                        String mensaje = rs.getString("resultado");
                        System.out.println("Resultado: " + mensaje);
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            if (e.getMessage().contains("no existe") || e.getMessage().contains("correo duplicado") || e.getMessage().contains("datos inválidos")) {
                System.err.println("Error del procedimiento: " + e.getMessage());
                throw new SQLException("Error al modificar socio: " + e.getMessage(), e);
            } else {
                System.err.println("Error al modificar socio: " + e.getMessage());
                e.printStackTrace();
                throw e;
            }
        }
    }
//-------------------------------------------------------------------------------------------------------------------------------------

    public ObservableList<Patron> todosPatrones() {
        ObservableList<Patron> lista = FXCollections.observableArrayList();

        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call todospatrones()}");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Patron patron = new Patron();
                patron.setId(rs.getInt(1));
                patron.setNombre(rs.getString(2));
                patron.setApellidoPaterno(rs.getString(3));
                patron.setApellidoMaterno(rs.getString(4));
                patron.setTelefono(rs.getString(5));
                patron.setCorreo(rs.getString(6));
                lista.add(patron);
            }

        } catch (SQLException e) {
            System.err.println("Error al obtener patrones: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    public void almacenarPatron(Patron patron) throws SQLException {
        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call GuardarNuevoPatron(?, ?, ?, ?, ?)}")) {

            stmt.setString(1, patron.getNombre());
            stmt.setString(2, patron.getApellidoPaterno());
            stmt.setString(3, patron.getApellidoMaterno());
            stmt.setString(4, patron.getTelefono());
            stmt.setString(5, patron.getCorreo());

            stmt.execute();

        } catch (SQLException e) {
            System.err.println("Error al almacenar patrón: " + e.getMessage());
            throw e;
        }
    }
    public boolean eliminarPatron(int idPatron) throws SQLException {
        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call EliminarPatron(?)}")) {

            stmt.setInt(1, idPatron);
            boolean hasResultSet = stmt.execute();

            if (hasResultSet) {
                try (ResultSet rs = stmt.getResultSet()) {
                    if (rs.next()) {
                        String mensaje = rs.getString("resultado");
                        System.out.println("Resultado: " + mensaje);

                        // Verificar diferentes tipos de error
                        if (mensaje.contains("no existe")) {
                            throw new SQLException("El patrón no existe");
                        } else if (mensaje.contains("viajes asociados")) {
                            throw new SQLException("No se puede eliminar el patrón porque tiene viajes asociados");
                        }

                        return true;
                    }
                }
            }
            return false;

        } catch (SQLException e) {
            System.err.println("Error al eliminar patrón: " + e.getMessage());
            throw e;
        }
    }
    public boolean modificarPatron(int id, String nombre, String apellidoPaterno,
                                   String apellidoMaterno, String telefono, String correo) throws SQLException {
        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call ModificarPatron(?, ?, ?, ?, ?, ?)}")) {

            stmt.setInt(1, id);
            stmt.setString(2, nombre);
            stmt.setString(3, apellidoPaterno);
            stmt.setString(4, apellidoMaterno);
            stmt.setString(5, telefono);
            stmt.setString(6, correo);

            boolean hasResultSet = stmt.execute();

            if (hasResultSet) {
                try (ResultSet rs = stmt.getResultSet()) {
                    if (rs.next()) {
                        String mensaje = rs.getString("resultado");
                        System.out.println("Resultado: " + mensaje);
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            if (e.getMessage().contains("no existe") || e.getMessage().contains("correo duplicado") ||
                    e.getMessage().contains("datos inválidos")) {
                System.err.println("Error del procedimiento: " + e.getMessage());
                throw new SQLException("Error al modificar patrón: " + e.getMessage(), e);
            } else {
                System.err.println("Error al modificar patrón: " + e.getMessage());
                e.printStackTrace();
                throw e;
            }
        }
    }
    //---------------------------------------------------------------------------------------------------------------------
    public ObservableList<Barco> todosBarcos() {
        ObservableList<Barco> lista = FXCollections.observableArrayList();

        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call mostrar_barcos()}");
             ResultSet rs = stmt.executeQuery()) {

            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            System.out.println("Columnas retornadas por mostrar_barcos:");
            for (int i = 1; i <= columnCount; i++) {
                System.out.println("Columna " + i + ": " + metaData.getColumnName(i) + " - Tipo: " + metaData.getColumnTypeName(i));
            }

            while (rs.next()) {
                if (lista.isEmpty()) {
                    System.out.println("\nPrimera fila de datos:");
                    for (int i = 1; i <= columnCount; i++) {
                        System.out.println("Columna " + i + " (" + metaData.getColumnName(i) + "): " + rs.getString(i));
                    }
                }

                Barco barco = new Barco();
                barco.setNMatricula(rs.getString("nº matrícula"));
                barco.setSocio(rs.getString("socio"));
                barco.setMuelle(rs.getString("muelle"));
                barco.setCantidadViajes(rs.getInt("viajes"));
                barco.setNombreBarco(rs.getString("nombre del barco"));
                barco.setMensualidad(rs.getDouble("mensualidad"));
                lista.add(barco);
            }

            System.out.println("Total de barcos cargados: " + lista.size());

        } catch (SQLException e) {
            System.err.println("Error al obtener barcos: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
    //-------------------------------------------------------------------------------------------------------------------------------------


    public ObservableList<Viaje> todosViajes() {
        ObservableList<Viaje> lista = FXCollections.observableArrayList();

        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call todosViajes()}");
             ResultSet rs = stmt.executeQuery()) {

            int contador = 1;
            while (rs.next()) {
                Viaje viaje = new Viaje();

                viaje.setNumero(contador++);

                viaje.setIdViaje(rs.getInt("numero_viaje"));

                Timestamp fechaSalida = rs.getTimestamp("fecha_hora_salida");
                if (fechaSalida != null) {
                    viaje.setFechaHoraSalida(fechaSalida.toString());
                }

                Timestamp fechaEntrada = rs.getTimestamp("fecha_hora_entrada");
                if (fechaEntrada != null) {
                    viaje.setFechaHoraEntrada(fechaEntrada.toString());
                }

                viaje.setDestino(rs.getString("destino"));

                viaje.setNombreCompletoPatron(rs.getString("nombre_completo_patron"));
                viaje.setTelefonoPatron(rs.getString("telefono_patron"));
                viaje.setCorreoPatron(rs.getString("correo_patron"));

                viaje.setMatriculaBarco(rs.getString("matricula_barco"));
                viaje.setNombreBarco(rs.getString("nombre_barco"));

                viaje.setNombreCompletoSocio(rs.getString("nombre_completo_socio"));
                viaje.setTelefonoSocio(rs.getString("telefono_socio"));

                lista.add(viaje);
            }

            System.out.println("Total de viajes cargados: " + lista.size());

        } catch (SQLException e) {
            System.err.println("Error al obtener viajes: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }
    //----------------------------------------------------buscarResul----------------
    public ObservableList<BuscarResultado> buscarSociosBarcosPorCampo(String nombre, String apellidoPaterno, String nombreBarco) {
        ObservableList<BuscarResultado> lista = FXCollections.observableArrayList();

        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call BuscarSociosBarcosPorCampo(?, ?, ?)}")) {

            // Configurar parámetros - si están vacíos, enviar null
            stmt.setString(1, (nombre != null && !nombre.trim().isEmpty()) ? nombre.trim() : null);
            stmt.setString(2, (apellidoPaterno != null && !apellidoPaterno.trim().isEmpty()) ? apellidoPaterno.trim() : null);
            stmt.setString(3, (nombreBarco != null && !nombreBarco.trim().isEmpty()) ? nombreBarco.trim() : null);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BuscarResultado resultado = new BuscarResultado();
                    resultado.setIdSocio(rs.getInt("id_socio"));
                    resultado.setNombre(rs.getString("nombre"));
                    resultado.setApellidoPaterno(rs.getString("apellido_paterno"));
                    resultado.setApellidoMaterno(rs.getString("apellido_materno"));
                    resultado.setNombreBarco(rs.getString("nombre_barco"));
                    resultado.setNMatricula(rs.getString("n_matricula"));

                    Double mensualidad = rs.getObject("mensualidad", Double.class);
                    resultado.setMensualidad(mensualidad != null ? mensualidad : 0.0);

                    lista.add(resultado);
                }
            }

            System.out.println("Búsqueda completada. Resultados encontrados: " + lista.size());

        } catch (SQLException e) {
            System.err.println("Error al buscar socios y barcos: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }
    //---------------------------------------------------------------------------------------------
    public ObservableList<BarcoCompleta> barcosCompleta() {
        ObservableList<BarcoCompleta> lista = FXCollections.observableArrayList();

        try (Connection conn = getConnection();
             CallableStatement stmt = conn.prepareCall("{call todosBarcos()}");
             ResultSet rs = stmt.executeQuery()) {

            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            System.out.println("Columnas retornadas por todosBarcos:");
            for (int i = 1; i <= columnCount; i++) {
                System.out.println("Columna " + i + ": " + metaData.getColumnName(i) + " - Tipo: " + metaData.getColumnTypeName(i));
            }

            while (rs.next()) {
                BarcoCompleta barco = new BarcoCompleta();

                try {
                    barco.setNMatricula(rs.getString(1));                    // Nº Matricula
                    barco.setNombreBarco(rs.getString(2));                   // Nombre del Barco
                    barco.setMensualidad(rs.getDouble(3));                   // Mensualidad
                    barco.setNombreCompletoSocio(rs.getString(4));           // Nombre Socio (completo)
                    barco.setTelefonoSocio(rs.getString(5));                 // Telefono
                    barco.setCorreoSocio(rs.getString(6));                   // Correo Socio
                    barco.setMuelle(rs.getString(7));                        // Muelle
                    barco.setAmarre(rs.getInt(8));                           // Amarre

                    if (lista.isEmpty()) {
                        System.out.println("\nPrimera fila de datos:");
                        System.out.println("Matrícula: " + barco.getNMatricula());
                        System.out.println("Nombre Barco: " + barco.getNombreBarco());
                        System.out.println("Mensualidad: " + barco.getMensualidad());
                        System.out.println("Socio: " + barco.getNombreCompletoSocio());
                        System.out.println("Teléfono: " + barco.getTelefonoSocio());
                        System.out.println("Correo: " + barco.getCorreoSocio());
                        System.out.println("Muelle: " + barco.getMuelle());
                        System.out.println("Amarre: " + barco.getAmarre());
                    }

                    lista.add(barco);

                } catch (SQLException e) {
                    System.err.println("Error al procesar fila del ResultSet: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            System.out.println("Total de barcos cargados: " + lista.size());

        } catch (SQLException e) {
            System.err.println("Error al obtener barcos completos: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }
}