//Check: https://totp.danhersam.com/

#pragma -w3

REQUEST HB_CODEPAGE_UTF8EX

memvar GETLIST

procedure Main()

   local cSecretKey as character:="BACP5V6SVALB4HS7MYQEFNTRYEEDHLYE"  // Defina sua chave secreta

   local oHB_OTP as object:=hb_OTP():New()

   hb_cdpSelect("UTF8EX")

   ValidateTOTP(@oHB_OTP,cSecretKey as character)
   InKey(0)

   ValidateHOTP(@oHB_OTP,cSecretKey as character)
   InKey(0)

   ? "OTP_STEAM_TOTP : ", oHB_OTP:OTP_STEAM_TOTP(cSecretKey,30)

   return

static function ValidateTOTP(oHB_OTP,cSecretKey as character)

   local cTOTP as character
   local cUserInput as character:=SPACE(6) // Espaço para o usuário inserir o código 2FA
   local lValid as logical
   local nInterval as numeric:=30

   private GETLIST as array:=Array(0)

   CLS

   @ 10,10 SAY "Digite o código 2FA:" GET cUserInput
   READ

   cTOTP:=oHB_OTP:OTP_TOTP(cSecretKey,6,nInterval,"SHA1")

   if (lValid:=(cTOTP==cUserInput))
      ? "Código TOTP válido!", cTOTP
   else
      ? "Código TOTP inválido!", cTOTP
   endif

   return(lValid) as logical

static function ValidateHOTP(oHB_OTP,cSecretKey as character)

   local cHOTP as character
   local cUserInput as character:=SPACE(6) // Espaço para o usuário inserir o código 2FA
   local lValid as logical
   local nInterval as numeric:=30

   private GETLIST as array:=Array(0)

   CLS

   @ 10,10 SAY "Digite o código 2FA:" GET cUserInput
   READ

   cHOTP:=oHB_OTP:OTP_HOTP(cSecretKey,6,nInterval,"SHA1")

   if (lValid:=(cHOTP==cUserInput))
      ? "Código HOTP válido!", cHOTP
   else
      ? "Código HOTP inválido!", cHOTP
   endif

   return(lValid) as logical
