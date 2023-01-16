package com.example.orderrest3.rest;

import com.example.orderrest3.dtos.OrderDto;
import com.example.orderrest3.services.OrdersService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrderRestController {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private OrdersService ordersService;

    @GetMapping
    public ResponseEntity<List<OrderDto>> findAll() {
        logger.info("Entered: GET /orders");
        return ResponseEntity.ok(ordersService.findAll());
    }

    @PostMapping
    public ResponseEntity<OrderDto> save(@Valid @RequestBody OrderDto order) {
        logger.info("Entered: POST /orders with params: " + order.toString());
        return ResponseEntity.ok(ordersService.save(order));
    }

    @PutMapping
    public ResponseEntity<?> update(@Valid @RequestBody OrderDto order) {
        logger.info("Entered: PUT /orders with params: " + order.toString());
        ordersService.update(order);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable("id") Long id) {
        logger.info("Entered: DELETE /orders with params: " + id.toString());
        ordersService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}