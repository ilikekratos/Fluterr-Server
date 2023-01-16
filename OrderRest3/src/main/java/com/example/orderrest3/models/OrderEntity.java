package com.example.orderrest3.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class OrderEntity extends BaseEntity<Long> {

    @Column
    @NotNull
    @Size(min = 1)
    private String products;

    @Column
    @NotNull
    @Size(min = 1)
    private String adress;

    @Column
    @NotNull
    @Size(min = 1)
    private String phone;
}
