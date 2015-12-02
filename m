From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: lttng view => [error] at line 1269: token "(":
 syntax error, unexpected LPAREN, expecting SEMICOLON or COMMA
Date: Wed, 2 Dec 2015 14:30:51 -0500
Message-ID: <CAB4xu_1WusPbbz2E9zSaGOUjdPj4JA_1qBveEY34DjkNSfBg=g__6264.08069297231$1449084749$gmane$org@mail.gmail.com>
References: <CANgVouUOGyQ5vvn9g-4fa5_ADU4yYcSiiUOezr-aJn2+yG8iDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0794809942=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1a4D7g-0005fO-Gy
 for lttng-dev@lists.lttng.org; Wed, 02 Dec 2015 14:31:30 -0500
Received: by lfdl133 with SMTP id l133so64011543lfd.2
 for <lttng-dev@lists.lttng.org>; Wed, 02 Dec 2015 11:31:20 -0800 (PST)
In-Reply-To: <CANgVouUOGyQ5vvn9g-4fa5_ADU4yYcSiiUOezr-aJn2+yG8iDw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: John Smith <whalajam@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0794809942==
Content-Type: multipart/alternative; boundary=001a1142507ea28bd60525ef518a

--001a1142507ea28bd60525ef518a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

John,

Can you pastebin the trace's metadata file? Use:

    babeltrace -o ctf-metadata /path/to/trace

to get it.

Thanks,

Philippe Proulx

On Tue, Dec 1, 2015 at 9:19 PM, John Smith <whalajam@gmail.com> wrote:

> Hi,
>
> issued the regular following lttng commands:
> [
> lttng create
> lttng enable-event -u -a
> lttng start
> <run-my-app>
> lttng stop
> lttng view
> ]
>
> "lttng view" command fails with the following:
>
> [error] at line 1269: token "(": syntax error, unexpected LPAREN,
> expecting SEMICOLON or COMMA
> Environment info:
> [
> $ uname -a
> Linux slab134 3.19.0-30-generic #34~14.04.1-Ubuntu SMP Fri Oct 2 22:09:39
> UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
> $ lttng --version
> lttng (LTTng Trace Control) 2.4.0 - =C3=89poque Opaque
> ]
>
> I used also:
> lttng view -e "babeltrace -n all -v -d"
>
> but the output is not revealing any comprehensible details.
>
> What mistake could lead to such a disastrous failure?
>
> thanks, John
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--001a1142507ea28bd60525ef518a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">John,<div><br></div><div>Can you pastebin the trace&#39;s =
metadata file? Use:</div><div><br></div><div>=C2=A0 =C2=A0 babeltrace -o ct=
f-metadata /path/to/trace</div><div><br></div><div>to get it.</div><div><br=
></div><div>Thanks,</div></div><div class=3D"gmail_extra"><br clear=3D"all"=
><div><div class=3D"gmail_signature">Philippe Proulx</div></div>
<br><div class=3D"gmail_quote">On Tue, Dec 1, 2015 at 9:19 PM, John Smith <=
span dir=3D"ltr">&lt;<a href=3D"mailto:whalajam@gmail.com" target=3D"_blank=
">whalajam@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr"><div>Hi,</div><div><br></div><div>issued the regular fol=
lowing lttng commands:<br>[<br>lttng create<br>lttng enable-event -u -a<br>=
lttng start</div><div>&lt;run-my-app&gt;</div><div>lttng stop<br>lttng view=
<br>]</div><p>&quot;lttng view&quot; command fails with the following:</p><=
p>[error] at line 1269: token &quot;(&quot;: syntax error, unexpected LPARE=
N, expecting SEMICOLON or COMMA</p><div>Environment info:</div><div>[</div>=
<div>$ uname -a<br>Linux slab134 3.19.0-30-generic #34~14.04.1-Ubuntu SMP F=
ri Oct 2 22:09:39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux</div><div>$ lttng=
 --version<br>lttng (LTTng Trace Control) 2.4.0 - =C3=89poque Opaque</div><=
div>]</div><div><br></div><div>I used also:</div><div>lttng view -e &quot;b=
abeltrace -n all -v -d&quot;</div><div><br></div><div>but the output is not=
 revealing any comprehensible details.</div><div><br></div><div>What mistak=
e could lead to such a disastrous failure?</div><div><br></div><div>thanks,=
 John</div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br></div>

--001a1142507ea28bd60525ef518a--


--===============0794809942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0794809942==--
