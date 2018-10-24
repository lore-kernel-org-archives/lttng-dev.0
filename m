From: "Scheler, Fabian (CT RDA IOT SES-DE)" <Fabian.Scheler@siemens.com>
Subject: LTTNG-ust detailed architecture?
Date: Wed, 24 Oct 2018 12:53:28 +0200
Message-ID: <6dea49d5-f25b-a790-3354-e961e739bb1e__838.394036009227$1540378297$gmane$org@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5590252125865085136=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by lists.lttng.org (Postfix) with ESMTPS id 42g6Yn1Ft6zg46
 for <lttng-dev@lists.lttng.org>; Wed, 24 Oct 2018 06:53:32 -0400 (EDT)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w9OArUHb016617
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <lttng-dev@lists.lttng.org>; Wed, 24 Oct 2018 12:53:31 +0200
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a cryptographically signed message in MIME format.

--===============5590252125865085136==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070707030408030308080605"

This is a cryptographically signed message in MIME format.

--------------ms070707030408030308080605
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

we would like to trace real-time applications and we consider LTTNG-ust=20
as one possible way to do this. But before we go for LTTNG-ust, we need=20
to estimate the impact LTTNG-ust could have on the instrumented=20
application. While I consider the user-manual of LTTNG-ust to be really=20
great, I am missing a more detailed architecture documentation, that=20
would be really helpful to answer this question.

Having a look at the picture here

https://lttng.org/docs/v2.10/#doc-plumbing

I want to review these component interactions more closely:

1. Session daemon -> liblttng-ust

This library seems to create a new thread in the context of the=20
instrumented application. How could this thread impact the run-time=20
behavior of the instrumented application, when it comes to

- submitting events to the buffer

   * Which component controls/instantiates/maintains the buffer?
   * How is the buffer synchronized?

- setting event-rules (i.e. enabling/disabling events)
- starting tracing sessions
- ...

   * What does happen along the red dashed arrow
     "Session Daemon -> liblttng-ust"?

2. liblttng-ust -> Consumer daemon

At some point the consumer daemon reads the events stored in the buffer=20
and writes them to some output-file.

   * What does happen along the violet arrow
     "liblttng-ust -> Consumer daemon"?
   * Could the instrumented application be affected here somehow?

Is this documented somewhere - maybe I simply missed it.

Ciao
Fabian
--=20
With best regards,
Dr. Fabian Scheler

Siemens AG
Corporate Technology
Research and Development for Digitalization and Automation
Smart Embedded Systems
CT RDA IOT SES-DE
Guenther-Scharowsky-Str. 1
91058 Erlangen, Germany
Tel.: +49 1522 1702973
Mobile: +49 1522 1702973
mailto:fabian.scheler@siemens.com

www.siemens.com/ingenuityforlife

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim=20
Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and=20
Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich,=20
Janina Kugel, Cedrik Neike, Michael Sen, Ralf P. Thomas; Registered=20
offices: Berlin and Munich, Germany; Commercial registries: Berlin=20
Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322


--------------ms070707030408030308080605
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Er0wggYnMIIFD6ADAgECAgQLJ1ECMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQGEwJERTEQ
MA4GA1UECgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaWTMxOjA4BgNVBAsMMUNvcHlyaWdo
dCAoQykgU2llbWVucyBBRyAyMDEzIEFsbCBSaWdodHMgUmVzZXJ2ZWQxJzAlBgNVBAMMHlNp
ZW1lbnMgSXNzdWluZyBDQSBFRSBFbmMgMjAxMzAeFw0xNjEwMjAwNjIxMzJaFw0xOTEwMjAw
NjIxMzJaMGExETAPBgNVBAUTCFowMDJZSlRLMQ8wDQYDVQQqDAZGYWJpYW4xEDAOBgNVBAQM
B1NjaGVsZXIxEDAOBgNVBAoMB1NpZW1lbnMxFzAVBgNVBAMMDlNjaGVsZXIgRmFiaWFuMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtKvENt7j2pUqvDJ6fWAt3PnYZ+qKLUEG
omWHKE+b6nZEfhNWTu046yImoE46o9m3mC2Woe5E59cl1y/Sq/Sere4h79gM/09Ay5Q3m7Ox
TQsFVlzP1xQK3UhT/t0+2G+1oA95aVap2AKFP+/CSfiuX61/B7xlKDMUw1A0o9aXicmUx6Gq
YrKyq6imz24mRkcnfjnjVVqfyGsKrianD5rsf+cWcn7rMY5KW7pFfayxLnyGdnaDuVCI3Efy
iBMjWEc0F/JjcgPeXGeCsWHCDY7QNlkg6wdgqSFKcIaRURC6LYO0R/nYGyVJJcp5nQVQmdFT
RW26uOaSzIQ/ZgBV8EHZdwIDAQABo4ICrjCCAqowggEEBggrBgEFBQcBAQSB9zCB9DAyBggr
BgEFBQcwAoYmaHR0cDovL2FoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpZMy5jcnQwQQYIKwYB
BQUHMAKGNWxkYXA6Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpZMyxMPVBLST9jQUNlcnRp
ZmljYXRlMEkGCCsGAQUFBzAChj1sZGFwOi8vYWwuc2llbWVucy5jb20vQ049WlpaWlpaWTMs
bz1UcnVzdGNlbnRlcj9jQUNlcnRpZmljYXRlMDAGCCsGAQUFBzABhiRodHRwOi8vb2NzcC5w
a2ktc2VydmljZXMuc2llbWVucy5jb20wHwYDVR0jBBgwFoAUZZJ8NWwp086shGT+vbyANu0a
hgswDAYDVR0TAQH/BAIwADAaBgNVHSAEEzARMA8GDSsGAQQBoWkHAgIDAQMwgcoGA1UdHwSB
wjCBvzCBvKCBuaCBtoYmaHR0cDovL2NoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpZMy5jcmyG
QWxkYXA6Ly9jbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpZMyxMPVBLST9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0hklsZGFwOi8vY2wuc2llbWVucy5jb20vQ049WlpaWlpaWTMsbz1UcnVz
dGNlbnRlcj9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MDIGA1UdJQQrMCkGCCsGAQUFBwME
BgorBgEEAYI3CgMEBgsrBgEEAYI3CgMEAQYEVR0lADAOBgNVHQ8BAf8EBAMCBDAwJQYDVR0R
BB4wHIEaZmFiaWFuLnNjaGVsZXJAc2llbWVucy5jb20wHQYDVR0OBBYEFN3qmAmIeCyez/8B
qsukPKSRkEJAMA0GCSqGSIb3DQEBCwUAA4IBAQAuJMIWTrdNbKArF8oahzrvodjdRM+imm7I
b8/GwmB+TW+BoWnZR1lRGR+QNHrFS0OGNZ+rPFBvvJjAowbOmOry+gZchCvx9IyWvRRmswbk
0EI3GIwk/rtLlFakuBOFkiGAVMqPLr5f3tJfYuOZikkHun0rGelvvAqYLwPP7xuHZS+M+jsc
oJcprYoReb1nywfIWnk2UDSNxSQlmoTN5cK8jEZmfwi/jP60yxqbnvUFdFOxnmh76Zw4sIsP
DQy3umFWHSF2Z9nn4vwpS7MAS5hcuRUMZZDzPQgngGUeybMCwIWew8hMC4NwA4a7SRI2Xcac
mBWz3M/+rEuoJ8nSA6t7MIIGNTCCBR2gAwIBAgIEWXAI+TANBgkqhkiG9w0BAQUFADCBmjEL
MAkGA1UEBhMCREUxEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpaWlpaWlYxMTowOAYD
VQQLDDFDb3B5cmlnaHQgKEMpIFNpZW1lbnMgQUcgMjAxMSBBbGwgUmlnaHRzIFJlc2VydmVk
MSowKAYDVQQDDCFTaWVtZW5zIFRydXN0IENlbnRlciBSb290LUNBIFYyLjAwHhcNMTMxMjAy
MTQxMDIyWhcNMTkxMjAyMTQxMDIyWjCBmDELMAkGA1UEBhMCREUxEDAOBgNVBAoMB1NpZW1l
bnMxETAPBgNVBAUTCFpaWlpaWlkyMTowOAYDVQQLDDFDb3B5cmlnaHQgKEMpIFNpZW1lbnMg
QUcgMjAxMyBBbGwgUmlnaHRzIFJlc2VydmVkMSgwJgYDVQQDDB9TaWVtZW5zIElzc3Vpbmcg
Q0EgRUUgQXV0aCAyMDEzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxrcVJIap
cgf2suGNyppO25NRa6khC4BS48JG16wea+8wL8HJokqIjEHV35I7DyVfHxHfAvFyztARH7PZ
i9voNjgr98lWij3FR75KHBgdsWlO+5PG9+lou1zk4W1a2/LaH3r8oCJcuJxfuzhP0G6SXmtp
hsPhoeuhl7GTL2quXhM/vzEfjT+P0QT/Hx1OhlBc+MyyrT1Y4JX2WeKJc4/mDUEMH11ccf/Z
THt09eef/AxZWaVpRlssCDafGYf0wam1a0SigliCgEktsAaYQ3xBaHZFWh4RsmDfy88HdbAb
K7OegNkmfs+fiCxkgksGxakYjkNqbod28nBqFHt4bSOwzwIDAQABo4ICgTCCAn0wggEFBggr
BgEFBQcBAQSB+DCB9TBBBggrBgEFBQcwAoY1bGRhcDovL2FsLnNpZW1lbnMubmV0L0NOPVpa
WlpaWlYxLEw9UEtJP2NBQ2VydGlmaWNhdGUwMgYIKwYBBQUHMAKGJmh0dHA6Ly9haC5zaWVt
ZW5zLmNvbS9wa2k/WlpaWlpaVjEuY3J0MEoGCCsGAQUFBzAChj5sZGFwOi8vYWwuc2llbWVu
cy5jb20vdWlkPVpaWlpaWlYxLG89VHJ1c3RjZW50ZXI/Y0FDZXJ0aWZpY2F0ZTAwBggrBgEF
BQcwAYYkaHR0cDovL29jc3AucGtpLXNlcnZpY2VzLnNpZW1lbnMuY29tMB8GA1UdIwQYMBaA
FPYWzExixwEmLyMUd8WnLuMUUzYrMBIGA1UdEwEB/wQIMAYBAf8CAQAwRAYDVR0gBD0wOzA5
BgRVHSAAMDEwLwYIKwYBBQUHAgEWI2h0dHA6Ly93d3cuc2llbWVucy5jb20vcGtpLXNlcnZp
Y2VzMIHHBgNVHR8Egb8wgbwwgbmggbaggbOGP2xkYXA6Ly9jbC5zaWVtZW5zLm5ldC9DTj1a
WlpaWlpWMSxMPVBLST9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdIYmaHR0cDovL2NoLnNpZW1l
bnMuY29tL3BraT9aWlpaWlpWMS5jcmyGSGxkYXA6Ly9jbC5zaWVtZW5zLmNvbS91aWQ9Wlpa
WlpaVjEsbz1UcnVzdGNlbnRlcj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDAOBgNVHQ8BAf8E
BAMCAQYwHQYDVR0OBBYEFN6UP0tqX1hOFBjJRtcUOcKcITwpMA0GCSqGSIb3DQEBBQUAA4IB
AQACZCamwFJncRrC9fs+Z6+Ae1QXhDD0V3u0rZUL2z3m1504Xnxy+FkMuiT2+Q2Z0SdSdkTW
j7mbqoTu8ALajuc24n30K7XzvgLfLU/RuLSQC8q2F9paBAKs/9trz+40SKqLlUxdkfn04cka
YofzQ5+0DezF4bElBlaoc+0M5XlCa0IDjMrsQM/DcP28eLwQOYavvBKPRNGml7vQDt7hMgGg
Wm4gjQOoDRHO2xhj0nyznFQJjYMscLkIRq5qTBsXgZ0ZDLm7+SAerzvsb4stTRtuCC92NPA5
IUb9A+CCBN5cwphgKbAJOhpbjQvrHMgTXRH1x0TNIFmwrZ8HmXjaitKXMIIGVTCCBT2gAwIB
AgIEKdQz+TANBgkqhkiG9w0BAQsFADCBmDELMAkGA1UEBhMCREUxEDAOBgNVBAoMB1NpZW1l
bnMxETAPBgNVBAUTCFpaWlpaWlkyMTowOAYDVQQLDDFDb3B5cmlnaHQgKEMpIFNpZW1lbnMg
QUcgMjAxMyBBbGwgUmlnaHRzIFJlc2VydmVkMSgwJgYDVQQDDB9TaWVtZW5zIElzc3Vpbmcg
Q0EgRUUgQXV0aCAyMDEzMB4XDTE2MTAyMDA2MjAyMFoXDTE5MTAyMDA2MjAyMFowYTERMA8G
A1UEBRMIWjAwMllKVEsxDzANBgNVBCoMBkZhYmlhbjEQMA4GA1UEBAwHU2NoZWxlcjEQMA4G
A1UECgwHU2llbWVuczEXMBUGA1UEAwwOU2NoZWxlciBGYWJpYW4wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCpy87x2b4LNN7Iu4BEV3VyA2uxTukuVke0pQPuy6PlZ/0DPfQT
5MpxBlq6muehtGe7D/9BqBt5qLU7M4Rap2AdM1Q3r5/7IxVuNcVMmlonF5mzGoTE31aF4Sbd
nSYZdgSBCGxWoJxyNhfgdFbAWpBD8MoE/gToLKv+wrkitshADCxT9JJQhumKnmYQ+D98yFM1
tQgtumIy3BPxqp509a9GkLNOzqrEOSjGGK4i7RIcywOYJU+RDHeU/cShCRNWQHWeIHsLEI/Z
TL1JGEMz4E8vUTfTAp9UoI6TgosPEIvAh7sr/lcA6cdyScRCTPNbmyBrHpyRZ52RQzw/9Na/
m9cZAgMBAAGjggLbMIIC1zAzBgNVHSUELDAqBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCCsGAQUFCAICMIHKBgNVHR8EgcIwgb8wgbyggbmggbaGJmh0dHA6Ly9jaC5zaWVt
ZW5zLmNvbS9wa2k/WlpaWlpaWTIuY3JshkFsZGFwOi8vY2wuc2llbWVucy5uZXQvQ049Wlpa
WlpaWTIsTD1QS0k/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdIZJbGRhcDovL2NsLnNpZW1l
bnMuY29tL0NOPVpaWlpaWlkyLG89VHJ1c3RjZW50ZXI/Y2VydGlmaWNhdGVSZXZvY2F0aW9u
TGlzdDAaBgNVHSAEEzARMA8GDSsGAQQBoWkHAgIDAQEwDAYDVR0TAQH/BAIwADAfBgNVHSME
GDAWgBTelD9Lal9YThQYyUbXFDnCnCE8KTCCAQQGCCsGAQUFBwEBBIH3MIH0MDIGCCsGAQUF
BzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWlkyLmNydDBBBggrBgEFBQcw
AoY1bGRhcDovL2FsLnNpZW1lbnMubmV0L0NOPVpaWlpaWlkyLEw9UEtJP2NBQ2VydGlmaWNh
dGUwSQYIKwYBBQUHMAKGPWxkYXA6Ly9hbC5zaWVtZW5zLmNvbS9DTj1aWlpaWlpZMixvPVRy
dXN0Y2VudGVyP2NBQ2VydGlmaWNhdGUwMAYIKwYBBQUHMAGGJGh0dHA6Ly9vY3NwLnBraS1z
ZXJ2aWNlcy5zaWVtZW5zLmNvbTAOBgNVHQ8BAf8EBAMCB4AwUQYDVR0RBEowSKAqBgorBgEE
AYI3FAIDoBwMGmZhYmlhbi5zY2hlbGVyQHNpZW1lbnMuY29tgRpmYWJpYW4uc2NoZWxlckBz
aWVtZW5zLmNvbTAdBgNVHQ4EFgQUVFSCuYI3myxMkmpTKSZ74jcbkrowDQYJKoZIhvcNAQEL
BQADggEBAB/+6qnw0V+TMEMNK8qLVOvZ3xIIbxyYilkGW48zt06CFIJE79Hfm8OCLxcx4kXj
pWh0C2YvWyYX3vt/9+8CEG320nn2oMp2Y5KYi85Q6o8moPtEJNjLC5kWwmK5L+IdDqR6LetL
qMtIRZYzWb/xV8TeOhYQJAD/Wpp8SuS+KvaoPHn6Hu+YwZeiUVn55b02dbd/7OSsfxsbbESY
8ial/TvgowWG5VDYSdpxxqxr1bXA8Iq5oy1lOpg4aDjLdvRRVbNsxR1eQZTnozB8aemMhMh+
IaN3qfSpJaGZ52tNHTXPy+5syubOwDeoL/6R8KW8btM+gVa8LRX33LqBu5wKiYoxggQSMIIE
DgIBATCBoTCBmDELMAkGA1UEBhMCREUxEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpa
WlpaWlkyMTowOAYDVQQLDDFDb3B5cmlnaHQgKEMpIFNpZW1lbnMgQUcgMjAxMyBBbGwgUmln
aHRzIFJlc2VydmVkMSgwJgYDVQQDDB9TaWVtZW5zIElzc3VpbmcgQ0EgRUUgQXV0aCAyMDEz
AgQp1DP5MA0GCWCGSAFlAwQCAQUAoIICQTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0xODEwMjQxMDUzMjhaMC8GCSqGSIb3DQEJBDEiBCBfor1L1l03sGb9
yyAkrUOD09i+yekzqd0E/bi2BSe4VDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGxBgkrBgEEAYI3EAQxgaMwgaAwgZcxCzAJBgNV
BAYTAkRFMRAwDgYDVQQKDAdTaWVtZW5zMREwDwYDVQQFEwhaWlpaWlpZMzE6MDgGA1UECwwx
Q29weXJpZ2h0IChDKSBTaWVtZW5zIEFHIDIwMTMgQWxsIFJpZ2h0cyBSZXNlcnZlZDEnMCUG
A1UEAwweU2llbWVucyBJc3N1aW5nIENBIEVFIEVuYyAyMDEzAgQLJ1ECMIGzBgsqhkiG9w0B
CRACCzGBo6CBoDCBlzELMAkGA1UEBhMCREUxEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUT
CFpaWlpaWlkzMTowOAYDVQQLDDFDb3B5cmlnaHQgKEMpIFNpZW1lbnMgQUcgMjAxMyBBbGwg
UmlnaHRzIFJlc2VydmVkMScwJQYDVQQDDB5TaWVtZW5zIElzc3VpbmcgQ0EgRUUgRW5jIDIw
MTMCBAsnUQIwDQYJKoZIhvcNAQEBBQAEggEAhvqQSUhwh5GhINYFTcnitSnkjDogWfeywQpK
KrBR9FdvkK/h6PjH4qANNtah09DO/t1V3JcKBVfu/rNFZzQUNRSY7uCp5f3LFLbXK8vgF5dP
REGINsvOD7F8ZRM15MdItjryoqJCFp2cTm1GuQ9F2LBOpOiKFCEbEqHdY11F33X+3mrkQ8ry
TvaJE3B0fvrBjkzkG2yUQb/XX7+AKtCuBMEoyiaDoibd4nmezca5rdHGPj39/GFJ8cr3Indc
AbT54tS1eY8Y25XUOTRdy5lO91SL6Dr5lt66ch2TDb68K5J4rTS5O/iLBr7t+TE9wmVLGYXc
1UT3WYFJM7Iahs63LgAAAAAAAA==
--------------ms070707030408030308080605--

--===============5590252125865085136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5590252125865085136==--
