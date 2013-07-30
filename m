From: Jonnavithula Sharma <sarmajprs@gmail.com>
Subject: Re: lttng Crash seen after stopping the traces.
Date: Tue, 30 Jul 2013 15:09:40 +0530
Message-ID: <CAJD=Q56CFSqfjGqiGUMN+Zq4WCFomuBNwbvGi=oTMjWM1hNZOA__47521.1674500771$1375177248$gmane$org@mail.gmail.com>
References: <CAJD=Q56dkx1jCUF0n03XFCs64hFmuDYELy+FVF9joZ8nxDUpDw@mail.gmail.com>
	<CA+jJMxt0kJJv2F26Myzcvms_6tSXAo269Zg5fMXyeXEn5eH95A@mail.gmail.com>
	<CAJD=Q56myG=OuBXv2At2NEB0eqXOqjtTqVAMA5SZf2BgmmZ3Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0103ecec5d1f6d04e2b76301
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sarmajprs@gmail.com>) id 1V46PC-0005gE-SB
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 05:39:51 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so2685111wgh.33
	for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2013 02:39:40 -0700 (PDT)
In-Reply-To: <CAJD=Q56myG=OuBXv2At2NEB0eqXOqjtTqVAMA5SZf2BgmmZ3Cg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, suprasad.desai@gmail.com
List-Id: lttng-dev@lists.lttng.org

--089e0103ecec5d1f6d04e2b76301
Content-Type: multipart/alternative; boundary=089e0103ecec5d1f6804e2b763ff

--089e0103ecec5d1f6804e2b763ff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry.Missed the attachment in previous mail.Enclosed here is the console
log for the crash with lttng-modules 2.2.1.

Regards,
Sarma  j


On Tue, Jul 30, 2013 at 11:08 AM, Jonnavithula Sharma
<sarmajprs@gmail.com>wrote:

> Hi Jeremie,
>
> We tried with the latest version(2.2.1) of lttng-modules. We are able to
> reproduce the same crash with the same steps.
>
> Am i missing anything here?
>
> Regards,
> Sarma J
>
>
> On Mon, Jul 29, 2013 at 9:05 PM, J=E9r=E9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>> Hi,
>>
>> Can you try to reproduce the problem with the latest version of
>> lttng-modules (v2.2.1)? There were some bug fixes to the ring buffer
>> that may correct your problem.
>>
>> Thanks for reporting,
>> J=E9r=E9mie
>>
>> On Mon, Jul 29, 2013 at 9:45 AM, Jonnavithula Sharma
>> <sarmajprs@gmail.com> wrote:
>> > Hi
>> >
>> > We are currently running lttng on our CPE with 64 MB RAM.We are
>> observing a
>> > crash after stopping the traces and even if we leave our CPE for few m=
in
>> > after starting the trace we are observing this crash.Please find the
>> > attachment for the crash log.
>> >
>> > Let us know if any one has faced this issue and your help is highly
>> > appreciated in resolving this issue.
>> >
>> >
>> > Regards,
>> > Sarma J
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>

--089e0103ecec5d1f6804e2b763ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry.Missed the attachment in previous mail.Enclosed=
 here is the console log for the crash with lttng-modules 2.2.1.<br><br></d=
iv>Regards,<br>Sarma=A0 j<br></div><div class=3D"gmail_extra"><br><br><div =
class=3D"gmail_quote">
On Tue, Jul 30, 2013 at 11:08 AM, Jonnavithula Sharma <span dir=3D"ltr">&lt=
;<a href=3D"mailto:sarmajprs@gmail.com" target=3D"_blank">sarmajprs@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div dir=3D"ltr"><div><div><div><div>Hi Jeremie,<br><br></div>We tried with=
 the latest version(2.2.1) of lttng-modules. We are able to reproduce the s=
ame crash with the same steps.<br><br></div>Am i missing anything here?<br>

<br></div>Regards,<br></div>Sarma J<br></div><div class=3D"HOEnZb"><div cla=
ss=3D"h5"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On =
Mon, Jul 29, 2013 at 9:05 PM, J=E9r=E9mie Galarneau <span dir=3D"ltr">&lt;<=
a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.=
galarneau@efficios.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
Can you try to reproduce the problem with the latest version of<br>
lttng-modules (v2.2.1)? There were some bug fixes to the ring buffer<br>
that may correct your problem.<br>
<br>
Thanks for reporting,<br>
J=E9r=E9mie<br>
<div><div><br>
On Mon, Jul 29, 2013 at 9:45 AM, Jonnavithula Sharma<br>
&lt;<a href=3D"mailto:sarmajprs@gmail.com" target=3D"_blank">sarmajprs@gmai=
l.com</a>&gt; wrote:<br>
&gt; Hi<br>
&gt;<br>
&gt; We are currently running lttng on our CPE with 64 MB RAM.We are observ=
ing a<br>
&gt; crash after stopping the traces and even if we leave our CPE for few m=
in<br>
&gt; after starting the trace we are observing this crash.Please find the<b=
r>
&gt; attachment for the crash log.<br>
&gt;<br>
&gt; Let us know if any one has faced this issue and your help is highly<br=
>
&gt; appreciated in resolving this issue.<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Sarma J<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<span><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--089e0103ecec5d1f6804e2b763ff--

--089e0103ecec5d1f6d04e2b76301
Content-Type: text/plain; charset=US-ASCII; name="lttng-crash_2.2.1.txt"
Content-Disposition: attachment; filename="lttng-crash_2.2.1.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjqwz7ou0

cm9vdEBsdHFjcGU6fiMgbHR0bmctc2Vzc2lvbmQgLWQgLXZ2dg0Kcm9vdEBsdHFjcGU6fiMgbHR0
bmcgY3JlYXRlIHRyYWNlDQpTZXNzaW9uIHRyYWNlIGNyZWF0ZWQuDQpUcmFjZXMgd2lsbCBiZSB3
cml0dGVuIGluIC9yb290L2x0dG5nLXRyYWNlcy90cmFjZS0yMDEzMDcyMi0xODU5MDANCnJvb3RA
bHRxY3BlOn4jIGx0dG5nIGVuYWJsZS1jaGFubmVsIGNoIC1zIHRyYWNlIC1rDQpLZXJuZWwgY2hh
bm5lbCBjaCBlbmFibGVkIGZvciBzZXNzaW9uIHRyYWNlDQpyb290QGx0cWNwZTp+IyBsdHRuZyBl
bmFibGUtZXZlbnQgZXYgLXMgdHJhY2UgLWsNCkVycm9yOiBFdmVudCBldjogRW5hYmxlIGtlcm5l
bCBldmVudCBmYWlsZWQgKGNoYW5uZWwgY2hhbm5lbDAsIHNlc3Npb24gdHJhY2UpDQpXYXJuaW5n
OiBTb21lIGNvbW1hbmQocykgd2VudCB3cm9uZw0Kcm9vdEBsdHFjcGU6fiMgbHR0bmcgZW5hYmxl
LWV2ZW50IGV2IC1rIHNjaGVkX3N3aXRjaA0KRXJyb3I6IEV2ZW50IGV2OiBFbmFibGUga2VybmVs
IGV2ZW50IGZhaWxlZCAoY2hhbm5lbCBjaGFubmVsMCwgc2Vzc2lvbiB0cmFjZSkNCldhcm5pbmc6
IFNvbWUgY29tbWFuZChzKSB3ZW50IHdyb25nDQpyb290QGx0cWNwZTp+IyBsdHRuZyBlbmFibGUt
ZXZlbnQgc2NoZWRfc3dpdGNoIC1rDQprZXJuZWwgZXZlbnQgc2NoZWRfc3dpdGNoIGNyZWF0ZWQg
aW4gY2hhbm5lbCBjaGFubmVsMA0Kcm9vdEBsdHFjcGU6fiMgbHR0bmcgc3RhcnQNClRyYWNpbmcg
c3RhcnRlZCBmb3Igc2Vzc2lvbiB0cmFjZQ0Kcm9vdEBsdHFjcGU6fiMgcGluZyAxOTIuMTY4LjEu
Mw0KUElORyAxOTIuMTY4LjEuMyAoMTkyLjE2OC4xLjMpOiA1NiBkYXRhIGJ5dGVzDQo2NCBieXRl
cyBmcm9tIDE5Mi4xNjguMS4zOiBzZXE9MCB0dGw9MTI4IHRpbWU9MS4xMTggbXMNCjY0IGJ5dGVz
IGZyb20gMTkyLjE2OC4xLjM6IHNlcT0xIHR0bD0xMjggdGltZT0wLjUwNSBtcw0KNjQgYnl0ZXMg
ZnJvbSAxOTIuMTY4LjEuMzogc2VxPTIgdHRsPTEyOCB0aW1lPTAuNTQ0IG1zDQo2NCBieXRlcyBm
cm9tIDE5Mi4xNjguMS4zOiBzZXE9MyB0dGw9MTI4IHRpbWU9MC41MjkgbXMNCjY0IGJ5dGVzIGZy
b20gMTkyLjE2OC4xLjM6IHNlcT00IHR0bD0xMjggdGltZT0wLjU0MSBtcw0KDQotLS0gMTkyLjE2
OC4xLjMgcGluZyBzdGF0aXN0aWNzIC0tLQ0KNSBwYWNrZXRzIHRyYW5zbWl0dGVkLCA1IHBhY2tl
dHMgcmVjZWl2ZWQsIDAlIHBhY2tldCBsb3NzDQpyb3VuZC10cmlwIG1pbi9hdmcvbWF4ID0gMC41
MDUvMC42NDcvMS4xMTggbXMNCnJvb3RAbHRxY3BlOn4jIGx0dG5nIHN0b3ANClsgIDIwMi4yNzAw
MDBdIENQVSAwIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1
YWwgYWRkcmVzcyBmZmZmOTc5YywgZXBjID09IDg3MWE5NzljLCByYSA9PSA4NzFhN2ZlYw0KWyAg
MjAyLjI3MDAwMF0gT29wc1sjMV06DQpbICAyMDIuMjcwMDAwXSBDcHUgMA0KWyAgMjAyLjI3MDAw
MF0gJCAwICAgOiAwMDAwMDAwMCA3Nzg4MWU0OCAwMDAwMDAwMSAwMDAwMDAwMQ0KWyAgMjAyLjI3
MDAwMF0gJCA0ICAgOiA4NzFhZDUwMCA4NzIxMWU2MCA4MDQ1NWU0OCAwMDAwMDAwMA0KWyAgMjAy
LjI3MDAwMF0gJCA4ICAgOiA4MDQ1NWU0YyAwMDAwNWYxYyAwMDAwMDAwMCAwMDAwMDAwNA0KWyAg
MjAyLjI3MDAwMF0gJDEyICAgOiA3Nzg4MWQ0MCAwMDAwMTAwMCAwMDAwMDAwMCAwMDQwNzk0OA0K
WyAgMjAyLjI3MDAwMF0gJDE2ICAgOiA4NjUxMTAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMTAw
MA0KWyAgMjAyLjI3MDAwMF0gJDIwICAgOiAwMDAwMTAwMCAwMDAwMDAxMCA4MDQ1NWU0OCA4MTEw
NGU2Yw0KWyAgMjAyLjI3MDAwMF0gJDI0ICAgOiAwMDAwMDAwMCA4NzFhOTc5Yw0KWyAgMjAyLjI3
MDAwMF0gJDI4ICAgOiA4NzIxMDAwMCA4NzIxMWQ1MCA4MDUwMDAwMCA4NzFhN2ZlYw0KWyAgMjAy
LjI3MDAwMF0gSGkgICAgOiAwMDAwMDI0ZA0KWyAgMjAyLjI3MDAwMF0gTG8gICAgOiAwMDAxZTY3
OA0KWyAgMjAyLjI3MDAwMF0gZXBjICAgOiA4NzFhOTc5YyBjbGVhbnVwX21vZHVsZSsweGZiYy8w
eDE4IFtsdHRuZ19saWJfcmluZ19idWZmZXJdDQpbICAyMDIuMjcwMDAwXSAgICAgVGFpbnRlZDog
RyAgICAgICAgICAgTw0KWyAgMjAyLjI3MDAwMF0gcmEgICAgOiA4NzFhN2ZlYyBsaWJfcmluZ19i
dWZmZXJfaW9jdGwrMHg1MzAvMHg1NjAgW2x0dG5nX2xpYl9yaW5nX2J1ZmZlcl0NClsgIDIwMi4y
NzAwMDBdIFN0YXR1czogMTEwMGZjMDMgICAgS0VSTkVMIEVYTCBJRQ0KWyAgMjAyLjI3MDAwMF0g
Q2F1c2UgOiAwMDgwMDAwOA0KWyAgMjAyLjI3MDAwMF0gQmFkVkEgOiBmZmZmOTc5Yw0KWyAgMjAy
LjI3MDAwMF0gUHJJZCAgOiAwMDAxOTU1NiAoTUlQUyAzNEtjKQ0KWyAgMjAyLjI3MDAwMF0gTW9k
dWxlcyBsaW5rZWQgaW46IGx0dG5nX3Byb2JlX3dvcmtxdWV1ZShPKSBsdHRuZ19wcm9iZV91ZHAo
TykgbHR0bmdfcHJvYmVfdGltZXIoTykgbHR0bmdfcHJvYmVfc3RhdGVkdW1wKE8pIGx0dG5nX3By
b2JlX3NvY2soTykgbHR0bmdfcHJvYmVfc2tiKE8pIGx0dG5nX3Byb2JlX3NpZ25hbChPKSBsdHRu
Z19wcm9iZV9zY3NpKE8pIGx0dG5nX3Byb2JlX3NjaGVkKE8pIGx0dG5nX3Byb2JlX3JjdShPKSBs
dHRuZ19wcm9iZV9yYW5kb20oTykgbHR0bmdfcHJvYmVfcHJpbnRrKE8pIGx0dG5nX3Byb2JlX3Bv
d2VyKE8pIGx0dG5nX3Byb2JlX25ldChPKSBsdHRuZ19wcm9iZV9uYXBpKE8pIGx0dG5nX3Byb2Jl
X21vZHVsZShPKSBsdHRuZ19wcm9iZV9rbWVtKE8pIGx0dG5nX3Byb2JlX2piZDIoTykgbHR0bmdf
cHJvYmVfaXJxKE8pIGx0dG5nX3Byb2JlX2dwaW8oTykgbHR0bmdfcHJvYmVfZXh0NChPKSBsdHRu
Z19wcm9iZV9jb21wYWN0aW9uKE8pIGx0dG5nX3Byb2JlX2Jsb2NrKE8pIGx0dG5nX3R5cGVzKE8p
IGx0dG5nX3JpbmdfYnVmZmVyX21ldGFkYXRhX21tYXBfY2xpZW50KE8pIGx0dG5nX3JpbmdfYnVm
ZmVyX2NsaWVudF9tbWFwX292ZXJ3cml0ZShPKSBsdHRuZ19yaW5nX2J1ZmZlcl9jbGllbnRfbW1h
cF9kaXNjYXJkKE8pIGx0dG5nX3JpbmdfYnVmZmVyX21ldGFkYXRhX2NsaWVudChPKSBsdHRuZ19y
aW5nX2J1ZmZlcl9jbGllbnRfb3ZlcndyaXRlKE8pIGx0dG5nX3JpbmdfYnVmZmVyX2NsaWVudF9k
aXNjYXJkKE8pIGx0dG5nX3RyYWNlcihPKSBsdHRuZ19saWJfcmluZ19idWZmZXIoTykgbHR0bmdf
c3RhdGVkdW1wKE8pDQpbICAyMDIuMjcwMDAwXSBQcm9jZXNzIGx0dG5nLWNvbnN1bWVyZCAocGlk
OiAxOTY1LCB0aHJlYWRpbmZvPTg3MjEwMDAwLCB0YXNrPTg3MjBiMWQ4LCB0bHM9Nzc4ODk5NzAp
DQpbICAyMDIuMjcwMDAwXSBTdGFjayA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDg3MWUz
NzdjIDAwMDAwMDAwIDAwMDAxMDAwIDg3MTM3OTY4IDAwMDAwMDI5DQogICAgICAgIDg3MGQzMDgw
IDg3MjBiMWQ4IDAwMDAwMDAxIDgwMGIyNzA0IDg3ODBlNTkwIDAwMDAwMDAwIDg3MWFkNDAwIDg3
MDliNDE4DQogICAgICAgIDg3MWUzNzdjIDAwMDAwMDI5IDc3ZDE5MDQ0IDAwMDAwMDI5IDg3MTM3
OTY4IDc3ZDE5MDQ0IDAwMDAwMDI5IDgwMDFlYTg4DQogICAgICAgIDUxZWQ4MTczIDMyYTlmODgw
IDAwMDAwMDA0IDAwMDAwMDAwIDAwMDAwMDAzIDAwMDAwMDE3IDAwMDMwMDAxIDAwMDAwMDE2DQog
ICAgICAgIDAwMDMwMDAxIDAwMDAwMDAzIDAwMDMwMDAwIDAwMDAwMDAxIDAwMDAwMDAxIDg3OTQ3
MmMwIDg3NTdkZWY0IDg3MWFkNDMwDQogICAgICAgIC4uLg0KWyAgMjAyLjI3MDAwMF0gQ2FsbCBU
cmFjZToNClsgIDIwMi4yNzAwMDBdIFs8ODAwYjI3MDQ+XSBoYW5kbGVfbW1fZmF1bHQrMHhiMC8w
eGQwDQpbICAyMDIuMjcwMDAwXSBbPDgwMDFlYTg4Pl0gZG9fcGFnZV9mYXVsdCsweDJmNC8weDRk
Yw0KWyAgMjAyLjI3MDAwMF0gWzw4MDBjMmZmND5dIGRvX3N5bmNfcmVhZCsweDk0LzB4ZTgNClsg
IDIwMi4yNzAwMDBdIFs8ODAxNzcwOTQ+XSBzZWN1cml0eV9maWxlX3Blcm1pc3Npb24rMHhhNC8w
eGNjDQpbICAyMDIuMjcwMDAwXSBbPDg3MWE3ZGUwPl0gbGliX3JpbmdfYnVmZmVyX2lvY3RsKzB4
MzI0LzB4NTYwIFtsdHRuZ19saWJfcmluZ19idWZmZXJdDQpbICAyMDIuMjcwMDAwXSBbPDg3MWE4
MDk0Pl0gbGliX3JpbmdfYnVmZmVyX3NwbGljZV9yZWFkKzB4NzgvMHgxMDQgW2x0dG5nX2xpYl9y
aW5nX2J1ZmZlcl0NClsgIDIwMi4yNzAwMDBdIFs8ODAwZWRhZjg+XSBkb19zcGxpY2VfdG8rMHg0
Yy8weGNjDQpbICAyMDIuMjcwMDAwXSBbPDgwMGVmN2ZjPl0gc3lzX3NwbGljZSsweDU1NC8weDVh
NA0KWyAgMjAyLjI3MDAwMF0gWzw4MDBkNDlmND5dIHN5c19pb2N0bCsweDc0LzB4YTQNClsgIDIw
Mi4yNzAwMDBdIFs8ODAwZDY3NWM+XSBzeXNfcG9sbCsweDk0LzB4ZjgNClsgIDIwMi4yNzAwMDBd
IFs8ODAwMDQxYjA+XSBzdGFja19kb25lKzB4MjAvMHg0NA0KWyAgMjAyLjI3MDAwMF0gWzw4MDAz
Zjc0OD5dIHN5c19nZXRjcHUrMHgwLzB4NzANClsgIDIwMi4yNzAwMDBdDQpbICAyMDIuMjcwMDAw
XQ0KQ29kZTogMDAwMDAwMDAgIDg3MDc2YTgwICA4NzFhZjU4MCA8ODcxYTk3OWM+IDg3MWE5Nzlj
ICA4NzE2NTE5OCAgMDAwMDAwMDAgIDgxMTAyODgwICAwMDAwMDAwMA0KWyAgMjAyLjU1MDAwMF0g
LS0tWyBlbmQgdHJhY2UgZTExNTc0Y2VjYmMzMjBhMCBdLS0tDQpbICAyMDIuNTYwMDAwXSBDUFUg
MCBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJl
c3MgZmZmZjk3OWMsIGVwYyA9PSA4NzFhOTc5YywgcmEgPT0gODcxYTdmZWMNClsgIDIwMi41NzAw
MDBdIE9vcHNbIzJdOg0KWyAgMjAyLjU3MDAwMF0gQ3B1IDANClsgIDIwMi41NzAwMDBdICQgMCAg
IDogMDAwMDAwMDAgNzdhODFlZjAgMDAwMDAwMDEgMDAwMDAwMDANClsgIDIwMi41NzAwMDBdICQg
NCAgIDogODcxYWQ3MDAgODcyMGZlNjAgODA0NTVlNDggMDAwMDAwMDANClsgIDIwMi41NzAwMDBd
ICQgOCAgIDogODA0NTVlNGMgMDAwMDVmMWUgMDAwMDAwMDAgMDAwMDAwMDQNClsgIDIwMi41NzAw
MDBdICQxMiAgIDogNzdhODFkZTggMDAwMDEwMDAgMDAwMDAwMDAgMDAwMDAwMDINClsgIDIwMi41
NzAwMDBdICQxNiAgIDogODY2MjIwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDEwMDANClsgIDIw
Mi41NzAwMDBdICQyMCAgIDogMDAwMDEwMDAgMDAwMDAwMDEgODA0NTVlNDggODdiNzIzOTQNClsg
IDIwMi41NzAwMDBdICQyNCAgIDogMDAwMDAwMDAgODcxYTk3OWMNClsgIDIwMi41NzAwMDBdICQy
OCAgIDogODcyMGUwMDAgODcyMGZkNTAgODA1MDAwMDAgODcxYTdmZWMNClsgIDIwMi41NzAwMDBd
IEhpICAgIDogMDAwMDAwMmYNClsgIDIwMi41NzAwMDBdIExvICAgIDogMjk4NDUwMDANClsgIDIw
Mi41NzAwMDBdIGVwYyAgIDogODcxYTk3OWMgY2xlYW51cF9tb2R1bGUrMHhmYmMvMHgxOCBbbHR0
bmdfbGliX3JpbmdfYnVmZmVyXQ0KWyAgMjAyLjU3MDAwMF0gICAgIFRhaW50ZWQ6IEcgICAgICBE
ICAgIE8NClsgIDIwMi41NzAwMDBdIHJhICAgIDogODcxYTdmZWMgbGliX3JpbmdfYnVmZmVyX2lv
Y3RsKzB4NTMwLzB4NTYwIFtsdHRuZ19saWJfcmluZ19idWZmZXJdDQpbICAyMDIuNTcwMDAwXSBT
dGF0dXM6IDExMDBmYzAzICAgIEtFUk5FTCBFWEwgSUUNClsgIDIwMi41NzAwMDBdIENhdXNlIDog
MDA4MDAwMDgNClsgIDIwMi41NzAwMDBdIEJhZFZBIDogZmZmZjk3OWMNClsgIDIwMi41NzAwMDBd
IFBySWQgIDogMDAwMTk1NTYgKE1JUFMgMzRLYykNClsgIDIwMi41NzAwMDBdIE1vZHVsZXMgbGlu
a2VkIGluOiBsdHRuZ19wcm9iZV93b3JrcXVldWUoTykgbHR0bmdfcHJvYmVfdWRwKE8pIGx0dG5n
X3Byb2JlX3RpbWVyKE8pIGx0dG5nX3Byb2JlX3N0YXRlZHVtcChPKSBsdHRuZ19wcm9iZV9zb2Nr
KE8pIGx0dG5nX3Byb2JlX3NrYihPKSBsdHRuZ19wcm9iZV9zaWduYWwoTykgbHR0bmdfcHJvYmVf
c2NzaShPKSBsdHRuZ19wcm9iZV9zY2hlZChPKSBsdHRuZ19wcm9iZV9yY3UoTykgbHR0bmdfcHJv
YmVfcmFuZG9tKE8pIGx0dG5nX3Byb2JlX3ByaW50ayhPKSBsdHRuZ19wcm9iZV9wb3dlcihPKSBs
dHRuZ19wcm9iZV9uZXQoTykgbHR0bmdfcHJvYmVfbmFwaShPKSBsdHRuZ19wcm9iZV9tb2R1bGUo
TykgbHR0bmdfcHJvYmVfa21lbShPKSBsdHRuZ19wcm9iZV9qYmQyKE8pIGx0dG5nX3Byb2JlX2ly
cShPKSBsdHRuZ19wcm9iZV9ncGlvKE8pIGx0dG5nX3Byb2JlX2V4dDQoTykgbHR0bmdfcHJvYmVf
Y29tcGFjdGlvbihPKSBsdHRuZ19wcm9iZV9ibG9jayhPKSBsdHRuZ190eXBlcyhPKSBsdHRuZ19y
aW5nX2J1ZmZlcl9tZXRhZGF0YV9tbWFwX2NsaWVudChPKSBsdHRuZ19yaW5nX2J1ZmZlcl9jbGll
bnRfbW1hcF9vdmVyd3JpdGUoTykgbHR0bmdfcmluZ19idWZmZXJfY2xpZW50X21tYXBfZGlzY2Fy
ZChPKSBsdHRuZ19yaW5nX2J1ZmZlcl9tZXRhZGF0YV9jbGllbnQoTykgbHR0bmdfcmluZ19idWZm
ZXJfY2xpZW50X292ZXJ3cml0ZShPKSBsdHRuZ19yaW5nX2J1ZmZlcl9jbGllbnRfZGlzY2FyZChP
KSBsdHRuZ190cmFjZXIoTykgbHR0bmdfbGliX3JpbmdfYnVmZmVyKE8pIGx0dG5nX3N0YXRlZHVt
cChPKQ0KWyAgMjAyLjU3MDAwMF0gUHJvY2VzcyBsdHRuZy1jb25zdW1lcmQgKHBpZDogMTk2NCwg
dGhyZWFkaW5mbz04NzIwZTAwMCwgdGFzaz04NzIwYjYwOCwgdGxzPTc3YTg5OTcwKQ0KWyAgMjAy
LjU3MDAwMF0gU3RhY2sgOiAwMDAwMDAwMCA4MzIwZmQ1NCA4NzBkMzBiOCA4NzFlMzc3OCAwMDAw
MDAwMCAwMDAwMTAwMCA4NzE4YmVlOCAwMDAwMDAyOQ0KICAgICAgICA4NzBkMzA4MCA4NzIwYjYw
OCAwMDAwMDAwMSA4MDBiMjcwNCA4NzEyNjQwMCA4MDAwMjQyMCA4NzFhZDYwMCA4NzFmZWUwMA0K
ICAgICAgICA4NzFlMzc3OCAwMDAwMDAyOSA3N2E4MjViNCAwMDAwMDAyOSA4NzE4YmVlOCA3N2E4
MjViNCAwMDAwMDAyOSA4MDAxZWE4OA0KICAgICAgICAwMDAwMDAxYiAwMDAwMDAwMCAwMDlkNjAw
MCA4NzFlMmYwYyA4NzIwZmZlMCAwMDAwZmMwMCAwMDAwMDAwMCAwMDAwMDAwMQ0KICAgICAgICAw
MDAwMDAyNSAwMDAwMDAwMiAwMDAwMDAwMCAwMDAwMDAwMiA4NzFlMmYwYyA4NzIwZmU5OCAwMDAw
MDAwMCAwMDlkNWZmOA0KICAgICAgICAuLi4NClsgIDIwMi41NzAwMDBdIENhbGwgVHJhY2U6DQpb
ICAyMDIuNTcwMDAwXSBbPDgwMGIyNzA0Pl0gaGFuZGxlX21tX2ZhdWx0KzB4YjAvMHhkMA0KWyAg
MjAyLjU3MDAwMF0gWzw4MDAwMjQyMD5dIHJldF9mcm9tX2V4Y2VwdGlvbisweDAvMHgxMA0KWyAg
MjAyLjU3MDAwMF0gWzw4MDAxZWE4OD5dIGRvX3BhZ2VfZmF1bHQrMHgyZjQvMHg0ZGMNClsgIDIw
Mi41NzAwMDBdIFs8ODAwNTk2NWM+XSBkZXF1ZXVlX3Rhc2tfZmFpcisweDAvMHgxMmMNClsgIDIw
Mi41NzAwMDBdIFs8ODAxMDE2YWM+XSBlcF9zZW5kX2V2ZW50c19wcm9jKzB4OTQvMHgxNmMNClsg
IDIwMi41NzAwMDBdIFs8ODAxNzcwOTQ+XSBzZWN1cml0eV9maWxlX3Blcm1pc3Npb24rMHhhNC8w
eGNjDQpbICAyMDIuNTcwMDAwXSBbPDg3MWE3ZGUwPl0gbGliX3JpbmdfYnVmZmVyX2lvY3RsKzB4
MzI0LzB4NTYwIFtsdHRuZ19saWJfcmluZ19idWZmZXJdDQpbICAyMDIuNTcwMDAwXSBbPDg3MWE4
MDk0Pl0gbGliX3JpbmdfYnVmZmVyX3NwbGljZV9yZWFkKzB4NzgvMHgxMDQgW2x0dG5nX2xpYl9y
aW5nX2J1ZmZlcl0NClsgIDIwMi41NzAwMDBdIFs8ODAwZWRhZjg+XSBkb19zcGxpY2VfdG8rMHg0
Yy8weGNjDQpbICAyMDIuNTcwMDAwXSBbPDgwMTAzMDcwPl0gc3lzX2Vwb2xsX3dhaXQrMHgzMGMv
MHgzYWMNClsgIDIwMi41NzAwMDBdIFs8ODAxMDJkMTA+XSBzeXNfZXBvbGxfY3RsKzB4ODJjLzB4
ODgwDQpbICAyMDIuNTcwMDAwXSBbPDgwMGVmN2ZjPl0gc3lzX3NwbGljZSsweDU1NC8weDVhNA0K
WyAgMjAyLjU3MDAwMF0gWzw4MDA1NmQwYz5dIGRlZmF1bHRfd2FrZV9mdW5jdGlvbisweDAvMHg4
DQpbICAyMDIuNTcwMDAwXSBbPDgwMGQ0OWY0Pl0gc3lzX2lvY3RsKzB4NzQvMHhhNA0KWyAgMjAy
LjU3MDAwMF0gWzw4MDAwNDFiMD5dIHN0YWNrX2RvbmUrMHgyMC8weDQ0DQpbICAyMDIuNTcwMDAw
XQ0KWyAgMjAyLjU3MDAwMF0NCkNvZGU6IDAwMDAwMDAwICA4NzA3NmE4MCAgODcxYWY1ODAgPDg3
MWE5NzljPiA4NzFhOTc5YyAgODcxNjUxOTggIDAwMDAwMDAwICA4MTEwMjg4MCAgMDAwMDAwMDAN
ClsgIDIwMi44NjAwMDBdIC0tLVsgZW5kIHRyYWNlIGUxMTU3NGNlY2JjMzIwYTEgXS0tLQ==
--089e0103ecec5d1f6d04e2b76301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--089e0103ecec5d1f6d04e2b76301--
