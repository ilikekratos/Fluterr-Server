package com.example.orderrest3.dtos;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrderDto extends BaseDto<Long> {

    @NotNull
    @Size(min = 1)
    private String products;

    @NotNull
    @Size(min = 1)
    private String phone;

    @NotNull
    @Size(min = 1)
    private String adress;
}
