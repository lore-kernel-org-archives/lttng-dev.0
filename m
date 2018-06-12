From: BADEUIL Thierry <thierry.badeuil@thalesgroup.com>
Subject: Re: Probleme with live session on LTTng 2.7.0
Date: Tue, 12 Jun 2018 12:53:16 +0200
Message-ID: <2588C50AE11CCC4B945875227E501190021891E98B4C__9950.53276788003$1528800686$gmane$org@THSONEA01CMS04P.one.grp>
References: <2588C50AE11CCC4B945875227E501190021891C9B82F@THSONEA01CMS04P.one.grp>
 <614894989.8932.1528467044925.JavaMail.zimbra@efficios.com>
 <671747492.9056.1528468064761.JavaMail.zimbra@efficios.com>
 <2588C50AE11CCC4B945875227E501190021891C9BA08@THSONEA01CMS04P.one.grp>
 <1520189977.9229.1528471194855.JavaMail.zimbra@efficios.com>
 <2588C50AE11CCC4B945875227E501190021891DC7EBB@THSONEA01CMS04P.one.grp>
 <1305764551.10725.1528737974718.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1333844675159873237=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from thsbbfxrt01p.thalesgroup.com (thsbbfxrt01p.thalesgroup.com
 [192.54.144.131])
 by lists.lttng.org (Postfix) with ESMTPS id 414mvM47fkz17Hr
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jun 2018 06:53:19 -0400 (EDT)
In-Reply-To: <1305764551.10725.1528737974718.JavaMail.zimbra@efficios.com>
Content-Language: fr-FR
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1333844675159873237==
Content-Language: fr-FR
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0042_01D4024C.52B4D5E0"

------=_NextPart_000_0042_01D4024C.52B4D5E0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

And last answer, here is the exact error message :
tmxv3@tmxv3-ThinkPad-T530:~$ sudo babeltrace -i lttng-live =
net://localhost/host/\(none\)/test -v
[verbose] Verbose mode active.
[verbose] Converting from directory(ies):
[verbose]     net://localhost/host/(none)/test
[verbose] Converting from format: lttng-live
[verbose] Converting to target: <stdout>
[verbose] Converting to format: text <default>
[error] Format : net://<hostname>/host/<traced_hostname>/<session_name>
[warning] [Context] Cannot open_trace of format lttng-live at path =
net://localhost/host/(none)/test.
[warning] [Context] cannot open trace "net://localhost/host/(none)/test" =
for reading.
[error] opening trace "net://localhost/host/(none)/test" for reading.

[error] none of the specified trace paths could be opened.

So ?

Thierry BADEUIL
THALES COMMUNICATIONS
T : +33 1 46 133 591
(  : +33 6 85 51 28 16
  : thierry.badeuil@thalesgroup.com


-----Message d'origine-----
De : Jonathan Rajotte-Julien =
[mailto:jonathan.rajotte-julien@efficios.com]=20
Envoy=C3=A9 : lundi 11 juin 2018 19:26
=C3=80 : BADEUIL Thierry
Cc : lttng-dev
Objet : Re: [lttng-dev] Probleme with live session on LTTng 2.7.0

Hi,

----- Original Message -----
> From: "BADEUIL Thierry" <thierry.badeuil@thalesgroup.com>
> To: "Jonathan Rajotte-Julien" <jonathan.rajotte-julien@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Monday, June 11, 2018 1:09:58 PM
> Subject: RE: [lttng-dev] Probleme with live session on LTTng 2.7.0

> Hello,
>=20
> Everything is almost OK except when I tried : babeltrace -i lttng-live
> net://localhost/host/<your hostname>/<session-name>

Please give us the output of the following when everything else is =
setup:

babeltrace -i lttng-live net://localhost

>=20
> Error messages :
> - [error] Format : net://....
> - [warning] [Context] Cannot open_trace of format lttng-live at =
path...
> - [warning] [Context] Cannot open trace "..." for reading
> - [error] opening trace "..."
> - [error] none of the specified trace paths could be opened.

Base on this output you seem to be "opening" the "net://..." path? Not =
sure why.

>=20
> Do you know why ?
>=20
> I updated babeltrace to 1.5.5 version and I installed 2.7 LTTng.

Perfect regarding Babeltrace but I would recommend that you upgrade =
lttng to the latest stable (2.10).

>=20
> Regards
>=20

------=_NextPart_000_0042_01D4024C.52B4D5E0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
kiaJk/IsZAEBEwhUMDAwNjI1NTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALGcevtX
o4LWyOCysyfnr1OeF3kS7I+l+1wC24jD0lRwJKCKB7lBjGWzI8BuJTJebyAYrggY29bHU1sXmYzf
VLUQgD9pUXEH5jRBP2z2qxg2+d66KL9+sa+XvXlUquMgxT/00ZDBIbTo2tz+f/cJCX9DaUSNLPt6
pOU7o4If2AFle527O8z8xgpXvzfdEi0W8TfxXfdxMBfs6EAZaUJnM/c4gIGkabIqNIH6gxo7xfhq
cBR7OKw1oe6dGBf6AtR2qBdtxrli/i0/phHb4gf3Da2Rvw/1st2oHFn7H4aHx0GJxqFu9ydDOwfF
E2yVqq/ITm1vxVBp7tgoHpxnhfwvPgECAwEAAaOCAhEwggINMB0GA1UdDgQWBBQjatJpG1HNROhT
4KJE3mpK07fnQzAfBgNVHSMEGDAWgBRFkJX/mV3SB42zEvbt8ig0klvbgTCB2gYDVR0gBIHSMIHP
MIHMBgcqgXoBbAEDMIHAMDsGCCsGAQUFBwIBFi9odHRwOi8vd3d3LnRoYWxlc2dyb3VwLmNvbS9j
ZXJ0aWZpY2F0aW9uX3BvbGljeTCBgAYIKwYBBQUHAgIwdBpyTW9yZSBpbmZvcm1hdGlvbiBvbiB0
aGUgVGhhbGVzIENlcnRpZmljYXRlIFBvbGljeSBjYW4gYmUgZm91bmQgYXQgaHR0cDovL3d3dy50
aGFsZXNncm91cC5jb20vY2VydGlmaWNhdGlvbl9wb2xpY3kgMB8GA1UdJQQYMBYGCCsGAQUFBwME
BgorBgEEAYI3CgMBMA4GA1UdDwEB/wQEAwIGwDAqBgNVHREEIzAhgR90aGllcnJ5LmJhZGV1aWxA
dGhhbGVzZ3JvdXAuY29tMEIGA1UdHwQ7MDkwN6A1oDOGMWh0dHA6Ly9jcmwudGhhbGVzZ3JvdXAu
Y29tL1RoYWxlc0ludGVybmFsQ0FWMy5jcmwwTQYIKwYBBQUHAQEEQTA/MD0GCCsGAQUFBzAChjFo
dHRwOi8vY3JsLnRoYWxlc2dyb3VwLmNvbS9UaGFsZXNJbnRlcm5hbENBVjMucDdjMA0GCSqGSIb3
DQEBCwUAA4ICAQCL5rz1Rb46zacF499WZCl1tI9Qg3zhc3FbOuTR/fUNh5DfLBfbZo4U8Dbmw1HH
sldB3Aol4hjBcfAXu/hVlNBXCJ0LEVIEN5vNrKAlmg0qJOJF/z8FOCWQX0KxHIyJOWwLgFTy4sy0
pGtTuIB8hcZe9O/sNDPCeJB3NPZFTnKncRpneDFXgo0Hhjpc1e9HsYFTiXJvSK9+MyKPOwBlckwe
UJ+4K8t02eOGrhHbqh3iZv4XWPLfwjLlNkXTwJV6ERjKq84XflSsRxM7KKfu8+aPLJVsOvWI9kD/
gN9Vt+fou0BKJJ7lct21Wd1Nb5ELuqvyAUe/FiheSC/mUup8S8N9/1GS5iDOQgdLjiUQcM+B9oXC
+ZFkKPFhPAz+4LCoWoTiJ6KQ1SU6UWT+eyidA8N3gIEcPke+JtqMVW993IEiSOuRHDXeV8hEdIzu
RDvkZX1e6HUlUXeBYhTkq0jeHIOJbs8R9TuKzB+lpykpJuxFVOUu8W21fws4YXXJrzXCEBw6JEAN
ZYyqcyatAZjIRJVMTUQdSjiOlKo9HGADBDfVbuEhELTbLsK+JfZD7paVALae/ruuTf8O+DpnIJ5T
qlgFfAqYTQEuvwytUaNugzJ3Dgu+by0Vf4sHTCIvCPrWaaX5kFFN7kSaYcZ4f2DIgkENoOxRhGV2
j56AEMxRPhhZlTCCBnswggRjoAMCAQICEhEhe8yEwSRlRHEmlUOl5JEq4DANBgkqhkiG9w0BAQsF
ADBTMQswCQYDVQQGEwJGUjEPMA0GA1UECgwGVGhhbGVzMRcwFQYDVQQLDA4wMDAyIDU1MjA1OTAy
NDEaMBgGA1UEAwwRVGhhbGVzIFJvb3QgQ0EgVjMwHhcNMTMxMTI2MDAwMDAwWhcNMjMxMTI2MDAw
MDAwWjBXMQswCQYDVQQGEwJGUjEPMA0GA1UECgwGVGhhbGVzMRcwFQYDVQQLDA4wMDAyIDU1MjA1
OTAyNDEeMBwGA1UEAwwVVGhhbGVzIEludGVybmFsIENBIFYzMIICIjANBgkqhkiG9w0BAQEFAAOC
Ag8AMIICCgKCAgEA0rkMp5a0Ce4DJ+bUrZ3vpMKHymqvp96yPqWHzvKrqusI2ApwVZWW/Y2gCNdA
UyE/gUN7BG+LXf5yyYhKRJO15OjwUVvpTUlIsR15RzHMnpFlgBIKHRV2OFOvIsIu456cFIIRU9Vq
Lf8Rvbz/d8IM4dVJoOZ3zCj06m99s0Zad2VxxTlN81Ek0J3Lkbu5aqg1E2A7Q80XwKNkkovuiAz4
klpbqyk2rothrnsZrMnE2UuEgwRkMBQufUk2PUha1E0DjG/iy7HyGkUuGL4k5E/57h0ebeqeMYVe
X/owek4oUeKwK+Opvi6cooJuAWfHuy6kH8OAPfbu22Vy3WCYbIfJtlKlNuEjYCWcUSHgJPg9dDYZ
ExBgTtEaK53xqJYWQUl8k7mScjhvxj+nF9h6/FYfdNUwv9OXkBFuiERWVil64zMGmPWiiAisnVLW
uNnc5Jk8SLvU1ham82zXPvEL8f+Lp8vsyHQHhA6eleTTqIifj7nsrgJCHih9xEtY+PI1wOOJoIUl
y9OOAM1LPeNyKCUQQbyPwNyhg9FuN3YOyIleYYHuWTMl4cCXiwmzeASGkhQC5icEHpYKRwL+ZAmG
WNDsY4wrQnE5i2wEH0utOKdb+gnPiP8+QpbI56pJbrXZL0rj43MmApGuRXQmVafoP4OnvdwfKBIP
7HzhQS7O8CvSxpsCAwEAAaOCAUMwggE/MA4GA1UdDwEB/wQEAwIBBjBRBgNVHSAESjBIMEYGBFUd
IAAwPjA8BggrBgEFBQcCARYwaHR0cDovL2NybC50aGFsZXNncm91cC5jb20vY2VydGlmaWNhdGlv
bl9wb2xpY3kvMA8GA1UdEwEB/wQFMAMBAf8wPgYDVR0fBDcwNTAzoDGgL4YtaHR0cDovL2NybC50
aGFsZXNncm91cC5jb20vVGhhbGVzUm9vdENBVjMuY3JsMEkGCCsGAQUFBwEBBD0wOzA5BggrBgEF
BQcwAoYtaHR0cDovL2NybC50aGFsZXNncm91cC5jb20vVGhhbGVzUm9vdENBVjMucDdjMB0GA1Ud
DgQWBBRFkJX/mV3SB42zEvbt8ig0klvbgTAfBgNVHSMEGDAWgBQrJxeCGWDoBEdY85KumrfqjtZ5
lTANBgkqhkiG9w0BAQsFAAOCAgEAhYwNoWezNu5n/I64uircImuPDaGQUGqAtyLF6LtcMkYB98Kq
ZYGdGfCUOKDI/r4NRI1F2mzbE07mlF0i35YijDVaHD+l7c2qYgg+ZHUt2tjkVMnk9goaZuixdztM
4IzY/1Br9q2Jum4jTdi9PYdO6pKHVtcFwLrza7l0rpVU5twguhSdSWVayOtjUQD63aWVDRuUOY+d
DQ7jAGVcB2ZdkN+OxjbfpV/Xm+6hdEO5uE3ghZOzS/HQUdSc0zy9myJeOzZ9+DmpMKyPLVADgxbt
2tOSC5ky4feLE3cOagJ0MIk93xWkajGo5BXqbqVl/gCXgrui4SRvUIUPQc8XHW1+usMzmiotDKGn
pPnQMI0BwBsQFCZxMmF+rgTe2kB2/TykXWmc9JA6Gof7MKCbcN93liiOm5sAQaL5ZDZXEmH+7Xry
N79AGWIxMqB9dbx/h6Pbp1bUtUf2htEN0S1MsE/RJtuGeYAdGn3rjidDjczoHCA9oRCZeeCXcr/W
oYeMNCuR/n60x1JrIoDIB0p+LkvnCPtwdPv12t2QAsXk9wNYd9PuMF42Tccz0SCBZgyh16I4AHQ7
GT3UuXBinFpVXY0MCd7pBwzMJsUizCN82jNvPnh9EewYMlxhres/AJvzu/4d5t3fLCudbW9VIBS5
esq6HpZ1CzF27v39fHemAM5E6M4wggaGMIIEbqADAgECAgMA6PYwDQYJKoZIhvcNAQELBQAwVzEL
MAkGA1UEBhMCRlIxDzANBgNVBAoMBlRoYWxlczEXMBUGA1UECwwOMDAwMiA1NTIwNTkwMjQxHjAc
BgNVBAMMFVRoYWxlcyBJbnRlcm5hbCBDQSBWMzAeFw0xNDEyMDkwOTUxMDJaFw0xOTEyMDkwOTUx
MDJaMHUxDzANBgNVBAoTBlRoYWxlczEYMBYGA1UEAxMPQkFERVVJTCBUaGllcnJ5MS4wLAYJKoZI
hvcNAQkBFh90aGllcnJ5LmJhZGV1aWxAdGhhbGVzZ3JvdXAuY29tMRgwFgYKCZImiZPyLGQBARMI
VDAwMDYyNTUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDXEYJPQNZD0AhY31Ma96ce
6OuqSiHdS/34timZw7XazImdP9Dmm8KN6imyWShw9EW2ahPNKIxTIUlvddn4HW1yITI+kne58D4J
e6z/x7D/4ijF660yyzMtxUs06XeB3qSJj2Hq8d0MM9Q/0MGtWOBtuXCI6t/1DivdWmIbdi4vYSp0
phbehF1u0uZA3ll4peRSFX7m3I7ieJtgyTxdjiV90qR9MW7IwVea+/CDgG8G84DRl1MwoimKt2tP
eATNpYPJNQB5IT+XL4oZJValzJauSwcbujeCWV1iiYO4khKxxV5dsuVNfUxfuXE1G+54BQfrBy8I
pjFYYxIV+OgMjFwhAgMBAAGjggI7MIICNzAdBgNVHQ4EFgQU/5ddQuBN0xMrYVxN+gYXzl0ud2cw
HwYDVR0jBBgwFoAURZCV/5ld0geNsxL27fIoNJJb24EwgdoGA1UdIASB0jCBzzCBzAYHKoF6AWwB
AzCBwDA7BggrBgEFBQcCARYvaHR0cDovL3d3dy50aGFsZXNncm91cC5jb20vY2VydGlmaWNhdGlv
bl9wb2xpY3kwgYAGCCsGAQUFBwICMHQack1vcmUgaW5mb3JtYXRpb24gb24gdGhlIFRoYWxlcyBD
ZXJ0aWZpY2F0ZSBQb2xpY3kgY2FuIGJlIGZvdW5kIGF0IGh0dHA6Ly93d3cudGhhbGVzZ3JvdXAu
Y29tL2NlcnRpZmljYXRpb25fcG9saWN5IDBJBgNVHSUEQjBABggrBgEFBQcDBAYKKwYBBAGCNwoD
AQYKKwYBBAGCNwoDBAYIKwYBBQUHAwUGCCsGAQUFBwMGBggrBgEFBQcDBzAOBgNVHQ8BAf8EBAMC
BDAwKgYDVR0RBCMwIYEfdGhpZXJyeS5iYWRldWlsQHRoYWxlc2dyb3VwLmNvbTBCBgNVHR8EOzA5
MDegNaAzhjFodHRwOi8vY3JsLnRoYWxlc2dyb3VwLmNvbS9UaGFsZXNJbnRlcm5hbENBVjMuY3Js
ME0GCCsGAQUFBwEBBEEwPzA9BggrBgEFBQcwAoYxaHR0cDovL2NybC50aGFsZXNncm91cC5jb20v
VGhhbGVzSW50ZXJuYWxDQVYzLnA3YzANBgkqhkiG9w0BAQsFAAOCAgEAQwESrDlSkrBs2JOL+AZj
FJ1OCLUYRf7BmWMyKeAuMaJtCkxF59OSuLgRFFpKk3VktQEJ0Ek6K4h9HnHh0zRR0bHnerFfz+Tz
+XwGzaGxwj5OwHVal9vKJAO71F8pAo4iEAh3plkzvDRjoVliUMkwzp0szx6MUEEWlMo5XooW7U8B
P55nfT/UR2oa/V3jMO2f7A0OxgE6G4S4E8BRvUmqhdVFYMqyIOFQvIsZbWxgyT91kM4+8M9ipmth
eimPfe6DeYFWaqjk86v50UC0Ea2pVojaYkxh+AHlFN8a0rzRhdN3D4lBCTKv8/5AJRpQUCGT9Nn/
PCS/vQFeVfdgxkcdoC6xKDvj32iiQr/bCz9uywArPmtIiGbYbYNhZBQDy8mtvz9xLWDDFFbO0rm6
nQTWvY/w8O3xe/fbKINZwzD8Q4zhz9B/sttTUcaSJ/hOlKZxOD7Oye7VsHSZ1ejfOGhK28z5SHgc
uSXQ5bgdv5w3thC6GfbKpcq49VJev90KC5fcdqaSXa0l8I5f+e/zRPg19Ke6pptAyM/W9Gf1GOE5
wi31QNREhgnUOh5xhJeSvH1Yg/t+i4cfcj/lWn0orq3R0BT8y5tDGC9cyHFvPWIG7o5PhWoIcQxF
LGuxt89SsQjFZrhVqOPYLZ1rPjA+jvF9+FFq04TxH1LdvcYqhNhTA/UxggMaMIIDFgIBATBeMFcx
CzAJBgNVBAYTAkZSMQ8wDQYDVQQKDAZUaGFsZXMxFzAVBgNVBAsMDjAwMDIgNTUyMDU5MDI0MR4w
HAYDVQQDDBVUaGFsZXMgSW50ZXJuYWwgQ0EgVjMCAwDo9DAJBgUrDgMCGgUAoIIBkTAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODA2MTIxMDUzMTJaMCMGCSqGSIb3
DQEJBDEWBBRnRwHhsvnrOrDml3OgKqtrV8JZYTBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDBt
BgkrBgEEAYI3EAQxYDBeMFcxCzAJBgNVBAYTAkZSMQ8wDQYDVQQKDAZUaGFsZXMxFzAVBgNVBAsM
DjAwMDIgNTUyMDU5MDI0MR4wHAYDVQQDDBVUaGFsZXMgSW50ZXJuYWwgQ0EgVjMCAwDo9jBvBgsq
hkiG9w0BCRACCzFgoF4wVzELMAkGA1UEBhMCRlIxDzANBgNVBAoMBlRoYWxlczEXMBUGA1UECwwO
MDAwMiA1NTIwNTkwMjQxHjAcBgNVBAMMFVRoYWxlcyBJbnRlcm5hbCBDQSBWMwIDAOj2MA0GCSqG
SIb3DQEBAQUABIIBAFmPL+iEFLa63uKMIGS/k/aWi8zKmrYiUe8vlatjFQ89AuGmjLDJpzKBmeB+
li+UbFdCjDTMC0vzB3znISfkpu6pHjgU2jJmjA19wY4ikVZtfX67DwYqYRyG/IJKNBUnExVKi3Uu
TjSW64mBvopEeCUlr8wFYQAmYLWRfmBboPO7niTdsdbcwDrzH6L+Vr1adxN20nkRHJYDXrShs0Me
bWGzkrfXh4IY9f6FyGJxFCzG5tduyunepZGJJo30RLuIuPXhxdfogaO0yNVPqt9vV1/OxloJac3M
O+8cH0KKWleEWfiFpC3FC7qtTLRWBXUqRfTsdC7G76GsEja5WXlXeRoAAAAAAAA=

------=_NextPart_000_0042_01D4024C.52B4D5E0--

--===============1333844675159873237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1333844675159873237==--
