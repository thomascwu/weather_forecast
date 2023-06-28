# Ruby on Rails App for Weather Forecast

# Mac OS

This app is developed on a MacBook Air with macOS Ventura 13.4.1

# Ruby & Rails

I use the latest versions of ruby & rails:

* ruby: 3.2.2

* rails: 7.0.5.1

# Unit Tests

* I follow the TDD to start with writing the tests for the controller and the services

# Comments/Documentation

* Comments in details are within the codes

* I provide the specific instructions within the service classes codes on how to make the successful API calls with valid credentials

* I also provide the details below related to the topics such as decomposition, scalability, etc in this document

# Decomposition

Objects in this app are:

* A Rails service class AddressGeocodeService to convert the input address to its corresponding geocodes for the weather forecast API call

* A Rails service class WeatherForecastService to make the API call to return the weather forecase details based on the geocodes of the input address

* A Controller class WeatherForecastsController to return the weather forecast data based on the address which will be cached based on the zip codes

* A UI view file to display the weather forecase details and a partial Flash page to display any error messages

# Design Patterns

* I create two Rails services mentioned above to be called by the controller to support the loose coupling and scalability

# Scalability Considerations

* The services are inherently scalable

* The cache is also good to support the scalability

# Naming Conventions

* I follow the standard and descriptive naming conventions

# Encapsulation

* Every method is just doing its own thing!

# Code Re-Use

* The Rails service classes are good candidates for code reusing

# UI Views

* I create a basic UI view to display the weather forecase details and could be more fancier.

