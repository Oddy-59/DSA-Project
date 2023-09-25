import ballerina/grpc;
import libraryManagement;// I am getting an error here, no idea why. tried quick fixes but no luck

// Let us define message types here

listener grpc:Listener ep = new (9090);

type Student record{
    readonly int student_id;
    string fname;
    string lname;
};

type Librarian record{
    readonly int staffNo;
    string fullNames;
    string officeNo;
};

type Books record{
    readonly int book_id;
    string isbn;
    string title;
    string author_1;
    string author_2;
    string location;
    boolean available;
};

table<Student> key(student_id) studentTable = table[];
table<Librarian> key(staffNo) librarianTable = table[];
table<Books> key(book_id) booksTable = table[];


@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on new grpc:Listener(9090) {

    // Error handling

    remote function AddBook(AddBookRequest value) returns string|error { //getting an error here at "AddBook"
        Book? newBook = createNewBook(value);

        if (newBook == null) {
            return error("Failed to add book!");
        }

        string response = value.isbn;
        return response;
    }

    remote function CreateUsers(CreateUserRequest value) returns CreateUsersResponse|error {
        CreateUsersResponse userCreated = createUser(value.username);

        if (value.username != null) { // also getting another error here at "value.username != null"
            return {message: "User created successfully"}; 
        }

        CreateUsersResponse response = {message: "Failed to create a user"};
        return response;
    }

    remote function UpdatedBook(UpdateBookRequest value) returns UpdateBookResponse|error {
        boolean isUpdated = updatedBook(value.isbn);

        if (!isUpdated) {
            return error("Failed to update the the book");
        }

        UpdateBookResponse response = {message: "Book has been updated successfully"};
        return response;
    }

    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
        boolean isRemoved = removeBook(value.isbn);

        if (!isRemoved) {
            return error("Failed to remove the book");
        }

        RemoveBookResponse response = {message: "Book removed successfully"};
        return response;
    }

    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
        Book[]? availableBooks = getAvailableBooks();

        if (availableBooks == null) {
            return error("Failed to retrieve available books");
        }

        ListAvailableBooksResponse response = {books: availableBooks};
        return response;
    }

    remote function LocateBook(LocateBookRequest value) returns Book[]|error {
        Book[]? searchResult = searchBook(value.isbn);

        if (searchResult == null) {
            return error("Book not found");
        }

        Book[] response = searchResult;
        return response;
    }

    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
        boolean isSuccess = borrowBook(value.student_id, value.isbn);

        if (!isSuccess) {
            return error("Failed to borrow the book");
        }

        BorrowBookResponse response = {message: "Book borrowed successfully"};
        return response;
    }
    
}

function createUser(any a) returns CreateUsersResponse {
    return {};
}

function updatedBook(string s) returns boolean {
    return false;
}

function removeBook(string s) returns boolean {
    return false;
}

function createNewBook(AddBookRequest r) returns Book? {
    return ();
}

function searchBook(any a) returns Book[]? {
    return ();
}

function borrowBook(any a, string s) returns boolean {
    return false;
}

function getAvailableBooks() returns Book[]? {
    return ();
}
