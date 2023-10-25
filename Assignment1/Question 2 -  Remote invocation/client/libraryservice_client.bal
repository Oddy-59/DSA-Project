import ballerina/io;

LibraryServiceClient ep = check new ("http://localhost:9090");

public function libraryservice_client() returns error? {

    AddBookRequest addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", status: "ballerina", available: true};
    AddBookResponse addBookResponse = check ep->AddBook(addBookRequest);
    io:println(addBookResponse);

    CreateUserRequest createUsersRequest = {id: "ballerina", username: "ballerina"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendCreateUserRequest(createUsersRequest);
    check createUsersStreamingClient->complete();
    CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();
    io:println(createUsersResponse);

    UpdateBookRequest updateBookRequest = {isbn: "ballerina", location: "ballerina"};
    UpdateBookResponse updateBookResponse = check ep->UpdateBook(updateBookRequest);
    io:println(updateBookResponse);

    RemoveBookRequest removeBookRequest = {isbn: "ballerina"};
    RemoveBookResponse removeBookResponse = check ep->RemoveBook(removeBookRequest);
    io:println(removeBookResponse);

    ListAvailableBooksRequest listAvailableBooksRequest = {filter_author: "ballerina"};
    ListAvailableBooksResponse listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);
    io:println(listAvailableBooksResponse);

    LocateBookRequest locateBookRequest = {isbn: "ballerina"};
    LocateBookResponse locateBookResponse = check ep->LocateBook(locateBookRequest);
    io:println(locateBookResponse);

    BorrowBookRequest borrowBookRequest = {student_id: "ballerina", isbn: "ballerina"};
    BorrowBookResponse borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
    io:println(borrowBookResponse);

}

