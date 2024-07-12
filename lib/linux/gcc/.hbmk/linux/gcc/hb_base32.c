/*
 * Harbour 3.2.0dev (r2307062207)
 * GNU C 9.4 (64-bit)
 * Generated C source from "./hb_base32.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( HB_BASE32 );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( HBOBJECT );
HB_FUNC_STATIC( HB_BASE32_INIT );
HB_FUNC_STATIC( HB_BASE32_ENCODE );
HB_FUNC_STATIC( HB_BASE32_DECODE );
HB_FUNC_STATIC( HB_BASE32_TOBINARYSTRING );
HB_FUNC_STATIC( HB_BASE32_FROMBINARYSTRING );
HB_FUNC_STATIC( HB_BASE32_ENCODE_C );
HB_FUNC_STATIC( HB_BASE32_DECODE_C );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_STATIC( _STRSPLIT );
HB_FUNC_EXTERN( BINTODEC );
HB_FUNC_EXTERN( HB_BITAND );
HB_FUNC_EXTERN( HB_BSUBSTR );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( AT );
HB_FUNC_EXTERN( HB_BPADL );
HB_FUNC_EXTERN( DECTOBIN );
HB_FUNC_EXTERN( RTRIM );
HB_FUNC_EXTERN( HB_BRIGHT );
HB_FUNC_EXTERN( HB_BPADR );
HB_FUNC_EXTERN( HB_BLEN );
HB_FUNC_EXTERN( HB_BCODE );
HB_FUNC_EXTERN( HB_BCHAR );
HB_FUNC_STATIC( BASE32_ENCODE );
HB_FUNC_STATIC( BASE32_DECODE );
HB_FUNC_EXTERN( MOD );
HB_FUNC_EXTERN( INT );
HB_FUNC_EXTERN( AADD );
HB_FUNC_INITSTATICS();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_HB_BASE32 )
{ "HB_BASE32", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32 )}, NULL },
{ "__CLSLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSLOCKDEF )}, NULL },
{ "NEW", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HBCLASS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBCLASS )}, NULL },
{ "HBOBJECT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBOBJECT )}, NULL },
{ "ADDMULTIDATA", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "ADDMETHOD", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HB_BASE32_INIT", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32_INIT )}, NULL },
{ "HB_BASE32_ENCODE", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32_ENCODE )}, NULL },
{ "HB_BASE32_DECODE", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32_DECODE )}, NULL },
{ "HB_BASE32_TOBINARYSTRING", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32_TOBINARYSTRING )}, NULL },
{ "HB_BASE32_FROMBINARYSTRING", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32_FROMBINARYSTRING )}, NULL },
{ "HB_BASE32_ENCODE_C", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32_ENCODE_C )}, NULL },
{ "HB_BASE32_DECODE_C", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HB_BASE32_DECODE_C )}, NULL },
{ "CREATE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__CLSUNLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSUNLOCKDEF )}, NULL },
{ "INSTANCE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__OBJHASMSG", {HB_FS_PUBLIC}, {HB_FUNCNAME( __OBJHASMSG )}, NULL },
{ "INITCLASS", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_CB32ALPHABET", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "TOBINARYSTRING", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_STRSPLIT", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( _STRSPLIT )}, NULL },
{ "BINTODEC", {HB_FS_PUBLIC}, {HB_FUNCNAME( BINTODEC )}, NULL },
{ "HB_BITAND", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BITAND )}, NULL },
{ "HB_BSUBSTR", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BSUBSTR )}, NULL },
{ "CB32ALPHABET", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "UPPER", {HB_FS_PUBLIC}, {HB_FUNCNAME( UPPER )}, NULL },
{ "AT", {HB_FS_PUBLIC}, {HB_FUNCNAME( AT )}, NULL },
{ "HB_BPADL", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BPADL )}, NULL },
{ "DECTOBIN", {HB_FS_PUBLIC}, {HB_FUNCNAME( DECTOBIN )}, NULL },
{ "FROMBINARYSTRING", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "RTRIM", {HB_FS_PUBLIC}, {HB_FUNCNAME( RTRIM )}, NULL },
{ "HB_BRIGHT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BRIGHT )}, NULL },
{ "HB_BPADR", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BPADR )}, NULL },
{ "HB_BLEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BLEN )}, NULL },
{ "HB_BCODE", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BCODE )}, NULL },
{ "HB_BCHAR", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_BCHAR )}, NULL },
{ "BASE32_ENCODE", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( BASE32_ENCODE )}, NULL },
{ "BASE32_DECODE", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( BASE32_DECODE )}, NULL },
{ "MOD", {HB_FS_PUBLIC}, {HB_FUNCNAME( MOD )}, NULL },
{ "INT", {HB_FS_PUBLIC}, {HB_FUNCNAME( INT )}, NULL },
{ "AADD", {HB_FS_PUBLIC}, {HB_FUNCNAME( AADD )}, NULL },
{ "(_INITSTATICS00001)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITSTATICS}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_HB_BASE32, "./hb_base32.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_HB_BASE32
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_HB_BASE32 )
   #include "hbiniseg.h"
#endif

HB_FUNC( HB_BASE32 )
{
	static const HB_BYTE pcode[] =
	{
		149,3,0,116,43,0,36,5,0,103,1,0,100,8,
		29,160,1,176,1,0,104,1,0,12,1,29,149,1,
		166,87,1,0,122,80,1,48,2,0,176,3,0,12,
		0,106,10,104,98,95,66,97,115,101,51,50,0,108,
		4,4,1,0,108,0,112,3,80,2,36,7,0,92,
		2,80,1,36,8,0,48,5,0,95,2,106,10,99,
		104,97,114,97,99,116,101,114,0,100,95,1,121,72,
		121,72,121,72,106,13,99,66,51,50,65,108,112,104,
		97,98,101,116,0,4,1,0,9,112,5,73,36,9,
		0,48,6,0,95,2,106,5,73,110,105,116,0,108,
		7,95,1,121,72,121,72,121,72,112,3,73,36,11,
		0,122,80,1,36,13,0,48,6,0,95,2,106,7,
		69,110,99,111,100,101,0,108,8,95,1,121,72,121,
		72,121,72,112,3,73,36,14,0,48,6,0,95,2,
		106,7,68,101,99,111,100,101,0,108,9,95,1,121,
		72,121,72,121,72,112,3,73,36,15,0,48,6,0,
		95,2,106,15,84,111,66,105,110,97,114,121,83,116,
		114,105,110,103,0,108,10,95,1,121,72,121,72,121,
		72,112,3,73,36,16,0,48,6,0,95,2,106,17,
		70,114,111,109,66,105,110,97,114,121,83,116,114,105,
		110,103,0,108,11,95,1,121,72,121,72,121,72,112,
		3,73,36,18,0,48,6,0,95,2,106,9,69,110,
		99,111,100,101,95,67,0,108,12,95,1,121,72,121,
		72,121,72,112,3,73,36,19,0,48,6,0,95,2,
		106,9,68,101,99,111,100,101,95,67,0,108,13,95,
		1,121,72,121,72,121,72,112,3,73,36,21,0,48,
		14,0,95,2,112,0,73,167,14,0,0,176,15,0,
		104,1,0,95,2,20,2,168,48,16,0,95,2,112,
		0,80,3,176,17,0,95,3,106,10,73,110,105,116,
		67,108,97,115,115,0,12,2,28,12,48,18,0,95,
		3,164,146,1,0,73,95,3,110,7,48,16,0,103,
		1,0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_BASE32_INIT )
{
	static const HB_BYTE pcode[] =
	{
		36,24,0,48,19,0,102,106,33,65,66,67,68,69,
		70,71,72,73,74,75,76,77,78,79,80,81,82,83,
		84,85,86,87,88,89,90,50,51,52,53,54,55,0,
		112,1,73,36,25,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_BASE32_ENCODE )
{
	static const HB_BYTE pcode[] =
	{
		13,7,1,36,30,0,48,20,0,102,95,1,112,1,
		80,3,36,31,0,176,21,0,95,3,92,5,12,2,
		80,4,36,32,0,106,1,0,80,5,36,35,0,122,
		165,80,6,25,67,36,36,0,95,4,95,6,1,80,
		2,36,37,0,176,22,0,95,2,12,1,80,7,36,
		38,0,176,23,0,95,7,92,31,12,2,80,8,36,
		39,0,96,5,0,176,24,0,48,25,0,102,112,0,
		95,8,122,72,122,12,3,135,36,35,0,175,6,0,
		176,26,0,95,4,12,1,15,28,183,36,42,0,95,
		5,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_BASE32_DECODE )
{
	static const HB_BYTE pcode[] =
	{
		13,6,1,36,48,0,106,1,0,80,4,36,49,0,
		176,21,0,176,27,0,95,1,12,1,122,12,2,80,
		5,36,52,0,122,165,80,6,25,65,36,53,0,176,
		28,0,95,5,95,6,1,48,25,0,102,112,0,12,
		2,122,49,80,7,36,54,0,95,7,121,16,28,27,
		36,55,0,96,4,0,176,29,0,176,30,0,95,7,
		12,1,92,5,106,2,48,0,12,3,135,36,52,0,
		175,6,0,176,26,0,95,5,12,1,15,28,185,36,
		59,0,48,31,0,102,95,4,112,1,80,2,36,62,
		0,176,32,0,95,2,12,1,80,2,36,63,0,106,
		2,32,0,80,3,36,64,0,176,33,0,95,2,122,
		12,2,95,3,69,28,25,36,65,0,176,34,0,95,
		2,176,35,0,95,2,12,1,122,72,95,3,12,3,
		80,2,36,69,0,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_BASE32_TOBINARYSTRING )
{
	static const HB_BYTE pcode[] =
	{
		13,4,1,36,74,0,106,1,0,80,3,36,77,0,
		122,165,80,4,25,60,36,78,0,176,24,0,95,1,
		95,4,122,12,3,80,5,36,79,0,176,29,0,176,
		30,0,176,36,0,95,5,12,1,12,1,92,8,106,
		2,48,0,12,3,80,2,36,80,0,96,3,0,95,
		2,135,36,77,0,175,4,0,176,26,0,95,1,12,
		1,15,28,190,36,83,0,95,3,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_BASE32_FROMBINARYSTRING )
{
	static const HB_BYTE pcode[] =
	{
		13,6,1,36,87,0,176,21,0,95,1,92,8,12,
		2,80,2,36,89,0,106,2,0,0,80,4,36,90,
		0,106,1,0,80,5,36,93,0,122,165,80,6,25,
		54,36,94,0,176,22,0,95,2,95,6,1,12,1,
		80,7,36,95,0,176,37,0,95,7,12,1,80,3,
		36,96,0,95,3,95,4,69,28,11,36,97,0,96,
		5,0,95,3,135,36,93,0,175,6,0,176,26,0,
		95,2,12,1,15,28,196,36,101,0,95,5,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_BASE32_ENCODE_C )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,104,0,176,38,0,95,1,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HB_BASE32_DECODE_C )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,107,0,176,39,0,95,1,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( _STRSPLIT )
{
	static const HB_BYTE pcode[] =
	{
		13,4,2,36,111,0,4,0,0,80,3,36,114,0,
		176,35,0,95,1,12,1,80,6,36,116,0,95,2,
		122,15,28,70,36,117,0,176,40,0,95,6,95,2,
		12,2,80,5,36,118,0,95,5,121,69,28,47,36,
		119,0,176,41,0,95,6,95,2,18,12,1,122,72,
		80,5,36,120,0,95,5,95,2,65,80,6,36,121,
		0,176,34,0,95,1,95,6,106,2,48,0,12,3,
		80,1,36,126,0,122,165,80,4,25,32,36,127,0,
		176,42,0,95,3,176,24,0,95,1,95,4,95,2,
		12,3,20,2,36,126,0,96,4,0,95,2,139,95,
		6,95,2,10,28,221,36,130,0,95,3,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,43,0,1,0,7
	};

	hb_vmExecute( pcode, symbols );
}

#line 133 "./hb_base32.prg"

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

