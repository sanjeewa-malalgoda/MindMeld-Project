import ballerinax/github;
import ballerina/http;

configurable string conf = ?;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating toprated repos
    # + organizationName - the input string name
    # + limitNumber - limit of results
    # + return - string name with hello message or error
    resource function get ratings(string organizationName, int limitNumber) returns string|error {
        // Send a response back to the caller.
        //var variable = conf;
        if organizationName is "" {
            return error("Organization name should not be empty!");
        }
        github:Client githubEp = check new (config = {
            auth: {
                token: conf
            }
        });

        //stream<github:Repository, error?> getRepositoriesResponse = check githubEp->getRepositories();
        stream<github:Repository, github:Error?> orgReposStream = check githubEp->getRepositories(organizationName, true);
        string[]? topRatedRepos = check from var repo in orgReposStream
            order by repo.stargazerCount descending
            limit limitNumber
            select repo.name;
        return "Top rates repos are, " + topRatedRepos.toString();
    }
}
