import ballerinax/github;
import ballerina/http;
import ballerina/log;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get ratings(int count = 10, string organization = "wso2") returns string|error {
        // Send a response back to the caller.
        if organization is "" {
            github:Client githubEp = check new (config = {
                auth: {
                    token: "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"
                }
            });
            stream<github:Repository, error?> getRepositoriesResponse = check githubEp->getRepositories();
            //return error("name should not be empty!");
            log:printInfo(check getRepositoriesResponse.toString());
        }
        return "Repo Names, " + organization;
    }
}
