# APEX REST API

- We can expose Apex classes and methods to External Applications through the REST Architecture 
- @RestResource annotation is used for this purpose.

### There are the classes containing methods and properties we use with Apex REST

- RestContext Class: contains the RestRequest and RestResponse object
- Request: use the System.RestRequest class to access and pass request data in a RESTful Apex method
- Response: represents an object used to pass data from Apex RESTfull Web Service method to and HTTP response.

### Governor Limits

- Call to Apex REST classes count against the organizations API governor limits. 
- All standard governor limits apply to Apex REST classes.
- Maximum request or response size, 6MB synchrounous or 12MB for assyncronous Apex.

### Authentication

- Apex REST supports theses auth mechanisms: OAuth 2.0 or Session ID.

### Annotations
- To use these annotations, your Apex method must be defined as global static.

- @ReadOnly
- @RestResource (urlMapping='/yourURL'):  
    - Is used at the class level and enables you to expose an Apex class as a REST resource.
    - URL Mapping:
        - Is relative to: https://instance.salesforce.com/services/apexrest/
        - Is case-sensitive my_url and != My_Url
    - URL Path mappings:
        - Must begin with a forward slash (/)
        - Can be up to 255 characters long
        - 
- @HttpDelete: delete the specified resource
- @HttpGet: returns the specified resource
- @HttpPatch: updates the specified resource.
- @HttpPost: creates a new resource.
- @HttpPut: creates or updates the specified resource.

### Methods

- Apex REST supports two formats of representations of resources: JSON and XML.

- JSON format is passed by default in the body if a request or response, and the format is indicated by the Content-Type property in the HTTP header.

- Returns and Parameters allowed: Apex Primitives (excluding sObjects and Blob), sObjects, Lists or Maps of Apex Primitives or sObjects(only maps with String key are supported)

- Apex REST doesn’t support XML serialization and deserialization of Connect in Apex objects

- Apex REST does support JSON serialization and deserialization of Connect in Apex objects.

- @HttpGet or @HttpDelete must have no parameters, because GET and DELETE requests have no request body, so there's nothing to deserialize.

-  @ReadOnly annotation supports the Apex REST annotations for all the HTTP requests: @HttpDelete, @HttpGet, @HttpPatch, @HttpPost, and @HttpPut.

- A single Apex class annotated with @RestResource can't have multiple methods annotated with the same HTTP request method.

### Exposing Data with Apex REST Web Service Methods

- Invoking a custom Apex REST Web service method always uses system context ==  any user who has access to these methods can use their full power, regardless of permissions, field-level security, or sharing rules.

- Apex class methods that are exposed through the Apex REST API don't enforce object permissions and field-level security by default.

-SOQL: To enforce object or field-level security while using SOQL SELECT statements in Apex, use the WITH SECURITY_ENFORCED clause.

- DML: You can strip user-inaccessible fields from query and subquery results, or remove inaccessible sObject fields before DML operations, by using the Security.stripInaccessible method. 

- APEX Classes: To enforce sharing rules for Apex REST API methods, declare the class that contains these methods with the with sharing keyword.