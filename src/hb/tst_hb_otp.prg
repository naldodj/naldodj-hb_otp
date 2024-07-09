//VALID: https://totp.danhersam.com/
//openssl
//hbmk2 tst_hb_otp.prg hb_base32.prg hb_otp.prg ./naldodj-libcotp/src/utils/base32.c ./naldodj-libcotp/src/utils/whmac_openssl.c ./naldodj-libcotp/src/otp.c -lhbmisc -lhbnf -lhbct -lssl -lcrypto -lm -cflag=-Wall -cflag=-Wextra -cflag=-O3 -cflag=-Wformat=2 -cflag=-Wmissing-format-attribute -cflag=-fstack-protector-strong -cflag=-Wundef -cflag=-Wmissing-format-attribute -cflag=-fdiagnostics-color=always -cflag=-Wstrict-prototypes -cflag=-Wunreachable-code -cflag=-Wchar-subscripts -cflag=-Wwrite-strings -cflag=-Wpointer-arith -cflag=-Wbad-function-cast -cflag=-Wcast-align -cflag=-Werror=format-security -cflag=-Werror=implicit-function-declaration -cflag=-Wno-sign-compare -cflag=-Wno-format-nonliteral -cflag=-U_FORTIFY_SOURCE -cflag=-D_FORTIFY_SOURCE=3 -L/mnt/f/tmp/ttop/naldodj-libcotp/build
//hbmk2 tst_hb_otp.prg hb_base32.prg hb_otp.prg -lhbmisc -lhbnf -lhbct -lssl -lcrypto -lm -cflag=-Wall -cflag=-Wextra -cflag=-O3 -cflag=-Wformat=2 -cflag=-Wmissing-format-attribute -cflag=-fstack-protector-strong -cflag=-Wundef -cflag=-Wmissing-format-attribute -cflag=-fdiagnostics-color=always -cflag=-Wstrict-prototypes -cflag=-Wunreachable-code -cflag=-Wchar-subscripts -cflag=-Wwrite-strings -cflag=-Wpointer-arith -cflag=-Wbad-function-cast -cflag=-Wcast-align -cflag=-Werror=format-security -cflag=-Werror=implicit-function-declaration -cflag=-Wno-sign-compare -cflag=-Wno-format-nonliteral -cflag=-U_FORTIFY_SOURCE -cflag=-D_FORTIFY_SOURCE=3 -L/mnt/f/tmp/ttop/naldodj-libcotp/build -prgflag=-DHB_USE_INCLUDE_OPENSSL -cflag=-DHB_USE_INCLUDE_OPENSSL
//gcrypt
//hbmk2 tst_hb_otp.prg hb_base32.prg hb_otp.prg ./naldodj-libcotp/src/utils/base32.c ./naldodj-libcotp/src/utils/whmac_gcrypt.c ./naldodj-libcotp/src/otp.c -lhbmisc -lhbnf -lhbct -lssl -lcrypto -lm -lgcrypt -cflag=-Wall -cflag=-Wextra -cflag=-O3 -cflag=-Wformat=2 -cflag=-Wmissing-format-attribute -cflag=-fstack-protector-strong -cflag=-Wundef -cflag=-Wmissing-format-attribute -cflag=-fdiagnostics-color=always -cflag=-Wstrict-prototypes -cflag=-Wunreachable-code -cflag=-Wchar-subscripts -cflag=-Wwrite-strings -cflag=-Wpointer-arith -cflag=-Wbad-function-cast -cflag=-Wcast-align -cflag=-Werror=format-security -cflag=-Werror=implicit-function-declaration -cflag=-Wno-sign-compare -cflag=-Wno-format-nonliteral -cflag=-U_FORTIFY_SOURCE -cflag=-D_FORTIFY_SOURCE=3 -L/mnt/f/tmp/ttop/naldodj-libcotp/build
//hbmk2 tst_hb_otp.prg hb_base32.prg hb_otp.prg -lhbmisc -lhbnf -lhbct -lssl -lcrypto -lm -lgcrypt -cflag=-Wall -cflag=-Wextra -cflag=-O3 -cflag=-Wformat=2 -cflag=-Wmissing-format-attribute -cflag=-fstack-protector-strong -cflag=-Wundef -cflag=-Wmissing-format-attribute -cflag=-fdiagnostics-color=always -cflag=-Wstrict-prototypes -cflag=-Wunreachable-code -cflag=-Wchar-subscripts -cflag=-Wwrite-strings -cflag=-Wpointer-arith -cflag=-Wbad-function-cast -cflag=-Wcast-align -cflag=-Werror=format-security -cflag=-Werror=implicit-function-declaration -cflag=-Wno-sign-compare -cflag=-Wno-format-nonliteral -cflag=-U_FORTIFY_SOURCE -cflag=-D_FORTIFY_SOURCE=3 -L/mnt/f/tmp/ttop/naldodj-libcotp/build -prgflag=-DHB_USE_INCLUDE_GCRYPT

#pragma -w3

REQUEST HB_CODEPAGE_UTF8EX

memvar GETLIST

procedure Main()

   local cSecretKey as character:="BACP5V6SVALB4HS7MYQEFNTRYEEDHLYE"  // Defina sua chave secreta
   local cUserInput as character:=SPACE(6)  // Espaço para o usuário inserir o código 2FA

   private GETLIST as array:=Array(0)

   hb_cdpSelect("UTF8EX")

   CLS

   @ 10,10 SAY "Digite o código 2FA:" GET cUserInput
   READ

   if (ValidateOPT(cSecretKey,cUserInput))
      ? "Código 2FA válido!"
   else
      ? "Código 2FA inválido!"
   endif

   return

static function ValidateOPT(cSecretKey as character,cUserInput as character)

   local oHB_OTP as object
   local cHTop as character
   local lValid as logical
   local nInterval as numeric:=30

   oHB_OTP:=hb_OTP():New()

   ? cHTop:=oHB_OTP:OTP_TOTP(cSecretKey,6,nInterval,"SHA1")

   ? oHB_OTP:OTP_HOTP(cSecretKey,6,nInterval,"SHA1")

   lValid:=(cHTop==cUserInput)

   return(lValid) as logical