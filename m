From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Some questions about Lttng
Date: Tue, 19 Jun 2012 11:28:01 +0200
Message-ID: <4FE04621.3070806__33867.8794717$1340098146$gmane$org@gmail.com>
References: <6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1143269404=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1SgujM-0007zO-Uf
	for lttng-dev@lists.lttng.org; Tue, 19 Jun 2012 05:28:14 -0400
Received: by lboj14 with SMTP id j14so6775669lbo.35
	for <lttng-dev@lists.lttng.org>; Tue, 19 Jun 2012 02:28:06 -0700 (PDT)
In-Reply-To: <6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.com>
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

--===============1143269404==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms080506030307040101090503"

Ceci est un message signé cryptographiquement au format MIME.

--------------ms080506030307040101090503
Content-Type: multipart/alternative;
 boundary="------------060507010207030605060807"

This is a multi-part message in MIME format.
--------------060507010207030605060807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le 2012-06-19 05:50, Zheng.Chang@emc.com a =E9crit :
>
> Hi folks,
>
> =20
>
> I'm studying how to use Lttng now. I built a kernel which version is
> 2.6.38 and ran with lttng 2.0.
>
> I got some confused when I started to use it. Here are my questions:
>
> =20
>
> 1. I didn't see kernel patches for kernel 3.x. Does it mean kernel 3.x
> support it already?
>

You don't need a kernel patch with lttng 2.0, only modules are required.
It uses the tracepoints already present in the kernel, and trace system
calls, and uses perf performance counters and kprobes.

> 2. I tried to do something like, dump the arguments of system call, or
> dump a backtrace in a specified function. But the output of lttng is
> very limited. Is there a way to do that with lttng?
>

If system calls are enabled, arguments are supposed to be dumped (option
--syscall to lttng enable-event). If it's not the case, then are you
sure you are using lttng 2.0 and not 0.12? ;) Because the older version
has a different behavior. One additional note: few system calls do not
have all their arguments decoded in lttng 2, but there are only a few.

> 3. I looked into some UST examples and found here are three header
> files:  tracepoint.h, tracepoint-event.h and ust-tracepoint-event.h.
> They have some duplicated macro definitions like TRACEPOINT_EVENT.
>

The macros are quite complicated. Some includes files are included more
than once to generate various portion of the tracepoint code. So, my
advice here is to take a working example and adapt it to your needs.

> And the examples includes all of these three header files despite no
> conflict here. Could someone help to explain the intention?
>
> 4. Once I defined a tracepoint in my code, seems some initializations
> would register default probe into the hook point.  How to disable the
> default probe and  register my self-defined probes?
>

You mean, call a custom function when tracepoint is executed? Maybe
somebody else has an answer, but AFAIK this is not possible. But you
could make a wrapper to your tracepoint and then call your additional
function there.

> 5. Does lttng-ust support dynamic traceing like kprobe?
>

AFAIK, the kernel tracer supports kprobe, but not UST. Maybe somebody
else can confirm/infirm the dynamic tracepoint feature in user-space?

You can use a feature of GCC to regiter callback on function entry and
exit, but since it executes for all functions, then the overhead is very
high. You can have a look here:

https://github.com/giraldeau/workload-kit/blob/master/ust/cyg.c

Cheers,

Francis

--------------060507010207030605060807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Le 2012-06-19 05:50, <a class=3D"moz-txt-link-abbreviated" href=3D"ma=
ilto:Zheng.Chang@emc.com">Zheng.Chang@emc.com</a> a &eacute;crit&nbsp;:
    <blockquote
cite=3D"mid:6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.c=
om"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3DISO-8859-1">
      <meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
=2EMsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal">Hi folks,<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">I&#8217;m studying how to use Lttng now. I=
 built
          a kernel which version is 2.6.38 and ran with lttng 2.0.<o:p></=
o:p></p>
        <p class=3D"MsoNormal">I got some confused when I started to use
          it. Here are my questions:<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class=3D"MsoNormal">1. I didn&#8217;t see kernel patches for k=
ernel
          3.x. Does it mean kernel 3.x support it already? <o:p></o:p></p=
>
      </div>
    </blockquote>
    <br>
    You don't need a kernel patch with lttng 2.0, only modules are
    required. It uses the tracepoints already present in the kernel, and
    trace system calls, and uses perf performance counters and kprobes.
    <br>
    <br>
    <blockquote
cite=3D"mid:6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.c=
om"
      type=3D"cite">
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal">2. I tried to do something like, dump the
          arguments of system call, or dump a backtrace in a specified
          function. But the output of lttng is very limited. Is there a
          way to do that with lttng?</p>
      </div>
    </blockquote>
    <br>
    If system calls are enabled, arguments are supposed to be dumped
    (option --syscall to lttng enable-event). If it's not the case, then
    are you sure you are using lttng 2.0 and not 0.12? ;) Because the
    older version has a different behavior. One additional note: few
    system calls do not have all their arguments decoded in lttng 2, but
    there are only a few. <br>
    <br>
    <blockquote
cite=3D"mid:6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.c=
om"
      type=3D"cite">
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"><o:p></o:p></p>
        <p class=3D"MsoNormal">3. I looked into some UST examples and
          found here are three header files:&nbsp; tracepoint.h,
          tracepoint-event.h and ust-tracepoint-event.h. They have some
          duplicated macro definitions like TRACEPOINT_EVENT.</p>
      </div>
    </blockquote>
    <br>
    The macros are quite complicated. Some includes files are included
    more than once to generate various portion of the tracepoint code.
    So, my advice here is to take a working example and adapt it to your
    needs. <br>
    <br>
    <blockquote
cite=3D"mid:6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.c=
om"
      type=3D"cite">
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"><o:p></o:p></p>
        <p class=3D"MsoNormal">And the examples includes all of these
          three header files despite no conflict here. Could someone
          help to explain the intention?<o:p></o:p></p>
        <p class=3D"MsoNormal">4. Once I defined a tracepoint in my code,=

          seems some initializations would register default probe into
          the hook point.&nbsp; How to disable the default probe and&nbsp=
;
          register my self-defined probes?</p>
      </div>
    </blockquote>
    <br>
    You mean, call a custom function when tracepoint is executed? Maybe
    somebody else has an answer, but AFAIK this is not possible. But you
    could make a wrapper to your tracepoint and then call your
    additional function there. <br>
    <br>
    <blockquote
cite=3D"mid:6539770C71C3814BB0BFC2DBEBD105087948C2@CORPUSMX30B.corp.emc.c=
om"
      type=3D"cite">
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"><o:p></o:p></p>
        <p class=3D"MsoNormal">5. Does lttng-ust support dynamic traceing=

          like kprobe?</p>
      </div>
    </blockquote>
    <br>
    AFAIK, the kernel tracer supports kprobe, but not UST. Maybe
    somebody else can confirm/infirm the dynamic tracepoint feature in
    user-space?<br>
    <br>
    You can use a feature of GCC to regiter callback on function entry
    and exit, but since it executes for all functions, then the overhead
    is very high. You can have a look here: <br>
    <br>
    <meta http-equiv=3D"content-type" content=3D"text/html;
      charset=3DISO-8859-1">
    <a
      href=3D"https://github.com/giraldeau/workload-kit/blob/master/ust/c=
yg.c">https://github.com/giraldeau/workload-kit/blob/master/ust/cyg.c</a>=
<br>
    <br>
    Cheers, <br>
    <br>
    Francis<br>
  </body>
</html>

--------------060507010207030605060807--

--------------ms080506030307040101090503
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
hvcNAQkFMQ8XDTEyMDYxOTA5MjgwMVowIwYJKoZIhvcNAQkEMRYEFBJyUht0q3mAaru+Ns31
3KAg7C9qMF8GCSqGSIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqG
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
AQAqhhqKso5lSaBzy3a017Y72T/ti/LXe6RwzZZLrGik1qurPhQLigleu/DLv38vS9YZpck6
/Pl7Zqe4W35vFzuxb6lmWUweVHN3ehd4V/Nk0HwGQrOFkaPa5PYPa2Va56kLbWd6bnC4C0T6
a+6SjzxN4/E3iRr929BmGbDlhw5da783xn16NoG3bNjcaoQG9uMqzv1UfSKm+gtmQkt/Drj0
PAypE0OJSfzwQdndWm5kr+gxHWSxsFSs8qFA1HCIVNG1H6beU51iLiQSLlC1Vu7Ftny0+t/N
lGrIMslzyc2tvTPOM7eXqfRzx/rf8zT86IgqnTu3gy3gQGnDDGTUHkH4AAAAAAAA
--------------ms080506030307040101090503--


--===============1143269404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1143269404==--
