import ballerina/http;
import ballerina/log;
import graphql_schemas;
import performanceManagementService;

public function main() returns error? {
    // Start the Ballerina HTTP service
    http:Listener listener = new(8080);
    var serviceEndpoint = listener;
    check panic on performanceManagementService.bind(serviceEndpoint);
    log:print("Performance Management GraphQL service started successfully.");
}
