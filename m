From: MMM via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Problem in Tracing C Program
Date: Thu, 30 Nov 2017 17:51:20 +0000 (UTC)
Message-ID: <1222277784.5319970.1512064280572__640.710481866513$1512067343$gmane$org@mail.yahoo.com>
References: <1968389067.5193789.1512054837510.ref@mail.yahoo.com>
 <1968389067.5193789.1512054837510@mail.yahoo.com>
 <78c5dc0c-f6d4-448e-2562-5c282e5ac538@efficios.com>
Reply-To: MMM <e.morovati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8275622305561394693=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic309-21.consmr.mail.ne1.yahoo.com
 (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
 by lists.lttng.org (Postfix) with ESMTP id 3ynmTw2zNzzjJs
 for <lttng-dev@lists.lttng.org>; Thu, 30 Nov 2017 18:42:11 +0000 (UTC)
In-Reply-To: <78c5dc0c-f6d4-448e-2562-5c282e5ac538@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Lttng-dev <lttng-dev@lists.lttng.org>, Houssem Daoud <houssemmh@gmail.com>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============8275622305561394693==
Content-Type: multipart/alternative;
	boundary="----=_Part_5319969_345942993.1512064280571"

------=_Part_5319969_345942993.1512064280571
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Dear Julien,
Thanks for your response. Is the mentioned task easier in Java or C program=
?indeed, I think it can be easier in Java program. If it is true, I can swi=
tch to Java language.
    On Thursday, November 30, 2017, 7:15:21 PM GMT+3:30, Julien Desfossez <=
jdesfossez@efficios.com> wrote: =20
=20
 On 2017-11-30 10:13 AM, MMM via lttng-dev wrote:
> Dear Users,
>=20
> I have posted a couple of email about my problem in the past, while
> nobody response those. It may be true that my question is amateurish,
> but due to the fact that I am a beginner, I can not find the sufficient
> document for solving my problem. I am going to trace a C program that
> read from a file and show the=C2=A0ratio of reads from page cache vs read=
s
> from disk. I read document of LTTng website, but I can not find
> appropriate explanation for this task. I just need a simple guidance to
> show me the right way for doing it. Could you please help me.
>=20
> Regards,
> Mehdi.

Hi,

This is a really non-trivial task to do. Basically, you need to
distinguish the read() syscalls that lead to FS/disk access with the
ones that don't (for the same FD).
The main difficulty is to make the link between the syscall and the
lower-level events and I am not sure we have all the data needed to
establish this link from the payload of the events we have (something
like FD -> FS inode -> block).

I added Houssem to this thread because I think I remember he did some
work around that, he may have more information.

Julien =20
------=_Part_5319969_345942993.1512064280571
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:courier new, courier, mo=
naco, monospace, sans-serif;font-size:13px;"><div></div>
            <div>Dear Julien,</div><div><br></div><div>Thanks for your resp=
onse. Is the mentioned task easier in Java or C program?</div><div>indeed, =
I think it can be easier in Java program. If it is true, I can switch to Ja=
va language.</div><div><br></div>
           =20
            <div id=3D"yahoo_quoted_2976374586" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On Thursday, November 30, 2017, 7:15:21 PM GMT+3:30=
, Julien Desfossez &lt;jdesfossez@efficios.com&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D"ltr">On 2017-11-30 10:13 AM, MMM via l=
ttng-dev wrote:<div class=3D"yqt7884770834" id=3D"yqtfd21507"><br clear=3D"=
none">&gt; Dear Users,<br clear=3D"none">&gt; <br clear=3D"none">&gt; I hav=
e posted a couple of email about my problem in the past, while<br clear=3D"=
none">&gt; nobody response those. It may be true that my question is amateu=
rish,<br clear=3D"none">&gt; but due to the fact that I am a beginner, I ca=
n not find the sufficient<br clear=3D"none">&gt; document for solving my pr=
oblem. I am going to trace a C program that<br clear=3D"none">&gt; read fro=
m a file and show the&nbsp;ratio of reads from page cache vs reads<br clear=
=3D"none">&gt; from disk. I read document of LTTng website, but I can not f=
ind<br clear=3D"none">&gt; appropriate explanation for this task. I just ne=
ed a simple guidance to<br clear=3D"none">&gt; show me the right way for do=
ing it. Could you please help me.<br clear=3D"none">&gt; <br clear=3D"none"=
>&gt; Regards,<br clear=3D"none">&gt; Mehdi.</div><br clear=3D"none"><br cl=
ear=3D"none">Hi,<br clear=3D"none"><br clear=3D"none">This is a really non-=
trivial task to do. Basically, you need to<br clear=3D"none">distinguish th=
e read() syscalls that lead to FS/disk access with the<br clear=3D"none">on=
es that don't (for the same FD).<br clear=3D"none">The main difficulty is t=
o make the link between the syscall and the<br clear=3D"none">lower-level e=
vents and I am not sure we have all the data needed to<br clear=3D"none">es=
tablish this link from the payload of the events we have (something<br clea=
r=3D"none">like FD -&gt; FS inode -&gt; block).<br clear=3D"none"><br clear=
=3D"none">I added Houssem to this thread because I think I remember he did =
some<br clear=3D"none">work around that, he may have more information.<br c=
lear=3D"none"><br clear=3D"none">Julien</div></div>
                </div>
            </div></div></body></html>
------=_Part_5319969_345942993.1512064280571--

--===============8275622305561394693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8275622305561394693==--
