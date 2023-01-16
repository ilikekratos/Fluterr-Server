package com.example.orderrest3.services;

import com.example.orderrest3.dtos.OrderDto;

import java.util.List;

public interface OrdersService {
    OrderDto save(OrderDto order);
    void update(OrderDto order);
    void delete(Long id);
    List<OrderDto> findAll();
}
