import ballerina/http;
import ballerina/graphql;
import ballerina/log;

// Sample in-memory data store for users, departments, and KPIs
map<json> usersDB = {};
map<json> departmentsDB = {};
map<json> kpisDB = {};

graphql:Service performanceManagementService on new http:Listener(8080) {

    // Implement GraphQL query resolvers
    getUserById(id string) returns graphql:User|error {
        json? userJson = usersDB[id];
        if (userJson != null) {
            graphql:User user = check <graphql:User>userJson;
            return user;
        }
        return error("User not found");
    }

    getDepartmentById(id string) returns graphql:Department|error {
        json? departmentJson = departmentsDB[id];
        if (departmentJson != null) {
            graphql:Department department = check <graphql:Department>departmentJson;
            return department;
        }
        return error("Department not found");
    }

    // Implement GraphQL mutation resolvers
    createUser(user graphql:UserInput) returns graphql:User|error {
        string userId = user.id;
        usersDB[userId] = user.toJson();
        return user;
    }

    createKPI(kpi graphql:KPIInput) returns graphql:KPI|error {
        string kpiId = kpi.id;
        kpisDB[kpiId] = kpi.toJson();
        return kpi;
    }
}