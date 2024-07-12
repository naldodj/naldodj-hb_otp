/*
 * Harbour 3.2.0dev (r2307062207)
 * GNU C 9.4 (64-bit)
 * Generated C source from "./hb_otp.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( HB_OTP );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( HBOBJECT );
HB_FUNC_STATIC( HB_OTP_OTP_HOTP );
HB_FUNC_STATIC( HB_OTP_OTP_TOTP );
HB_FUNC_STATIC( HB_OTP_OTP_STEAM_TOTP );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_EXTERN( HB_DEFAULT );
HB_FUNC_STATIC( OTP_HOTP );
HB_FUNC_STATIC( OTP_TOTP );
HB_FUNC_STATIC( OTP_STEAM_TOTP );
HB_FUNC_INITSTATICS();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_HB_OTP )
{ "HB_OTP", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_OTP )}, NULL },
{ "__CLSLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSLOCKDEF )}, NULL },
{ "NEW", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HBCLASS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBCLASS )}, NULL },
{ "HBOBJECT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBOBJECT )}, NULL },
{ "ADDMETHOD", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HB_OTP_OTP_HOTP", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_OTP_OTP_HOTP )}, NULL },
{ "HB_OTP_OTP_TOTP", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_OTP_OTP_TOTP )}, NULL },
{ "HB_OTP_OTP_STEAM_TOTP", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_OTP_OTP_STEAM_TOTP )}, NULL },
{ "CREATE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__CLSUNLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSUNLOCKDEF )}, NULL },
{ "INSTANCE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__OBJHASMSG", {HB_FS_PUBLIC}, {HB_FUNCNAME( __OBJHASMSG )}, NULL },
{ "INITCLASS", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HB_DEFAULT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_DEFAULT )}, NULL },
{ "OTP_HOTP", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( OTP_HOTP )}, NULL },
{ "OTP_TOTP", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( OTP_TOTP )}, NULL },
{ "OTP_STEAM_TOTP", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( OTP_STEAM_TOTP )}, NULL },
{ "(_INITSTATICS00001)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITSTATICS}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_HB_OTP, "./hb_otp.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_HB_OTP
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_HB_OTP )
   #include "hbiniseg.h"
#endif

HB_FUNC( HB_OTP )
{
	static const HB_BYTE pcode[] =
	{
		149,3,0,116,18,0,36,9,0,103,1,0,100,8,
		29,221,0,176,1,0,104,1,0,12,1,29,210,0,
		166,148,0,0,122,80,1,48,2,0,176,3,0,12,
		0,106,7,104,98,95,79,84,80,0,108,4,4,1,
		0,108,0,112,3,80,2,36,11,0,48,5,0,95,
		2,106,9,79,84,80,95,72,79,84,80,0,108,6,
		95,1,121,72,121,72,121,72,112,3,73,36,12,0,
		48,5,0,95,2,106,9,79,84,80,95,84,79,84,
		80,0,108,7,95,1,121,72,121,72,121,72,112,3,
		73,36,14,0,48,5,0,95,2,106,15,79,84,80,
		95,83,84,69,65,77,95,84,79,84,80,0,108,8,
		95,1,121,72,121,72,121,72,112,3,73,36,16,0,
		48,9,0,95,2,112,0,73,167,14,0,0,176,10,
		0,104,1,0,95,2,20,2,168,48,11,0,95,2,
		112,0,80,3,176,12,0,95,3,106,10,73,110,105,
		116,67,108,97,115,115,0,12,2,28,12,48,13,0,
		95,3,164,146,1,0,73,95,3,110,7,48,11,0,
		103,1,0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_OTP_OTP_HOTP )
{
	static const HB_BYTE pcode[] =
	{
		13,2,4,36,23,0,176,14,0,96,4,0,106,5,
		83,72,65,49,0,20,2,36,25,0,25,35,36,27,
		0,121,80,6,25,66,36,30,0,122,80,6,25,58,
		36,33,0,92,2,80,6,25,49,36,36,0,121,80,
		6,25,41,95,4,133,4,0,106,5,83,72,65,49,
		0,25,211,106,7,83,72,65,50,53,54,0,25,208,
		106,7,83,72,65,53,49,50,0,25,205,100,25,211,
		36,39,0,176,15,0,95,1,95,2,95,3,95,6,
		12,4,80,5,36,41,0,95,5,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_OTP_OTP_TOTP )
{
	static const HB_BYTE pcode[] =
	{
		13,2,4,36,48,0,176,14,0,96,4,0,106,5,
		83,72,65,49,0,20,2,36,50,0,25,35,36,52,
		0,121,80,6,25,66,36,55,0,122,80,6,25,58,
		36,58,0,92,2,80,6,25,49,36,61,0,121,80,
		6,25,41,95,4,133,4,0,106,5,83,72,65,49,
		0,25,211,106,7,83,72,65,50,53,54,0,25,208,
		106,7,83,72,65,53,49,50,0,25,205,100,25,211,
		36,64,0,176,16,0,95,1,95,2,95,3,95,6,
		12,4,80,5,36,66,0,95,5,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_OTP_OTP_STEAM_TOTP )
{
	static const HB_BYTE pcode[] =
	{
		13,1,2,36,70,0,176,17,0,95,1,95,2,12,
		2,80,3,36,72,0,95,3,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,18,0,1,0,7
	};

	hb_vmExecute( pcode, symbols );
}

#line 75 "./hb_otp.prg"

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

