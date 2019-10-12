From: Milian Wolff via lttng-dev <lttng-dev@lists.lttng.org>
Subject: hiding lttng-ust-internal syscalls from record?
Date: Sat, 12 Oct 2019 12:54:51 +0200
Message-ID: <5322462.3xMDDC0yJl__2315.35911313898$1570878243$gmane$org@agathebauer>
Reply-To: Milian Wolff <milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5249108759733898111=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 46r24c2cJlz1Phw
 for <lttng-dev@lists.lttng.org>; Sat, 12 Oct 2019 07:03:44 -0400 (EDT)
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

--===============5249108759733898111==
Content-Type: multipart/signed; boundary="nextPart4073216.vALiDWoFip";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart4073216.vALiDWoFip
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey all,

I'll give two presentations on LTTng in the coming months, at Qt World Summit 
and then at ESE Kongress. For demo purposes I setup a yocto build on an older 
NXP IMX.6 board I had flying around in the office. I stumbled upon an 
unexpected trace point order issue with lttng-ust:

These are the versions for the various LTTng related tools:

```
sources/poky/meta/recipes-kernel/lttng$ ls
babeltrace_1.5.3.bb  lttng-modules  lttng-modules_2.10.5.bb  lttng-tools  
lttng-tools_2.9.5.bb  lttng-ust  lttng-ust_2.10.1.bb
```

Everything works like a charm, except for a surprising side-effect when 
recording LTTng-UST trace points. I have never seen the following two issues 
before on my x86-64 host:

1) The syscalls done by lttng-ust internally seem to be recorded, which is not 
desirable for me - I would prefer to only record the syscalls actually done by 
the user application itself, not by lttng-ust. Is there a way to do that?

2) Oddly enough, the clock_gettime syscall is improperly nested with the ust 
syscall, i.e. the order observed for all ust trace events is:

    syscall_entry_getcpu
    syscall_exit_getcpu
    syscall_entry_clock_gettime
    ust_event
    syscall_exit_clock_gettime

This cannot be correct. Has anyone ever seen that? How can I resolve this - 
does anyone know? Here's an excerpt from babeltrace (v1.5.6 on my host):

```
[09:36:23.999290417] (+0.000320667) imx6qsabresd syscall_entry_getcpu: { 
cpu_id = 3 }, { tcache = 0x0 }
[09:36:23.999297084] (+0.000006667) imx6qsabresd syscall_exit_getcpu: { cpu_id 
= 3 }, { ret = 0, cpup = 0x7EA3B8FC, nodep = 0x0, tcache = 0x0 }
[09:36:23.999305084] (+0.000008000) imx6qsabresd syscall_entry_clock_gettime: 
{ cpu_id = 3 }, { which_clock = 1 }
[09:36:23.999308084] (+0.000003000) imx6qsabresd qtcore:QObject_ctor: { cpu_id 
= 3 }, { object = 0x7EA3BC84 }
[09:36:23.999311417] (+0.000003333) imx6qsabresd syscall_exit_clock_gettime: { 
cpu_id = 3 }, { ret = 0, tp = 2124659000 }
[09:36:23.999341084] (+0.000029667) imx6qsabresd syscall_entry_getcpu: { 
cpu_id = 3 }, { tcache = 0x0 }
[09:36:23.999345417] (+0.000004333) imx6qsabresd syscall_exit_getcpu: { cpu_id 
= 3 }, { ret = 0, cpup = 0x7EA3B88C, nodep = 0x0, tcache = 0x0 }
[09:36:23.999350417] (+0.000005000) imx6qsabresd syscall_entry_clock_gettime: 
{ cpu_id = 3 }, { which_clock = 1 }
[09:36:23.999352417] (+0.000002000) imx6qsabresd 
qtgui:QGuiApplicationPrivate_init_entry: { cpu_id = 3 }, { }
[09:36:23.999355084] (+0.000002667) imx6qsabresd syscall_exit_clock_gettime: { 
cpu_id = 3 }, { ret = 0, tp = 2124658888 }
[09:36:23.999376417] (+0.000021333) imx6qsabresd syscall_entry_getcpu: { 
cpu_id = 3 }, { tcache = 0x0 }
[09:36:23.999380417] (+0.000004000) imx6qsabresd syscall_exit_getcpu: { cpu_id 
= 3 }, { ret = 0, cpup = 0x7EA3B844, nodep = 0x0, tcache = 0x0 }
[09:36:23.999385084] (+0.000004667) imx6qsabresd syscall_entry_clock_gettime: 
{ cpu_id = 3 }, { which_clock = 1 }
[09:36:23.999387084] (+0.000002000) imx6qsabresd 
qtcore:QCoreApplicationPrivate_init_entry: { cpu_id = 3 }, { }
[09:36:23.999389084] (+0.000002000) imx6qsabresd syscall_exit_clock_gettime: { 
cpu_id = 3 }, { ret = 0, tp = 2124658816 }
```

Here's how I configure the LTTng session:

```
#!/bin/sh

if [ ! -d /tmp/lttng ]; then
    mkdir /tmp/lttng
fi

lttng create -o /tmp/lttng/$(date -Iseconds)

lttng enable-channel kernel -k

kernel_events=(
  "sched_switch,sched_process_*"
  "lttng_statedump_*"
  kmem_{mm_page,cache}_{alloc,free}
  power_cpu_frequency
  block_rq_{issue,complete,requeue}
  "irq_*"
  "signal_*"
  "workqueue_*"
)

for event in "${kernel_events[@]}"; do
    lttng enable-event -c kernel -k "$event"
done

lttng enable-event -c kernel -k --syscall -a

lttng enable-channel ust -u
lttng enable-event -c ust -u -a

lttng start
```

Any help would be appreciated

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart4073216.vALiDWoFip
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDEIw
ggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mx
gUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT
/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6
RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD
8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuv
fgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8B
Af8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUw
QzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1
dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au
Y29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkI
BtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/
AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZ
lPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNq
bzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5I
SYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmU
dp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ8
4F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR
1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBlQwggU8oAMCAQICEAf6KCF9+1doL2oE
OTPysLwwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0w
OwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMB4XDTE3MDUyMzAwMDAwMFoXDTIwMDUyMjIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0G
A1UEERMGNjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNV
BAkTD05vcnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRh
bGVucyBEYXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNV
BAsMOklzc3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1h
bmFnZXIxHzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBX
b2xmZjEkMCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxrzfNBVvRbiAknuTBXuQnNm9sLIFLo0vbPB6kswk78A3tA++Zn5c
lQUHhGlQq1cdYxagnUpqwvG3Sod15mPSOLkAPf/mabLN7p+lFbRaUP+97ZkTZtvb4BCC3osIEFI4
G393OSFWqc2qmIPE/SwSASbAA20Fcaa2M6P1lhOk/ttUh2jIurTPF0wUycIA7lBddrOgaOA8e2m6
iLTNHtlrfRbBaUX91D5ebY+UWmIjXSQ9+CtutMzBkwnF0rZKririvOkklg9VzEGNQVHrQfDF2s/U
pOtmtuVSwElauGT/KALyCFuIrYC1pmaKH8S1xODJqiRaf6jH8E+KQzKjyM/ErwIDAQABo4IB1TCC
AdEwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFN+m99RtIuA1bSdw
6b1brOX7X3AJMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29s
ZmZAa2RhYi5jb20wDQYJKoZIhvcNAQELBQADggEBABf47LSJADqH+ow9INv3QM1NC/qq2bjxGvsZ
68iD11VEUAFlsYfsVTgQqUirwPVTYenXtwVBELHZyywsui1JxL7HKQetLQegDDP/RyfjReVaWxhy
3OpuItsgLVbru9QVgPifnoBFPtfZcwjeJDmeSbLT8oj4Rd0KYBOIve7WKvsfNPsNwfbLwY2zILkE
LjxZcVi2AwZHDyab+dzL/3YcLuJj1lSawBGn7ilpcdZydlv4aye51pD/MemLIYLcylt+ImrmjnTV
y+QlAHRF3s5FE8yAr+W1MBD/1bKZCSgFt8VQoAlz3hiQh8QqZp4Zl8WuVL4+mP/mT6VDEWgq/0Bo
cukxggJuMIICagIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkxMDEyMTA1NDUxWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgazD6jPFAR6OPUn1qOkrFRVzvDqPx
B2i8tdJUEfGMTA0wDQYJKoZIhvcNAQEBBQAEggEAGUuflpkIpEqMnDXIrZFdx1f/LNAtxlZEwraZ
VJvvBM093Il6MGIFdiM/mk3VyFyVfvewwZCksmyxRyLfx7jP/OpqD0CUNum4KTTfUdqKQuO/vQty
f+iZhCoEY00Z57xaOuvSTx5bjI7kolgZF7rUQNvlA7quNX89R5q+j7hYSDTtcxTonyl4L8PTLB3V
nXvCjklY7tHwjT6i248KBjn2vSbOlHpRt/kPdHUiikiuZzXIdP5Achfn76PdjWY6xhI3VNSLTNa+
hdBFl3zpLDB6g7ysPf7k1PSLfYN7kRTCR1U1Xqc4bHpiIJeOHum0yS3aWsaZJeMXZkEYWkK2AncH
KAAAAAAAAA==


--nextPart4073216.vALiDWoFip--



--===============5249108759733898111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5249108759733898111==--
