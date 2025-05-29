package com.eazybytes.accounts.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Schema(
        name = "Accounts",
        description = "Schema to hold Account information"
)
@Data
public class AccountsDto {
    @NotEmpty(message="AccountNumber cannot be a null or empty")
    @Schema(
            description = "Account Number of Eazy Bank account", example = "3454433243"
    )
    @Pattern(regexp="(^$|[0-9]{10})", message="Mobile number must be 10 digits")
    private Long accountNumber;

    @Schema(
            description = "Account type of Eazy Bank account", example = "Savings"
    )
    @NotEmpty(message="Account Type cannot be a null or empty")
    private String accountType;

    @Schema(
            description = "Eazy Bank branch address", example = "123 NewYork"
    )
    @NotEmpty(message="Branch Address cannot be a null or empty")
    private String branchAddress;
}
