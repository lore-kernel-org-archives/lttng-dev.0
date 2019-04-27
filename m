From: whalajam--- via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: running lttng 2.10 on Docker 1.13.1
Date: Sat, 27 Apr 2019 01:44:47 +0000 (UTC)
Message-ID: <925094052.1088921.1556329487899__35488.7235489272$1556331336$gmane$org@mail.yahoo.com>
References: <97612750.1097694.1556328978552.ref@mail.yahoo.com>
 <97612750.1097694.1556328978552@mail.yahoo.com>
Reply-To: "whalajam@yahoo.com" <whalajam@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_1088920_1868740719.1556329487899"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic306-3.consmr.mail.bf2.yahoo.com
 (sonic306-3.consmr.mail.bf2.yahoo.com [74.6.132.42])
 by lists.lttng.org (Postfix) with ESMTPS id 44rZJM33VMz1KM3
 for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2019 22:15:15 -0400 (EDT)
In-Reply-To: <97612750.1097694.1556328978552@mail.yahoo.com>
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

------=_Part_1088920_1868740719.1556329487899
Content-Type: multipart/alternative;
	boundary="----=_Part_1088919_1252295608.1556329487898"

------=_Part_1088919_1252295608.1556329487898
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 I attach the lttng-sessiond -vvv output,John
    On Friday, April 26, 2019, 9:38:36 p.m. EDT, whalajam--- via lttng-dev =
<lttng-dev@lists.lttng.org> wrote: =20
=20
 Hi,I have one docker container on which I installed LTTng version 2.10.I u=
se the same Docker container to build and run the application.=C2=A0The pro=
blem I have is that there are no traces in the path specified when doing "l=
ttng create". "lttng view"fails complaining about files not found, the trac=
e directories are sometimes added to the path but the /root/lttng../../../c=
hannel0_* files are empty.=3DC2=3DA0I've followed the installation instruct=
ions from=3DC2=3DA0http://frederic-wou.net/lttng/and docs on=3DC2=3DA0https=
://lttng.org/docs/v2.10/=3DC2=3DA0These are the commands: "lttng enable -u =
a:b", "lttng start", <excercise-the-tracepoints>,"lttng stop" and "lttng vi=
ew". lttng-consumerd is running. Running 'lttng-sessiond --vvv' returns DEB=
UG info and an error about server already runningWhat could be the reason f=
or the failure, how can I debug it?John


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
 =20
------=_Part_1088919_1252295608.1556329487898
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"ydp501fd31eyahoo-style-wrap" style=
=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px=
;"><div></div>
        <div>I attach the lttng-sessiond -vvv output,</div><div>John</div><=
div><br></div>
       =20
        </div><div id=3D"yahoo_quoted_6882624374" class=3D"yahoo_quoted">
            <div style=3D"font-family:'Helvetica Neue', Helvetica, Arial, s=
ans-serif;font-size:13px;color:#26282a;">
               =20
                <div>
                    On Friday, April 26, 2019, 9:38:36 p.m. EDT, whalajam--=
- via lttng-dev &lt;lttng-dev@lists.lttng.org&gt; wrote:
                </div>
                <div><br></div>
                <div><br></div>
                <div><div id=3D"yiv3630930461"><div><div class=3D"yiv363093=
0461yahoo-style-wrap" style=3D"font-family:Helvetica Neue, Helvetica, Arial=
, sans-serif;font-size:16px;"><div><span><div dir=3D"ltr" style=3D"font-fam=
ily:Helvetica, Arial, sans-serif;">Hi,</div><div dir=3D"ltr" style=3D"font-=
family:Helvetica, Arial, sans-serif;">I have one docker container on which =
I installed LTTng version 2.10.I use the same Docker container to build and=
 run the application.&nbsp;</div><div dir=3D"ltr" style=3D"font-family:Helv=
etica, Arial, sans-serif;">The problem I have is that there are no traces i=
n the path specified when doing "lttng create". "lttng view"fails complaini=
ng about files not found, the trace directories are sometimes added to the =
path but the /root/lttng../../../channel0_* files are empty.=3DC2=3DA0I've =
followed the installation instructions from=3DC2=3DA0http://frederic-wou.ne=
t/lttng/and docs on=3DC2=3DA0https://lttng.org/docs/v2.10/=3DC2=3DA0These a=
re the commands: "lttng enable -u a:b", "lttng start", &lt;excercise-the-tr=
acepoints&gt;,"lttng stop" and "lttng view". lttng-consumerd is running. Ru=
nning 'lttng-sessiond --vvv' returns DEBUG info and an error about server a=
lready runningWhat could be the reason for the failure, how can I debug it?=
</div><div dir=3D"ltr" style=3D"font-family:Helvetica, Arial, sans-serif;">=
John<br></div><div><br></div></span><br></div></div></div></div>___________=
____________________________________<br>lttng-dev mailing list<br><a ymailt=
o=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng=
.org">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.or=
g/cgi-bin/mailman/listinfo/lttng-dev</a><br></div>
            </div>
        </div></body></html>
------=_Part_1088919_1252295608.1556329487898--

------=_Part_1088920_1868740719.1556329487899
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="=?UTF-8?b?bHR0bmcudHh0?="
Content-ID: <0afeda91-e20b-7a2a-c8d1-3c4689769c0f@yahoo.com>

IyBsdHRuZy1zZXNzaW9uZCAtdnZ2CkRFQlVHMSAtIDIyOjM2OjM5LjkwODQyODYwMCBbMjM1MTEv
MjM1MTFdOiBbc2Vzc2lvbmQgY29uZmlndXJhdGlvbl0KREVCVUcxIC0gMjI6MzY6MzkuOTA4NTQ0
NDAwIFsyMzUxMS8yMzUxMV06IAl2ZXJib3NlOiAgICAgICAgICAgICAgICAgICAgICAgMwpERUJV
RzEgLSAyMjozNjozOS45MDg1NTMwMDAgWzIzNTExLzIzNTExXTogCXZlcmJvc2UgY29uc3VtZXI6
ICAgICAgICAgICAgICAwCkRFQlVHMSAtIDIyOjM2OjM5LjkwODU2MDgwMCBbMjM1MTEvMjM1MTFd
OiAJcXVpZXQgbW9kZTogICAgICAgICAgICAgICAgICAgIEZhbHNlCkRFQlVHMSAtIDIyOjM2OjM5
LjkwODU2ODAwMCBbMjM1MTEvMjM1MTFdOiAJYWdlbnRfdGNwX3BvcnQ6ICAgICAgICAgICAgICAg
IFs1MzQ1LCA1MzU0XQpERUJVRzEgLSAyMjozNjozOS45MDg1NzU0MDAgWzIzNTExLzIzNTExXTog
CWFwcGxpY2F0aW9uIHNvY2tldCB0aW1lb3V0OiAgICA1CkRFQlVHMSAtIDIyOjM2OjM5LjkwODU4
MzAwMCBbMjM1MTEvMjM1MTFdOiAJbm8ta2VybmVsOiAgICAgICAgICAgICAgICAgICAgIEZhbHNl
CkRFQlVHMSAtIDIyOjM2OjM5LjkwODU5MTYwMCBbMjM1MTEvMjM1MTFdOiAJYmFja2dyb3VuZDog
ICAgICAgICAgICAgICAgICAgIEZhbHNlCkRFQlVHMSAtIDIyOjM2OjM5LjkwODU5OTIwMCBbMjM1
MTEvMjM1MTFdOiAJZGFlbW9uaXplOiAgICAgICAgICAgICAgICAgICAgIEZhbHNlCkRFQlVHMSAt
IDIyOjM2OjM5LjkwODYwNjcwMCBbMjM1MTEvMjM1MTFdOiAJc2lnbmFsIHBhcmVudCBvbiBzdGFy
dDogICAgICAgIEZhbHNlCkRFQlVHMSAtIDIyOjM2OjM5LjkwODYxMzcwMCBbMjM1MTEvMjM1MTFd
OiAJdHJhY2luZyBncm91cCBuYW1lOiAgICAgICAgICAgIHRyYWNpbmcKREVCVUcxIC0gMjI6MzY6
MzkuOTA4NjIxMjAwIFsyMzUxMS8yMzUxMV06IAlrbW9kX3Byb2JlX2xpc3Q6ICAgICAgICAgICAg
ICAgTm9uZQpERUJVRzEgLSAyMjozNjozOS45MDg2Mjg3MDAgWzIzNTExLzIzNTExXTogCWttb2Rf
ZXh0cmFfcHJvYmVfbGlzdDogICAgICAgICBOb25lCkRFQlVHMSAtIDIyOjM2OjM5LjkwODYzNTkw
MCBbMjM1MTEvMjM1MTFdOiAJcnVuZGlyOiAgICAgICAgICAgICAgICAgICAgICAgIC92YXIvcnVu
L2x0dG5nCkRFQlVHMSAtIDIyOjM2OjM5LjkwODY0MzMwMCBbMjM1MTEvMjM1MTFdOiAJYXBwbGlj
YXRpb24gc29ja2V0IHBhdGg6ICAgICAgIC92YXIvcnVuL2x0dG5nL2x0dG5nLXVzdC1zb2NrLTcK
REVCVUcxIC0gMjI6MzY6MzkuOTA4NjUxMDAwIFsyMzUxMS8yMzUxMV06IAljbGllbnQgc29ja2V0
IHBhdGg6ICAgICAgICAgICAgL3Zhci9ydW4vbHR0bmcvY2xpZW50LWx0dG5nLXNlc3Npb25kCkRF
QlVHMSAtIDIyOjM2OjM5LjkwODY1ODQwMCBbMjM1MTEvMjM1MTFdOiAJd2FpdCBzaG0gcGF0aDog
ICAgICAgICAgICAgICAgIC9sdHRuZy11c3Qtd2FpdC03CkRFQlVHMSAtIDIyOjM2OjM5LjkwODY2
NTQwMCBbMjM1MTEvMjM1MTFdOiAJaGVhbHRoIHNvY2tldCBwYXRoOiAgICAgICAgICAgIC92YXIv
cnVuL2x0dG5nL3Nlc3Npb25kLWhlYWx0aApERUJVRzEgLSAyMjozNjozOS45MDg2NzI5MDAgWzIz
NTExLzIzNTExXTogCUxUVE5HX1VTVF9DTE9DS19QTFVHSU46ICAgICAgICBOb25lCkRFQlVHMSAt
IDIyOjM2OjM5LjkwODY4MDAwMCBbMjM1MTEvMjM1MTFdOiAJcGlkIGZpbGUgcGF0aDogICAgICAg
ICAgICAgICAgIC92YXIvcnVuL2x0dG5nL2x0dG5nLXNlc3Npb25kLnBpZApERUJVRzEgLSAyMjoz
NjozOS45MDg2ODczMDAgWzIzNTExLzIzNTExXTogCWxvY2sgZmlsZSBwYXRoOiAgICAgICAgICAg
ICAgICAvdmFyL3J1bi9sdHRuZy9sdHRuZy1zZXNzaW9uZC5sY2sKREVCVUcxIC0gMjI6MzY6Mzku
OTA4Njk0NDAwIFsyMzUxMS8yMzUxMV06IAlzZXNzaW9uIGxvYWQgcGF0aDogICAgICAgICAgICAg
Tm9uZQpERUJVRzEgLSAyMjozNjozOS45MDg3MDE3MDAgWzIzNTExLzIzNTExXTogCWFnZW50IHBv
cnQgZmlsZSBwYXRoOiAgICAgICAgICAvdmFyL3J1bi9sdHRuZy9hZ2VudC5wb3J0CkRFQlVHMSAt
IDIyOjM2OjM5LjkwODcxMjEwMCBbMjM1MTEvMjM1MTFdOiAJY29uc3VtZXJkMzIgcGF0aDogICAg
ICAgICAgICAgIC92YXIvcnVuL2x0dG5nL3VzdGNvbnN1bWVyZDMyCkRFQlVHMSAtIDIyOjM2OjM5
LjkwODcxOTcwMCBbMjM1MTEvMjM1MTFdOiAJY29uc3VtZXJkMzIgYmluIHBhdGg6ICAgICAgICAg
IFVua25vd24KREVCVUcxIC0gMjI6MzY6MzkuOTA4NzI2NzAwIFsyMzUxMS8yMzUxMV06IAljb25z
dW1lcmQzMiBsaWIgZGlyOiAgICAgICAgICAgVW5rbm93bgpERUJVRzEgLSAyMjozNjozOS45MDg3
MzM2MDAgWzIzNTExLzIzNTExXTogCWNvbnN1bWVyZDMyIGVyciB1bml4IHNvY2sgcGF0aDovdmFy
L3J1bi9sdHRuZy91c3Rjb25zdW1lcmQzMi9lcnJvcgpERUJVRzEgLSAyMjozNjozOS45MDg3NDA5
MDAgWzIzNTExLzIzNTExXTogCWNvbnN1bWVyZDMyIGNtZCB1bml4IHNvY2sgcGF0aDovdmFyL3J1
bi9sdHRuZy91c3Rjb25zdW1lcmQzMi9jb21tYW5kCkRFQlVHMSAtIDIyOjM2OjM5LjkwODc0ODIw
MCBbMjM1MTEvMjM1MTFdOiAJY29uc3VtZXJkNjQgcGF0aDogICAgICAgICAgICAgIC92YXIvcnVu
L2x0dG5nL3VzdGNvbnN1bWVyZDY0CkRFQlVHMSAtIDIyOjM2OjM5LjkwODc1NTMwMCBbMjM1MTEv
MjM1MTFdOiAJY29uc3VtZXJkNjQgYmluIHBhdGg6ICAgICAgICAgIC91c3IvbGliNjQvbHR0bmcv
bGliZXhlYy9sdHRuZy1jb25zdW1lcmQKREVCVUcxIC0gMjI6MzY6MzkuOTA4NzYyNzAwIFsyMzUx
MS8yMzUxMV06IAljb25zdW1lcmQ2NCBsaWIgZGlyOiAgICAgICAgICAgL3Vzci9saWI2NApERUJV
RzEgLSAyMjozNjozOS45MDg3NzI1MDAgWzIzNTExLzIzNTExXTogCWNvbnN1bWVyZDY0IGVyciB1
bml4IHNvY2sgcGF0aDovdmFyL3J1bi9sdHRuZy91c3Rjb25zdW1lcmQ2NC9lcnJvcgpERUJVRzEg
LSAyMjozNjozOS45MDg3ODQ1MDAgWzIzNTExLzIzNTExXTogCWNvbnN1bWVyZDY0IGNtZCB1bml4
IHNvY2sgcGF0aDovdmFyL3J1bi9sdHRuZy91c3Rjb25zdW1lcmQ2NC9jb21tYW5kCkRFQlVHMSAt
IDIyOjM2OjM5LjkwODc5MTkwMCBbMjM1MTEvMjM1MTFdOiAJa2NvbnN1bWVyZCBwYXRoOiAgICAg
ICAgICAgICAgIC92YXIvcnVuL2x0dG5nL2tjb25zdW1lcmQKREVCVUcxIC0gMjI6MzY6MzkuOTA4
Nzk5MzAwIFsyMzUxMS8yMzUxMV06IAlrY29uc3VtZXJkIGVyciB1bml4IHNvY2sgcGF0aDogL3Zh
ci9ydW4vbHR0bmcva2NvbnN1bWVyZC9lcnJvcgpERUJVRzEgLSAyMjozNjozOS45MDg4MDcyMDAg
WzIzNTExLzIzNTExXTogCWtjb25zdW1lcmQgY21kIHVuaXggc29jayBwYXRoOiAvdmFyL3J1bi9s
dHRuZy9rY29uc3VtZXJkL2NvbW1hbmQKREVCVUczIC0gMjI6MzY6MzkuOTA4ODE1MDAwIFsyMzUx
MS8yMzUxMV06IENyZWF0aW5nIExUVG5nIHJ1biBkaXJlY3Rvcnk6IC92YXIvcnVuL2x0dG5nIChp
biBjcmVhdGVfbHR0bmdfcnVuZGlyKCkgYXQgbWFpbi5jOjUzMDEpCkVycm9yOiBBIHNlc3Npb24g
ZGFlbW9uIGlzIGFscmVhZHkgcnVubmluZy4KREVCVUcxIC0gMjI6MzY6MzkuOTA4OTYwNDAwIFsy
MzUxMS8yMzUxMV06IENsZWFuaW5nIHVwIG9wdGlvbnMgKGluIHNlc3Npb25kX2NsZWFudXBfb3B0
aW9ucygpIGF0IG1haW4uYzo2NDIpCkRFQlVHMSAtIDIyOjM2OjM5LjkwODk3MzYwMCBbMjM1MTEv
MjM1MTFdOiBEZXN0cm95aW5nIHJ1bl9hcyB3b3JrZXIgKGluIHJ1bl9hc19kZXN0cm95X3dvcmtl
cigpIGF0IHJ1bmFzLmM6NzEwKQoK

------=_Part_1088920_1868740719.1556329487899
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_1088920_1868740719.1556329487899--
