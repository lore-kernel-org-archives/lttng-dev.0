From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Python CTF writer example
Date: Fri, 13 Sep 2019 19:03:59 -0400
Message-ID: <CAC6yHM7iNtK7nt30mq2xeX5Z_K9nhEND6XP6jHS-s7dAJGkgZA__37633.758159221$1568415893$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000002224cb059277479a"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw1-xc30.google.com (mail-yw1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by lists.lttng.org (Postfix) with ESMTPS id 46VWRm5xhVzqrM
 for <lttng-dev@lists.lttng.org>; Fri, 13 Sep 2019 19:04:36 -0400 (EDT)
Received: by mail-yw1-xc30.google.com with SMTP id q7so10984996ywe.10
 for <lttng-dev@lists.lttng.org>; Fri, 13 Sep 2019 16:04:36 -0700 (PDT)
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

--0000000000002224cb059277479a
Content-Type: multipart/alternative; boundary="0000000000002224c80592774798"

--0000000000002224c80592774798
Content-Type: text/plain; charset="UTF-8"

Hello!

It looks like there are some issues with the Python CTF writer example with
babeltrace stable-1.5.

* Import error, should replace "import babeltrace.writer as btw" by "from
babeltrace import CTFWriter as btw"
* The FloatingPointDeclaration does not exists and should be replaced
by FloatFieldDeclaration
* babeltrace.common.CTFStringEncoding.UTF8 is
instead babeltrace.CTFStringEncoding.UTF8
* The variant still had issue that I cannot fix (ValueError("Invalid tag
provided.") babeltrace.py:2221)

Events with simple fields are working okay with these changes. I thought
that the clock would be updated automatically when appending the event, but
that would be nice also to add it to the example.

I tried babeltrace 2.0.0-pre6, but the writer API seems to have
disappeared. I was looking at how to create a ctf.fs.sink, but I was not
successful. Is writing CTF traces with the Python bindings still possible?

Regards,

-- 
Francis

--0000000000002224c80592774798
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello!<div><br></div><div>It looks like there are some iss=
ues with the Python CTF writer example with babeltrace stable-1.5.=C2=A0<di=
v><br></div><div>* Import error, should replace &quot;import babeltrace.wri=
ter as btw&quot; by &quot;from babeltrace import CTFWriter as btw&quot;</di=
v><div>* The FloatingPointDeclaration does not exists and should be replace=
d by=C2=A0FloatFieldDeclaration</div><div>* babeltrace.common.CTFStringEnco=
ding.UTF8 is instead=C2=A0babeltrace.CTFStringEncoding.UTF8</div><div>* The=
 variant still had issue that I cannot fix (ValueError(&quot;Invalid tag pr=
ovided.&quot;) babeltrace.py:2221)</div><div><br></div><div>Events with sim=
ple fields are working okay with these changes. I thought that the clock wo=
uld be updated automatically when appending the event, but that would be ni=
ce also to add it to the example.</div><div><br></div><div>I tried babeltra=
ce 2.0.0-pre6, but the writer API seems to have disappeared. I was looking =
at how to create a ctf.fs.sink, but I was not successful. Is writing CTF tr=
aces with the Python bindings still possible?</div><div><div><br></div><div=
>Regards,</div><div><br></div><div>--=C2=A0<br></div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Fr=
ancis</div></div></div></div></div>

--0000000000002224c80592774798--

--0000000000002224cb059277479a
Content-Type: application/octet-stream; name=ctf-writer-example
Content-Disposition: attachment; filename=ctf-writer-example
Content-Transfer-Encoding: base64
Content-ID: <f_k0iqa79c0>
X-Attachment-Id: f_k0iqa79c0

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoKI2ltcG9ydCBiYWJlbHRyYWNlLndyaXRlciBhcyBidHcK
I2ltcG9ydCBiYWJlbHRyYWNlLmNvbW1vbgoKaW1wb3J0IGJhYmVsdHJhY2UKZnJvbSBiYWJlbHRy
YWNlIGltcG9ydCBDVEZXcml0ZXIgYXMgYnR3CmltcG9ydCB0ZW1wZmlsZQppbXBvcnQgdGltZQoK
dHJhY2VfcGF0aCA9IHRlbXBmaWxlLm1rZHRlbXAoKQoKcHJpbnQoJ3RyYWNlIHBhdGg6IHt9Jy5m
b3JtYXQodHJhY2VfcGF0aCkpCgoKd3JpdGVyID0gYnR3LldyaXRlcih0cmFjZV9wYXRoKQoKY2xv
Y2sgPSBidHcuQ2xvY2soJ215X2Nsb2NrJykKY2xvY2suZGVzY3JpcHRpb24gPSAndGhpcyBpcyBt
eSBjbG9jaycKd3JpdGVyLmFkZF9jbG9jayhjbG9jaykKCnN0cmVhbV9jbGFzcyA9IGJ0dy5TdHJl
YW1DbGFzcygnbXlfc3RyZWFtJykKc3RyZWFtX2NsYXNzLmNsb2NrID0gY2xvY2sKCmV2ZW50X2Ns
YXNzID0gYnR3LkV2ZW50Q2xhc3MoJ215X2V2ZW50JykKCiMgMzItYml0IHNpZ25lZCBpbnRlZ2Vy
IGZpZWxkIGRlY2xhcmF0aW9uCmludDMyX2ZpZWxkX2RlY2wgPSBidHcuSW50ZWdlckZpZWxkRGVj
bGFyYXRpb24oMzIpCmludDMyX2ZpZWxkX2RlY2wuc2lnbmVkID0gVHJ1ZQoKIyBzdHJpbmcgZmll
bGQgZGVjbGFyYXRpb24Kc3RyaW5nX2ZpZWxkX2RlY2wgPSBidHcuU3RyaW5nRmllbGREZWNsYXJh
dGlvbigpCnN0cmluZ19maWVsZF9kZWNsLmVuY29kaW5nID0gYmFiZWx0cmFjZS5DVEZTdHJpbmdF
bmNvZGluZy5VVEY4CgojIElFRUUgNzU0IHNpbmdsZSBwcmVjaXNpb24gZmxvYXRpbmcgcG9pbnQg
bnVtYmVyIGZpZWxkIGRlY2xhcmF0aW9uCmZsb2F0X2ZpZWxkX2RlY2wgPSBidHcuRmxvYXRGaWVs
ZERlY2xhcmF0aW9uKCkKZmxvYXRfZmllbGRfZGVjbC5leHBvbmVudF9kaWdpdHMgPSBidHcuRmxv
YXRGaWVsZERlY2xhcmF0aW9uLkZMVF9FWFBfRElHCmZsb2F0X2ZpZWxkX2RlY2wubWFudGlzc2Ff
ZGlnaXRzID0gYnR3LkZsb2F0RmllbGREZWNsYXJhdGlvbi5GTFRfTUFOVF9ESUcKCmV2ZW50X2Ns
YXNzLmFkZF9maWVsZChpbnQzMl9maWVsZF9kZWNsLCAndmFsMScpCmV2ZW50X2NsYXNzLmFkZF9m
aWVsZChzdHJpbmdfZmllbGRfZGVjbCwgJ3ZhbDInKQpldmVudF9jbGFzcy5hZGRfZmllbGQoZmxv
YXRfZmllbGRfZGVjbCwgJ3ZhbDMnKQoKc3RyZWFtX2NsYXNzLmFkZF9ldmVudF9jbGFzcyhldmVu
dF9jbGFzcykKCnN0cmVhbSA9IHdyaXRlci5jcmVhdGVfc3RyZWFtKHN0cmVhbV9jbGFzcykKCmZv
ciBpIGluIHJhbmdlKDEwKToKICAgIGV2ZW50ID0gYnR3LkV2ZW50KGV2ZW50X2NsYXNzKQogICAg
ZXZlbnQucGF5bG9hZCgndmFsMScpLnZhbHVlID0gNDIgKyBpCiAgICBldmVudC5wYXlsb2FkKCd2
YWwyJykudmFsdWUgPSAiZm9vIHt9Ii5mb3JtYXQoaSkKICAgIGV2ZW50LnBheWxvYWQoJ3ZhbDMn
KS52YWx1ZSA9IGkgKiAwLjEKICAgIGNsb2NrLnRpbWUgPSB0aW1lLnRpbWVfbnMoKQogICAgc3Ry
ZWFtLmFwcGVuZF9ldmVudChldmVudCkKCnN0cmVhbS5mbHVzaCgpCg==
--0000000000002224cb059277479a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--0000000000002224cb059277479a--
