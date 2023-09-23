import ballerina/grpc;
import library;// Import the generated gRPC package

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

    resource function AddBook(library:AddBookRequest) returns AddBookResponse {
        // Create a new Book instance from the request
        Book newBook = {
            isbn: library.isbn,
            title: library.title,
            author_1: library.author_1,
            author_2: library.author_2,
            location: library.location,
            available: true // Assuming the book is available when added
        };

        // Add the new book to the table
        booksTable.add(newBook);

        // Create a response and set the ISBN
        AddBookResponse response = { isbn: library.isbn };

        // Return the response
        return response;
    }

    remote function CreateUsers(stream CreateUserRequest) returns CreateUsersResponse|error {

    }

    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {

    }

    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {

    }


    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
        Book[]? availableBooks = getAvailableBooks();

        if (availableBooks == null) {
            return error("Failed to retrieve available books");
        }

        ListAvailableBooksResponse response = {books: availableBooks};
        return response;
    }

    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|Book[] {
        Book[]? searchResult = searchBook(value.isbn);

        if (searchResult == null) {
            return {message: "Book not found"};
        }

        Book[] response = searchResult;
        return response;
    }

    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
        boolean isSuccess = borrowBook(value.student_id, value.isbn);

        if (!isSuccess) {
            return {message: "Failed to borrow the book"};
        }

        BorrowBookResponse response = {message: "Book borrowed successfully"};
        return response;
    }
    
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
