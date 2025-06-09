package com.eazybytes.accounts.controller;

import com.eazybytes.accounts.dto.CustomerDetailsDto;
import com.eazybytes.accounts.service.ICustomersService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.Pattern;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


@Tag(
        name="CRUD RestAPIs for Customer  in Eazybank",
        description="CRUD REST APIs in Eazy bank to  FETCH customer details"
)
@RequestMapping(path = "/api", produces = {MediaType.APPLICATION_JSON_VALUE})
@Validated
@RestController
public class CustomerController {

    private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

    private final ICustomersService iCustomersService;

    public CustomerController(ICustomersService iCustomersService) {
        this.iCustomersService = iCustomersService;
    }

    @GetMapping("/fetchCustomerDetails")
    public ResponseEntity<CustomerDetailsDto> fetchCustomerDetails(@RequestHeader("eazybank-correlation-id") String correlationId,
                                                                   @RequestParam
                                                                 @Pattern(regexp="(^$|[0-9]{10})", message="Mobile number must be 10 digits")
                                                                   String mobileNumber){

        logger.debug("EazyBank-correlation-id found: {}", correlationId);
        CustomerDetailsDto customerDetailsDto = iCustomersService.fetchCustomerDetails(mobileNumber, correlationId);

        return ResponseEntity.status(HttpStatus.OK).body(customerDetailsDto);
    }

}
