package com.example.orderrest3.repositories;

import com.example.orderrest3.models.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrdersRepository extends JpaRepository<OrderEntity, Long> {
}
