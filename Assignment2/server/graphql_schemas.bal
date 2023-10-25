public const graphql:ObjectType User = {
    fields: {
        id: graphql:ID,
        firstName: graphql:String,
        lastName: graphql:String,
        jobTitle: graphql:String,
        position: graphql:String,
        role: graphql:String
    }
};

public const graphql:ObjectType KPI = {
    fields: {
        id: graphql:ID,
        name: graphql:String,
        value: graphql:Float
    }
};

public const graphql:ObjectType Objective = {
    fields: {
        id: graphql:ID,
        name: graphql:String,
        weightage: graphql:Float
    }
};

public const graphql:ObjectType Department = {
    fields: {
        id: graphql:ID,
        name: graphql:String,
        objectives: graphql:[graphql:ObjectType(Objective)]
    }
};
