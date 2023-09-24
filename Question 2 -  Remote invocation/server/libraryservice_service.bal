import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
    }
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    }
    remote function SearchBook(SearchBookRequest value) returns SearchBookResponse|error {
    }
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    }
    remote function ReturnBook(ReturnBookRequest value) returns ReturnBookResponse|error {
    }
    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
    }
    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
    }
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    }
    remote function ListBorrowedBooks(ListBorrowedBooksRequest value) returns ListBorrowedBooksResponse|error {
    }
    remote function CreateUsers(stream<CreateUserRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

