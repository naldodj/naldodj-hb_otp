#!/bin/bash

# Definir a variável para o caminho do hbmk2
HBMK2=~/naldodj-hb/bin/cygwin/gcc/hbmk2.exe

# Definir a variável para o caminho repositório
HB_OTPPATH=/cygdrive/c/GitHub/naldodj-hb_otp/src/hb/hbp/

# Definir a variável para dos binários gerados
HB_OTPPATHBIN=/cygdrive/c/GitHub/naldodj-hb_otp/bin/cygwin/gcc/

# Mudar para o diretório de origem
cd $HB_OTPPATH

# Compilar os arquivos .hbp usando hbmk2
$HBMK2 hb_otp_gcrypt.hbp
$HBMK2 hb_otp_openssl.hbp
$HBMK2 hb_otp_mbedtls.hbp
$HBMK2 hbgenkey.hbp
$HBMK2 hbotp_gcrypt.hbp
$HBMK2 hbotp_openssl.hbp
$HBMK2 hbotp_mbedtls.hbp
$HBMK2 tst_otp_gcrypt.hbp
$HBMK2 tst_otp_openssl.hbp
$HBMK2 tst_otp_mbedtls.hbp
$HBMK2 tst_otp_mbedtls.hbp
$HBMK2 tst_hb_base32.hbp

# Mudar para o diretório binário
cd $HB_OTPPATHBIN

# Compactar os arquivos .exe usando upx
upx hbgenkey.exe
upx hbotp_gcrypt.exe
upx hbotp_openssl.exe
upx hbotp_mbedtls.exe
upx tst_otp_gcrypt.exe
upx tst_otp_openssl.exe
upx tst_otp_mbedtls.exe
upx tst_hb_base32.exe

cp hbotp_gcrypt.exe /cygdrive/c/GitHub/naldodj-2FA-windows/src/2FA/hb/hb_otp/bin/cygwin/gcc/
cp hbotp_openssl.exe /cygdrive/c/GitHub/naldodj-2FA-windows/src/2FA/hb/hb_otp/bin/cygwin/gcc/
cp hbotp_mbedtls.exe /cygdrive/c/GitHub/naldodj-2FA-windows/src/2FA/hb/hb_otp/bin/cygwin/gcc/

# Voltar para o diretório inicial
#cd /cygdrive/c/GitHub/naldodj-hb_otp/
