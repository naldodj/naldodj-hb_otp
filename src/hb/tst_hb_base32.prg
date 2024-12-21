#pragma -w3

REQUEST HB_CODEPAGE_UTF8EX

memvar GETLIST

#include "hbver.ch"

procedure Main(...)

   local aArgs as array:=hb_AParams()

   local cKey as character
   local cEncode as character
   local cParam as character
   local cArgName as character

   local lBase64 as logical

   local idx as numeric
   local nDigits as numeric

   local oHB_Base32 as object

   hb_cdpSelect("UTF8EX")

   begin sequence

      if (;
            (!Empty(aArgs));
            .and.;
            (;
               Lower(aArgs[1])=="-h";
               .or.;
               Lower(aArgs[1])=="--help";
            );
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
               case (cArgName=="-s")
                  nDigits:=val(cParam)
               case (cArgName=="-base64-")
                  lBase64:=.F.
               otherwise
                  ShowHelp("Unrecognized option:"+cArgName+iif(Len(cParam)>0,"="+cParam,""))
                  break
            endcase
         endif
      next each

      hb_default(@nDigits,20)
      hb_default(@lBase64,.T.)

      cKey:=hb_randStr(nDigits)

      if (lBase64)
         cKey:=hb_base64Encode(cKey,.F.)
      endif

      oHB_Base32:=hb_Base32():New()

      OutStd("ohb_Base32:Encode/Decode: ",hb_eol())
      OutStd("cKey:",cKey,hb_eol())
      OutStd("ohb_Base32:Encode: ",cEncode:=ohb_Base32:Encode(cKey),hb_eol())
      OutStd("ohb_Base32:Decode:",ohb_Base32:Decode(cEncode),hb_eol())

      OutStd(Replicate("=",80),hb_eol())

      OutStd("ohb_Base32:Encode_C/Decode_C: ",hb_eol())
      OutStd("cKey:",cKey,hb_eol())
      OutStd("ohb_Base32:Encode_C: ",cEncode:=ohb_Base32:Encode_C(cKey),hb_eol())
      OutStd("ohb_Base32:Decode_C:",ohb_Base32:Decode_C(cEncode),hb_eol())

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
         ,"HBGenKey ("+ExeName()+") "+HBRawVersion();
         ,"Copyright (c) 2024-"+hb_NToS(Year(Date()))+", "+hb_Version(HB_VERSION_URL_BASE);
         ,"";
         ,"Syntax:";
         ,"";
         ,{ExeName()+" [options]"};
         ,"";
         ,"Options:";
         ,{;
             "-h or --help       Show this help screen";
            ,"-s=<digits>        Specify the number of digits in the key code";
            ,"-base64-           When this option is specified, the random key generated will not be encoded in base64 before being converted to base32";
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
