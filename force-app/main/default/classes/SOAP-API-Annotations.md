# APEX SOAP Web Services

- We can expose Apex classes and methods to External Applications through the SOAP web service 
- WebService keyword is used for this purpose.

### Exposing Data with Webservice Methods

- Invoking a custom webservice method always uses system context == Any user who has access to these methods can use their full power, regardless of permissions, field-level security, or sharing rules.
- APEX Classes: To enforce sharing rules, declare the class that contains these methods with the with sharing keyword.

### Considerations for Using the webservice Keyword

- You cannot use the webservice keyword in a trigger.
- All classes that contain methods defined with the webservice keyword must be declared as global
- Define any method that uses the webservice keyword as static
- SOAP and WSDL do not provide good support for overloading methods.
- Apex does not allow two methods marked with the webservice keyword to have the same name. 
- Web service methods that have the same name in the same class generate a compile-time error.
- Because there are no SOAP analogs for certain Apex elements, methods defined with the webservice keyword cannot take the following elements as parameters. While these elements can be used within the method, they also cannot be marked as return values.
    - Maps, Sets, Pattern objects, Matcher objects, Exception object