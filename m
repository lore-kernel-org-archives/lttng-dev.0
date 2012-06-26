From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space
Date: Tue, 26 Jun 2012 16:52:01 +0200
Message-ID: <4FE9CC91.5030301__14079.0940182798$1340722375$gmane$org@gmail.com>
References: <1338938654-16515-1-git-send-email-francis.giraldeau@gmail.com>
	<20120626064016.GD11952@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1692546713=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1SjX7t-0001x8-4X
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 10:52:22 -0400
Received: by lboj14 with SMTP id j14so220896lbo.35
	for <lttng-dev@lists.lttng.org>; Tue, 26 Jun 2012 07:52:14 -0700 (PDT)
In-Reply-To: <20120626064016.GD11952@Krystal>
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

--===============1692546713==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms030404090609070907000301"

Ceci est un message signé cryptographiquement au format MIME.

--------------ms030404090609070907000301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le 2012-06-26 08:40, Mathieu Desnoyers a =E9crit :
>> +/*
>> + * lttng_uevent_set_handler - set handler functions for uevent
>> + *
>> + * Access to handler code is protected with rwlock in order to
>> + * prevent the optional module to be removed while in use.
>> + */
>> +
>> +void lttng_uevent_set_handler(write_ops_t handler)
>> +{
>> +	write_lock(&uevent_rwlock);
>=20
> write lock not necessary.
>=20
> if (!lttng_uevent_set_handler)
>   release refcount in prior handler's module.
>=20
> then:
> take a refcount on the module that contains the handler address.
> (explicit)


The function now looks like this:

void lttng_uevent_set_handler(struct file_operations *fops)
{
	if (lttng_uevent_handler) {
		module_put(lttng_uevent_handler->owner);
	}
	if (fops && try_module_get(fops->owner)) {
		lttng_uevent_handler =3D fops;
		return;
	}
	lttng_uevent_handler =3D NULL;
	return;
}

The problem with this approach is that lttng_uevent can't be unloaded
anymore:

  rmmod lttng_uevent
  ERROR: Module lttng_uevent is in use

The module lttng_uevent can't be unloaded without unloading the module
lttng_tracer. The function module_exit of lttng_uevent is never called,
such that there is a chicken-and-egg situation. This problem was solved
by using rwlock to access the handler pointer. In the rare event when
unload module would occur while a trace event is recorded, the write
lock was preventing to change the handler pointer while it's in use. But
maybe there is another way to do it?

Thanks!

Francis Giraldeau


--------------ms030404090609070907000301
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
xmgD5yKocwuxvKDaUljdCg5/wYIxggTsMIIE6AIBATCB8jCB3TELMAkGA1UEBhMCVVMxFzAV
BgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3Jr
MTswOQYDVQQLEzJUZXJtcyBvZiB1c2UgYXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3Jw
YSAoYykwOTEeMBwGA1UECxMVUGVyc29uYSBOb3QgVmFsaWRhdGVkMTcwNQYDVQQDEy5WZXJp
U2lnbiBDbGFzcyAxIEluZGl2aWR1YWwgU3Vic2NyaWJlciBDQSAtIEczAhBlp+zf8jmhEaRv
JGV9QrmtMAkGBSsOAwIaBQCgggLOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTEyMDYyNjE0NTIwMVowIwYJKoZIhvcNAQkEMRYEFHqOG+JEzri7MhAIb/TB
gM+N+P2MMF8GCSqGSIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCCAQMG
CSsGAQQBgjcQBDGB9TCB8jCB3TELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJ
bmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQLEzJUZXJtcyBv
ZiB1c2UgYXQgaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYSAoYykwOTEeMBwGA1UECxMV
UGVyc29uYSBOb3QgVmFsaWRhdGVkMTcwNQYDVQQDEy5WZXJpU2lnbiBDbGFzcyAxIEluZGl2
aWR1YWwgU3Vic2NyaWJlciBDQSAtIEczAhBlp+zf8jmhEaRvJGV9QrmtMIIBBQYLKoZIhvcN
AQkQAgsxgfWggfIwgd0xCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEf
MB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazE7MDkGA1UECxMyVGVybXMgb2YgdXNl
IGF0IGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9ycGEgKGMpMDkxHjAcBgNVBAsTFVBlcnNv
bmEgTm90IFZhbGlkYXRlZDE3MDUGA1UEAxMuVmVyaVNpZ24gQ2xhc3MgMSBJbmRpdmlkdWFs
IFN1YnNjcmliZXIgQ0EgLSBHMwIQZafs3/I5oRGkbyRlfUK5rTANBgkqhkiG9w0BAQEFAASC
AQBZZj1cOCu0Jdx4KsmKCKcEPnUmBwT6ISeONsr7N2b2e9aL3rdovoJaL4B1tMSuCn6SgUdR
njrgDVJxZEzMNm0mHXbZ5F24iK9nawf+xwe3k2l9KI/HCCMio+HCebCl7SGVjpekTne9xQrl
ceI3/n9sI/DCYTaHQ/vXkFCIX4Ixsxa8X00hP9e1NcT+Hbn40m1JntlIzVQizVBeHQXeSHdB
sBewiO2NfNHCXn+FnXKsGt16he4D1nUHIk9zVpQEApaH5UkoAyopRTT+DhL/bUwlx9VTHeZB
QFwLngD/Lg0Vw1lsFexWcEstQCpK6e+F6zPH1PcWwU4al5GMlZFTTaY+AAAAAAAA
--------------ms030404090609070907000301--


--===============1692546713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1692546713==--
