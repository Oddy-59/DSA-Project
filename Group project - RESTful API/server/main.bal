import ballerina/http;

enum Courses {
    DSA612S,
    DTA612S,
    WAD612S   
}

type Course record {
    readonly string id;
    string courseName;
    string courseCode;
    int NQF_Level;
};

type Lecturer record {
     //readonly string id;
     readonly int staffNumber;
     int officeNumber;
     string name;
     string title;
     Courses coursesTaught;
};

type courseLecturer record {
    readonly string id;
    string staffNumber;
    string courseCode;
};

//Creating tables for both the courses and lecturers
table<Course> key(id) courseTable = table[];
table<Lecturer> key(staffNumber) lecturerTable = table[];
table<courseLecturer> key(id) courseLecturerTable = table[];


service / on new http:Listener(8000) {
   resource function post addLecturer(Lecturer newLecturer) returns string|error {
        //Error handling to ensure our app does not crash
        error? createNewLecturer = lecturerTable.add(newLecturer);

        if (createNewLecturer is error){
            return "Error " + createNewLecturer.message();
        }else {
           return newLecturer.name + " saved successfuly!";
        }
   } 

   resource function get retrieveLecturerByStaffNumber(int staffNumber) returns Lecturer[] {
        table<Lecturer> lecturerResults =  from var lecturer in lecturerTable
            order by  lecturer.name ascending
            where lecturer.staffNumber === staffNumber
            select lecturer;
            
        return lecturerResults.toArray();
   }

   resource function get retrieveAllLecturers() returns Lecturer[]{
        return lecturerTable.toArray(); 
   }

   resource function put UpdateLecturer(Lecturer updatedLecturer) returns string {
        //Error handling to ensure our app does not crash
        error? updateLecturer = lecturerTable.put(updatedLecturer);

        if (updateLecturer is error){
            return "Error " + updateLecturer.message();
        }else {
           return updatedLecturer.name + " updated successfuly!";
        }
   } 

   resource function delete deleteLecturer(int staffNumber) returns string|error {
        //Error handling to ensure our app does not crash
        Lecturer|error deleteLecturer = lecturerTable.remove(staffNumber);

        if (deleteLecturer is error){
            return "Error " + deleteLecturer.message();
        }else {
           return deleteLecturer.name + " deleted successfuly!";
        }
   } 

   resource function post createCourse(Course newCourse) returns string {
        //Error handling to ensure our app does not crash
        error? createNewCourse = courseTable.add(newCourse);

        if (createNewCourse is error){
            return "Error " + createNewCourse.message();
        }else {
           return newCourse.courseName + "saved successfuly";
        }
   } 

   resource function get retrieveAllLecturersByCourse(string coursesTaught) returns Lecturer[]{
         table<Lecturer> lecturerByCourseResults =  from var lecturer in lecturerTable
            order by  lecturer.name ascending
            where lecturer.coursesTaught === coursesTaught
            select lecturer;
            
        return lecturerByCourseResults.toArray();
   }


   resource function get retrieveAllLecturerByOffice(int officeNumber) returns Lecturer[] {
        table<Lecturer> lecturerByOfficeResults =  from var lecturer in lecturerTable
            order by  lecturer.name ascending
            where lecturer.officeNumber === officeNumber
            select lecturer;
            
        return lecturerByOfficeResults.toArray();
   }
}
