import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get ratings(int count = 10, string organization = "wso2") returns string|error {
        // Send a response back to the caller.
        if organization is "" {
            return error("name should not be empty!");
        }
        return "Repo Names, " + organization;
    }
}
