From: Thomas McGuire <thomas.mcguire@kdab.com>
Subject: Re: Allocation failures with babeltrace and
 TraceCompass - corrupt trace?
Date: Wed, 14 Jun 2017 17:55:57 +0200
Message-ID: <85fce57d-85e8-7ce8-998b-7fd7e91f6002__30253.1333327808$1497456336$gmane$org@kdab.com>
References: <077661a3-81fb-b8e7-bf3b-15167c9240cc@kdab.com>
 <2088647396.12698.1497453179549.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0693228469842574132=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3wnrrT4fd5z123x
 for <lttng-dev@lists.lttng.org>; Wed, 14 Jun 2017 15:58:01 +0000 (UTC)
In-Reply-To: <2088647396.12698.1497453179549.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a cryptographically signed message in MIME format.

--===============0693228469842574132==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090309080709030007020905"

This is a cryptographically signed message in MIME format.

--------------ms090309080709030007020905
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 14.06.2017 17:12, Mathieu Desnoyers wrote:
> Can you provide a copy of the metadata file ? And ideally the data
> streams too ? This would give us a better idea of what is happening.
>=20
> Do you perform kernel or user-space tracing ? Do you trace huge
> sequences of bytes within your own tracepoints ?

I perform kernel traceing only, in this case limited to syscalls,
sched*, block* and irq*. No user-space tracepoints.

I didn't know the metadata file was plain text, I had a quick look into
it and noticed corruption already, with random garbage data inserted all
over the place. I'm surprised babeltrace didn't choke on the metadata
already.
I can not provide the data file as it has confidential data. Looking at
it with a hex editor, I see the same kind of garbage as in the metadata
file, so both files are affected by the same problem.

I've uploaded the metadata file to
http://www.kdab.com/~thomas/stuff/metadata.

To double-check that it isn't file system corruption, I ran "yes >
test.data" - that file is OK, so it's probably a different problem.

Any idea what can cause the corrupted trace?

Regards,
Thomas
--=20
Thomas McGuire | thomas.mcguire@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts


--------------ms090309080709030007020905
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Cx0wggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4
dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290
MB4XDTE0MTIyMjAwMDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAImxDdp6UxlOcFIdvFamBia3uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdh
TpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYepLkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak
+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayTQLm1CJM6nCpToxDbPSBhPFUDjtlOdiUC
ISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9UjewM2ktQ+v61qXxl3dnUYzZ7ifr
vKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3RhUL7GQD/L5OKfoiECAwEAAaOC
ARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1QaMB0GA1UdDgQWBBSSYWuC
4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAd
BgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4dGVybmFs
Q0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb
4yJjnFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ
26Y3NOh74AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT
9HaSyoY0B7ksyuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInl
tukWeh95FPZKEBom+nyK+5swggZmMIIFTqADAgECAhAZI7LeyhSMlN2e4v936HQiMA0GCSqG
SIb3DQEBCwUAMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UE
AxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0EwHhcNMTYwNTIwMDAwMDAwWhcNMTkwNTIwMjM1OTU5WjCCAV0xCzAJBgNVBAYTAlNF
MQ8wDQYDVQQREwY2ODMgMzExEjAQBgNVBAgTCVZhZXJtbGFuZDEQMA4GA1UEBxMHSGFnZm9y
czEYMBYGA1UECRMPTm9ycmluZ3MgdmFlZyAyMQ8wDQYDVQQSEwZCb3ggMzAxJjAkBgNVBAoM
HUtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCMR0wGwYDVQQLExRBIEtEQUIgR3JvdXAg
Q29tcGFueTFDMEEGA1UECww6SXNzdWVkIHRocm91Z2ggS2xhcsOkbHZkYWxlbnMgRGF0YWtv
bnN1bHQgQUIgRS1QS0kgTWFuYWdlcjEfMB0GA1UECxMWQ29ycG9yYXRlIFNlY3VyZSBFbWFp
bDEXMBUGA1UEAxMOVGhvbWFzIE1jR3VpcmUxJjAkBgkqhkiG9w0BCQEWF3Rob21hcy5tY2d1
aXJlQGtkYWIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuDecKvDdY1ph
SHzfXH9PNNU9p/uUYczsDFcOhZhgliTQIkhKYzfKHDS9whGctQgk24WW4pWljmqe04yR9PAa
7W6P33fUIpRbLXpcJH/kbB5KKFvu6ngNCvvsMcc99O8VUpwpAQxQzD1wE2JMTaQP3qncEWnA
w5BxqKmNwsPWSA83rtIymqdywH+XpW6OlGnobIeWbJs01DyWtk3fSihXkIScdSbseURGfe5I
h8dgtwKcDOclIZMOpNrTIeUptaBgz0agyumGUng674yjLCsq2y56M0GVVqV/UuQVXD3hZ0sd
NI6QwEpVv9SqYNG9P6EFZDLWOMoQ/Wr381u50Gi9SQIDAQABo4IB3zCCAdswHwYDVR0jBBgw
FoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFFJkf3u3i5ya0btTxeE7SBUfMb4V
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggr
BgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1odHRw
czovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBdBgNVHR8EVjBUMFKgUKBOhkxodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3JsMIGQBggrBgEFBQcBAQSBgzCBgDBYBggrBgEFBQcwAoZMaHR0cDovL2Ny
dC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1
cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCIG
A1UdEQQbMBmBF3Rob21hcy5tY2d1aXJlQGtkYWIuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQAr
10v3g3pwIwMrlnY0+Th+xn3abKxWFnjyMU53hI9AvSuw3GlnxxuCSRtqvAuOhT3UyPx0SmCa
JmK4kWLmw7kcpCev9M0MX9CAoih81htOi227ejkK3I3+C+7x73/xaFRWxC33bO7aHF/UPF0D
SuB7AJ7YbL/i/xk8hoTfi2ht5mzP22pkVYVjvQZsBB5wXMEGytPC5p1KXfK7kPF0JzwnnHGh
ykXopklCR8QY65FULJHT/ESjEJ/8+XTx0HCkmGYja6n+9Zwh1oP9nXeIBrolhJIf74n97f3K
cSbqGQDVuoH0JyUG9OtMpaEXoBw9TRX7qmfxjlYXdNjYRK/0NCE2MYIEQTCCBD0CAQEwgbAw
gZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcT
B1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8g
U0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQGSOy
3soUjJTdnuL/d+h0IjANBglghkgBZQMEAgEFAKCCAmEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwNjE0MTU1NTU3WjAvBgkqhkiG9w0BCQQxIgQg6gYt
jVoT4qpiorEq6Ik9tiJDfsmXojMBZCVlTj0dtpAwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBwQYJKwYBBAGCNxAEMYGzMIGwMIGb
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNI
QS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEBkjst7K
FIyU3Z7i/3fodCIwgcMGCyqGSIb3DQEJEAILMYGzoIGwMIGbMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFD
T01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEBkjst7KFIyU3Z7i/3fodCIwDQYJKoZI
hvcNAQEBBQAEggEAQ0BVsAar7U6asNzXq8zBgILronDiBq69XtuGhE+/0E1Q73S+WrDvSRLF
uISLcb+4P9Vb4pVKq5UqArpVgeOksriBUl8H0W3xVWpGYFE8ArfgCLBX4eLogDeTokTNAdmP
AR/8PFwHDlIFP+LxiSi+uBgvZTQ4ZJqCmg7dnh6vIwUEhl0v4zYabVWCvq7ZM7hvxaYLXmZ0
kyuJUH9CHmXh3CLCBWauiqAebyI0v/GE4pvFQcwpP4RfJMJRqGjrALRWtY531UimOiC8Y93F
kCq51LOBIMiJWq1mlfgqJg5Z1T8OUhul03rXyDMtWjrxEVdIF0BK3VAcgnMa2a/EyEFRggAA
AAAAAA==
--------------ms090309080709030007020905--

--===============0693228469842574132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0693228469842574132==--
