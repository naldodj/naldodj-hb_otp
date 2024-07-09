#pragma -w3

#include "hbclass.ch"

class hb_Base32

   PROTECTED:
   data cB32Alphabet as character
   method Init() as object

   EXPORTED:

   method Encode(cData as character) as character
   method Decode(cBase32 as character) as character
   method ToBinaryString(cData as character) as character
   method FromBinaryString(cBinaryString as character) as character

   method Encode_C(cData as character) as character
   method Decode_C(cBase32 as character) as character

endclass

method Init() class hb_Base32
   self:cB32Alphabet:="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
return(self)

method Encode(cData as character) class hb_Base32

   local cBin as character
   local cBinaryString as character:=self:ToBinaryString(cData)
   local aFiveBitBinaryArray as array:=_StrSplit(cBinaryString,5)
   local cBase32 as character:=""
   local i,nDec,nValue as numeric

   for i:=1 to Len(aFiveBitBinaryArray)
      cBin:=aFiveBitBinaryArray[i]
      nDec:=BinToDec(cBin)
      nValue:=hb_BitAnd(nDec,31)
      cBase32+=hb_BSubStr(self:cB32Alphabet,nValue+1,1)
   next i

   return(cBase32)

method Decode(cBase32 as character) class hb_Base32

   local cDecode as character
   local cBChar0 as character
   local cBinaryString as character:=""
   local aBase32 as array:=_StrSplit(Upper(cBase32),1)
   local i,nPos as numeric

   for i:=1 to Len(aBase32)
      nPos:=(AT(aBase32[i],self:cB32Alphabet)-1)
      if (nPos>=0)
         cBinaryString+=HB_BPADL(DecToBin(nPos),5,"0")
      endif
   next i

   cDecode:=self:FromBinaryString(cBinaryString)

   //TODO Begin: Rever este fragamento
   cDecode:=RTrim(cDecode)
   cBChar0:=" "
   if (hb_bRight(cDecode,1)!=cBChar0)
      cDecode:=hb_BPadR(cDecode,hb_bLen(cDecode)+1,cBChar0)
   endif
   //TODO End: Rever este fragamento

   return(cDecode)

method ToBinaryString(cData as character) class hb_Base32

   local cBin as character
   local cBinaryString as character:=""
   local i,cChar as numeric

   for i:=1 to Len(cData)
      cChar:=hb_BSubStr(cData,i,1)
      cBin:=HB_BPADL(DecToBin(hb_BCode(cChar)),8,"0")
      cBinaryString+=cBin
   NEXT

   return(cBinaryString)

method FromBinaryString(cBinaryString as character) class hb_Base32

   local aEightBitBinaryArray as array:=_StrSplit(cBinaryString,8)
   local cBChar as character
   local cBChar0:=hb_BChar(0) as character
   local cDecoded as character:=""
   local i,nValue as numeric

   for i:=1 to Len(aEightBitBinaryArray)
      nValue:=BinToDec(aEightBitBinaryArray[i])
      cBChar:=hb_BChar(nValue)
      if (cBChar!=cBChar0)
         cDecoded+=cBChar
      endif
   next i

   return(cDecoded)

method Encode_C(cData as character) class hb_Base32
return(base32_encode(cData)) as character

method Decode_C(cBase32 as character) class hb_Base32
return(base32_decode(cBase32)) as character

static function _StrSplit(cString,nSize)

   local aResult as array:={}
   local i,nMod,nStringSize as numeric

   nStringSize:=hb_bLen(cSTring)
   //TODO Begin: Rever este fragamento
   if (nSize>1)
      nMod:=Mod(nStringSize,nSize)
      if (nMod!=0)
         nMod:=(Int(nStringSize/nSize)+1)
         nStringSize:=(nMod*nSize)
         cString:=HB_BPADR(cString,nStringSize,"0")
      endif
   endif
   //TODO End: Rever este fragamento

   for i:=1 to nStringSize step nSize
      aAdd(aResult,hb_BSubStr(cString,i,nSize))
   next i

   return(aResult)

#pragma BEGINDUMP

#include "hbapi.h"
#include <string.h>

static const char base32_chars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";

static int base32_decode(const char *szB32Encoded, unsigned char *result, int bufSize) {
    int buffer = 0, bitsLeft = 0, count = 0;
    for (const char *ptr = szB32Encoded; *ptr; ptr++) {
        const char *p = strchr(base32_chars, *ptr);
        if (p) {
            buffer <<= 5;
            buffer |= (p - base32_chars);
            bitsLeft += 5;
            if (bitsLeft >= 8) {
                if (count >= bufSize) {
                    return -1;
                }
                result[count++] = (buffer >> (bitsLeft - 8)) & 0xFF;
                bitsLeft -= 8;
            }
        }
    }
    return count;
}

static char* base32_encode(const unsigned char *data, int length) {
    int buffer = 0, bitsLeft = 0, count = 0;
    int encoded_len = ((length + 4) / 5) * 8; // 8 output chars for every 5 input bytes
    char *encoded = (char *)malloc(encoded_len + 1); // +1 for null terminator

    if (!encoded) {
        return NULL;
    }

    for (int i = 0; i < length; i++) {
        buffer = (buffer << 8) | data[i];
        bitsLeft += 8;

        while (bitsLeft >= 5) {
            encoded[count++] = base32_chars[(buffer >> (bitsLeft - 5)) & 0x1F];
            bitsLeft -= 5;
        }
    }

    if (bitsLeft > 0) {
        buffer <<= (5 - bitsLeft);
        encoded[count++] = base32_chars[buffer & 0x1F];
    }

    encoded[count] = '\0';
    return encoded;
}

HB_FUNC_STATIC( BASE32_DECODE )
{
    const char *szB32Encoded = hb_parcx(1);
    int encoded_len = hb_parclen(1);
    int bufSize = (encoded_len * 5) / 8; // Calculate the buffer size
    unsigned char *szRet = (unsigned char *)malloc(bufSize);
    int szRet_len;

    if (!szRet) {
        hb_retc_null();
        return;
    }

    szRet_len = base32_decode(szB32Encoded, szRet, bufSize);
    if (szRet_len < 0) {
        free(szRet);
        hb_retc_null();
    } else {
        hb_retclen((char*)szRet, szRet_len);
        free(szRet);
    }
}

HB_FUNC_STATIC( BASE32_ENCODE )
{
    const unsigned char *data = (const unsigned char *)hb_parcx(1);
    int length = hb_parclen(1);
    char *encoded = base32_encode(data, length);

    if (encoded) {
        hb_retc(encoded);
        free(encoded);
    } else {
        hb_retc_null();
    }
}

#pragma ENDDUMP
