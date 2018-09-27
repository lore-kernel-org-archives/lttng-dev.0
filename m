From: John O'Sullivan <John.OSullivan@BlackBox.com>
Subject: User Space Tracing
Date: Thu, 27 Sep 2018 16:13:37 +0000
Message-ID: <1538064817178.44592__46756.9596054547$1538064778$gmane$org@BlackBox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_006_153806481717844592BlackBoxcom_"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from esa4.hc2026-0.iphmx.com (esa4.hc2026-0.iphmx.com
 [68.232.154.207])
 by lists.lttng.org (Postfix) with ESMTPS id 42Lfyx0CtRzxMs
 for <lttng-dev@lists.lttng.org>; Thu, 27 Sep 2018 12:14:48 -0400 (EDT)
Content-Language: en-IE
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

--_006_153806481717844592BlackBoxcom_
Content-Type: multipart/alternative;
	boundary="_000_153806481717844592BlackBoxcom_"

--_000_153806481717844592BlackBoxcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am really struggling trying to get user space tracing working predictably=
 and consistently and would appreciate some help.


I created a trace event called

kvm_server:new_connection_tracepoint (see attached), I then use lttng-gen-t=
p to generate the .c and .h files which I link to the program and call with

tracepoint(kvm_server, new_connection_tracepoint, .................)

This appears predictably in my traces

However if I call my second tracepoint (see attached)

tracepoint(resolution_management, resolution_management_tracepoint,.......)

It never appears in any of the traces

I can see no significant difference between the two definitions.


I then created a third trace definition called simple_example (see attached=
)

tracepoint(simple_example, simple_example_tracepoint, .....)

This again appears in the trace


I start the tracing using

lttng enable-event -u -a      # enable user-space tracing

I then use babel trace to dump the trace,


'kvm_server' and 'simple_example' appear in the trace,  resolution_manageme=
nt does not.



Any idea why the resolution_management tracepoint does not appear in any tr=
aces or is there some way of debugging the tracecall macro itself?


regards

John

________________________________

This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail in general. If you are not the intended r=
ecipient or you have received this email in error, any use, dissemination o=
r forwarding of this email is strictly prohibited. If you have received thi=
s email in error, please notify the sender by replying to this email.

--_000_153806481717844592BlackBoxcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} --></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>I am really struggling trying to get user space tracing working predicta=
bly and consistently and would appreciate some help.</p>
<p><br>
</p>
<p>I created a trace event called </p>
<p>kvm_server:new_connection_tracepoint (see attached), I then use lttng-ge=
n-tp to generate the .c and .h files which I link to the program and call w=
ith
</p>
<p>tracepoint(kvm_server, new_connection_tracepoint, .................)</p>
<p>This appears predictably in my traces</p>
<p>However if I call my second tracepoint (see attached)<br>
</p>
<p>tracepoint(resolution_management, resolution_management_tracepoint,.....=
..)</p>
<p>It never appears in any of the traces</p>
<p>I can see no significant difference between the two definitions.</p>
<p><br>
</p>
<p>I then created a third trace definition called simple_example (see attac=
hed)<br>
</p>
<p>tracepoint(simple_example, simple_example_tracepoint, .....)</p>
<p>This again appears in the trace</p>
<p><br>
</p>
<p>I start the tracing using </p>
<p>lttng enable-event -u -a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # enable user-spa=
ce tracing</p>
<p>I then use babel trace to dump the trace, </p>
<p><br>
</p>
<p>'kvm_server' and 'simple_example' appear in the trace,&nbsp; resolution_=
management does not.</p>
<p><br>
</p>
<p><br>
</p>
<p>Any idea why the resolution_management tracepoint does not appear in any=
 traces or is there some way of debugging the tracecall macro itself?<br>
</p>
<p><br>
</p>
<p>regards</p>
<p>John<br>
</p>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1"><br>
This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail
 in general. If you are not the intended recipient or you have received thi=
s email in error, any use, dissemination or forwarding of this email is str=
ictly prohibited. If you have received this email in error, please notify t=
he sender by replying to this email.<br>
</font>
</body>
</html>

--_000_153806481717844592BlackBoxcom_--

--_006_153806481717844592BlackBoxcom_
Content-Type: application/octet-stream; name="connection_management_tp.tp"
Content-Description: connection_management_tp.tp
Content-Disposition: attachment; filename="connection_management_tp.tp";
	size=2100; creation-date="Thu, 27 Sep 2018 14:56:37 GMT";
	modification-date="Thu, 27 Sep 2018 14:56:37 GMT"
Content-Transfer-Encoding: base64

VFJBQ0VQT0lOVF9FVkVOVF9DTEFTUygKICAgIC8qIFRyYWNlcG9pbnQgcHJvdmlkZXIgbmFtZSAq
LwogICAga3ZtX3NlcnZlciwKCiAgICAvKiBUcmFjZXBvaW50IGNsYXNzIG5hbWUgKi8KICAgIGNv
bm5lY3Rpb25fbWFuYWdlbWVudF90cmFjZXBvaW50X2NsYXNzLAoKLyogSW5wdXQgYXJndW1lbnRz
ICovCiAgICBUUF9BUkdTKAogICAgICBpbnQsIGNvbm5lY3Rpb25fdHlwZSwKICAgICAgaW50LCBj
b25uZWN0aW9uX2lkLAogICAgICBpbnQsIHNsYXZlX2lkLAogICAgICBpbnQsIGNtX2Nvbm5lY3Rp
b25fbW9kZSwKICAgICAgY29uc3QgY2hhciAqLCBjb25uZWN0aW9uX2hvc3RuYW1lCiAgICApLAoK
ICAgIC8qIE91dHB1dCBldmVudCBmaWVsZHMgKi8KICAgIFRQX0ZJRUxEUygKCSAgICBjdGZfaW50
ZWdlcihpbnQsIGNvbm5fdHlwZSwgY29ubmVjdGlvbl90eXBlKQoJICAgIGN0Zl9pbnRlZ2VyKGlu
dCwgY29ubl9pZCwgY29ubmVjdGlvbl9pZCkKCSAgICBjdGZfaW50ZWdlcihpbnQsIHNsYXZlX2lk
LCBzbGF2ZV9pZCkKICAgICAgICBjdGZfaW50ZWdlcihpbnQsIGNtX21vZGUsIGNtX2Nvbm5lY3Rp
b25fbW9kZSkKCSAgICBjdGZfc3RyaW5nKGhvc3RuYW1lLCBjb25uZWN0aW9uX2hvc3RuYW1lKQog
ICAgKQopCgoKCgoKVFJBQ0VQT0lOVF9FVkVOVF9JTlNUQU5DRSgKICAgIGt2bV9zZXJ2ZXIsCiAg
ICBjb25uZWN0aW9uX21hbmFnZW1lbnRfdHJhY2Vwb2ludF9jbGFzcywKICAgIG5ld19jb25uZWN0
aW9uX3RyYWNlcG9pbnQsCiAgICBUUF9BUkdTKAogICAgICBpbnQsIGNvbm5lY3Rpb25fdHlwZSwK
ICAgICAgaW50LCBjb25uZWN0aW9uX2lkLAogICAgICBpbnQsIHNsYXZlX2lkLAogICAgICBpbnQs
IGNtX2Nvbm5lY3Rpb25fbW9kZSwKICAgICAgY29uc3QgY2hhciAqLCBjb25uZWN0aW9uX2hvc3Ru
YW1lCiAgICApCikKClRSQUNFUE9JTlRfRVZFTlRfSU5TVEFOQ0UoCiAgICBrdm1fc2VydmVyLAog
ICAgY29ubmVjdGlvbl9tYW5hZ2VtZW50X3RyYWNlcG9pbnRfY2xhc3MsCiAgICBjb25uZWN0aW9u
X3Rlcm1pbmF0aW9uX3RyYWNlcG9pbnQsCiAgICBUUF9BUkdTKAogICAgICBpbnQsIGNvbm5lY3Rp
b25fdHlwZSwKICAgICAgaW50LCBjb25uZWN0aW9uX2lkLAogICAgICBpbnQsIHNsYXZlX2lkLAog
ICAgICBpbnQsIGNtX2Nvbm5lY3Rpb25fbW9kZSwKICAgICAgY29uc3QgY2hhciAqLCBjb25uZWN0
aW9uX2hvc3RuYW1lCiAgICApCikKClRSQUNFUE9JTlRfRVZFTlRfSU5TVEFOQ0UoCiAgICBrdm1f
c2VydmVyLAogICAgY29ubmVjdGlvbl9tYW5hZ2VtZW50X3RyYWNlcG9pbnRfY2xhc3MsCiAgICBj
b25uZWN0aW9uX2NsaWVudF9yZWFkeV90cmFjZXBvaW50LAogICAgVFBfQVJHUygKICAgICAgaW50
LCBjb25uZWN0aW9uX3R5cGUsCiAgICAgIGludCwgY29ubmVjdGlvbl9pZCwKICAgICAgaW50LCBz
bGF2ZV9pZCwKICAgICAgaW50LCBjbV9jb25uZWN0aW9uX21vZGUsCiAgICAgIGNvbnN0IGNoYXIg
KiwgY29ubmVjdGlvbl9ob3N0bmFtZQogICAgKQopCgpUUkFDRVBPSU5UX0VWRU5UX0lOU1RBTkNF
KAogICAga3ZtX3NlcnZlciwKICAgIGNvbm5lY3Rpb25fbWFuYWdlbWVudF90cmFjZXBvaW50X2Ns
YXNzLAogICAgY29ubmVjdGlvbl9zZXJ2ZXJfcGVlcl9yZWFkeV90cmFjZXBvaW50LAogICAgVFBf
QVJHUygKICAgICAgaW50LCBjb25uZWN0aW9uX3R5cGUsCiAgICAgIGludCwgY29ubmVjdGlvbl9p
ZCwKICAgICAgaW50LCBzbGF2ZV9pZCwKICAgICAgaW50LCBjbV9jb25uZWN0aW9uX21vZGUsCiAg
ICAgIGNvbnN0IGNoYXIgKiwgY29ubmVjdGlvbl9ob3N0bmFtZQogICAgKQopCgpUUkFDRVBPSU5U
X0VWRU5UX0lOU1RBTkNFKAogICAga3ZtX3NlcnZlciwKICAgIGNvbm5lY3Rpb25fbWFuYWdlbWVu
dF90cmFjZXBvaW50X2NsYXNzLAogICAgY29ubmVjdGlvbl9pbmZvX3RyYWNlcG9pbnQsCiAgICBU
UF9BUkdTKAogICAgICBpbnQsIGNvbm5lY3Rpb25fdHlwZSwKICAgICAgaW50LCBjb25uZWN0aW9u
X2lkLAogICAgICBpbnQsIHNsYXZlX2lkLAogICAgICBpbnQsIGNtX2Nvbm5lY3Rpb25fbW9kZSwK
ICAgICAgY29uc3QgY2hhciAqLCBjb25uZWN0aW9uX2hvc3RuYW1lCiAgICApCikK

--_006_153806481717844592BlackBoxcom_
Content-Type: application/octet-stream; name="resolution_management_tp.tp"
Content-Description: resolution_management_tp.tp
Content-Disposition: attachment; filename="resolution_management_tp.tp";
	size=1568; creation-date="Thu, 27 Sep 2018 14:56:38 GMT";
	modification-date="Thu, 27 Sep 2018 14:56:38 GMT"
Content-Transfer-Encoding: base64

ClRSQUNFUE9JTlRfRVZFTlRfQ0xBU1MoCiAgICAvKiBUcmFjZXBvaW50IHByb3ZpZGVyIG5hbWUg
Ki8KICAgIHJlc29sdXRpb25fbWFuYWdlbWVudCwKCiAgICAvKiBUcmFjZXBvaW50IGNsYXNzIG5h
bWUgKi8KICAgIHJlc29sdXRpb25fbWFuYWdlbWVudF90cmFjZXBvaW50X2NsYXNzLAoKLyogSW5w
dXQgYXJndW1lbnRzICovCiAgICBUUF9BUkdTKAogICAgICBpbnQsIGNvbm5lY3Rpb25fdHlwZSwK
ICAgICAgaW50LCBjb25uZWN0aW9uX3BpZCwKICAgICAgaW50LCBzbGF2ZV9pZCwKICAgICAgaW50
LCBjbV9jb25uZWN0aW9uX21vZGUsCiAgICAgIGNvbnN0IGNoYXIgKiwgY29ubmVjdGlvbl9ob3N0
bmFtZSwKICAgICAgaW50LCB3aWR0aCwKICAgICAgaW50LCBoZWlnaHQsCiAgICAgIGludCwgcmVm
cmVzaCwKICAgICAgaW50LCBzeW5jX2xvc3MKCgogICAgKSwKCiAgICAvKiBPdXRwdXQgZXZlbnQg
ZmllbGRzICovCiAgICBUUF9GSUVMRFMoCgkgICAgY3RmX2ludGVnZXIoaW50LCBjb25uX3R5cGUs
IGNvbm5lY3Rpb25fdHlwZSkKCSAgICBjdGZfaW50ZWdlcihpbnQsIGNvbm5faWQsIGNvbm5lY3Rp
b25fcGlkKQoJICAgIGN0Zl9pbnRlZ2VyKGludCwgc2xhdmVfaWQsIHNsYXZlX2lkKQogICAgICAg
IGN0Zl9pbnRlZ2VyKGludCwgY21fbW9kZSwgY21fY29ubmVjdGlvbl9tb2RlKQoJICAgIGN0Zl9z
dHJpbmcoaG9zdG5hbWUsIGNvbm5lY3Rpb25faG9zdG5hbWUpCgkJY3RmX2ludGVnZXIoaW50LCB3
aWR0aCwgd2lkdGgpCgkJY3RmX2ludGVnZXIoaW50LCBoZWlnaHQsIGhlaWdodCkKCQljdGZfaW50
ZWdlcihpbnQsIHJlZnJlc2gsIHJlZnJlc2gpCgkgICAgY3RmX2ludGVnZXIoaW50LCBzeW5jX2xv
c3MsIHN5bmNfbG9zcykKCgogICAgKQopCgoKCgoKVFJBQ0VQT0lOVF9FVkVOVF9JTlNUQU5DRSgK
ICAgIHJlc29sdXRpb25fbWFuYWdlbWVudCwKICAgIHJlc29sdXRpb25fbWFuYWdlbWVudF90cmFj
ZXBvaW50X2NsYXNzLAogICAgcmVzb2x1dGlvbl9tYW5hZ2VtZW50X3RyYWNlcG9pbnQsCiAgICBU
UF9BUkdTKAogICAgICBpbnQsIGNvbm5lY3Rpb25fdHlwZSwKICAgICAgaW50LCBjb25uZWN0aW9u
X3BpZCwKICAgICAgaW50LCBzbGF2ZV9pZCwKICAgICAgaW50LCBjbV9jb25uZWN0aW9uX21vZGUs
CiAgICAgIGNvbnN0IGNoYXIgKiwgY29ubmVjdGlvbl9ob3N0bmFtZSwKICAgICAgaW50LCB3aWR0
aCwKICAgICAgaW50LCBoZWlnaHQsCiAgICAgIGludCwgcmVmcmVzaAoKCiAgICApCikKCgoKCgpU
UkFDRVBPSU5UX0VWRU5UX0lOU1RBTkNFKAogICAgcmVzb2x1dGlvbl9tYW5hZ2VtZW50LAogICAg
cmVzb2x1dGlvbl9tYW5hZ2VtZW50X3RyYWNlcG9pbnRfY2xhc3MsCiAgICBzeW5jX2xvc3NfdHJh
Y2Vwb2ludCwKICAgIFRQX0FSR1MoCiAgICAgIGludCwgY29ubmVjdGlvbl90eXBlLAogICAgICBp
bnQsIGNvbm5lY3Rpb25fcGlkLAogICAgICBpbnQsIHNsYXZlX2lkLAogICAgICBpbnQsIGNtX2Nv
bm5lY3Rpb25fbW9kZSwKICAgICAgY29uc3QgY2hhciAqLCBjb25uZWN0aW9uX2hvc3RuYW1lLAog
ICAgICBpbnQsIHN5bmNfbG9zcwoKICAgICkKKQo=

--_006_153806481717844592BlackBoxcom_
Content-Type: application/octet-stream; name="simple_trace_tp.tp"
Content-Description: simple_trace_tp.tp
Content-Disposition: attachment; filename="simple_trace_tp.tp"; size=798;
	creation-date="Thu, 27 Sep 2018 14:56:38 GMT";
	modification-date="Thu, 27 Sep 2018 14:56:38 GMT"
Content-Transfer-Encoding: base64

ClRSQUNFUE9JTlRfRVZFTlRfQ0xBU1MoCiAgICAvKiBUcmFjZXBvaW50IHByb3ZpZGVyIG5hbWUg
Ki8KICAgIHNpbXBsZV9leGFtcGxlLAoKICAgIC8qIFRyYWNlcG9pbnQgY2xhc3MgbmFtZSAqLwog
ICAgc2ltcGxlX2V4YW1wbGVfdHJhY2Vwb2ludF9jbGFzcywKCi8qIElucHV0IGFyZ3VtZW50cyAq
LwogICAgVFBfQVJHUygKICAgICAgaW50LCBjb25uZWN0aW9uX3R5cGUsCiAgICAgIGludCwgY29u
bmVjdGlvbl9waWQKCiAgICApLAoKICAgIC8qIE91dHB1dCBldmVudCBmaWVsZHMgKi8KICAgIFRQ
X0ZJRUxEUygKCSAgICBjdGZfaW50ZWdlcihpbnQsIGNvbm5fdHlwZSwgY29ubmVjdGlvbl90eXBl
KQoJICAgIGN0Zl9pbnRlZ2VyKGludCwgY29ubl9pZCwgY29ubmVjdGlvbl9waWQpCgogICAgKQop
CgoKCgoKVFJBQ0VQT0lOVF9FVkVOVF9JTlNUQU5DRSgKICAgIHNpbXBsZV9leGFtcGxlLAogICAg
c2ltcGxlX2V4YW1wbGVfdHJhY2Vwb2ludF9jbGFzcywKICAgIHNpbXBsZV9leGFtcGxlX3RyYWNl
cG9pbnQsCiAgICBUUF9BUkdTKAogICAgICBpbnQsIGNvbm5lY3Rpb25fdHlwZSwKICAgICAgaW50
LCBjb25uZWN0aW9uX3BpZAoKCiAgICApCikKCgoKCgpUUkFDRVBPSU5UX0VWRU5UX0lOU1RBTkNF
KAogICAgc2ltcGxlX2V4YW1wbGUsCiAgICBzaW1wbGVfZXhhbXBsZV90cmFjZXBvaW50X2NsYXNz
LAogICAgc2Vjb25kX3NpbXBsZV9leGFtcGxlX3RyYWNlcG9pbnQsCiAgICBUUF9BUkdTKAogICAg
ICBpbnQsIGNvbm5lY3Rpb25fdHlwZSwKICAgICAgaW50LCBjb25uZWN0aW9uX3BpZAogICAgKQop

--_006_153806481717844592BlackBoxcom_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--_006_153806481717844592BlackBoxcom_--
