From: Milian Wolff via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: decoding tracef msg string via babeltrace API
Date: Tue, 02 Apr 2019 21:40:02 +0200
Message-ID: <5382125.x1mbapOiNS__31151.0242916242$1554234025$gmane$org@agathebauer>
References: <33072915.QNGMzHgIAz@agathebauer>
Reply-To: Milian Wolff <milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3818558249736486837=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 44YfgV6DHzz1L5c
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2019 15:40:06 -0400 (EDT)
In-Reply-To: <33072915.QNGMzHgIAz@agathebauer>
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

--===============3818558249736486837==
Content-Type: multipart/signed; boundary="nextPart518082153.8bjd64lSC9";
 micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart518082153.8bjd64lSC9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 2. April 2019 21:03:41 CEST Milian Wolff wrote:
> Hey all
> 
> I added a tracef tracepoint and want to decode it's `msg` field in the
> BT_EVENT_FIELDS scope. Babeltrace on the command line seems to handle this
> nicely, but whatever I try, it doesn't work with the API.
> 
> I'm using babeltrace from the stable-1.5 branch.
> 
> First, the output from babeltrace on the command line:
> 
> ```
> event {
>         name = "lttng_ust_tracef:event";
>         id = 9;
>         stream_id = 0;
>         loglevel = 14;
>         fields := struct {
>                 integer { size = 32; align = 8; signed = 0; encoding = none;
> base = 10; } __msg_length;
>                 integer { size = 8; align = 8; signed = 1; encoding = UTF8;
> base = 10; } _msg[ __msg_length ];
>         };
> };
> ...
> timestamp = 15:56:15.404973865, delta = +0.000023594, trace = 1000/64-bit,
> trace:hostname = agathebauer, trace:domain = ust, loglevel = TRACE_DEBUG
> (14), name = lttng_ust_tracef:event, stream.packet.context = {
> timestamp_begin = 4382372875047, timestamp_end = 4462741641629,
> content_size = 47177888, packet_size = 47185920, packet_seq_num = 0,
> events_discarded = 0, cpu_id = 3 }, stream.event.header = { id = (
> "compact" : container = 9 ), v = { compact = { timestamp = 70385656 } } },
> event.fields = { _msg_length = 33, msg = "run_event_entry: ImageCache,
> 1000" }
> ...
> ```
> 
> Now, in my code I find the event and then I've tried:
> 
> ```
>             auto definition = bt_ctf_get_field(event, scope, "msg");
>             auto declaration = bt_ctf_get_decl_from_def(definition);
>             auto type = bt_ctf_field_type(declaration);
>             auto encoding = bt_ctf_get_encoding(declaration);
>             auto string = bt_ctf_get_string(definition);
>             auto char_array = bt_ctf_get_char_array(definition);
>             const bt_definition* const* list = nullptr;
>             unsigned num_list = 0;
>             auto field_list_ret = bt_ctf_get_field_list(ctf_event,
> definition, &list, &num_list);
>             fprintf(stderr, "tracef dbg: %p %p | %d %d | %s | %s | %p %u
> %d\n", definition, declaration, type, encoding, string, char_array, list,
> num_list, field_list_ret);
> ```
> 
> the output is:
> 
> ```
> tracef dbg: 0x55e4c5b084f0 0x55e4c5b3f220 | 9 1 | (null) | (null) | (nil) 0
> -1
> 
> ```
> 
> So, it's a sequence (type 9), but I can't get the sequence... Actually, when
> I tried this the firs ttime without patching babeltrace, then it crashed in
> events.c:256 [1]. The def_sequence is non-null, but def_sequence->elems is
> null and that's not checked...
> 
> [1]: https://github.com/efficios/babeltrace/blob/stable-1.5/formats/ctf/
> events.c#L256
> 
> I'm quite stumped - what am I doing wrong? How does babeltrace handle the
> string-decoding of tracef's msg arg?

I've found out that babeltrace seems to not consume the public API. Instead, 
in `sequence.c` it's directly accessing the sequence's string member. If I 
patch `bt_ctf_get_string` like this:

```
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index bd195b93..f0ea49c8 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -599,12 +599,26 @@ end:
 char *bt_ctf_get_string(const struct bt_definition *field)
 {
 	char *ret = NULL;
+	const struct bt_declaration *decl = field ? 
bt_ctf_get_decl_from_def(field) : NULL;
+	enum ctf_type_id type = decl ? bt_ctf_field_type(decl) : 
CTF_TYPE_UNKNOWN;
 
-	if (field && bt_ctf_field_type(bt_ctf_get_decl_from_def(field)) == 
CTF_TYPE_STRING)
+	if (type == CTF_TYPE_SEQUENCE) {
+		enum ctf_string_encoding encoding = bt_ctf_get_encoding(decl);
+		struct definition_sequence *sequence_definition;
+		if (encoding == CTF_STRING_UTF8 || encoding  == 
CTF_STRING_ASCII) {
+			sequence_definition = container_of(field, struct 
definition_sequence, p);
+			ret = sequence_definition->string->str;
+			goto end;
+		}
+	} else if (type == CTF_TYPE_STRING) {
 		ret = bt_get_string(field);
-	else
-		bt_ctf_field_set_error(-EINVAL);
+		goto end;
+	}
 
+error:
+	bt_ctf_field_set_error(-EINVAL);
+
+end:
 	return ret;
 }
```

it seems to be doing what I was hoping for. Would something like that be 
accepted upstream, or do we need a third string-returning function 
`bt_ctf_get_string_sequence` or similar?

Generally, I already dislike it very much that there is a distinction between 
`bt_ctf_get_string` and `bt_ctf_get_char_array` - both should - imo - be 
handled through `bt_ctf_get_string`.

Cheers
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart518082153.8bjd64lSC9
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNDAyMTk0MDAyWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgB6k1jQVtwC1nNeQ4F4CH89V5ALXj
LfjpbWyfrR3qg0owDQYJKoZIhvcNAQEBBQAEggEAmB4xHWwq8fZJTf7ePeU//EXOr4pgvsPICutk
53P3BJMtcldHgl9hM3rEXvr3TNiQP8TSjwOdqlzPTgQyjGR3bY5wlE4aC15IqW9UC+qukvBjtZlg
vyFRVyoXBtAqIabWEVhhD53U73E/Qsfx4y4wQGK1B+4oSlE6QhGgQidcrUPIURtMm9PRO0wBawgL
FGRv2CV5yugZstH73/1NM2/KzeKuBGGKhI/IRxw5Evm/389STGeQw9aXiHilV2trC9ciLysKpKHq
s4nAGKAeOAcSpe0ZKVVBybd2M9sNIwRmm845N2b78U9pUWLo3JKx0J9+MLRDRmoQIrnA8nigCg+h
xgAAAAAAAA==


--nextPart518082153.8bjd64lSC9--



--===============3818558249736486837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3818558249736486837==--
