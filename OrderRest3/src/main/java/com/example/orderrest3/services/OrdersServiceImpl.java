package com.example.orderrest3.services;

import com.example.orderrest3.dtos.OrderDto;
import com.example.orderrest3.models.OrderEntity;
import com.example.orderrest3.repositories.OrdersRepository;
import jakarta.validation.Valid;
import org.aspectj.weaver.ast.Or;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Service
public class OrdersServiceImpl implements OrdersService{
    Logger logger = LoggerFactory.getLogger(OrdersServiceImpl.class);

    @Autowired
    private OrdersRepository ordersRepository;

    @Override
    public OrderDto save(OrderDto order) {
        OrderEntity orderEntity = new OrderEntity(
                order.getProducts(),
                order.getAdress(),
                order.getPhone()
        );
        try {
            OrderEntity createdOrder = ordersRepository.save(orderEntity);
            OrderDto createdOrderDto = new OrderDto(
                    createdOrder.getProducts(),
                    createdOrder.getPhone(),
                    createdOrder.getAdress()

            );
            createdOrderDto.setId(createdOrder.getId());
            return createdOrderDto;
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }
    }

    @Override
    @Transactional
    public void update(OrderDto order) {
        try {
            ordersRepository.findById(order.getId())
                    .ifPresent(entity -> {
                        entity.setProducts(order.getProducts());
                        entity.setAdress(order.getAdress());
                        entity.setPhone(order.getPhone());
                    });
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }

    }

    @Override
    public void delete(Long id) {
        try {
            ordersRepository.deleteById(id);
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }
    }

    @Override
    public List<OrderDto> findAll() {
        try {
            return ordersRepository.findAll().stream()
                    .map(item -> {
                        OrderDto comp = new OrderDto(
                                item.getProducts(),
                                item.getPhone(),
                                item.getAdress()

                        );
                        comp.setId(item.getId());
                        return comp;
                    }).toList();
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }
    }
}
