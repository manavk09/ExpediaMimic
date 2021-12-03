package cs336proj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class registerDao {
	
	private String dbURL = "jdbc:mysql://localhost:3306/CS336_PROJ";
	private String dbUserName = "root";
	private String dbPass = System.getenv("sqlPassword");
	private String dbDriver = "com.mysql.cj.jdbc.Driver";
	
	public void loadDriver(String dbDriver) {
		try {
			Class.forName(dbDriver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public Connection getConnection() {
		Connection con = null;
		try {
			con = DriverManager.getConnection(dbURL,dbUserName,dbPass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
	
	public int insert(Customer customer) {
		//first load the driver
		loadDriver(dbDriver);
		//then get connection
		Connection con = getConnection();
		int result = 0;
		
		String querry = "insert into user values(?,?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(querry);
			ps.setString(1, customer.getUsername());
			ps.setString(2, customer.getPassword());
			ps.setString(3, customer.getfName());
			ps.setString(4, customer.getlName());
			ps.setString(5, "Customer");
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = 1;
		}
		
		return result;
			
	}
	
	public int validate(String username, String password) {
		//load the driver
		loadDriver(dbDriver);
		//get connection
		Connection con = getConnection();
		int result = 0;
		String role = "";
		
		String querry = "select Username,Password,Role from User where Username = ? and Password = ?";
		try {
			PreparedStatement ps = con.prepareStatement(querry);
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				role = rs.getString(3);
			}
			if(role.equals("Admin")) {
				result = 1;
			}
			else if(role.equals("Customer Representative")) {
				result = 2;
			}
			else if(role.equals("Customer")){
				result = 0;
			}
			else {
				result = -1;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result;
	}

}
