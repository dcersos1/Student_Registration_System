## Steps to RUN the project

# Commands to Create the tables, triggers and Running the PL/SQL package which contains the functions and procedures.
        ssh -X rmaddineni@harveyv.binghamton.edu
        sqlplus rmaddineni@acad111
        @final.sql
        @UniversityDataPkg.pks


# Commands to run java Text-Driven Application

	Execute Command: javac -cp /usr/lib/oracle/18.3/client64/lib/ojdbc8.jar UniversityDBMenu.java

	Execute Command: java -cp /usr/lib/oracle/18.3/client64/lib/ojdbc8.jar UniversityDBMenu.java

	

# Commands to Run the server of Web Application
        Step 1 : open new cmd terminal window
        Execute Command : ssh -L 9000:localhost:8080 rmaddineni@harveyv.binghamton.edu
        
        Step 2: go to UniversityApp folder
        Execute Command: cd UniversityApp
        (the above command connects our system's 9000 port to remote system 8080 where the server will be started)

        #run the server ( from UniversityApp folder)    
        Execute Command : java -jar target/UniversityApplication-0.0.1-SNAPSHOT.jar

        Step 2: open any browser in system and go to "localhost:9000" for viewing the website


## IF WE HAVE TO RUN IN DIFFERENT REMOTE SYSTEM : 
	Step 0: Connect with SSH and Create table as shown using above commands for tables, triggers and package.
        Step 1: ssh -L 9000:localhost:8080 user@harveyv.binghamton.edu

        Step 2: go to UniversityApp folder
        Execute Command: cd UniversityApp

        Step 3:  go to UniversityApp/src/main/resources and change the application.properties jdbc username and password of the remote system.
                spring.datasource.username= NEW_User
                spring.datasource.password= NEW_Password

        Step 4: (go back to present working directory : Inside UniversityApp folder)

        # this command will build the jar file of server.
        Execute Command: ./mvnw install

        # run the server
        Execute Command:  java -jar target/UniversityApplication-0.0.1-SNAPSHOT.jar
        Step 5: server will be up and running, open any browser in system and go to "localhost:9000" for viewing the website

