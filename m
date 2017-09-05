From: Milian Wolff <milian.wolff@kdab.com>
Subject: large liblttng-ust startup overhead (ust_lock)
Date: Tue, 05 Sep 2017 16:34:54 +0200
Message-ID: <2117884.c1kuPXoiOA__10063.89743784$1504622497$gmane$org@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7740590606952133090=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3xmqC56sS5zCNB
 for <lttng-dev@lists.lttng.org>; Tue,  5 Sep 2017 14:40:49 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7740590606952133090==
Content-Type: multipart/signed; boundary="nextPart2175168.VoJKCTIPhK"; micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart2175168.VoJKCTIPhK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hey all,

I have noticed a very large overhead when linking against liblttng-ust:

~~~~~
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ cat lttng-test.c =20
int main()
{
  return 0;
}
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ gcc -O2 -g -ldl lttng-test.c                    =20
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ perf stat -r 5 ./a.out=20

 Performance counter stats for './a.out' (5 runs):

          0.209587      task-clock (msec)         #    0.596 CPUs utilized =
          =20
( +-  8.76% )
                 0      context-switches          #    0.000 K/sec         =
        =20
                 0      cpu-migrations            #    0.000 K/sec         =
        =20
                49      page-faults               #    0.235 M/sec         =
          =20
( +-  1.19% )
           706,854      cycles                    #    3.373 GHz           =
          =20
( +-  8.82% )
           773,603      instructions              #    1.09  insn per cycle=
          =20
( +-  0.75% )
           147,128      branches                  #  701.987 M/sec         =
          =20
( +-  0.70% )
             4,096      branch-misses             #    2.78% of all branche=
s         =20
( +-  5.27% )

       0.000351422 seconds time elapsed                                    =
     =20
( +- 11.85% )

=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ gcc -O2 -g -ldl -llttng-ust lttng-test.c
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ perf stat -r 5 ./a.out=20

 Performance counter stats for './a.out' (5 runs):

          2.063040      task-clock (msec)         #    0.009 CPUs utilized =
          =20
( +-  1.37% )
                44      context-switches          #    0.021 M/sec         =
          =20
( +-  1.95% )
                 2      cpu-migrations            #    0.776 K/sec         =
          =20
( +- 25.00% )
               209      page-faults               #    0.101 M/sec         =
          =20
( +-  0.34% )
         7,053,686      cycles                    #    3.419 GHz           =
          =20
( +-  2.03% )
         6,893,783      instructions              #    0.98  insn per cycle=
          =20
( +-  0.25% )
         1,342,492      branches                  #  650.735 M/sec         =
          =20
( +-  0.20% )
            29,390      branch-misses             #    2.19% of all branche=
s         =20
( +-  0.61% )

       0.225597302 seconds time elapsed                                    =
     =20
( +-  6.68% )
~~~~~

This is without any LTTng session configured. If I enable LTTng kernel and=
=20
userspace events, this becomes even worse:

~~~~~
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ cat $(which run_lttng_trace.sh)
#!/bin/sh

if [ -z "$(pidof lttng-sessiond)" ]; then
    sudo lttng-sessiond --daemonize
fi

sudo lttng create -o ~/lttng-traces/$(date -Iseconds)
sudo lttng enable-channel kernel -k --subbuf-size 16M --num-subbuf 8
sudo lttng enable-event -c kernel -k -a
sudo lttng enable-channel ust -u --subbuf-size 16M --num-subbuf 8
sudo lttng enable-event -c ust -u lttng_ust_tracef:*
sudo lttng start
$@
sudo lttng stop

sudo chmod a+rx -R ~/lttng-traces
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ run_lttng_trace.sh perf stat -r 5 ./a.out=20
Session auto-20170905-162818 created.
Traces will be written in /home/milian/lttng-traces/2017-09-05T16:28:18+02:=
00
Kernel channel kernel enabled for session auto-20170905-162818
All Kernel events are enabled in channel kernel
UST channel ust enabled for session auto-20170905-162818
UST event lttng_ust_tracef:* created in channel ust
Tracing started for session auto-20170905-162818

 Performance counter stats for './a.out' (5 runs):

          4.937820      task-clock (msec)         #    0.005 CPUs utilized =
          =20
( +-  1.28% )
               117      context-switches          #    0.024 M/sec         =
          =20
( +-  0.70% )
                 3      cpu-migrations            #    0.608 K/sec         =
          =20
( +- 23.57% )
               245      page-faults               #    0.050 M/sec         =
          =20
( +-  0.20% )
        16,541,355      cycles                    #    3.350 GHz           =
          =20
( +-  0.94% )
        20,611,637      instructions              #    1.25  insn per cycle=
          =20
( +-  0.23% )
         3,580,525      branches                  #  725.123 M/sec         =
          =20
( +-  0.19% )
            52,093      branch-misses             #    1.45% of all branche=
s         =20
( +-  1.73% )

       0.965545882 seconds time elapsed                                    =
     =20
( +- 16.96% )

Waiting for data availability...
Tracing stopped for session auto-20170905-162818
~~~~~

I see this ~1s delay during startup in nearly all test applications where I=
=20
wanted to use lttng-ust. In tracecompass, and according to perf sleep time=
=20
profiling, this seems to be mostly due to extensive sleeping on mutex locks=
=20
(from ust_lock in liblttng-ust). With perf trace, I also see membarrier tak=
ing=20
a lot of time:

~~~~~
# without a running lttng session:
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ perf trace --duration 1 ./a.out
     6.492 (52.468 ms): a.out/23672 recvmsg(fd: 3<socket:[1178439]>, msg:=20
0x7fbe2fbb1070                  ) =3D 1
     5.077 (54.271 ms): a.out/23671 futex(uaddr: 0x7fbe30d508a0, op:=20
WAIT_BITSET|PRIV|CLKRT, utime: 0x7ffc474ff5a0, val3: 4294967295) =3D 0
    59.598 (79.379 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0
   138.984 (39.945 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0
    59.621 (119.324 ms): a.out/23672 futex(uaddr: 0x7fbe303e54c0, op: WAIT|
PRIV, val: 2                    ) =3D 0
   179.045 (79.918 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0
   258.971 (39.997 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0
   299.052 (79.883 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0
   378.942 (59.988 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0
   439.022 (69.908 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0
   508.937 (80.027 ms): a.out/23671 membarrier(cmd: 1                      =
                              =20
) =3D 0

# with a running lttng session:
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ run_lttng_trace.sh perf trace --duration 1 ./a.out=20
     6.666 (392.496 ms): a.out-ust/23790 recvmsg(fd: 3<socket:[1185362]>, m=
sg:=20
0x7fcd81d8a0b0                  ) =3D 612
   400.238 (68.452 ms): a.out-ust/23790 membarrier(cmd: 1                  =
                                  =20
) =3D 0
   468.698 (39.983 ms): a.out-ust/23790 membarrier(cmd: 1                  =
                                  =20
) =3D 0
   510.567 (98.113 ms): a.out-ust/23790 recvmsg(fd: 3<socket:[1185362]>, ms=
g:=20
0x7fcd81d8a070                  ) =3D 1
     6.467 (603.500 ms): a.out/23789 futex(uaddr: 0x7fcd82f298a0, op:=20
WAIT_BITSET|PRIV|CLKRT, utime: 0x7fff4df6c970, val3: 4294967295) =3D 0
   610.020 ( 6.307 ms): a.out/23789 futex(uaddr: 0x7fcd82f29960, op: WAIT|
PRIV, val: 2                    ) =3D 0
   616.446 (62.265 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
   678.721 (59.916 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
   616.332 (122.335 ms): a.out-ust/23790 futex(uaddr: 0x7fcd82f29960, op:=20
WAIT|PRIV, val: 2                    ) =3D 0
   738.976 (49.658 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
   788.642 (49.987 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
   739.014 (99.644 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4c0, op: WA=
IT|
PRIV, val: 2                    ) =3D 0
   838.651 (49.977 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
   888.636 (69.983 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
   838.662 (119.978 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4c0, op:=20
WAIT|PRIV, val: 2                    ) =3D 0
   958.739 (59.873 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
  1018.621 (80.058 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
  1098.782 (49.844 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
  1148.634 (59.998 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
  1208.731 (69.940 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
  1278.680 (79.947 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
  1358.727 (39.881 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
  1398.616 (39.980 ms): a.out/23789 membarrier(cmd: 1                      =
                              =20
) =3D 0
     6.640 (1432.157 ms): a.out-ust/23791 futex(uaddr: 0x7fcd82f90000      =
                                    =20
) =3D -1 (null) INTERNAL ERROR: strerror_r(512, 0x7ffdbc5467a0, 128)=3D22
~~~~~

This makes lttng-ust pretty much unusable for any short-lived application. =
Is=20
this a known limitation?

I'm using lttng-ust on Arch from the AUR packages, i.e. LTTng 2.9.4. I've s=
een=20
this problem also on Ubuntu 17.04 though I didn't do any of the above=20
measurements there. So far, I suspected the ust statedump to take too much=
=20
time, but I disabled that one for the measurements above.

Any help would be appreciated

=2D-=20
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart2175168.VoJKCTIPhK
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwOTA1MTQzNDU0WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgqmoORrN5zofGf354vFW0aHk6Dfr/
RDI11q2NuAnx/L0wDQYJKoZIhvcNAQEBBQAEggEAYf3johaL4nWOn6gpfjSxC8mKvT761UFI4+rM
WoH3krzy9Z+SS2NsEYgd9UJP7Rz26j2iRfPtEy3pG31p0NBV+jUo6HsTWQ65b5A2o1yWiuqd/rI8
0pka6YorEkntn+o3kaqwH+vZIDT0/XEGIZcc/1efszKRcFigxM0lnMiBPI4VQLtH1GK6EMciQcYu
SJ1Q+Nf9gJvItD/BTwCQTjd3k5Q3xZVRmKc7oIHC6KkW1qq5ehxbFQgsVSCsEFk5oBT5jWqEO9Zt
N1PRAWyXXpIYUoU78dAUoPrxaCRkSQ3Xz4ZYM4TApbSQ1bvg6qSw+rM7uACAblkFNM+UauCelUtz
pQAAAAAAAA==


--nextPart2175168.VoJKCTIPhK--




--===============7740590606952133090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7740590606952133090==--
