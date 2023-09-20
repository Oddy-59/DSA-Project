import ballerina/grpc;

public function main() {
    // Set up gRPC client
    endpoint grpc:Client libraryClient {
        target: "grpc://localhost:9090/library.LibraryService"
    };

    // Create a ListAvailableBooksRequest message
    ListAvailableBooksRequest listAvailableBooksRequest = {};

    // Make a gRPC call to list available books
    var availableBooksStream = check libraryClient->listAvailableBooks(listAvailableBooksRequest);

    // Iterate through the stream and display available books
    while (availableBooksStream.hasNext()) {
        Book availableBook = check availableBooksStream.next();
        io:println("Book ISBN: " + availableBook.isbn);
        io:println("Title: " + availableBook.title);
        io:println("Author: " + availableBook.author_1);
        io:println("Location: " + availableBook.location);
        io:println("Available: " + availableBook.isAvailable);
        io:println("------------------------------");
    }
}
