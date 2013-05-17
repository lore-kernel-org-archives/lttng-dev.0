From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: LTTNG on Android ICS
Date: Fri, 17 May 2013 07:50:40 -0400
Message-ID: <51961990.5010801__38343.7785240405$1368791492$gmane$org@gmail.com>
References: <CAGNqz8L+Kat-C+3RLRknPHOiGXX8_1zYcKCm1j1s5tet3AsEqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1147000940=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UdJBW-0002Uf-Eo
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 07:50:54 -0400
Received: by mail-qa0-f49.google.com with SMTP id j11so327802qag.1
	for <lttng-dev@lists.lttng.org>; Fri, 17 May 2013 04:50:49 -0700 (PDT)
In-Reply-To: <CAGNqz8L+Kat-C+3RLRknPHOiGXX8_1zYcKCm1j1s5tet3AsEqA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ionut D." <ionut5001@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Ceci est un message signC) cryptographiquement au format MIME.

--===============1147000940==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000808040206070208060004"

Ceci est un message signé cryptographiquement au format MIME.

--------------ms000808040206070208060004
Content-Type: multipart/alternative;
 boundary="------------040206070107040303050604"

This is a multi-part message in MIME format.
--------------040206070107040303050604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le 2013-05-17 01:32, Ionut D. a =E9crit :
> Hello all,
>
> Recently I started to integrate LTTNG in Android ICS by compiling each
> package, each dependency, by using the Android build system. It is a
> lot of work because I met different problems and to be sincere, I do
> not know if at the end will work and I do not know how much I will
> need to modify the sources in order to work.
>
> My questions are about this integration. I mention that I read a lot
> of discussions about this on Internet, on this mailing list, but the
> things are still not very clear for me.
>
> It is ok? what I am trying to do ? to integrate and build by using the
> Android build system.
> Could you give me some guidelines, indications about how I should
> proceed, maybe a tutorial or maybe some android make files/patches
> that would help me to see how the job must be done and if I am doing
> it right ?
Hi!

A group of students at Ecole Polytechnique of Montreal worked on that
topic. They were able to get a kernel trace from Nexus 7 tablet. It
required small modifications to tools, and cleanup is in process to
merge patches upstream[1]. Kernel tracing is working, while UST requires
still some work on few bugs. I received the confirmation from the
students the build scripts they created will be released under open
source licence soon.

LTTng tools depends on two libraries libpopt and libuuid that are in
android sources. It's simpler to just build the whole thing. Once tools
are built, then they can be installed on the target.

A tutorial would be a must! I'm installing it on my phone right now, if
nobody else did the tutorial by then, I will do so. That would be great
if this was to be integrated in the dev tools in the android source repo!=


Cheers,

Francis

[1] http://git.dorsal.polymtl.ca/~cbriere?p=3Dlttng-tools.git;a=3Dsummary=

<http://git.dorsal.polymtl.ca/%7Ecbriere?p=3Dlttng-tools.git;a=3Dsummary>=

branch portAndroid-rebased-signed

--------------040206070107040303050604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Le 2013-05-17 01:32, Ionut D. a &eacut=
e;crit&nbsp;:<br>
    </div>
    <blockquote
cite=3D"mid:CAGNqz8L+Kat-C+3RLRknPHOiGXX8_1zYcKCm1j1s5tet3AsEqA@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div>Hello all,</div>
        <div><br>
        </div>
        <div>Recently I started to integrate LTTNG in Android ICS by
          compiling each package, each dependency, by using the Android
          build system. It is a lot of work because I met different
          problems and to be sincere, I do not know if at the end will
          work and I do not know how much I will need to modify the
          sources in order to work.<br>
        </div>
        <br>
        My questions are about this integration. I mention that I read a
        lot of discussions about this on Internet, on this mailing list,
        but the things are still not very clear for me.<br>
        <br>
        It is ok? what I am trying to do ? to integrate and build by
        using the Android build system.<br>
        Could you give me some guidelines, indications about how I
        should proceed, maybe a tutorial or maybe some android make
        files/patches that would help me to see how the job must be done
        and if I am doing it right ?<br>
      </div>
    </blockquote>
    Hi!<br>
    <br>
    A group of students at Ecole Polytechnique of Montreal worked on
    that topic. They were able to get a kernel trace from Nexus 7
    tablet. It required small modifications to tools, and cleanup is in
    process to merge patches upstream[1]. Kernel tracing is working,
    while UST requires still some work on few bugs. I received the
    confirmation from the students the build scripts they created will
    be released under open source licence soon.<br>
    <br>
    LTTng tools depends on two libraries libpopt and libuuid that are in
    android sources. It's simpler to just build the whole thing. Once
    tools are built, then they can be installed on the target. <br>
    <br>
    A tutorial would be a must! I'm installing it on my phone right now,
    if nobody else did the tutorial by then, I will do so. That would be
    great if this was to be integrated in the dev tools in the android
    source repo!<br>
    <br>
    Cheers,<br>
    <br>
    Francis<br>
    <meta http-equiv=3D"content-type" content=3D"text/html;
      charset=3DISO-8859-1">
    <br>
    [1]
    <meta http-equiv=3D"content-type" content=3D"text/html;
      charset=3DISO-8859-1">
    <a
href=3D"http://git.dorsal.polymtl.ca/%7Ecbriere?p=3Dlttng-tools.git;a=3Ds=
ummary">http://git.dorsal.polymtl.ca/~cbriere?p=3Dlttng-tools.git;a=3Dsum=
mary</a>
    branch portAndroid-rebased-signed<br>
  </body>
</html>

--------------040206070107040303050604--

--------------ms000808040206070208060004
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
hvcNAQkFMQ8XDTEzMDUxNzExNTA0MFowIwYJKoZIhvcNAQkEMRYEFFuA2/atLiglUBh6A9zS
ywkNg9yIMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
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
KoZIhvcNAQEBBQAEggEAfpvO5/NIuuluAkwkv93Lu2kz0YgzLEIWLduiks5cEfze57zJu1bk
J/ikqjxwbkp5d/FTVkg+PLDdoA9lKp2Rv6Np9PPaSxFj1pAk4ECpCAr5Oi2OSQ/+9wQT1RRi
he7sg++Cfl5EDq+FWeiLKDLLL9bsAcHuJTCn1M2DcIgrqcg4PSjWSKMV+PZixO7jwzaSWumJ
z4maPr4MsLwhRKwvjXjPlRKKvbHVnSWR3UPPtH75nGAsStb2/Oj9VT0b6KLFNtRvcTgO9Dey
hZm/AYV4wEmc8PlBgKnG/2bok/X3LJHmYYm+MDZ92GsAd/md7OwF+z002PDmy4VngqMaHreL
jwAAAAAAAA==
--------------ms000808040206070208060004--


--===============1147000940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1147000940==--
