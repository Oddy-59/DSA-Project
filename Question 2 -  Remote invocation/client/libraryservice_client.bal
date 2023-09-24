import ballerina/io;

LibraryServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    ListAvailableBooksRequest listAvailableBooksRequest = {filter_author: "ballerina"};
    ListAvailableBooksResponse listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);
    io:println(listAvailableBooksResponse);

    BorrowBookRequest borrowBookRequest = {student_id: "ballerina", isbn: "ballerina"};
    BorrowBookResponse borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
    io:println(borrowBookResponse);

    SearchBookRequest searchBookRequest = {query: "ballerina"};
    SearchBookResponse searchBookResponse = check ep->SearchBook(searchBookRequest);
    io:println(searchBookResponse);

    LocateBookRequest locateBookRequest = {isbn: "ballerina"};
    LocateBookResponse locateBookResponse = check ep->LocateBook(locateBookRequest);
    io:println(locateBookResponse);

    ReturnBookRequest returnBookRequest = {book_id: "ballerina", student_id: "ballerina"};
    ReturnBookResponse returnBookResponse = check ep->ReturnBook(returnBookRequest);
    io:println(returnBookResponse);

    AddBookRequest addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", status: "ballerina", available: true};
    AddBookResponse addBookResponse = check ep->AddBook(addBookRequest);
    io:println(addBookResponse);

    UpdateBookRequest updateBookRequest = {isbn: "ballerina", location: "ballerina"};
    UpdateBookResponse updateBookResponse = check ep->UpdateBook(updateBookRequest);
    io:println(updateBookResponse);

    RemoveBookRequest removeBookRequest = {isbn: "ballerina"};
    RemoveBookResponse removeBookResponse = check ep->RemoveBook(removeBookRequest);
    io:println(removeBookResponse);

    ListBorrowedBooksRequest listBorrowedBooksRequest = {student_id: "ballerina"};
    ListBorrowedBooksResponse listBorrowedBooksResponse = check ep->ListBorrowedBooks(listBorrowedBooksRequest);
    io:println(listBorrowedBooksResponse);

    CreateUserRequest createUsersRequest = {id: "ballerina", username: "ballerina"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendCreateUserRequest(createUsersRequest);
    check createUsersStreamingClient->complete();
    CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();
    io:println(createUsersResponse);
}

