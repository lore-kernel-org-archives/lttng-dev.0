From: John Smith <whalajam@gmail.com>
Subject: Re: lttng view => [error] at line 1269: token "(":
 syntax error, unexpected LPAREN, expecting SEMICOLON or COMMA
Date: Wed, 2 Dec 2015 22:56:38 -0800
Message-ID: <CANgVouVd7Uaa6ZgRq+FWeL05XiG3cdigVae8-R+-ry9Od5tBsg__3524.07220420918$1449183636$gmane$org@mail.gmail.com>
References: <CANgVouUOGyQ5vvn9g-4fa5_ADU4yYcSiiUOezr-aJn2+yG8iDw@mail.gmail.com>
 <CAB4xu_1WusPbbz2E9zSaGOUjdPj4JA_1qBveEY34DjkNSfBg=g@mail.gmail.com>
 <CANgVouV_w1yWj-99Ey2DrrP3VjHK2AxkSvSZGkFkxz8tBUxJYg@mail.gmail.com>
 <CAB4xu_2RQRa0kbEmPX4xsZ4c=jSavqwgLmmW3n0_yp-0hcnKog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0848935373=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1a4Nop-0000f6-WA
 for lttng-dev@lists.lttng.org; Thu, 03 Dec 2015 01:56:46 -0500
Received: by igvg19 with SMTP id g19so6862259igv.1
 for <lttng-dev@lists.lttng.org>; Wed, 02 Dec 2015 22:56:38 -0800 (PST)
In-Reply-To: <CAB4xu_2RQRa0kbEmPX4xsZ4c=jSavqwgLmmW3n0_yp-0hcnKog@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0848935373==
Content-Type: multipart/alternative; boundary=089e010d97f8738ca60525f8e4e2

--089e010d97f8738ca60525f8e4e2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe,

On "3.19.0-30-generic #34~14.04.1-Ubuntu", apt-get won't install anything
else, is LTTng 2.6 (or 2.7) user space backward compatible with kernel 3.19=
?
I remember a while back trying to build the 2.7 kernel LTTng modules and
got build errors, required additional packages versions that were not
available for 3.19 and upgrading to a newer kernel is problematic,

thanks, John


On Wed, Dec 2, 2015 at 6:02 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> Okay,
>
> You should know, however, that LTTng 2.4 is not supported anymore. There
> could be bugs in there not fixed in this version. Any chance you can
> upgrade to at least LTTng 2.6 (2.7 is better)?
>
> Philippe Proulx
>
> On Wed, Dec 2, 2015 at 7:31 PM, John Smith <whalajam@gmail.com> wrote:
>
>> Philippe,
>> it doesn't work:
>>
>> babeltrace -o ctf-metadata /home/john.s/lttng-traces/auto-20151202-16210=
0
>> [error] at line 1147: token "(": syntax error, unexpected LPAREN,
>> expecting SEMICOLON or COMMA
>> [error] Error creating AST
>> [warning] Unable to open trace metadata for path
>> "/home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit".
>> [warning] [Context] Cannot open_trace of format ctf at path
>> /home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit.
>> [warning] [Context] cannot open trace
>> "/home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit" from
>> /home/john.s/lttng-traces/auto-20151202-162100 for reading.
>> [error] Cannot open any trace for reading.
>> [error] opening trace "/home/john.s/lttng-traces/auto-20151202-162100"
>> for reading.
>>
>> The logs are populated:
>>
>> ls -l  /home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit/
>> total 884
>> -rw-rw---- 1 john.s john.s   8192 Dec  2 16:21 channel0_0
>> -rw-rw---- 1 john.s john.s   4096 Dec  2 16:21 channel0_1
>> ...
>> -rw-rw---- 1 john.s john.s   4096 Dec  2 16:21 channel0_9
>> drwxrwx--- 2 john.s john.s 4096 Dec  2 16:21 index
>> -rw-rw---- 1 john.s john.s   98304 Dec  2 16:21 metadata
>>
>> thanks, John
>>
>> On Wed, Dec 2, 2015 at 11:30 AM, Philippe Proulx <eeppeliteloop@gmail.co=
m
>> > wrote:
>>
>>> John,
>>>
>>> Can you pastebin the trace's metadata file? Use:
>>>
>>>     babeltrace -o ctf-metadata /path/to/trace
>>>
>>> to get it.
>>>
>>> Thanks,
>>>
>>> Philippe Proulx
>>>
>>> On Tue, Dec 1, 2015 at 9:19 PM, John Smith <whalajam@gmail.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> issued the regular following lttng commands:
>>>> [
>>>> lttng create
>>>> lttng enable-event -u -a
>>>> lttng start
>>>> <run-my-app>
>>>> lttng stop
>>>> lttng view
>>>> ]
>>>>
>>>> "lttng view" command fails with the following:
>>>>
>>>> [error] at line 1269: token "(": syntax error, unexpected LPAREN,
>>>> expecting SEMICOLON or COMMA
>>>> Environment info:
>>>> [
>>>> $ uname -a
>>>> Linux slab134 3.19.0-30-generic #34~14.04.1-Ubuntu SMP Fri Oct 2
>>>> 22:09:39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>>> $ lttng --version
>>>> lttng (LTTng Trace Control) 2.4.0 - =C3=89poque Opaque
>>>> ]
>>>>
>>>> I used also:
>>>> lttng view -e "babeltrace -n all -v -d"
>>>>
>>>> but the output is not revealing any comprehensible details.
>>>>
>>>> What mistake could lead to such a disastrous failure?
>>>>
>>>> thanks, John
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>
>>
>

--089e010d97f8738ca60525f8e4e2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Philippe,</div><div><br></div><div>On &quot;3.19.0-30=
-generic #34~14.04.1-Ubuntu&quot;, apt-get won&#39;t=C2=A0install=C2=A0anyt=
hing else, is LTTng 2.6 (or 2.7) user space backward compatible with kernel=
 3.19?</div><div>I remember a while back trying to build the 2.7 kernel LTT=
ng modules and got build errors,=C2=A0required additional packages versions=
 that were not available for 3.19 and upgrading to a newer kernel is proble=
matic,</div><div><br></div><div>thanks, John</div><div>=C2=A0=C2=A0</div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Dec 2=
, 2015 at 6:02 PM, Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"mailto:=
eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@gmail.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Okay,<div>=
<br></div><div>You should know, however, that LTTng 2.4 is not supported an=
ymore. There could be bugs in there not fixed in this version. Any chance y=
ou can upgrade to at least LTTng 2.6 (2.7 is better)?</div></div><div class=
=3D"gmail_extra"><span class=3D"HOEnZb"><font color=3D"#888888"><br clear=
=3D"all"><div><div>Philippe Proulx</div></div></font></span><div><div class=
=3D"h5">
<br><div class=3D"gmail_quote">On Wed, Dec 2, 2015 at 7:31 PM, John Smith <=
span dir=3D"ltr">&lt;<a href=3D"mailto:whalajam@gmail.com" target=3D"_blank=
">whalajam@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;padding-left:1ex;border-left-color:r=
gb(204,204,204);border-left-width:1px;border-left-style:solid"><div dir=3D"=
ltr"><div>Philippe,</div><div>it doesn&#39;t work:</div><div><br></div><div=
>babeltrace -o ctf-metadata /home/john.s/lttng-traces/auto-20151202-162100<=
br>[error] at line 1147: token &quot;(&quot;: syntax error, unexpected LPAR=
EN, expecting SEMICOLON or COMMA</div><div>[error] Error creating AST<br>[w=
arning] Unable to open trace metadata for path &quot;/home/john.s/lttng-tra=
ces/auto-20151202-162100/ust/uid/0/64-bit&quot;.<br>[warning] [Context] Can=
not open_trace of format ctf at path /home/john.s/lttng-traces/auto-2015120=
2-162100/ust/uid/0/64-bit.<br>[warning] [Context] cannot open trace &quot;/=
home/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit&quot; from /=
home/john.s/lttng-traces/auto-20151202-162100 for reading.<br>[error] Canno=
t open any trace for reading.</div><div>[error] opening trace &quot;/home/j=
ohn.s/lttng-traces/auto-20151202-162100&quot; for reading.</div><div><br></=
div><div>The logs are populated:</div><div><br></div><div>ls -l=C2=A0 /home=
/john.s/lttng-traces/auto-20151202-162100/ust/uid/0/64-bit/<br>total 884<br=
>-rw-rw---- 1 john.s=C2=A0john.s=C2=A0=C2=A0 8192 Dec=C2=A0 2 16:21 channel=
0_0<br>-rw-rw---- 1 john.s john.s=C2=A0=C2=A0 4096 Dec=C2=A0 2 16:21 channe=
l0_1<br></div><div>...</div><div>-rw-rw---- 1 john.s john.s=C2=A0=C2=A0 409=
6 Dec=C2=A0 2 16:21 channel0_9<br>drwxrwx--- 2 john.s john.s 4096 Dec=C2=A0=
 2 16:21 index<br>-rw-rw---- 1 john.s john.s=C2=A0=C2=A0 98304 Dec=C2=A0 2 =
16:21 metadata<br></div><div><br></div><div>thanks, John<br></div></div><di=
v><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, De=
c 2, 2015 at 11:30 AM, Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@gmail.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;padding-left:1ex;border-left-color:rgb(204,204,204);border-le=
ft-width:1px;border-left-style:solid"><div dir=3D"ltr">John,<div><br></div>=
<div>Can you pastebin the trace&#39;s metadata file? Use:</div><div><br></d=
iv><div>=C2=A0 =C2=A0 babeltrace -o ctf-metadata /path/to/trace</div><div><=
br></div><div>to get it.</div><div><br></div><div>Thanks,</div></div><div c=
lass=3D"gmail_extra"><br clear=3D"all"><div><div>Philippe Proulx</div></div=
>
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
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank" rel=3D"noreferrer">http://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev</a><br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div></div></div>
</blockquote></div><br></div>

--089e010d97f8738ca60525f8e4e2--


--===============0848935373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0848935373==--
