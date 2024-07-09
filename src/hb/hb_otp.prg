#pragma -w3

#include "hbclass.ch"

#define ALG_SHA1    0
#define ALG_SHA256  1
#define ALG_SHA512  2

class hb_OTP

    method OTP_HOTP(cKey as character,nDigits as numeric,nInterval as numeric,cDigest as character) as character
    method OTP_TOTP(cKey as character,nDigits as numeric,nInterval as numeric,cDigest as character) as character

    method OTP_STEAM_TOTP(cKey as character,nInterval as numeric) as character

endclass

method OTP_HOTP(cKey as character,nDigits as numeric,nInterval as numeric,cDigest as character) class hb_OTP

    local cToken as character
    local nDigest as numeric

    hb_default(@cDigest,"SHA1")

    switch cDigest
        case "SHA1"
            nDigest:=ALG_SHA1
            exit
        case "SHA256"
            nDigest:=ALG_SHA256
            exit
        case "SHA512"
            nDigest:=ALG_SHA512
            exit
        otherwise
            nDigest:=ALG_SHA1
    endswitch

    cToken:=OTP_HOTP(cKey,nDigits,nInterval,nDigest)

    return(cToken) as character

method OTP_TOTP(cKey as character,nDigits as numeric,nInterval as numeric,cDigest as character) class hb_OTP

    local cToken as character
    local nDigest as numeric

    hb_default(@cDigest,"SHA1")

    switch cDigest
        case "SHA1"
            nDigest:=ALG_SHA1
            exit
        case "SHA256"
            nDigest:=ALG_SHA256
            exit
        case "SHA512"
            nDigest:=ALG_SHA512
            exit
        otherwise
            nDigest:=ALG_SHA1
    endswitch

    cToken:=OTP_TOTP(cKey,nDigits,nInterval,nDigest)

    return(cToken) as character

method OTP_STEAM_TOTP(cKey as character,nInterval as numeric) class hb_OTP

    local cToken as character:=OTP_STEAM_TOTP(cKey,nInterval)

    return(cToken) as character

#pragma BEGINDUMP

#include "cotp.h"
#include "hbapi.h"
#include <time.h>

// Wrapper for get_hotp
HB_FUNC_STATIC( OTP_HOTP )
{
    const char *secret = hb_parc(1);
    int digits = hb_parni(2);
    long interval = time( NULL )/hb_parni(3);
    int algorithm = hb_parni(4);

    cotp_error_t err;
    char *hotp=get_hotp(secret,interval,digits,algorithm,&err);

    if (err != NO_ERROR)
    {
        // Handle the error appropriately, e.g., return a specific error message or code
        switch (err)
        {
            case VALID:
                hb_retc("Valid");
                break;
            case WCRYPT_VERSION_MISMATCH:
                hb_retc("Wcrypt version mismatch");
                break;
            case INVALID_B32_INPUT:
                hb_retc("Invalid base32 input");
                break;
            case INVALID_ALGO:
                hb_retc("Invalid algorithm");
                break;
            case INVALID_DIGITS:
                hb_retc("Invalid digits");
                break;
            case INVALID_PERIOD:
                hb_retc("Invalid period");
                break;
            case MEMORY_ALLOCATION_ERROR:
                hb_retc("Memory allocation error");
                break;
            case INVALID_USER_INPUT:
                hb_retc("Invalid user input");
                break;
            case EMPTY_STRING:
                hb_retc("Empty string");
                break;
            case MISSING_LEADING_ZERO:
                hb_retc("Missing leading zero");
                break;
            case INVALID_COUNTER:
                hb_retc("Invalid counter");
                break;
            case WHMAC_ERROR:
                hb_retc("WHMAC error");
                break;
            default:
                hb_retc("Unknown error");
                break;
        }
    }
    else
    {
        hb_retc(hotp);
    }

    // Free the allocated memory if not NULL
    if (hotp != NULL)
    {
        free(hotp);
    }

}

// Wrapper for get_totp
HB_FUNC_STATIC( OTP_TOTP )
{
    const char *secret = hb_parc(1);
    int digits = hb_parni(2);
    int interval = hb_parni(3);
    int algorithm = hb_parni(4);

    cotp_error_t err;
    char *totp=get_totp(secret,digits,interval,algorithm,&err);

    if (err != NO_ERROR)
    {
        // Handle the error appropriately, e.g., return a specific error message or code
        switch (err)
        {
            case VALID:
                hb_retc("Valid");
                break;
            case WCRYPT_VERSION_MISMATCH:
                hb_retc("Wcrypt version mismatch");
                break;
            case INVALID_B32_INPUT:
                hb_retc("Invalid base32 input");
                break;
            case INVALID_ALGO:
                hb_retc("Invalid algorithm");
                break;
            case INVALID_DIGITS:
                hb_retc("Invalid digits");
                break;
            case INVALID_PERIOD:
                hb_retc("Invalid period");
                break;
            case MEMORY_ALLOCATION_ERROR:
                hb_retc("Memory allocation error");
                break;
            case INVALID_USER_INPUT:
                hb_retc("Invalid user input");
                break;
            case EMPTY_STRING:
                hb_retc("Empty string");
                break;
            case MISSING_LEADING_ZERO:
                hb_retc("Missing leading zero");
                break;
            case INVALID_COUNTER:
                hb_retc("Invalid counter");
                break;
            case WHMAC_ERROR:
                hb_retc("WHMAC error");
                break;
            default:
                hb_retc("Unknown error");
                break;
        }
    }
    else
    {
        hb_retc(totp);
    }

    // Free the allocated memory if not NULL
    if (totp != NULL)
    {
        free(totp);
    }
}

// Wrapper for get_steam_totp
HB_FUNC_STATIC( OTP_STEAM_TOTP )
{
    const char *secret = hb_parc(1);
    int interval = hb_parni(2);

    cotp_error_t err;
    char *steam_totp=get_steam_totp(secret,interval,&err);

    if (err != NO_ERROR)
    {
        // Handle the error appropriately, e.g., return a specific error message or code
        switch (err)
        {
            case VALID:
                hb_retc("Valid");
                break;
            case WCRYPT_VERSION_MISMATCH:
                hb_retc("Wcrypt version mismatch");
                break;
            case INVALID_B32_INPUT:
                hb_retc("Invalid base32 input");
                break;
            case INVALID_ALGO:
                hb_retc("Invalid algorithm");
                break;
            case INVALID_DIGITS:
                hb_retc("Invalid digits");
                break;
            case INVALID_PERIOD:
                hb_retc("Invalid period");
                break;
            case MEMORY_ALLOCATION_ERROR:
                hb_retc("Memory allocation error");
                break;
            case INVALID_USER_INPUT:
                hb_retc("Invalid user input");
                break;
            case EMPTY_STRING:
                hb_retc("Empty string");
                break;
            case MISSING_LEADING_ZERO:
                hb_retc("Missing leading zero");
                break;
            case INVALID_COUNTER:
                hb_retc("Invalid counter");
                break;
            case WHMAC_ERROR:
                hb_retc("WHMAC error");
                break;
            default:
                hb_retc("Unknown error");
                break;
        }
    }
    else
    {
        hb_retc(steam_totp);
    }

    // Free the allocated memory if not NULL
    if (steam_totp != NULL)
    {
        free(steam_totp);
    }
}

#pragma ENDDUMP
