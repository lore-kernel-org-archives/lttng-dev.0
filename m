From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?The_problem_with_compiling_multiple_tracepo?=
 =?utf-8?q?int_sources_with_app_directly?=
Date: Tue, 29 Oct 2013 09:50:05 +0800
Message-ID: <73a74f67-0109-4724-93b9-96b8ef72ee03__9143.85986184261$1383011482$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0852682105=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-316.freemail.mail.aliyun.com ([110.75.46.16])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhenyu.ren@aliyun.com>) id 1VayRo-0007pa-6c
	for lttng-dev@lists.lttng.org; Mon, 28 Oct 2013 21:50:27 -0400
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

--===============0852682105==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_28991_54ef1940_526f144d_2971c"

------=ALIBOUNDARY_28991_54ef1940_526f144d_2971c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGksZGV2LWxpc3QKwqDCoCBJdCBzZWVtcyB3b3JrIHdlbGwgaWYgdGhlcmUgaXMgb25seSBvbmUg
dHJhY2Vwb2ludCBmaWxlKHNhbXBsZV90cmFjZXBvaW50LmgpIGluY2x1ZGluZyBpbiBhcHAgLmku
ZXNhbXBsZV90cmFjZXBvaW50LmgjdW5kZWYgVFJBQ0VQT0lOVF9QUk9WSURFUgojZGVmaW5lIFRS
QUNFUE9JTlRfUFJPVklERVIgc2FtcGxlCgojaWYgIWRlZmluZWQoU0FNUExFX1RSQUNFUE9JTlRf
SCkgfHwgZGVmaW5lZChUUkFDRVBPSU5UX0hFQURFUl9NVUxUSV9SRUFEKQojZGVmaW5lIFNBTVBM
RV9UUkFDRVBPSU5UX0gKCiNpbmNsdWRlIDxsdHRuZy90cmFjZXBvaW50Lmg+CgpUUkFDRVBPSU5U
X0VWRU5UKArCoMKgwqDCoMKgwqDCoCBzYW1wbGUsCsKgwqDCoMKgwqDCoMKgIGJ5dGVzX2luLCAv
LyBDKysgU3R5bGUgY29tbWVudArCoMKgwqDCoMKgwqDCoCBUUF9BUkdTKGNoYXIgKiwgdGV4dCks
CsKgwqDCoMKgwqDCoMKgIFRQX0ZJRUxEUygKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGN0Zl9zdHJpbmcobWVzc2FnZSwgdGV4dCkKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCApCikKI2VuZGlmIC8qIFNBTVBMRV9UUkFDRVBPSU5UX0ggKi8KI3VuZGVmIFRSQUNFUE9J
TlRfSU5DTFVERQojZGVmaW5lIFRSQUNFUE9JTlRfSU5DTFVERSAiLi9zYW1wbGVfdHJhY2Vwb2lu
dC5oIgoKI2luY2x1ZGUgPGx0dG5nL3RyYWNlcG9pbnQtZXZlbnQuaD4Kc2FtcGxlLmMjaW5jbHVk
ZSA8dW5pc3RkLmg+CiNkZWZpbmUgVFJBQ0VQT0lOVF9ERUZJTkUKI2RlZmluZSBUUkFDRVBPSU5U
X0NSRUFURV9QUk9CRVMKI2luY2x1ZGUgInNhbXBsZV90cmFjZXBvaW50LmgiCmludCBtYWluKGlu
dCBhcmdjLCBjaGFyICoqYXJndikKewrCoMKgwqDCoMKgwqDCoCBpbnQgaSA9IDA7CsKgwqDCoMKg
wqDCoMKgIGZvciAoaSA9IDA7IGkgPCAxMDAwMDA7IGkrKykgewrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdHJhY2Vwb2ludChzYW1wbGUsIGJ5dGVzX2luLMKgICJieXRlcyBpbiIpOwrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xlZXAoMSk7CsKgwqDCoMKgwqDCoMKgIH0K
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cn0KY29tcGlsZTrCoGdjYyAtSS4gLW8gc2FtcGxlIHNh
bXBsZS5jIC1sZGwgLWxsdHRuZy11c3RIb3dldmVyLElmIG9uZSBtb3JlIHRyYWNlcG9pbnQgaW5j
bHVkZSBmaWxlKHNhbXBsZV90cmFjZXBvaW50Mi5oKSBhZGRlZCBpbiBhcHAsY29tcGlsZSBmYWls
ZWQuc2FtcGxlX3RyYWNlcG9pbnQyLmgjdW5kZWYgVFJBQ0VQT0lOVF9QUk9WSURFUgojZGVmaW5l
IFRSQUNFUE9JTlRfUFJPVklERVIgc2FtcGxlMgojaWYgIWRlZmluZWQoU0FNUExFX1RSQUNFUE9J
TlQyX0gpIHx8IGRlZmluZWQoVFJBQ0VQT0lOVF9IRUFERVJfTVVMVElfUkVBRCkKI2RlZmluZSBT
QU1QTEVfVFJBQ0VQT0lOVDJfSAoKI2luY2x1ZGUgPGx0dG5nL3RyYWNlcG9pbnQuaD4KClRSQUNF
UE9JTlRfRVZFTlQoCsKgwqDCoMKgwqDCoMKgIHNhbXBsZTIsCsKgwqDCoMKgwqDCoMKgIGJ5dGVz
X2luLCAvLyBDKysgU3R5bGUgY29tbWVudArCoMKgwqDCoMKgwqDCoCBUUF9BUkdTKGNoYXIgKiwg
dGV4dCksCsKgwqDCoMKgwqDCoMKgIFRQX0ZJRUxEUygKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGN0Zl9zdHJpbmcobWVzc2FnZSwgdGV4dCkKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCApCikKI2VuZGlmIC8qIFNBTVBMRV9UUkFDRVBPSU5UMl9IICovCiN1bmRlZiBU
UkFDRVBPSU5UX0lOQ0xVREUKI2RlZmluZSBUUkFDRVBPSU5UX0lOQ0xVREUgIi4vc2FtcGxlX3Ry
YWNlcG9pbnQyLmgiCiNpbmNsdWRlIDxsdHRuZy90cmFjZXBvaW50LWV2ZW50Lmg+CnNhbXBsZS5j
I2luY2x1ZGUgPHVuaXN0ZC5oPgojZGVmaW5lIFRSQUNFUE9JTlRfREVGSU5FCiNkZWZpbmUgVFJB
Q0VQT0lOVF9DUkVBVEVfUFJPQkVTCiNpbmNsdWRlICJzYW1wbGVfdHJhY2Vwb2ludC5oIgojaW5j
bHVkZSAic2FtcGxlX3RyYWNlcG9pbnQyLmgiCgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpCnsKwqDCoMKgwqDCoMKgwqAgaW50IGkgPSAwOwrCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAw
OyBpIDwgMTAwMDAwOyBpKyspIHsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNl
cG9pbnQoc2FtcGxlLCBieXRlc19pbizCoCAiYnl0ZXMgaW4iKTsKwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRyYWNlcG9pbnQoc2FtcGxlMiwgYnl0ZXNfaW4swqAgImJ5dGVzIGluIik7
CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbGVlcCgxKTsKwqDCoMKgwqDCoMKgwqAg
fQrCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKfQpjb21waWxlOmdjYyAtSS4gLW8gc2FtcGxlIHNh
bXBsZS5jIC1sZGwgLWxsdHRuZy11c3RzYW1wbGUuYzogSW4gZnVuY3Rpb27LnG1haW46CnNhbXBs
ZS5jOjEyOiBlcnJvcjogX190cmFjZXBvaW50X3NhbXBsZTJfX19ieXRlc19pbiB1bmRlY2xhcmVk
IChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKc2FtcGxlLmM6MTI6IGVycm9yOiAoRWFjaCB1
bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlCnNhbXBsZS5jOjEyOiBl
cnJvcjogZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pwqDCoCBEb2VzIExUVG5nIHN1
cHBvcnQgY29tcGlsaW5nIG11bHRpcGxlIHRyYWNlcG9pbnQgc291cmNlcyB3aXRoIGFwcCBkaXJl
Y3RseT/CoMKgIFllcyxJIGNhbiBjb21waWxlIG11bHRpcGxlIHRyYWNlcG9pbnQgcHJvdmlkZXJz
IHRvIHNoYXJlIGxpYnMgYW5kIGxpbmsgdGhlbSB0byBhcHAgdGhyb3VnaMKgVFJBQ0VQT0lOVF9Q
Uk9CRV9EWU5BTUlDX0xJTktBR0XCoCBzdWNoIGFzIHdoYXQgZG9jL2V4YW1wbGVzL2RlbW8gZG9l
cy4gVGhhbmtzemhlbnl1LnJlbgoK
------=ALIBOUNDARY_28991_54ef1940_526f144d_2971c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"">Hi,dev-list<br></div>=
<div style=3D""><br data-mce-bogus=3D"1"></div><div style=3D"">&nbsp;&nbsp; It=
 seems work well if there is only one tracepoint file(sample_tracepoint.h) inc=
luding in app .i.e<br data-mce-bogus=3D"1"></div><div style=3D""><br data-mce-=
bogus=3D"1"></div><div style=3D"">sample_tracepoint.h<br data-mce-bogus=3D"1">=
</div><div style=3D""><br data-mce-bogus=3D"1"></div><div style=3D"">#undef TR=
ACEPOINT_PROVIDER<br>#define TRACEPOINT_PROVIDER sample<br><br>#if !defined(SA=
MPLE_TRACEPOINT_H) || defined(TRACEPOINT_HEADER_MULTI_READ)<br>#define SAMPLE_=
TRACEPOINT_H<br><br>#include &lt;lttng/tracepoint.h&gt;<br><br>TRACEPOINT_EVEN=
T(<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sample,<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bytes_in, // C++ Style comment<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(char *, text),<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; TP_FIELDS(<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_string(message, text)<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; )<br>)<br>#endif /* SAMPLE_TRACEPOINT_H */<br>#undef TRACEPO=
INT_INCLUDE<br>#define TRACEPOINT_INCLUDE "./sample_tracepoint.h"<br><br>#incl=
ude &lt;lttng/tracepoint-event.h&gt;<br></div><div style=3D""><br data-mce-bog=
us=3D"1"></div><div style=3D"">sample.c<br data-mce-bogus=3D"1"></div><div sty=
le=3D"">#include &lt;unistd.h&gt;<br>#define TRACEPOINT_DEFINE<br>#define TRAC=
EPOINT_CREATE_PROBES<br>#include "sample_tracepoint.h"<br>int main(int argc, c=
har **argv)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 100000; i++) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; tracepoint(sample, bytes_in,&nbsp; "bytes in");<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sleep(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>}<br></div><div style=3D"">compile:=
<br data-mce-bogus=3D"1"></div><div style=3D"">&nbsp;gcc -I. -o sample sample.=
c -ldl -llttng-ust</div><div style=3D""><br data-mce-bogus=3D"1"></div><div st=
yle=3D"">However,If one more tracepoint include file(sample_tracepoint2.h) add=
ed in app,compile failed.<br data-mce-bogus=3D"1"></div><div style=3D""><br da=
ta-mce-bogus=3D"1"></div><div style=3D"">sample_tracepoint2.h<br data-mce-bogu=
s=3D"1"></div><div style=3D"">#undef TRACEPOINT_PROVIDER<br>#define TRACEPOINT=
_PROVIDER sample2<br>#if !defined(SAMPLE_TRACEPOINT2_H) || defined(TRACEPOINT_=
HEADER_MULTI_READ)<br>#define SAMPLE_TRACEPOINT2_H<br><br>#include &lt;lttng/t=
racepoint.h&gt;<br><br>TRACEPOINT_EVENT(<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; sample2,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_in, // C=
++ Style comment<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(char *,=
 text),<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_FIELDS(<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ctf_string(message, text)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>)<br>#endif /* S=
AMPLE_TRACEPOINT2_H */<br>#undef TRACEPOINT_INCLUDE<br>#define TRACEPOINT_INCL=
UDE "./sample_tracepoint2.h"<br>#include &lt;lttng/tracepoint-event.h&gt;<br><=
/div><div style=3D""><br data-mce-bogus=3D"1"></div><div style=3D"">sample.c<b=
r data-mce-bogus=3D"1"></div><div style=3D"">#include &lt;unistd.h&gt;<br>#def=
ine TRACEPOINT_DEFINE<br>#define TRACEPOINT_CREATE_PROBES<br>#include "sample_=
tracepoint.h"<br>#include "sample_tracepoint2.h"<br><br>int main(int argc, cha=
r **argv)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 100000; i++) {<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; tracepoint(sample, bytes_in,&nbsp; "bytes in");<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; tracepoint(sample2, bytes_in,&nbsp; "bytes in");<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep(1);<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>}<br></div><div style=3D""><br data-mce-bogus=3D"1=
"></div><div style=3D"">compile:<br data-mce-bogus=3D"1"></div><div style=3D""=
>gcc -I. -o sample sample.c -ldl -llttng-ust</div><div style=3D"">sample.c: In=
 function=CB=9Cmain:<br>sample.c:12: error: __tracepoint_sample2___bytes_in un=
declared (first use in this function)<br>sample.c:12: error: (Each undeclared =
identifier is reported only once<br>sample.c:12: error: for each function it a=
ppears in.)</div><div style=3D""><br data-mce-bogus=3D"1"></div><div style=3D"=
">&nbsp;&nbsp; Does LTTng support compiling multiple tracepoint sources with a=
pp directly?</div><div style=3D""><br data-mce-bogus=3D"1"></div><div style=3D=
"">&nbsp;&nbsp; Yes,I can compile multiple tracepoint providers to share libs =
and link them to app through&nbsp;TRACEPOINT_PROBE_DYNAMIC_LINKAGE&nbsp; such =
as what doc/examples/demo does. <br data-mce-bogus=3D"1"></div><div style=3D""=
><br data-mce-bogus=3D"1"></div><div style=3D"">Thanks<br data-mce-bogus=3D"1"=
></div><div style=3D"">zhenyu.ren<br data-mce-bogus=3D"1"></div><div class=3D"=
__aliyun_signature_wrap"><br><br></div></div>
------=ALIBOUNDARY_28991_54ef1940_526f144d_2971c--



--===============0852682105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0852682105==--
