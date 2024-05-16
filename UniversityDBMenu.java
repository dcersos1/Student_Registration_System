// Here we import the necessary libraries, functions, and means of facilitiating the formation fo the menu driven interface
import java.sql.*;
import oracle.jdbc.*;
import oracle.jdbc.pool.OracleDataSource;
import java.util.Scanner;



// Here we define the broadest class as the outer level of how interacting with the db from the MDI will occur
public class UniversityDBMenu {
    // This intilaizes two objects, a scanner for user input and for faciliating the connection
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Connection conn = null;

        // Below we intialize the connection, state the connection url, and subseqently confirm said connection to the db
        try {
            OracleDataSource ds = new OracleDataSource();
            ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
            conn = ds.getConnection("rmaddineni", "rakesh190702");
            System.out.println("Connected to the database successfully.");
            // Now we write the logic for how the user will be presented with the MDI and this si done in a continuois loop
            // to allow for the user to keep taking furhter action as they see fit
            while (true) {
                System.out.println("\n--- University Database Menu ---");
                System.out.println("1. Display a Table");
                System.out.println("2. Enroll a Graduate Student");
                System.out.println("3. Exit");
                System.out.print("Enter your choice: ");
                int mainChoice = scanner.nextInt();
                // based on the user choice, we implment the resulting action to carry out the ensuing operation as a product of said choice
                switch (mainChoice) {
                    case 1:
                        displayTableMenu(conn, scanner);
                        break;
                    case 2:
                        enrollStudent(conn, scanner);
                        break;
                    case 3:
                        System.out.println("Exiting...");
                        return;
                    default:
                        System.out.println("Invalid choice. Please try again.");
                }
            }
        // We implement measure for handlign sql anamolies and return the requiste message to inform the user of the issue
        // befor ultimatley implementing the funcitonality to close the connection
        } catch (SQLException ex) {
            System.out.println("\n*** SQLException caught ***\n" + ex.getMessage());
        } catch (Exception e) {
            System.out.println("\n*** Other Exception caught ***\n");
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Error closing the connection: " + e.getMessage());
            }
        }
    }
    // This provides the ability to portray the tabes in alignment with the above processes while providing functioanlity
    // to read the users choice and show the relevant table accordingly 
    private static void displayTableMenu(Connection conn, Scanner scanner) throws SQLException {
        System.out.println("\nSelect which table to display:");
        System.out.println("1. Students");
        System.out.println("2. Courses");
        System.out.println("3. Prerequisites");
        System.out.println("4. Course Credit");
        System.out.println("5. Classes");
        System.out.println("6. Score Grade");
        System.out.println("7. G Enrollments");
        System.out.println("8. Logs");
        System.out.print("Enter your choice: ");
        int tableChoice = scanner.nextInt();

        displayTable(conn, tableChoice);
    }
    // This is the portion if the code which, based oin the selected tabke above, provides the logic to display said table
    //from the db
    private static void displayTable(Connection conn, int tableChoice) throws SQLException {
        String tableName = getFunctionName(tableChoice);
        if (tableName == null) {
            System.out.println("Invalid table choice.");
            return;
        }

        // This subseqent block intializes the sql from the package to execute the elevant procedure , retrieve the results
        // and print each every row
        String call = "{ ? = call UniversityDataPkg.get_" + tableName + "() }";
        try (CallableStatement cs = conn.prepareCall(call)) {
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            try (ResultSet rs = (ResultSet) cs.getObject(1)) {
                
                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();
             
            
                while (rs.next()) {
                    for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                        System.out.print(rs.getMetaData().getColumnName(i) + ":" + rs.getString(i) + ", ");
                    }
                    System.out.println();
                }
            }
        }
    }
    // This enforces the association betwenen user choice and the corresponding relation name
    private static String getFunctionName(int choice) {
        switch (choice) {
            case 1: return "students";
            case 2: return "courses";
            case 3: return "prerequisites";
            case 4: return "course_credit";
            case 5: return "classes";
            case 6: return "score_grade";
            case 7: return "g_enrollments";
            case 8: return "logs";
            default: return null;
        }
    }
    // Now we get into rpvioding the confirgutation for the specific operations themselves

    // We start with incorporating code to handle the enrollment of specifically graduate students
    private static void enrollStudent(Connection conn, Scanner scanner) throws SQLException {
        try {
            // This specifically shows all the students
            System.out.println("List of all Students:");
            displayStudents(conn);

            // Similar to above but for classes
            System.out.println("\nList of all Classes:");
            displayCourses(conn);

            // Allows for asking the user for b number and class id for enrollment 
            System.out.print("Enter student B# to enroll: ");
            String studentId = scanner.next();
            System.out.print("Enter class ID to enroll in: ");
            String classId = scanner.next();

            // This allows for the relevant procedure based on user action to be called and executed
            try (CallableStatement cs = conn.prepareCall("{ call UniversityDataPkg.Enroll_Student(?, ?) }")) {
                cs.setString(1, studentId);
                cs.setString(2, classId);
                cs.execute();
                System.out.println("Student successfully enrolled.");
            }
        
        // Handling for any sql anamolies which prevent successful execution with messages 
        } catch (SQLException e) {
            String errorMessage = parseSQLException(e.getMessage());
            System.out.println("Here --------");
            System.out.println("Enrollment failed: " + errorMessage);
            System.out.println("Here --------");
        }
    }

    // WE now pivot to provide the unqiue funcitonality for displaying students by referencing the procedure associated 
    // and in doing so we resgister the output to serve as the result set before executing said assocaited procedure
    private static void displayStudents(Connection conn) throws SQLException {
        try (CallableStatement cs = conn.prepareCall("{ ? = call UniversityDataPkg.get_students() }")) {
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            try (ResultSet rs = (ResultSet) cs.getObject(1)) {
                while (rs.next()) {
                    System.out.println(rs.getString("B#") + ": " + rs.getString("first_name") + " " + rs.getString("last_name"));
                }
            }
        }
    }
    // This block focuses on displaying the courses and follows simialr logic to the above process with specific
    // consideration for the disparities in the nature of students vs courses. For example, how the result is printed
    private static void displayCourses(Connection conn) throws SQLException {
        try (CallableStatement cs = conn.prepareCall("{ ? = call UniversityDataPkg.get_classes() }")) {
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            try (ResultSet rs = (ResultSet) cs.getObject(1)) {
                while (rs.next()) {
                    System.out.println(rs.getString("classid") + ": " + rs.getString("course#"));
                }
            }
        }
    }

    //After having configuired logic to catch sql anamolies above, we now look to integrate logic which provides 
    // custom messages for specific anamolies to streamline user interpretability of the issues at hand
    private static String parseSQLException(String message) {
        if (message.contains("ORA-20001")) {
            return "The B# is invalid.";
        } else if (message.contains("ORA-20002")) {
            return "This is not a graduate student.";
        } else if (message.contains("ORA-20003")) {
            return "The classid is invalid.";
        } else if (message.contains("ORA-20004 ")){
            return "Cannot enroll into a class from a previous semester";
        }else if (message.contains("ORA-20005")) {
            return "The class is already full.";
        }else if (message.contains("ORA-20006")) {
            return "The student is already in the class.";
        } else if (message.contains("ORA-20007")) {
            return "Students cannot be enrolled in more than five classes in the same semester.";
        } else if (message.contains("ORA-20008")) {
            return "Prerequisite not satisfied.";
        }else if (message.contains("ORA-20009")){
            return "Data validation failed.";
        }else {
            return "An unexpected error occurred: " + message;
        }
    }
}
