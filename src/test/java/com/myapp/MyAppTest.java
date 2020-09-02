package com.myapp;

import grpc.MyApp;
import grpc.helloGrpc;
import io.grpc.internal.testing.StreamRecorder;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.concurrent.TimeUnit;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(classes = {MyAppApplication.class})
public class MyAppTest {

    @Autowired
    private helloGrpc.helloImplBase myService;

    @Test
    void testSayHello() throws Exception {
        MyApp.HelloRequest request = MyApp.HelloRequest.newBuilder()
                .setMessage("Are you alive?")
                .build();
        StreamRecorder<MyApp.HelloResponse> responseObserver = StreamRecorder.create();
        myService.getHello(request, responseObserver);
        if (!responseObserver.awaitCompletion(5, TimeUnit.SECONDS)) {
            fail("The call did not terminate in time");
        }
        assertNull(responseObserver.getError());
        List<MyApp.HelloResponse> results = responseObserver.getValues();
        assertEquals(1, results.size());
        MyApp.HelloResponse response = results.get(0);
        assertEquals(MyApp.HelloResponse.newBuilder()
                .setMessage("Hello, I'm alive")
                .build(), response);
    }

}