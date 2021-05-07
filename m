Return-Path: <SRS0=RQiO=KC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E08C433ED
	for <lttng-dev@archiver.kernel.org>; Fri,  7 May 2021 10:43:14 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065DB61075
	for <lttng-dev@archiver.kernel.org>; Fri,  7 May 2021 10:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065DB61075
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fc6VQ6PvQz1jhZ;
	Fri,  7 May 2021 06:43:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1620384191;
	bh=bQyk7vj3hoy3yzmIs7KRlRcjOwrDAMXv1o4K//rLKOY=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Bw+sCYIGi3zleNeUUT+cxSMBrYZPVd2H7nI0uyCqxCJBRjbsPopq7c6bxTlERvvor
	 XZMBUYvBd5L9YGpA4hwdq0Yd+SPVvlV/2vkOH1AS/nzfsPWfRu7P2WiDOrvOs0VvZy
	 qxDmyP3Noghod7bjyUdolckE3IVEOIx7kRHfcE1azP8edJLKYAGg9YFoQ0fwfn+zLX
	 Aa9+4ppOtf/YUJ7TOgjRm0j1NgpsuOIpoccMWNtBMaxD66L2iYD2U171AOlR3nPoU8
	 yQUsh7sbq19qxiNjvvlI2UHzlN1LocxQGHkJSWHjeYDF4xyycZUsUFv6+5GwgXl0xY
	 4QJIbQmlkqL8Q==
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fc6VN5Zv8z1jhX
 for <lttng-dev@lists.lttng.org>; Fri,  7 May 2021 06:43:08 -0400 (EDT)
X-Virus-Scanned: amavisd-new at kdab.com
To: lttng-dev@lists.lttng.org
Cc: bhanu kiran chaluvadi <nthdimensionalreality@gmail.com>
Date: Fri, 07 May 2021 12:30:07 +0200
Message-ID: <33760007.sq35sl3qWi@milian-workstation>
Organization: KDAB
In-Reply-To: <CAJYn_wj-H2mGYVDSR8mynyh0VcOOcf868s+z9mAc1h0D7B8m2g@mail.gmail.com>
References: <CAJYn_wj-H2mGYVDSR8mynyh0VcOOcf868s+z9mAc1h0D7B8m2g@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [lttng-dev] How to trace a memory leak in my application using
 LTTng
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Milian Wolff via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Milian Wolff <milian.wolff@kdab.com>
Content-Type: multipart/mixed; boundary="===============0465502351217367161=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0465502351217367161==
Content-Type: multipart/signed; boundary="nextPart2533869.yfGodxQqnx";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart2533869.yfGodxQqnx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 5. Mai 2021 12:36:06 CEST bhanu kiran chaluvadi via lttng-dev 
wrote:
> Hi,
> 
> I have a memory leak some where in my c++ application.  Since it was
> written in c++98 there are lot of pointer passed back and forth and there
> is no clear ownership of the pointers. I was  wondering if it's possible to
> check for memory leak and give a value sections to probe for the leak using
> LTTng ?  Since i am new, Can you also point me to some sample example to
> track memory leak, in case if they are available or can you provide some
> instructions to use LTTng in order to trace the leak.

While it's probably possible to leverage LTTng for this purpose, I don't think 
it's worthwhile to do so. Better start off with a ready-made tool for this 
purpose, such as heaptrack, LSAN or valgrind's memcheck.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart2533869.yfGodxQqnx
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEekw
ggWBMIIEaaADAgECAhA5ckQ6+SK3UdfTbBDdMTWVMA0GCSqGSIb3DQEBDAUAMHsxCzAJBgNVBAYT
AkdCMRswGQYDVQQIDBJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNV
BAoMEUNvbW9kbyBDQSBMaW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMw
HhcNMTkwMzEyMDAwMDAwWhcNMjgxMjMxMjM1OTU5WjCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
Ck5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkw
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCAEmUXNg7D2wiz0KxXDXbtzSfTTK1Qg2Hi
qiBNCS1kCdzOiZ/MPans9s/B3PHTsdZ7NygRK0faOca8Ohm0X6a9fZ2jY0K2dvKpOyuR+OJv0OwW
IJAJPuLodMkYtJHUYmTbf6MG8YgYapAiPLz+E/CHFHv25B+O1ORRxhFnRghRy4YUVD+8M/5+bJz/
Fp0YvVGONaanZshyZ9shZrHUm3gDwFA66Mzw3LyeTP6vBZY1H1dat//O+T23LLb2VN3I5xI6Ta5M
irdcmrS3ID3KfyI0rn47aGYBROcBTkZTmzNg95S+UzeQc0PzMsNT79uq/nROacdrjGCT3sTHDN/h
Mq7MkztReJVni+49Vv4M0GkPGw/zJSZrM233bkf6c0Plfg6lZrEpfDKEY1WJxA3Bk1QwGROs0303
p+tdOmw1XNtB1xLaqUkL39iAigmTYo61Zs8liM2EuLE/pDkP2QKe6xJMlXzzawWpXhaDzLhn4ugT
ncxbgtNMs+1b/97lc6wjOy0AvzVVdAlJ2ElYGn+SNuZRkg7zJn0cTRe8yexDJtC/QV9AqURE9Jnn
V4eeUB9XVKg+/XRjL7FQZQnmWEIuQxpMtPAlR1n6BB6T1CZGSlCBst6+eLf8ZxXhyVeEHg9j1uli
utZfVS7qXMYoCAQlObgOK6nyTJccBz8NUvXt7y+CDwIDAQABo4HyMIHvMB8GA1UdIwQYMBaAFKAR
CiM+lvEH7OKvKe+CpX/QMKS0MB0GA1UdDgQWBBRTeb9aqitKz1SA4dibwJ3ysgNmyzAOBgNVHQ8B
Af8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAIMAYGBFUdIAAwQwYDVR0fBDwwOjA4
oDagNIYyaHR0cDovL2NybC5jb21vZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmww
NAYIKwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJ
KoZIhvcNAQEMBQADggEBABiHUdx0IT2ciuAntzPQLszs8ObLXhHeIm+bdY6ecv7k1v6qH5yWLe8D
Sn6u9I1vcjxDO8A/67jfXKqpxq7y/Njuo3tD9oY2fBTgzfT3P/7euLSK8JGW/v1DZH79zNIBoX19
+BkZyUIrE79Yi7qkomYEdoiRTgyJFM6iTckys7roFBq8cfFb8EELmAAKIgMQ5Qyx+c2SNxntO/Hk
Orb5RRMmda+7qu8/e3c70sQCkT0ZANMXXDnbP3sYDUXNk4WWL13fWRZPP1G91UUYP+1KjugGYXQj
FrUNUHMnREd/EF2JKmuFMRTE6KlqTIC8anjPuH+OdnKZDJ3+15EIFqGjX5UwggYQMIID+KADAgEC
AhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UE
CBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJV
U1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
IExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975
Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK
8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oH
ox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLt
piK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B
0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHY
m8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjAS
BgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAE
CjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VT
RVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/Bggr
BgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0Eu
Y3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUA
A4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8
zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8J
fqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmN
HdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdN
uO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRd
Wyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq
4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLw
rymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uY
dBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8m
ybM2JzCCBkwwggU0oAMCAQICEHR8gsPqhWo7MMOepQh9ypIwDQYJKoZIhvcNAQELBQAwgZYxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1
dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjAwNTEyMDAwMDAwWhcNMjMwNTEy
MjM1OTU5WjCCAVkxCzAJBgNVBAYTAlNFMQ8wDQYDVQQREwY2ODMgMzExEjAQBgNVBAgTCVZhZXJt
bGFuZDEQMA4GA1UEBxMHSGFnZm9yczEYMBYGA1UECRMPTm9ycmluZ3MgdmFlZyAyMQ8wDQYDVQQS
EwZCb3ggMzAxJjAkBgNVBAoMHUtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCMR0wGwYDVQQL
ExRBIEtEQUIgR3JvdXAgQ29tcGFueTFDMEEGA1UECww6SXNzdWVkIHRocm91Z2ggS2xhcsOkbHZk
YWxlbnMgRGF0YWtvbnN1bHQgQUIgRS1QS0kgTWFuYWdlcjEfMB0GA1UECxMWQ29ycG9yYXRlIFNl
Y3VyZSBFbWFpbDEVMBMGA1UEAxMMTWlsaWFuIFdvbGZmMSQwIgYJKoZIhvcNAQkBFhVtaWxpYW4u
d29sZmZAa2RhYi5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8vdk66W4eo0O1
1Dh3zPXW/zrkwzzxRR0Air/VRxAIG5q/klE9mF2gsGBPXQpCtDMvkuvSLQ+5mR50Cb+V+4Y9n0W6
98JoyQHYAo6uswLyTchcF6IVckkkZrm1RD1DXnlIHpCsacO7PDDxMslzFs5XZfRkH4F1SKkiVwup
/Nsn0z12SGRzxSUUxr4VHZgIqgRGqVSbVJfjtTRigAu+fmXUXHs0bMRv8TonzrDRlN61m1UakrFu
qvKAgXYfZULZ52IKNK/jq8nPHJDD9oOr5pVi4Yx9GyVeMM0qNPC74fJnGh7lOpJiAcqYBEis73lm
U+RtH3Bj85Qdqvwxo3bf7s1zAgMBAAGjggHOMIIByjAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+o
mULPyeCtADAdBgNVHQ4EFgQUMc6p+s2l6xbyh8jLYeP7fQrRiW4wDgYDVR0PAQH/BAQDAgWgMAwG
A1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYM
KwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1Ud
HwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhl
bnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcw
AoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25h
bmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20w
IAYDVR0RBBkwF4EVbWlsaWFuLndvbGZmQGtkYWIuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBW3rFX
47Cnu8JMNm8row/96V8xGwPzir9lEpnasNxi+GhvQjGzvoP5oxMoBJ+hgD8fMk5X15IDuKa9KVHb
BzBG9kOPGB4h/89voWpzWIVy7Q3k+dPByfghbufR+83TvN20lV9VqXYjPeYypHlD/vJ4Z8iWn3s3
0iUfYr1CCr8zoje1hijPM9A0wN7K8iCtIc4OAfJpwKsXMCNAv1SdxD196vCKrTnWiEmAw0g8FpDM
GWIww0+2Qq+Peeoe53+34GetRPIbS5jPlCEy7xgC8c7qoJTNzhCyVENRByoA5dsLzK+Nv0IT1h2C
gu2w5VxHo0DjlCmYddu46uwpWjKpNuhaMYICbTCCAmkCAQEwgaswgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
Y3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9u
IGFuZCBTZWN1cmUgRW1haWwgQ0ECEHR8gsPqhWo7MMOepQh9ypIwDQYJYIZIAWUDBAIBBQCggZMw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwNTA3MTAzMDA3WjAo
BgkqhkiG9w0BCQ8xGzAZMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg
L1wjJquCo3quT2T5L0iUbKBfMGKnKbXfMCJuY4c8fPIwDQYJKoZIhvcNAQEBBQAEggEAHSMbL2XY
5LU+NkcpKU2o/81JIT7Z+CuLFqk2IITmlSQjFwW2FM/6HmPeO1AUu/T/I5lJOiFTXOIOCMNcDjub
LaLLzxpFC3XMUOOnYzK3JzZoZfRhoKpnA51DLr87bU2yMSNH7TmJIoglQqVyFmpxWGlB5m9ea5rz
JKrZCjhKbzSsCgO+CdehM9QHx7N9AM1NwrZ2YuexScqMbzjDWOkQiVcirvBPLGjiHdATh6Qf27BV
bVyJFVVm49LGana18tJLXT8KORDaAmzxxILg09S0iIdlWnwk28THi0Wll+UagKwtjdWrmj82wtAa
evOp/Oc/VvLoA2dg7qn3vWT5uBrzGQAAAAAAAA==


--nextPart2533869.yfGodxQqnx--



--===============0465502351217367161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0465502351217367161==--


