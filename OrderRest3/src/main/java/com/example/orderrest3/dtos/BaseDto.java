package com.example.orderrest3.dtos;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BaseDto<ID> {
    ID id;
}
