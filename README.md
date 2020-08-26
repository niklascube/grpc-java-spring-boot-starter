# gRPC Java Spring Boot Starter Application

This project gives you a quick start in building gRPC Services with built-in integration tests.

Clone and initialize me
   ```
    $> git clone 
    $> cd grpc-java-spring-boot-starter
    $> ./init_app.sh`
   ```

init_app.sh will initialize app. It will rename all files, folders and strings  
to your name which you have to enter after executing init_app.sh.  
Build the project in order to generate the Java-classes out of your proto file.  
Then you able to run your project ;-)  

HAPPY CODING!

**How to add a new gRPC Service endpoint?**  
First of all, get familiar with protobuf-files and adjust the proto to your needs.  
One gRPC service endpoint 'hello' is already implemented which can be used as a template.  
Just duplicate it and change the names of every request-object, response-observer, service and method names.  
Just have in mind, that your service and method name *must* match your protobuf definition.  

The [gRPC Spring Starter Server Package](https://github.com/LogNet/grpc-spring-boot-starter/tree/master/grpc-spring-boot-starter) by LogNet
is used as server base.  

If you want to test your gRPC service, have a look at [BloomRPC](https://github.com/uw-labs/bloomrpc) or [grpcurl](https://github.com/fullstorydev/grpcurl).