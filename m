From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: UST context causes empty trace
Date: Sun, 12 May 2013 11:00:09 -0400
Message-ID: <518FAE79.1010009__45549.9267475263$1368370854$gmane$org@gmail.com>
References: <518EEC19.6080504@gmail.com> <20130512030802.GE405@Krystal>
	<CAJ7wx-EoDjkgv=Pk8RjtbhyRy6eOM7RoJmhBEg5XA_xOxLMgWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1841436433=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1UbXl3-0004Cc-EE
	for lttng-dev@lists.lttng.org; Sun, 12 May 2013 11:00:17 -0400
Received: by mail-qa0-f43.google.com with SMTP id bs12so1037788qab.9
	for <lttng-dev@lists.lttng.org>; Sun, 12 May 2013 08:00:12 -0700 (PDT)
In-Reply-To: <CAJ7wx-EoDjkgv=Pk8RjtbhyRy6eOM7RoJmhBEg5XA_xOxLMgWA@mail.gmail.com>
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

--===============1841436433==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms090507080105010408070700"

Ceci est un message signé cryptographiquement au format MIME.

--------------ms090507080105010408070700
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I confirm that this patch solved the problem.

Thanks!

Francis

Le 2013-05-12 05:27, Zifei Tong a =C3=A9crit :
> Hi,
>
> I did some debugging one this issue. The problem only occurs when we
> have more than one context field.
> So this will not work, too:
>
> lttng create
> lttng enable-event -a -u
> lttng add-context -u -t vpid
> lttng add-context -u -t vtid
> lttng start
> $@
> lttng stop
> sleep 1
> lttng view
> lttng destroy
>
> The problem I found out is wrong `fields` argument passed into
> `ustcomm_register_channel`.
> The `fields` argument passed is a pointer to the `event_field` of the
> first element in a `lttng_ctx_field` array,
> but not a `lttng_event_field` array as expected.
>
> Please see the patch for more details.
>
> The patch works on my machine. But I wonder if there is something
> wrong or maybe a better fix.
> Please review.
>
> Thanks,
>
> Zifei Tong
>
> Signed-off-by: Zifei Tong <soariez@gmail.com>
> ---
>  liblttng-ust/lttng-events.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
> index e4faf60..7afe13f 100644
> --- a/liblttng-ust/lttng-events.c
> +++ b/liblttng-ust/lttng-events.c
> @@ -260,9 +260,10 @@ int lttng_session_enable(struct lttng_session *ses=
sion)
>  	 */
>  	cds_list_for_each_entry(chan, &session->chan_head, node) {
>  		const struct lttng_ctx *ctx;
> -		const struct lttng_event_field *fields =3D NULL;
> +		struct lttng_event_field *fields =3D NULL;
>  		size_t nr_fields =3D 0;
>  		uint32_t chan_id;
> +		int i;
>
>  		/* don't change it if session stop/restart */
>  		if (chan->header_type)
> @@ -270,7 +271,9 @@ int lttng_session_enable(struct lttng_session *sess=
ion)
>  		ctx =3D chan->ctx;
>  		if (ctx) {
>  			nr_fields =3D ctx->nr_fields;
> -			fields =3D &ctx->fields->event_field;
> +			fields =3D malloc(nr_fields * sizeof(struct lttng_event_field));
> +			for (i =3D 0; i < nr_fields; i++)
> +				fields[i] =3D ctx->fields[i].event_field;
>  		}
>  		ret =3D ustcomm_register_channel(notify_socket,
>  			session->objd,
> @@ -279,6 +282,8 @@ int lttng_session_enable(struct lttng_session *sess=
ion)
>  			fields,
>  			&chan_id,
>  			&chan->header_type);
> +		if (fields !=3D NULL)
> +			free(fields);
>  		if (ret) {
>  			DBG("Error (%d) registering channel to sessiond", ret);
>  			return ret;



--------------ms090507080105010408070700
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
hvcNAQkFMQ8XDTEzMDUxMjE1MDAwOVowIwYJKoZIhvcNAQkEMRYEFH8eD1SeyRcNqjR2iQ9n
9rxOXlyvMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
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
KoZIhvcNAQEBBQAEggEAdjQ6Rso6V2zp8t1eXHLvyKk7tR2AAl+qsj3huPtRiAeeK0SwwxnT
AH7TKxRrRhUsFp+YcVv0qK6e9twSzfyjKyKVFwZRpNlIqOjw1KHEXi4Xz5QJ4NHO7YPm9Tm3
xnNuSwHLzTxCjWoK3Xou/DgI9tUF1/Jl7/vRt+BaI+Agi1YoD/aDsMuPqcA/7yD7Y7hpqJ0S
JuEpTXNzK2xAkzHtfvM4Z6NZ0ouhM4Pm/3+N0GWsMQR/RYhPNC4gzRO6pBgr9bIxtRjLoYAG
ymmR/SBfQeeIg7Pvk6HawkJ+aG3IYD345o6FJuPRsXvoJB9r2NsS03gxrSoToNTmimmqdmJT
HAAAAAAAAA==
--------------ms090507080105010408070700--


--===============1841436433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1841436433==--
