# hb_otp

(x)Harbour library that generates TOTP and HOTP according to [RFC-6238](https://tools.ietf.org/html/rfc6238)

## Requirements
- [libcotp](https://github.com/naldodj/naldodj-libcotp)
- GCC/Clang and CMake to build the library
- libgcrypt >= 1.8.0 or openssl >= 3.0.0

## Compile (lib)
```bash
hbmk2 hb_otp_gcrypt.hbp
```
or
```bash
hbmk2 hb_otp_openssl.hbp
```

## Cross-compilation
```bash
hbmk2 hb_otp_gcrypt.hbp -comp=mingw64 -cpu=x64 -plat=win
```
or
```bash
hbmk2 hb_otp_openssl.hbp -comp=mingw64 -cpu=x64 -plat=win
```

## Compile (teste)
```bash
hbmk2 tst_otp_gcrypt.hbp
```
or
```bash
hbmk2 tst_otp_openssl.hbp
```
