#pragma -w3

REQUEST HB_CODEPAGE_UTF8EX

memvar GETLIST

#include "hbver.ch"

procedure Main(...)

   local aArgs as array:=hb_AParams()

   local cKey as character
   local cType as character
   local cParam as character
   local cDigest as character
   local cArgName as character
   local c2FACode as character:=""

   local idx as numeric
   local nDigits as numeric
   local nInterval as numeric

   local oHB_OTP as object

   hb_cdpSelect("UTF8EX")

   begin sequence

      if (;
            (Empty(aArgs));
            .or.;
            Lower(aArgs[1])=="-h";
            .or.;
            Lower(aArgs[1])=="--help";
      )
         ShowHelp(nil,aArgs)
         break
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
                  cKey:=cParam
                  if (empty(cKey))
                     ShowHelp("Attention: The secret key is missing!")
                     break
                  endif
               case (cArgName=="-s")
                  nDigits:=val(cParam)
               case (cArgName=="-i")
                  nInterval:=val(cParam)
               case (cArgName=="-d")
                  cDigest:=Upper(allTrim(cParam))
               case (cArgName=="-t")
                  cType:=Upper(allTrim(cParam))
                  if (!(cType$"TOTP|HTOP"))
                     ShowHelp("Unrecognized option:"+cArgName+iif(Len(cParam)>0,"="+cParam,""))
                     break
                  endif               
               otherwise
                  ShowHelp("Unrecognized option:"+cArgName+iif(Len(cParam)>0,"="+cParam,""))
                  break
            endcase
         endif
      next each

     if (empty(cKey))
         ShowHelp("Attention: The secret key is missing!")
         break
      endif

      hb_default(@nDigits,6)
      hb_default(@nInterval,30)
      hb_default(@cDigest,"SHA1")
      hb_default(@cType,"TOTP")

      oHB_OTP:=hb_OTP():New()
      if (cType=="TOTP")
         c2FACode:=oHB_OTP:OTP_TOTP(cKey,nDigits,nInterval,cDigest)
      elseif (cType=="HOTP")
         c2FACode:=oHB_OTP:OTP_HOTP(cKey,nDigits,nInterval,cDigest)
      else
         cArgName:="-t"
         ShowHelp("Unrecognized option:"+cArgName+iif(Len(cType)>0,"="+cType,""))
         break
      endif

      OutStd(c2FACode)   
      
   end sequence
   
   return

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
            ,"-t=<type>          Specify the OTP type to use for generating the 2FA code: TOTP, HOTP";
         };
      }
   else
      ShowHelp("Unrecognized help option")
      return
   endif

   /* using hbmk2 style */
   aEval(aHelp,{|x|ShowSubHelp(x,@nMode,0)})

   return