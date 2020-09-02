package com.myapp;

import grpc.MyApp;
import grpc.helloGrpc;
import io.grpc.stub.StreamObserver;
import org.lognet.springboot.grpc.GRpcService;


@GRpcService
public class HelloService extends helloGrpc.helloImplBase {

    @Override
    public void getHello(MyApp.HelloRequest request, StreamObserver<MyApp.HelloResponse> responseObserver) {
        MyApp.HelloResponse.Builder replyBuilder = MyApp.HelloResponse.newBuilder();
        replyBuilder.setMessage("Hello, I'm alive");

        responseObserver.onNext(replyBuilder.build());
        responseObserver.onCompleted();
    }

}