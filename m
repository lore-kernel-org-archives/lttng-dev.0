From: Milian Wolff <milian.wolff@kdab.com>
Subject: liblttng-ust overhead, take 2
Date: Thu, 07 Sep 2017 10:47:46 +0200
Message-ID: <1671874.aHIhmVXznC__28167.5262180672$1504774101$gmane$org@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6957147221333004225=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3xnvGx3sG7zCf6
 for <lttng-dev@lists.lttng.org>; Thu,  7 Sep 2017 08:47:52 +0000 (UTC)
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

--===============6957147221333004225==
Content-Type: multipart/signed; boundary="nextPart1909254.iedNQQuK5R"; micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart1909254.iedNQQuK5R
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey all,

after my latest report over liblttng-ust overhead yielded such quick results, 
I would like to expand on this with a more realistic workload that I'm looking 
at.

We have two applications, one that sets up an SQLite database and then 
launches multiple client applications that try to read and write concurrently 
from that database. Of course, this will show file-level lock contention. I'd 
like to use LTTng to visualize the effect.

On my machine I get the following numbers.

1) Without LTTng and without UST:
~~~~~
 Performance counter stats for './launcher/lab_latency_launcher':

        495.075367      task-clock (msec)         #    0.150 CPUs utilized          
             2,340      context-switches          #    0.005 M/sec                  
               291      cpu-migrations            #    0.588 K/sec                  
            52,265      page-faults               #    0.106 M/sec                  
     3,098,760,038      cycles                    #    6.259 GHz                    
     1,894,074,743      instructions              #    0.61  insn per cycle         
       354,869,636      branches                  #  716.799 M/sec                  
        10,317,266      branch-misses             #    2.91% of all branches        

       3.298337574 seconds time elapsed
~~~~~~

2) With LTTng (all kernel events enabled) and without UST:
~~~~~
 Performance counter stats for 'run_lttng_trace.sh ./launcher/
lab_latency_launcher':

        296.329694      task-clock (msec)         #    0.068 CPUs utilized          
             1,808      context-switches          #    0.006 M/sec                  
               398      cpu-migrations            #    0.001 M/sec                  
            53,493      page-faults               #    0.181 M/sec                  
     2,411,871,165      cycles                    #    8.139 GHz                    
     2,370,005,487      instructions              #    0.98  insn per cycle         
       425,284,747      branches                  # 1435.174 M/sec                  
        10,442,662      branch-misses             #    2.46% of all branches        

       4.338938821 seconds time elapsed
~~~~~~

3) With LTTng (all kernel events enabled) and with UST `tracef()` events 
enabled (~400 UST events in total):

~~~~~~
 Performance counter stats for './launcher/lab_latency_launcher':

        796.595231      task-clock (msec)         #    0.069 CPUs utilized          
            17,728      context-switches          #    0.022 M/sec                  
               429      cpu-migrations            #    0.539 K/sec                  
            85,737      page-faults               #    0.108 M/sec                  
     4,483,999,258      cycles                    #    5.629 GHz                    
     5,112,633,073      instructions              #    1.14  insn per cycle         
       985,315,773      branches                  # 1236.909 M/sec                  
        14,993,555      branch-misses             #    1.52% of all branches        

      11.505288968 seconds time elapsed
~~~~~~

4) This is running against the patched userspace-urcu. Without the performance 
fix there, the performance is even worse:

~~~~~~
 Performance counter stats for 'run_lttng_trace.sh ./launcher/
lab_latency_launcher':

        952.959433      task-clock (msec)         #    0.019 CPUs utilized          
             6,021      context-switches          #    0.006 M/sec                  
               954      cpu-migrations            #    0.001 M/sec                  
            69,310      page-faults               #    0.073 M/sec                  
     5,335,988,506      cycles                    #    5.599 GHz                    
     6,031,685,882      instructions              #    1.13  insn per cycle         
     1,093,132,635      branches                  # 1147.093 M/sec                  
        16,090,093      branch-misses             #    1.47% of all branches        

      50.786464678 seconds time elapsed
~~~~~

So, I don't think we need to talk about 4) anymore. But I do think that 
comparing 3) to 2) begs for clarifications. Just linking against lttng-ust 
grinds the workload to a halt. The ~400 UST events cannot explain this at all. 
Additionally, the timeline visualization of the processes becomes much harder, 
as the UST overhead seems to dominate. This becomes apparent when comparing 
the 2) and 3) data in tracecompass visually...

Could anyone look into this please? As-is, I cannot recommend using lttng-ust. 
Rather, I'd opt for "faking" the custom trace points by e.g. doing something 
like open("/UST-FAKE/$payload-here"). This also allows me to "annotate" the 
kernel trace, a bit clumsily, but at least it has extremely low overhead when 
compared to UST...

You can find a toy Qt 5 application to reproduce my measurements above here:

https://swanson.kdab.com/owncloud/index.php/s/FGI2PZNvwzoR4RZ

Unpack it, then build it with:

~~~~~
cd ust-slowness
mkdir build-with-ust build-no-ust
cd build-with-ust
qmake -r CONFIG+=with_lttng_ust ..
make
cd ../build-no-ust
qmake -r ..
make
~~~~~~

Then you can reproduce the issue by comparing runs of the `launcher` binary in 
the two build folders. One will be quick, the other will be dog slow. I hope 
you guys find more optimization opportunities here.

If not, then shouldn't it be possible to get something like tracef() simulated 
via a custom syscall that gets directly handled by the kernel LTTng module? 
This would hopefully be just as fast as using only the kernel tracing, while 
removing the overhead of UST tracing... Just an idea.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart1909254.iedNQQuK5R
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwOTA3MDg0NzQ2WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgMLZnWnC4rZDtjpchON6FHJq0zCAG
1MP7jywsD2luZc4wDQYJKoZIhvcNAQEBBQAEggEALZGJGpbmcyXDrgY3SJSCXSUKD/g6h4ELkzWh
g69GEhQ/aOeXfvqLYXFk0KGL3otusGIYnHzwM+i9Ye1Cu3wsvyesm1TrpAPeZLNLVM9v83/MP/Bh
EqRnHlMXL4Qap53mJLnjfaqKU30hqaQMqdlR/AcU7Az/qStL1KVqs49d+vcELqjKsdwpy7MhAXO0
waG/7haGQBHD2/YNJyLtLM7OJ22w6zaXvF7j3rJwqmLtRz10k4B0TD19njSG0Qdc1Ur2BFzWY/hs
YhrbcTiMMrS5VVFx2Cx69cKaUlJj0V6NgAqPO/COqJB1NTOK5aeFQSnl2jIzr03TAYjFIwPjn2hH
wQAAAAAAAA==


--nextPart1909254.iedNQQuK5R--




--===============6957147221333004225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6957147221333004225==--
