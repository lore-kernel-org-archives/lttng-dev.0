From: =?utf-8?Q?Lo=C3=AFc_Gelle?= <loic.gelle@polymtl.ca>
Subject: Golang agent for LTTng-ust
Date: Fri, 4 May 2018 06:03:15 -0400
Message-ID: <29167624-BBCE-401B-8FD9-6DFEB14D3E0E__21900.4303603016$1525428092$gmane$org@polymtl.ca>
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Content-Type: multipart/mixed; boundary="===============1782259294778627131=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 40cndm4xgDz18SQ
 for <lttng-dev@lists.lttng.org>; Fri,  4 May 2018 06:03:24 -0400 (EDT)
Received: from [10.242.73.29] ([91.224.175.205]) (authenticated bits=0)
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id w44A3Htp032150
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Fri, 4 May 2018 06:03:23 -0400
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


--===============1782259294778627131==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_48538466-1B44-49BC-8A1C-E3A47A480CD7"


--Apple-Mail=_48538466-1B44-49BC-8A1C-E3A47A480CD7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

There has been a previous discussion on the mailing list about porting =
LTTng to Golang, about a year ago: =
https://lists.lttng.org/pipermail/lttng-dev/2017-June/027203.html =
<https://lists.lttng.org/pipermail/lttng-dev/2017-June/027203.html> . =
This new topic is to discuss more precisely about implementation =
possibilities.

Currently, one has to use the the C UST agent from LTTng in order to =
instrument Golang programs, and to compile the whole thing using custom =
Makefiles and cgo. Here is a recent example that I wrote: =
https://github.com/loicgelle/jaeger-go-lttng-instr =
<https://github.com/loicgelle/jaeger-go-lttng-instr>

As you can guess, there are a low of drawbacks in that approach. It is =
actually a hack and cannot be integrated into more complex Golang =
program that use a more complex build process (e.g. the Golang runtime =
itself), because of the compiler instructions that you have to include =
at the top of the Golang files. There is also a big concern about the =
performance of this solution, as calling a C function from Go requires =
to do a full context switch on the stack, because the calling =
conventions in C and Golang are different.

I think a more integrated and performant solution is needed. We can=E2=80=99=
t really ignore a language such as Golang that is now widely adopted for =
cloud applications. LTTng is really the best solution out there in terms =
of overhead per tracepoint, and could benefit from being made available =
to such a large community. My question to the experts on this mailing =
list: how much would it take to write a Golang agent for LTTng?

Cheers,
Lo=C3=AFc.=

--Apple-Mail=_48538466-1B44-49BC-8A1C-E3A47A480CD7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D"">Hi,<div class=3D""><br class=3D""></div><div class=3D"">There =
has been a previous discussion on the mailing list about porting LTTng =
to Golang, about a year ago:&nbsp;<a =
href=3D"https://lists.lttng.org/pipermail/lttng-dev/2017-June/027203.html"=
 =
class=3D"">https://lists.lttng.org/pipermail/lttng-dev/2017-June/027203.ht=
ml</a>&nbsp;.&nbsp;This new topic is to discuss more precisely about =
implementation possibilities.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Currently, one has to use the the C UST =
agent from LTTng in order to instrument Golang programs, and to compile =
the whole thing using custom Makefiles and cgo. Here is a recent example =
that I wrote:&nbsp;<a =
href=3D"https://github.com/loicgelle/jaeger-go-lttng-instr" =
class=3D"">https://github.com/loicgelle/jaeger-go-lttng-instr</a></div><di=
v class=3D""><br class=3D""></div><div class=3D"">As you can guess, =
there are a low of drawbacks in that approach. It is actually a hack and =
cannot be integrated into more complex Golang program that use a more =
complex build process (e.g. the Golang runtime itself), because of the =
compiler instructions that you have to include at the top of the Golang =
files. There is also a big concern about the performance of this =
solution, as calling a C function from Go requires to do a full context =
switch on the stack, because the calling conventions in C and Golang are =
different.</div><div class=3D""><br class=3D""></div><div class=3D"">I =
think a more integrated and performant solution is needed. We can=E2=80=99=
t really ignore a language such as Golang that is now widely adopted for =
cloud applications. LTTng is really the best solution out there in terms =
of overhead per tracepoint, and could benefit from being made available =
to such a large community. My question to the experts on this mailing =
list: how much would it take to write a Golang agent for =
LTTng?</div><div class=3D""><br class=3D""></div><div =
class=3D"">Cheers,</div><div class=3D"">Lo=C3=AFc.</div></body></html>=

--Apple-Mail=_48538466-1B44-49BC-8A1C-E3A47A480CD7--

--===============1782259294778627131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1782259294778627131==--
