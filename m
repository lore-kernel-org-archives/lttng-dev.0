From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space (version
 6)
Date: Tue, 03 Jul 2012 16:23:40 +0200
Message-ID: <4FF3006C.5000308__530.63277523524$1341325499$gmane$org@gmail.com>
References: <1341266778-13735-1-git-send-email-francis.giraldeau@gmail.com>
	<20120702222340.GA1702@Krystal> <4FF28F07.6000901@gmail.com>
	<20120703113947.GA24563@Krystal> <4FF2F4DF.9030904@gmail.com>
	<20120703134031.GB32190@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1425617121=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1Sm41H-0001AQ-Fh
	for lttng-dev@lists.lttng.org; Tue, 03 Jul 2012 10:24:00 -0400
Received: by bkty7 with SMTP id y7so2820593bkt.35
	for <lttng-dev@lists.lttng.org>; Tue, 03 Jul 2012 07:23:53 -0700 (PDT)
In-Reply-To: <20120703134031.GB32190@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Ceci est un message signC) cryptographiquement au format MIME.

--===============1425617121==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms060204060004030101070107"

Ceci est un message signé cryptographiquement au format MIME.

--------------ms060204060004030101070107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le 2012-07-03 15:40, Mathieu Desnoyers a =E9crit :
>> It's not possible to remove the module while an active tracing session=

>> references the event lttng_uevent. I tested insertion/removal of the
>> module while tracing with the previous version that was using RCU and =
it
>> was working well.
>=20
> But you don't need to have an active tracing session to perform the tes=
t
> I point to above. Could you run it on this latest version ?

Ok. I updated the test to run in a loop rmmod/modprobe, while writing
with 20 threads into /proc/lttng_uevent. The result is that the module
can be unloaded properly, the test shows no race that prevent the module
to be unloaded or other problems.

If somebody wants to test it for themselves, I added the code for this
test under workload-kit/tests.

  * test-uevent : runs 4 times 20 threads each producing 64k events
  * module-reload-forever.sh : rmmod/modprobe of lttng_uevent
  * test-uevent.sh : quick wrapper for testing functionnality

Thanks!

Francis


--------------ms060204060004030101070107
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Signature cryptographique S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMUjCC
BVwwggREoAMCAQICEGWn7N/yOaERpG8kZX1Cua0wDQYJKoZIhvcNAQEFBQAwgd0xCzAJBgNV
BAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1
c3QgTmV0d29yazE7MDkGA1UECxMyVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZlcmlz
aWduLmNvbS9ycGEgKGMpMDkxHjAcBgNVBAsTFVBlcnNvbmEgTm90IFZhbGlkYXRlZDE3MDUG
A1UEAxMuVmVyaVNpZ24gQ2xhc3MgMSBJbmRpdmlkdWFsIFN1YnNjcmliZXIgQ0EgLSBHMzAe
Fw0xMjA1MjgwMDAwMDBaFw0xMzA1MjgyMzU5NTlaMIIBHzEXMBUGA1UEChMOVmVyaVNpZ24s
IEluYy4xHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxRjBEBgNVBAsTPXd3dy52
ZXJpc2lnbi5jb20vcmVwb3NpdG9yeS9SUEEgSW5jb3JwLiBieSBSZWYuLExJQUIuTFREKGMp
OTgxHjAcBgNVBAsTFVBlcnNvbmEgTm90IFZhbGlkYXRlZDEzMDEGA1UECxMqRGlnaXRhbCBJ
RCBDbGFzcyAxIC0gTmV0c2NhcGUgRnVsbCBTZXJ2aWNlMRowGAYDVQQDFBFGcmFuY2lzIEdp
cmFsZGVhdTEqMCgGCSqGSIb3DQEJARYbZnJhbmNpcy5naXJhbGRlYXVAZ21haWwuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqiOFH8B8262aBX5FMSzvA38NY4ekw6W+
zThHjeI46j7VFPXJbK0BM7yAMu4DmybyE8b5IB4oKcjRGdGC8GaMZdx0+Je0CxR/+M4hMB9s
g3JhgXLQ9RYDJKn9k0JZ59pbYsh6OMtYPX3WDCyEXBg3xkd2JQ9YiY46IJSEhfbHHE9CwaYa
f3Pbl3Bp5oi5PUADYu76ItNdHBHzBGBrkkYFaGoI5Mh27oBABvDW6QNuGvrTkkWOmFeJPNAu
AS52izUNriCmkMGNbGON3dMM7cNk1uoNXyV7vnIP0pwTm+xA5CLkvjt+/sxynJYWXqexwcer
X0VCw5Hbaqa3IxzJKB8BYwIDAQABo4HSMIHPMAkGA1UdEwQCMAAwRAYDVR0gBD0wOzA5Bgtg
hkgBhvhFAQcXATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcnBh
MAsGA1UdDwQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwUAYDVR0fBEkw
RzBFoEOgQYY/aHR0cDovL2luZGMxZGlnaXRhbGlkLWczLWNybC52ZXJpc2lnbi5jb20vSW5k
QzFEaWdpdGFsSUQtRzMuY3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAMYnv8qG3qSGJYAn+PhjGx
lbmbaxqYyD0QVRq6g8tXrZtBUqNO29mce+olKu7lHsrEHpIKwMfArh3BpxPYVhKMAP6GaCAn
jdr8LJ6TZHTLeVo4BLU7ZEPR6qCGxUhIodqzzWoet0cardf6Ub0OknxxAymgQ8+pIGJmxOOr
ypWp+3ba6dPmY/MJeXIWq08V+P6912vL6I+cwrS6e7rud0XeR9KEEqn/EpuqDpp1mNj5QeRo
73zkl8G1nBnYbr42r2jSzqxRvefsfimWm6XX2L2K9WKp6TvJhFejZ7aP234pRDx9Ep0unSH4
LR2o5p6Ik5RQaG0xu1c74KgDTyzZVn2+MIIG7jCCBdagAwIBAgIQcRVmBUrkkSFN6bxE+azT
3DANBgkqhkiG9w0BAQUFADCByjELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJ
bmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMTk5
OSBWZXJpU2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYDVQQDEzxW
ZXJpU2lnbiBDbGFzcyAxIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0aG9yaXR5
IC0gRzMwHhcNMDkwNTAxMDAwMDAwWhcNMTkwNDMwMjM1OTU5WjCB3TELMAkGA1UEBhMCVVMx
FzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3
b3JrMTswOQYDVQQLEzJUZXJtcyBvZiB1c2UgYXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29t
L3JwYSAoYykwOTEeMBwGA1UECxMVUGVyc29uYSBOb3QgVmFsaWRhdGVkMTcwNQYDVQQDEy5W
ZXJpU2lnbiBDbGFzcyAxIEluZGl2aWR1YWwgU3Vic2NyaWJlciBDQSAtIEczMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7cRH3yooHXwGa7vXITLJbBOP6bGNQU4099oL42r6
ZYggCxET6ZvgSU6Lb9UB0F8NR5GKWkx0Pj/GkQm7TDSejW6hglFi92l2WJYHr54UGAdPWr2f
0jGyVBlzRmoZQhHsEnMhjfXcMM3l2VYKMcU2bSkUl70t2olHGYjYSwQ967Y8Zx50ABMN0Iba
k2f4MwOuGjxraXj2wCyO4YM/d/mZ//6fUlrCtIcK2GypR8FUKWVDPkrAlh/Brfd3r2yxBF6+
wbaULZeQLSfSux7pg2qE9sSyriMGZSalJ1grByK0b6ZiSBp38tVQJ5op05b7KPW6JHZi44xZ
6/tu1ULEvkHH9QIDAQABo4ICuTCCArUwNAYIKwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhho
dHRwOi8vb2NzcC52ZXJpc2lnbi5jb20wEgYDVR0TAQH/BAgwBgEB/wIBADBwBgNVHSAEaTBn
MGUGC2CGSAGG+EUBBxcBMFYwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LnZlcmlzaWduLmNv
bS9jcHMwKgYIKwYBBQUHAgIwHhocaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYTA0BgNV
HR8ELTArMCmgJ6AlhiNodHRwOi8vY3JsLnZlcmlzaWduLmNvbS9wY2ExLWczLmNybDAOBgNV
HQ8BAf8EBAMCAQYwbgYIKwYBBQUHAQwEYjBgoV6gXDBaMFgwVhYJaW1hZ2UvZ2lmMCEwHzAH
BgUrDgMCGgQUS2u5KJYGDLvQUjibKaxLB4shBRgwJhYkaHR0cDovL2xvZ28udmVyaXNpZ24u
Y29tL3ZzbG9nbzEuZ2lmMC4GA1UdEQQnMCWkIzAhMR8wHQYDVQQDExZQcml2YXRlTGFiZWw0
LTIwNDgtMTE4MB0GA1UdDgQWBBR5R2EIQf04BKJL57XM9UP2SSsR+DCB8QYDVR0jBIHpMIHm
oYHQpIHNMIHKMQswCQYDVQQGEwJVUzEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4xHzAdBgNV
BAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOjA4BgNVBAsTMShjKSAxOTk5IFZlcmlTaWdu
LCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkxRTBDBgNVBAMTPFZlcmlTaWduIENs
YXNzIDEgUHVibGljIFByaW1hcnkgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHM4IRAItb
dVaEVIULAM+vOEjOsaQwDQYJKoZIhvcNAQEFBQADggEBADlNz0GZgbWpBbVSOOk5hIls5DSo
WufYbAlMJBq6WaSHO3Mh8ZOBz79oY1pn/jWFK6HDXaNKwjoZ3TDWzE3v8dKBl8pUWkO/N4t6
jhmND0OojPKvYLMVirOVnDzgnrMnmKQ1chfl/Cpdh9OKDcLRRSr4wPSsKpM61a4ScAjr+zvi
d+zoK2Q1ds262uDRyxTWcVibvtU+fbbZ6CTFJGZMXZEfdrMXPn8NxiGJL7M3uKH/XLJtSd5l
UkL7DojS7Uodv0vj+Mxy+kgOZY5JyNb4mZg7t5Q+MXEGh/psWVMu198r7V9jAKwV7QO4VRaM
xmgD5yKocwuxvKDaUljdCg5/wYIxggT5MIIE9QIBATCB8jCB3TELMAkGA1UEBhMCVVMxFzAV
BgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3Jr
MTswOQYDVQQLEzJUZXJtcyBvZiB1c2UgYXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3Jw
YSAoYykwOTEeMBwGA1UECxMVUGVyc29uYSBOb3QgVmFsaWRhdGVkMTcwNQYDVQQDEy5WZXJp
U2lnbiBDbGFzcyAxIEluZGl2aWR1YWwgU3Vic2NyaWJlciBDQSAtIEczAhBlp+zf8jmhEaRv
JGV9QrmtMAkGBSsOAwIaBQCgggLbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTEyMDcwMzE0MjM0MFowIwYJKoZIhvcNAQkEMRYEFCdkVm2oQfWExCcAjRIV
0GH38MEWMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwggEDBgkrBgEEAYI3EAQxgfUwgfIwgd0xCzAJBgNVBAYTAlVTMRcwFQYDVQQK
Ew5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazE7MDkG
A1UECxMyVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9ycGEgKGMp
MDkxHjAcBgNVBAsTFVBlcnNvbmEgTm90IFZhbGlkYXRlZDE3MDUGA1UEAxMuVmVyaVNpZ24g
Q2xhc3MgMSBJbmRpdmlkdWFsIFN1YnNjcmliZXIgQ0EgLSBHMwIQZafs3/I5oRGkbyRlfUK5
rTCCAQUGCyqGSIb3DQEJEAILMYH1oIHyMIHdMQswCQYDVQQGEwJVUzEXMBUGA1UEChMOVmVy
aVNpZ24sIEluYy4xHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOzA5BgNVBAsT
MlRlcm1zIG9mIHVzZSBhdCBodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcnBhIChjKTA5MR4w
HAYDVQQLExVQZXJzb25hIE5vdCBWYWxpZGF0ZWQxNzA1BgNVBAMTLlZlcmlTaWduIENsYXNz
IDEgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBIC0gRzMCEGWn7N/yOaERpG8kZX1Cua0wDQYJ
KoZIhvcNAQEBBQAEggEAGdzNhBBLCcsKdV5HMuI1qySwtP8GLS0+Q1FoARx8S9+eN3wPc1ct
KkfX13EEIXNZyLgcfHhwUeCmnpKHxysKk8uPAYUe16Pol7jQpu7c8Cwl01/aSU+qd7gMRxjY
rEJ93bbVRv5WbSSKy53kZdQcNeyj/BMPFfT+Hq3tJIlVxXTfFeKmroQNpetAZpLgUtjvIzM5
B4yAPe6hgHIt8p+j0XOcWupxW059Dg027TdNQ+2MbrGhgWcq1UltYxN9tiLTv7d1/pwGjeSt
QvSljay5gO54kw/ZNY2UCnW0Kmly2SdF+U5mzFp3SXFe1zUVDk4FvYkiAP5s2uSPNmVYq1c6
CQAAAAAAAA==
--------------ms060204060004030101070107--


--===============1425617121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1425617121==--
