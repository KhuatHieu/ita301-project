package dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Properties;
import java.util.StringJoiner;
import java.util.logging.Level;
import java.util.logging.Logger;

public class _BaseDAO<T> {

    private final String DB_CONFIG_FILE = System.getProperty("user.dir") + File.separator + "_env.properties";

    protected Connection connection;

    protected Class<T> __modelClass;

    protected String tableName = "";

    protected String strictTableName = "";
    private String strictDestTableName = "";

    private String statement = "";
    private ArrayList<String> params = new ArrayList<>();

    private void initConnection() {
        Properties properties = new Properties();

        File file = new File(DB_CONFIG_FILE);
        if (!file.exists()) {
            try ( FileOutputStream output = new FileOutputStream(DB_CONFIG_FILE)) {
                properties.setProperty("hostname", "");
                properties.setProperty("port", "");
                properties.setProperty("database-name", "");
                properties.setProperty("username", "");
                properties.setProperty("password", "");
                properties.store(output, "JDBC Database Configurations");
            } catch (Exception ex) {
                Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
            }
        }

        try {
            properties.load(new FileInputStream(DB_CONFIG_FILE));
        } catch (IOException ex) {
            Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        String hostname = properties.getProperty("hostname");
        String port = properties.getProperty("port");
        String name = properties.getProperty("database-name");
        String username = properties.getProperty("username");
        String password = properties.getProperty("password");

        if (hostname.isEmpty() || port.isEmpty()
                || name.isEmpty() || username.isEmpty()
                || password.isEmpty()) {
            try {
                throw new Exception("Invalid connection properties. Please reconfigure at '_env.properties' file.");
            } catch (Exception ex) {
                Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, ex.getMessage(), ex);
            }
        }

        try {
            String url = "jdbc:sqlserver://" + hostname + ":" + port + ";database=" + name;
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, "Database connection failed.", ex);
        }
    }

    protected _BaseDAO() {
        this.initConnection();
    }

    protected _BaseDAO(String table) {
        this();

        this.tableName = table;
        this.strictTableName = getStrictTableName(table);
    }

    protected _BaseDAO(Class<T> modelClass, String table) {
        this(table);

        this.__modelClass = modelClass;
    }

    private Field[] getFields() {
        Field[] fields = __modelClass.getDeclaredFields();

        Field[] nonStaticFields = Arrays.stream(fields)
                .filter(field -> !Modifier.isStatic(field.getModifiers()))
                .toArray(Field[]::new);

        return nonStaticFields;
    }

    protected _BaseDAO table(String table) {
        return new _BaseDAO(table);
    }

    private String getStrictTableName(String table) {
        return '[' + table + ']';
    }

    private String getStrictColName(String col) {
        if (col.charAt(0) != '`') {
            col = strictTableName + "." + col;
        }
        return col;
    }

    private String getStrictDestColName(String destCol) {
        if (destCol.charAt(0) != '[') {
            destCol = strictDestTableName + "." + destCol;
        }
        return destCol;
    }

    private String camelToSnake(String input) {
        return input.replaceAll("([a-z])([A-Z])", "$1_$2").toLowerCase();
    }

    private String getFieldNameAtIndex(int index) {
        Field[] fields = getFields();

        return camelToSnake(fields[index - 1].getName());
    }

    protected _BaseDAO selects() {
        statement += "SELECT *\n";
        return this.from();
    }

    protected _BaseDAO select(String... cols) {
        StringJoiner joiner = new StringJoiner(", ");
        for (String col : cols) {
            col = getStrictColName(col);
            joiner.add(col);
        }

        statement += "SELECT " + joiner.toString() + "\n";
        return this;
    }

    protected _BaseDAO from() {
        return this.from(tableName);
    }

    protected _BaseDAO from(String... tables) {
        if (tables[0].isEmpty()) {
            tables[0] = tableName;
        }

        StringJoiner joiner = new StringJoiner(", ");
        for (String table : tables) {
            joiner.add(getStrictTableName(table));
        }

        statement += "FROM " + joiner.toString() + "\n";
        return this;
    }

    protected _BaseDAO where(String col, T val) {
        return this.where(col, (T) "=", val);
    }

    protected _BaseDAO where(String col, T op, T val) {
        col = getStrictColName(col);
        statement += "WHERE " + col + " " + op + " ?\n";
        params.add(String.valueOf(val));
        return this;
    }

    protected _BaseDAO andWhere(String col, T val) {
        return this.andWhere(col, (T) "=", val);
    }

    protected _BaseDAO andWhere(String col, T op, T val) {
        col = getStrictColName(col);
        statement += "\tAND " + col + " " + op + " ?\n";
        params.add(String.valueOf(val));
        return this;
    }

    protected _BaseDAO orWhere(String col, T val) {
        return this.orWhere(col, (T) "=", val);
    }

    protected _BaseDAO orWhere(String col, T op, T val) {
        col = getStrictColName(col);
        statement += "\tOR " + col + " " + op + " ?\n";
        params.add(String.valueOf(val));
        return this;
    }

    private _BaseDAO _join(String type, String destTable) {
        strictDestTableName = getStrictTableName(destTable);
        statement += "\t" + type + " JOIN " + strictDestTableName + "\n";
        return this;
    }

    protected _BaseDAO join(String destTable) {
        return this._join("", destTable);
    }

    protected _BaseDAO leftJoin(String destTable) {
        return this._join("LEFT", destTable);
    }

    protected _BaseDAO innerJoin(String destTable) {
        return this._join("INNER", destTable);
    }

    protected _BaseDAO rightJoin(String destTable) {
        return this._join("RIGHT", destTable);
    }

    protected _BaseDAO on(String commonCol) {
        return on(commonCol, commonCol);
    }

    protected _BaseDAO on(String col, String destCol) {
        col = getStrictColName(col);
        destCol = getStrictDestColName(destCol);

        statement += "\t\tON " + col + " = " + destCol + "\n";
        strictDestTableName = "";
        return this;
    }

    protected _BaseDAO orderBy(String col) {
        col = getStrictColName(col);
        statement += "ORDER BY " + col + " ASC\n";
        return this;
    }

    protected _BaseDAO orderBy(String col, String order) {
        col = getStrictColName(col);
        statement += "ORDER BY " + col + " " + order + "\n";
        return this;
    }

    private int itemsPerPage = -1;
    private int page = 1;

    public _BaseDAO paginate(int itemsPerPage, int page) {
        int offset = (page - 1) * itemsPerPage;
        statement += "OFFSET " + offset + " ROWS FETCH NEXT " + itemsPerPage + " ROWS ONLY\n";
        return this;
    }

    protected _BaseDAO insertInto(String table, String... cols) {
        if (table.isEmpty() || table.equalsIgnoreCase("this")) {
            table = this.tableName;
        }

        StringBuilder columnList = new StringBuilder();

        for (String col : cols) {
            columnList.append(col).append(", ");
        }

        if (cols.length > 0) {
            columnList.setLength(columnList.length() - 2);
        }

        statement += String.format("INSERT INTO %s (%s)\n",
                getStrictTableName(table), columnList);
        return this;
    }

    protected _BaseDAO values(T... values) {
        StringBuilder valueList = new StringBuilder();

        for (T value : values) {
            valueList.append("'").append(value).append("'").append(", ");
        }

        if (values.length > 0) {
            valueList.setLength(valueList.length() - 2);
        }

        statement += String.format("VALUES (%s)\n", valueList);
        return this;
    }

    protected _BaseDAO update() {
        statement += "UPDATE " + strictTableName + "\n";
        return this;
    }

    protected _BaseDAO set(String col, T val) {
        statement += "SET " + getStrictColName(col) + " = ?\n";
        params.add(val.toString());
        return this;
    }

    protected _BaseDAO andSet(String col, T val) {
        statement += ", " + getStrictColName(col) + " = ?\n";
        params.add(val.toString());
        return this;
    }

    protected ArrayList<T> get() {
        return this.selects().exec();
    }

    protected T get(int id) {
        return this.getAll(this.getFieldNameAtIndex(1), String.valueOf(id))
                .get(0);
    }

    protected T get(String col, String val) {
        return this.getAll(col, val)
                .get(0);
    }

    protected T get(String col, String op, String val) {
        return this.getAll(col, op, val)
                .get(0);
    }

    protected ArrayList<T> getAll() {
        return this.selects().exec();
    }

    protected ArrayList<T> getAll(String col, String val) {
        return this.selects()
                .where(col, "=", val)
                .exec();
    }

    protected ArrayList<T> getAll(String col, String op, String val) {
        return this.selects()
                .where(col, op, val)
                .exec();
    }

    private _BaseDAO create(T model) {
        StringBuilder columns = new StringBuilder();
        StringBuilder placeholders = new StringBuilder();

        Field[] fields = getFields();

        for (int i = 0; i < fields.length; i++) {
            Field field = fields[i];
            try {
                field.setAccessible(true);
                if (i != 0) {
                    Object value = field.get(model);

                    if (value != null) {
                        columns.append(field.getName()).append(", ");
                        placeholders.append("?, ");
                        params.add(String.valueOf(value));
                    }
                }
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }

        columns.setLength(columns.length() - 2);
        placeholders.setLength(placeholders.length() - 2);

        statement = String.format("INSERT INTO %s (%s) VALUES (%s)", strictTableName, columns, placeholders);
        this.exec();

        return this;
    }

    private _BaseDAO update(T model) {
        Field[] fields = getFields();
        StringBuilder updateSet = new StringBuilder();

        Field idField = fields[0];
        idField.setAccessible(true);

        try {
            Integer id = (Integer) idField.get(model);

            for (Field field : fields) {
                if (field != idField) {
                    field.setAccessible(true);
                    Object value = field.get(model);
                    if (value != null) {
                        updateSet.append(field.getName()).append(" = ?, ");
                        params.add(String.valueOf(value));
                    }
                }
            }

            updateSet.setLength(updateSet.length() - 2);

            statement = String.format("UPDATE %s \nSET %s WHERE %s = ?",
                    strictTableName, updateSet, fields[0].getName());
            params.add(String.valueOf(id));

            exec();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

        return this;
    }

    protected _BaseDAO save(T model) {
        try {
            Field[] fields = getFields();
            fields[0].setAccessible(true);

            int id = (int) fields[0].get(model);
            if (id == 0) {
                return this.create(model);
            } else {
                return this.update(model);
            }
        } catch (IllegalArgumentException | IllegalAccessException ex) {
            Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return this;
    }

    private T mapResultSetToModel(ResultSet rs) {
        try {
            T model = __modelClass.newInstance();

            for (Field field : getFields()) {
                String fieldName = camelToSnake(field.getName());

                // there's must be a better way than this
                Class<?> fieldType = field.getType();
                Object value = null;
                if (fieldType == int.class) {
                    value = rs.getInt(fieldName);
                } else if (fieldType == String.class) {
                    value = rs.getString(fieldName);
                } else if (fieldType == Float.class) {
                    value = rs.getFloat(fieldName);
                } else if (fieldType == boolean.class) {
                    value = rs.getBoolean(fieldName);
                } else if (fieldType == byte.class) {
                    value = rs.getByte(fieldName);
                } else if (fieldType == Timestamp.class) {
                    value = rs.getTimestamp(fieldName);
                }
                field.setAccessible(true);
                field.set(model, value);
            }

            return model;
        } catch (SQLException | IllegalAccessException | InstantiationException e) {
            e.printStackTrace();
        }
        return null;
    }

    private PreparedStatement _currPrepStmt = null;

    private void _prepStmt(boolean isClearAfterPrep) {
        try {
            _currPrepStmt = connection.prepareStatement(statement);
            for (int i = 1; i <= params.size(); i++) {
                _currPrepStmt.setString(i, String.valueOf(params.get(i - 1)));
            }

            if (isClearAfterPrep) {
                statement = "";
                params = new ArrayList<>();
            }
        } catch (SQLException ex) {
            Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private String getStatement() {
        return this.statement;
    }

    protected _BaseDAO createStatement(_BaseDAO b) {
        this.statement = b.getStatement();

        return this;
    }

    protected _BaseDAO raw(String rawStmt) {
        this.statement = rawStmt + "\n";

        return this;
    }

    protected _BaseDAO raw(String rawStmt, T... rawVal) {
        this.statement = rawStmt + "\n";

        return this.setRawVal(rawVal);
    }

    protected _BaseDAO setRawVal(T... val) {
        for (T t : val) {
            this.params.add(String.valueOf(t));
        }

        return this;
    }

    public _BaseDAO printStatement() {
        String _outQueryString = statement;
        for (String param : params) {
            _outQueryString = _outQueryString.replaceFirst("\\?", param);
        }
        System.out.print("===== BEGIN STATEMENT ===== \n" + _outQueryString);
        System.out.println("===== END OF STATEMENT =====");
        return this;
    }

    protected ArrayList<T> exec() {
        ArrayList<T> resultList = new ArrayList<>();

        this._prepStmt(true);
        try {
            if (_currPrepStmt.execute() == true) {
                ResultSet rs = _currPrepStmt.getResultSet();
                while (rs.next()) {
                    T model = mapResultSetToModel(rs);
                    resultList.add(model);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return resultList;
    }

    protected ResultSet execSql() {
        this._prepStmt(true);
        try {
            if (_currPrepStmt.execute() == true) {
                return _currPrepStmt.getResultSet();
            }
        } catch (SQLException ex) {
            Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    protected ResultSet execRaw() {
        return this.execSql();
    }

    protected void printResultSet() {
        try {
            ResultSet rs = this.execSql();
            if (rs == null) {
                return;
            }

            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();

            System.out.println("\n===== STATEMENT EXECUTED ===== \n===== BEGIN RESULTSET =====");
            System.out.print(String.format("%-7s", "#"));
            for (int i = 1; i <= columnCount; i++) {
                String colName = rsmd.getColumnName(i) + "[" + i + "]";
                System.out.print(String.format("%-25s", colName));
            }
            System.out.println();

            for (int count = 1; rs.next(); count++) {
                System.out.print(String.format("%-7s", count));
                for (int i = 1; i <= columnCount; i++) {
                    String value;
                    if (rs.getString(i) == null) {
                        value = "<null>";
                    } else if (rs.getString(i).isEmpty()) {
                        value = "<empty>";
                    } else {
                        value = rs.getString(i);
                    }

                    System.out.print(String.format("%-25s", value));
                }
                System.out.println();
            }

            System.out.println("\n" + ((itemsPerPage == -1)
                    ? "-> Showing all items"
                    : ("-> Paginated " + itemsPerPage + " items per page.")
                    + "\n-> Showing all items in page " + page)
                    + "."
            );
            System.out.println("===== END OF RESULTSET =====");

        } catch (SQLException ex) {
            Logger.getLogger(_BaseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
