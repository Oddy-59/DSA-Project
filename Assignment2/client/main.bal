import ballerina/http;
import ballerina/io;
import client_utils;

function main(string... args) returns error? {
    // Initialize client configurations
    client_utils:init();

    // Example: Making a GraphQL query to the server-side API
    var query = `{
        getUserById(id: "123") {
            id
            firstName
            lastName
            jobTitle
        }
    }`;

    // Sending an HTTP request to the server
    var response = check sendHttpRequest("http://localhost:8080/graphql", query);

    // Handling the response
    match response {

        http:Response resp => {

            // Handling a successful response
            if (resp.statusCode == 200) {

                // Parse the JSON response
                json data = check resp.getJsonPayload();
                
                // Extract data from the response
                string userId = data.id.toString();
                string firstName = data.firstName.toString();
                string lastName = data.lastName.toString();
                string jobTitle = data.jobTitle.toString();
                
                // Process the extracted data
                io:println("User ID: " + userId);
                io:println("First Name: " + firstName);
                io:println("Last Name: " + lastName);
                io:println("Job Title: " + jobTitle);
            } else {
                // Handling non-200 status codes
                io:println("Unexpected Status Code: " + resp.statusCode.toString());
            }
        }
        error err => {
            // Handling errors in the response
            io:println("Error occurred: " + err.message());
        }
    }
}
