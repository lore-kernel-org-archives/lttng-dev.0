From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: lttng view => [error] at line 1269: token "(":
 syntax error, unexpected LPAREN, expecting SEMICOLON or COMMA
Date: Wed, 2 Dec 2015 21:02:57 -0500
Message-ID: <CAB4xu_2RQRa0kbEmPX4xsZ4c=jSavqwgLmmW3n0_yp-0hcnKog__41356.2574460686$1449108304$gmane$org@mail.gmail.com>
References: <CANgVouUOGyQ5vvn9g-4fa5_ADU4yYcSiiUOezr-aJn2+yG8iDw@mail.gmail.com>
 <CAB4xu_1WusPbbz2E9zSaGOUjdPj4JA_1qBveEY34DjkNSfBg=g@mail.gmail.com>
 <CANgVouV_w1yWj-99Ey2DrrP3VjHK2AxkSvSZGkFkxz8tBUxJYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0131533984=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1a4JF6-0007YI-S0
 for lttng-dev@lists.lttng.org; Wed, 02 Dec 2015 21:03:37 -0500
Received: by lffu14 with SMTP id u14so74421462lff.1
 for <lttng-dev@lists.lttng.org>; Wed, 02 Dec 2015 18:03:27 -0800 (PST)
In-Reply-To: <CANgVouV_w1yWj-99Ey2DrrP3VjHK2AxkSvSZGkFkxz8tBUxJYg@mail.gmail.com>
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

--===============0131533984==
Content-Type: multipart/alternative; boundary=001a113ebf06ebd9a20525f4cb42

--001a113ebf06ebd9a20525f4cb42
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Okay,

You should know, however, that LTTng 2.4 is not supported anymore. There
could be bugs in there not fixed in this version. Any chance you can
upgrade to at least LTTng 2.6 (2.7 is better)?

Philippe Proulx

On Wed, Dec 2, 2015 at 7:31 PM, John Smith <whalajam@gmail.com> wrote:

> Philippe,
> it doesn't work:
>
> babeltrace -o ctf-metadata /home/john.s/lttng-traces/auto-20151202-162100
> [error] at line 1147: token "(": syntax error, unexpected LPAREN,
> expecting SEMICOLON or COMMA
> [error] Error creating AST
> [warning] Unable to open trace metadata for path
> "/home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit".
> [warning] [Context] Cannot open_trace of format ctf at path
> /home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit.
> [warning] [Context] cannot open trace
> "/home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit" from
> /home/john.s/lttng-traces/auto-20151202-162100 for reading.
> [error] Cannot open any trace for reading.
> [error] opening trace "/home/john.s/lttng-traces/auto-20151202-162100" fo=
r
> reading.
>
> The logs are populated:
>
> ls -l  /home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit/
> total 884
> -rw-rw---- 1 john.s john.s   8192 Dec  2 16:21 channel0_0
> -rw-rw---- 1 john.s john.s   4096 Dec  2 16:21 channel0_1
> ...
> -rw-rw---- 1 john.s john.s   4096 Dec  2 16:21 channel0_9
> drwxrwx--- 2 john.s john.s 4096 Dec  2 16:21 index
> -rw-rw---- 1 john.s john.s   98304 Dec  2 16:21 metadata
>
> thanks, John
>
> On Wed, Dec 2, 2015 at 11:30 AM, Philippe Proulx <eeppeliteloop@gmail.com=
>
> wrote:
>
>> John,
>>
>> Can you pastebin the trace's metadata file? Use:
>>
>>     babeltrace -o ctf-metadata /path/to/trace
>>
>> to get it.
>>
>> Thanks,
>>
>> Philippe Proulx
>>
>> On Tue, Dec 1, 2015 at 9:19 PM, John Smith <whalajam@gmail.com> wrote:
>>
>>> Hi,
>>>
>>> issued the regular following lttng commands:
>>> [
>>> lttng create
>>> lttng enable-event -u -a
>>> lttng start
>>> <run-my-app>
>>> lttng stop
>>> lttng view
>>> ]
>>>
>>> "lttng view" command fails with the following:
>>>
>>> [error] at line 1269: token "(": syntax error, unexpected LPAREN,
>>> expecting SEMICOLON or COMMA
>>> Environment info:
>>> [
>>> $ uname -a
>>> Linux slab134 3.19.0-30-generic #34~14.04.1-Ubuntu SMP Fri Oct 2
>>> 22:09:39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>> $ lttng --version
>>> lttng (LTTng Trace Control) 2.4.0 - =C3=89poque Opaque
>>> ]
>>>
>>> I used also:
>>> lttng view -e "babeltrace -n all -v -d"
>>>
>>> but the output is not revealing any comprehensible details.
>>>
>>> What mistake could lead to such a disastrous failure?
>>>
>>> thanks, John
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>

--001a113ebf06ebd9a20525f4cb42
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Okay,<div><br></div><div>You should know, however, that LT=
Tng 2.4 is not supported anymore. There could be bugs in there not fixed in=
 this version. Any chance you can upgrade to at least LTTng 2.6 (2.7 is bet=
ter)?</div></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div cla=
ss=3D"gmail_signature">Philippe Proulx</div></div>
<br><div class=3D"gmail_quote">On Wed, Dec 2, 2015 at 7:31 PM, John Smith <=
span dir=3D"ltr">&lt;<a href=3D"mailto:whalajam@gmail.com" target=3D"_blank=
">whalajam@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr"><div>Philippe,</div><div>it doesn&#39;t work:</div><div>=
<br></div><div>babeltrace -o ctf-metadata /home/john.s/lttng-traces/auto-20=
151202-162100<br>[error] at line 1147: token &quot;(&quot;: syntax error, u=
nexpected LPAREN, expecting SEMICOLON or COMMA</div><div>[error] Error crea=
ting AST<br>[warning] Unable to open trace metadata for path &quot;/home/jo=
hn.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit&quot;.<br>[warning]=
 [Context] Cannot open_trace of format ctf at path /home/john.s/lttng-trace=
s/auto-20151202-162100/ust/uid/0/64-bit.<br>[warning] [Context] cannot open=
 trace &quot;/home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bi=
t&quot; from /home/john.s/lttng-traces/auto-20151202-162100 for reading.<br=
>[error] Cannot open any trace for reading.</div><div>[error] opening trace=
 &quot;/home/john.s/lttng-traces/auto-20151202-162100&quot; for reading.</d=
iv><div><br></div><div>The logs are populated:</div><div><br></div><div>ls =
-l=C2=A0 /home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit/<b=
r>total 884<br>-rw-rw---- 1 john.s=C2=A0john.s=C2=A0=C2=A0 8192 Dec=C2=A0 2=
 16:21 channel0_0<br>-rw-rw---- 1 john.s john.s=C2=A0=C2=A0 4096 Dec=C2=A0 =
2 16:21 channel0_1<br></div><div>...</div><div>-rw-rw---- 1 john.s john.s=
=C2=A0=C2=A0 4096 Dec=C2=A0 2 16:21 channel0_9<br>drwxrwx--- 2 john.s john.=
s 4096 Dec=C2=A0 2 16:21 index<br>-rw-rw---- 1 john.s john.s=C2=A0=C2=A0 98=
304 Dec=C2=A0 2 16:21 metadata<br></div><div><br></div><div>thanks, John<br=
></div></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Dec 2, 2015 at 11:30 AM, Philip=
pe Proulx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" =
target=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div dir=3D"ltr">John,<div><br></div><div>Can you pa=
stebin the trace&#39;s metadata file? Use:</div><div><br></div><div>=C2=A0 =
=C2=A0 babeltrace -o ctf-metadata /path/to/trace</div><div><br></div><div>t=
o get it.</div><div><br></div><div>Thanks,</div></div><div class=3D"gmail_e=
xtra"><br clear=3D"all"><div><div>Philippe Proulx</div></div>
<br><div class=3D"gmail_quote"><div><div>On Tue, Dec 1, 2015 at 9:19 PM, Jo=
hn Smith <span dir=3D"ltr">&lt;<a href=3D"mailto:whalajam@gmail.com" target=
=3D"_blank">whalajam@gmail.com</a>&gt;</span> wrote:<br></div></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;padding-left:1=
ex;border-left-color:rgb(204,204,204);border-left-width:1px;border-left-sty=
le:solid"><div><div><div dir=3D"ltr"><div>Hi,</div><div><br></div><div>issu=
ed the regular following lttng commands:<br>[<br>lttng create<br>lttng enab=
le-event -u -a<br>lttng start</div><div>&lt;run-my-app&gt;</div><div>lttng =
stop<br>lttng view<br>]</div><p>&quot;lttng view&quot; command fails with t=
he following:</p><p>[error] at line 1269: token &quot;(&quot;: syntax error=
, unexpected LPAREN, expecting SEMICOLON or COMMA</p><div>Environment info:=
</div><div>[</div><div>$ uname -a<br>Linux slab134 3.19.0-30-generic #34~14=
.04.1-Ubuntu SMP Fri Oct 2 22:09:39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux=
</div><div>$ lttng --version<br>lttng (LTTng Trace Control) 2.4.0 - =C3=89p=
oque Opaque</div><div>]</div><div><br></div><div>I used also:</div><div>ltt=
ng view -e &quot;babeltrace -n all -v -d&quot;</div><div><br></div><div>but=
 the output is not revealing any comprehensible details.</div><div><br></di=
v><div>What mistake could lead to such a disastrous failure?</div><div><br>=
</div><div>thanks, John</div></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a113ebf06ebd9a20525f4cb42--


--===============0131533984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0131533984==--
