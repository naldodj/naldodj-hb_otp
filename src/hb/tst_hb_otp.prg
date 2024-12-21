//Check: https://totp.danhersam.com/

#pragma -w3

REQUEST HB_CODEPAGE_UTF8EX

memvar GETLIST

#include "hbver.ch"

procedure Main(...)

   local aArgs as array:=hb_AParams()

   local cParam as character
   local cDigest as character
   local cArgName as character
   local cSecretKey as character

   local idx as numeric
   local nDigits as numeric
   local nInterval as numeric

   local oHB_OTP as object

   hb_cdpSelect("UTF8EX")

   if (;
         (Empty(aArgs));
         .or.;
         Lower(aArgs[1])=="-h";
         .or.;
         Lower(aArgs[1])=="--help";
   )
      ShowHelp(nil,aArgs)
      return
   endif

   for each cParam in aArgs

      if (!Empty(cParam))

         if ((idx:=At("=",cParam))==0)
            cArgName:=Lower(cParam)
            cParam:=""
         else
            cArgName:=Left(cParam,idx-1)
            cParam:=SubStr(cParam,idx+1)
         endif

         do case
            case (cArgName=="-k")
               cSecretKey:=cParam
               if (empty(cSecretKey))
                  ShowHelp("Attention: The secret key is missing!")
                  return
               endif
            case (cArgName=="-s")
               nDigits:=val(cParam)
            case (cArgName=="-i")
               nInterval:=val(cParam)
            case (cArgName=="-d")
               cDigest:=Upper(allTrim(cParam))
            otherwise
               ShowHelp("Unrecognized option:"+cArgName+iif(Len(cParam)>0,"="+cParam,""))
               return
         endcase
      endif
   next each

  if (empty(cSecretKey))
      ShowHelp("Attention: The secret key is missing!")
      return
   endif

   hb_default(@nDigits,6)
   hb_default(@nInterval,30)
   hb_default(@cDigest,"SHA1")

   oHB_OTP:=hb_OTP():New()
   ValidateTOTP(@oHB_OTP,cSecretKey,nDigits,nInterval,cDigest)
   InKey(0)

   ValidateHOTP(@oHB_OTP,cSecretKey,nDigits,nInterval,cDigest)
   InKey(0)

   ? "OTP_STEAM_TOTP : ", oHB_OTP:OTP_STEAM_TOTP(cSecretKey,nInterval)

   return

static function ValidateTOTP(oHB_OTP as object,cSecretKey as character,nDigits as numeric,nInterval as numeric,cDigest as character)

   local cTOTP as character
   local cUserInput as character:=Space(6)

   local lValid as logical

   private GETLIST as array:=Array(0)

   CLS

   @ 10,10 SAY "Digite o código 2FA:" GET cUserInput
   READ

   cTOTP:=oHB_OTP:OTP_TOTP(cSecretKey,nDigits,nInterval,cDigest)

   if (lValid:=(cTOTP==cUserInput))
      ? "Código TOTP válido!", cTOTP
   else
      ? "Código TOTP inválido!", cTOTP
   endif

   return(lValid) as logical

static function ValidateHOTP(oHB_OTP as object,cSecretKey as character,nDigits as numeric,nInterval as numeric,cDigest as character)

   local cHOTP as character
   local cUserInput as character:=Space(6)

   local lValid as logical

   private GETLIST as array:=Array(0)

   CLS

   @ 10,10 SAY "Digite o código 2FA:" GET cUserInput
   READ

   cHOTP:=oHB_OTP:OTP_HOTP(cSecretKey,nDigits,nInterval,cDigest)

   if (lValid:=(cHOTP==cUserInput))
      ? "Código HOTP válido!", cHOTP
   else
      ? "Código HOTP inválido!", cHOTP
   endif

   return(lValid) as logical

static procedure ShowSubHelp(xLine as anytype,/*@*/nMode as numeric,nIndent as numeric,n as numeric)

   DO CASE
      CASE xLine == NIL
      CASE HB_ISNUMERIC( xLine )
         nMode := xLine
      CASE HB_ISEVALITEM( xLine )
         Eval( xLine )
      CASE HB_ISARRAY( xLine )
         IF nMode == 2
            OutStd( Space( nIndent ) + Space( 2 ) )
         ENDIF
         AEval( xLine, {| x, n | ShowSubHelp( x, @nMode, nIndent + 2, n ) } )
         IF nMode == 2
            OutStd( hb_eol() )
         ENDIF
      OTHERWISE
         DO CASE
            CASE nMode == 1 ; OutStd( Space( nIndent ) + xLine + hb_eol() )
            CASE nMode == 2 ; OutStd( iif( n > 1, ", ", "" ) + xLine )
            OTHERWISE       ; OutStd( "(" + hb_ntos( nMode ) + ") " + xLine + hb_eol() )
         ENDCASE
   ENDCASE

   RETURN

static function HBRawVersion()
   return(;
       hb_StrFormat( "%d.%d.%d%s (%s) (%s)";
      ,hb_Version(HB_VERSION_MAJOR);
      ,hb_Version(HB_VERSION_MINOR);
      ,hb_Version(HB_VERSION_RELEASE);
      ,hb_Version(HB_VERSION_STATUS);
      ,hb_Version(HB_VERSION_ID);
      ,"20"+Transform(hb_Version(HB_VERSION_REVISION),"99-99-99 99:99"));
   ) as character

static procedure ShowHelp(cExtraMessage as character,aArgs as array)

   local aHelp as array
   local nMode as numeric:=1

   if (Empty(aArgs).or.(Len(aArgs)<=1).or.(Empty(aArgs[1])))
      aHelp:={;
         cExtraMessage;
         ,"HB_OTP Test ("+ExeName()+") "+HBRawVersion();
         ,"Copyright (c) 2024-"+hb_NToS(Year(Date()))+", "+hb_Version(HB_VERSION_URL_BASE);
         ,"";
         ,"Syntax:";
         ,"";
         ,{ExeName()+" [options]"};
         ,"";
         ,"Options:";
         ,{;
             "-h or --help       Show this help screen";
            ,"-k=<Secret Key>    Specify the secret key";
            ,"-s=<digits>        Specify the number of digits in the 2FA code";
            ,"-i=<interval>      Specify the interval, in seconds, for 2FA code generation";
            ,"-d=<digest>        Specify the digest algorithm to use for generating the 2FA code: SHA1, SHA256, SHA512";
         };
         ,"";
      }
   else
      ShowHelp("Unrecognized help option")
      return
   endif

   /* using hbmk2 style */
   aEval(aHelp,{|x|ShowSubHelp(x,@nMode,0)})

   return