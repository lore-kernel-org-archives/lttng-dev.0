From: Thomas McGuire <thomas.mcguire@kdab.com>
Subject: Re: Wrong timestamps in trace
Date: Tue, 13 Jun 2017 11:31:39 +0200
Message-ID: <7c59a802-b9f7-d973-8a01-f86eda8fa5de__585.292318328534$1497346322$gmane$org@kdab.com>
References: <9396da08-11fe-bb73-0915-7feaf8ef38ae@kdab.com>
 <1444561955.10915.1497283734936.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8899383002791509597=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3wn4MX3T2Xz113N
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2017 09:33:44 +0000 (UTC)
In-Reply-To: <1444561955.10915.1497283734936.JavaMail.zimbra@efficios.com>
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

--===============8899383002791509597==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040702020407070508020708"

This is a cryptographically signed message in MIME format.

--------------ms040702020407070508020708
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

On 12.06.2017 18:08, Mathieu Desnoyers wrote:
>> I'm struggling to get lttng to run on an i.MX 25 board. I got everythi=
ng
>> working, however the timestamps in the resulting trace file are all th=
e
>> same. Because of the timestamps, TraceCompass fails at visualizing the=

>> schedule.
>> I record on the device and then copy the trace over to my host to
>> examine it with babeltrace. See attached text files for the start and
>> the end of the trace, showing the timestamps being the same, despite t=
he
>> trace running for a few seconds.
>>
>> The output of lttng-sessiond -v is also attached.
>>
>> I started everything the following way:
>>  cd /lib/modules/4.9.28-20170428-1/kernel/extra
>>  find . -type f -exec insmod {} \;
>>  find . -type f -exec insmod {} \;
>>  find . -type f -exec insmod {} \;
>>  find . -type f -exec insmod {} \;
>> lttng-sessiond -v --consumerd32-path=3D/usr/bin/lttng-consumerd &>
>> sessiond-log.txt
>>  lttng create my-session --output=3D/home/lttng/my-trace
>>  lttng enable-event --kernel --syscall --all --channel channel0
>>  lttng enable-event --kernel --channel channel0 sched*
>>  lttng start
>>  sleep 5 # do something
>>  lttng stop
>>
>> The Linux distribution is Pengutronix's ptxdist, which doesn't have
>> lttng rules, so I manually cross-compiled lttng-tools 2.9.4 and
>> lttng-modules 2.9.2. Kernel is 4.9.28-20170428-1, babeltrace on the ho=
st
>> is 1.2.4.
>>
>> What do I need to do to get correct timestamps?
>
> Hi Thomas,
>
> It appears like you may have the lttng-modules tests/clock-plugin
> kernel module loaded, which overrides the clock source with a
> "dummy" clock for testing purposes.
>
> Can you provide the output of lsmod ? Or did you build lttng
> within your kernel image ? If so, what is your kernel config ?
>
> Can you also provide the "metadata" file generated as attachment ?
> It will allow us to confirm whether it's using the kernel clock
> ("monotonic") or the dummy test clock ("lttng_test_clock_override").

Thanks for the quick response, that was exactly my problem! I simply=20
issued an "insmod" on every lttng-related .ko file that lttng built, and =

that included the test clock plugin.
The reason why I used "insmod" is that for me, lttng-sessiond didn't=20
load the lttng modules itself. I looked at this further now, and the=20
reason was that I didn't issue a "depmod -a". With that, everything now=20
works perfectly, the timestamps are correct and TraceCompass shows me a=20
nice schedule :)

Thanks again for your help and every developer here for providing lttng, =

it's a great tool.

Regards,
Thomas
--=20
Thomas McGuire | thomas.mcguire@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH & Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts


--------------ms040702020407070508020708
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwNjEzMDkzMTM5WjAvBgkqhkiG9w0BCQQxIgQgqdb8
wJlTI80DWuHt2S1HX+KxtnBPu7poiHM+FGIAGOcwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBwQYJKwYBBAGCNxAEMYGzMIGwMIGb
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNI
QS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEBkjst7K
FIyU3Z7i/3fodCIwgcMGCyqGSIb3DQEJEAILMYGzoIGwMIGbMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFD
T01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEBkjst7KFIyU3Z7i/3fodCIwDQYJKoZI
hvcNAQEBBQAEggEASl4E3wKo3aTf7yBvan4J7UeQ9QdiE8nsS+5c6pvTPMfzD/RdUGIf9JNU
BFmu1bULD6kPTItncmtqroPQyV6yYm6ntrS4L4QF+Gm10GpbvtLa6HqQHvHIokh9N5RevZVR
5vCVd2D7izQOI+fyr49wg6nPWyaQnMgINw6dlYJcZNwink0jcoLdrsNeW5POApJBo0+pNi8n
J8KcJZP7BI29v+bfOdDXqLYxhuvVBWLkUzVLstiNzol0fytY5jnhqhRai2+6g/oT8AWnjckn
ZpareQfHLCzFUAIs7t0Hre4dQKemPgfpJAb8cUIB3jT/zV+lE1YPbpQzR3wdK8EnopzbuQAA
AAAAAA==
--------------ms040702020407070508020708--

--===============8899383002791509597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8899383002791509597==--
