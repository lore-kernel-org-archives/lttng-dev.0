From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: scale numbers for LTTNG
Date: Thu, 26 May 2016 19:46:17 +0000 (UTC)
Message-ID: <177841807.20574.1464291977964.JavaMail.zimbra__36929.0721639574$1464292002$gmane$org@efficios.com>
References: <CAHxF_R8QdRQjbgfE1d+Zgi=CmDiB6SEgL2Up1G-p21YdQz9pYA@mail.gmail.com>
 <CAHxF_R9iWBOU=hawM8ZjJCVG3TV7YZOtkwvaqhm2MTdwza48jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5229528137565187247=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4ADBDA3640
 for <lttng-dev@lists.lttng.org>; Thu, 26 May 2016 19:46:19 +0000 (UTC)
In-Reply-To: <CAHxF_R9iWBOU=hawM8ZjJCVG3TV7YZOtkwvaqhm2MTdwza48jg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Vijay Anand <vjanandr85@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5229528137565187247==
Content-Type: multipart/alternative;
	boundary="----=_Part_20573_1870693024.1464291977963"

------=_Part_20573_1870693024.1464291977963
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On May 26, 2016, at 8:23 AM, Vijay Anand <vjanandr85@gmail.com> wrote=
:=20

> Could anyone please let us know how do we go about this ?

> Regards,
> Vijay

> On Tue, May 24, 2016 at 11:31 AM, Vijay Anand < vjanandr85@gmail.com > wr=
ote:

>> Hello Folks,

>> We have been evaluating LTTNG for use in our production systems for user=
 space
>> tracing. We have evaluated most of the features supported by LTTNG and v=
ery
>> much see a value add LTTNG brings into our debugging infrastructure.

>>     * Our current requirement is to trace Userspace programs running on =
linux.
>>     * Each of the linux processes define their own tracepoint providers.

Sounds like a good design.=20

>>     *
>>     * We would like to trace event histories of each process independent=
ly.

Why ? You can always collect trace data into buffers shared across processe=
s (per-uid buffers)=20
and filter after the fact.=20

>>     *
>>     * We could potentially have 1000s of such processes running simultan=
eously.

Especially with that many processes, having per-process buffers will degrad=
e your cache=20
locality.=20

>>     *
>>    * We concluded on using a session/channel to trace one tracepoint pro=
vider
>>     corresponding to a unique process.

>>        * But I understand we could also create one system wide session a=
nd use channels
>>         to trace each of the providers. Either of the approaches seems t=
o work for us.

Both approach will kill you cache locality with that many process. I don't =
recommend either=20
of the two approaches you refer to above. You might want to consider sharin=
g your buffers=20
across processes.=20

>>    * But upon evaluating I see that we could create only 25 active proce=
ss-sessions
>>     and not traces from all the processes are logged.

We will need much more details on your tracing configuration setup (exact l=
ist of commands you=20
issue to create your tracing sessions).=20

Also please detail what you mean by " not traces from all the processes are=
 logged".=20
What commands do you issue, what is the exact setup, and what is the output=
=20
you observe (exact listing) which leads you to reach this conclusion.=20

Thanks,=20

Mathieu=20

>>        * Please note I have tried increasing the buffer size and the num=
ber of buffers.
>>         This doesn't help.
>>         * Each of the process trace 52 events at and interval of 1 secon=
d each.
>>     *
>> I have evaluated this with lttng in session,live and snapshot modes and =
I have
>> not been getting favourable.

>> Could you folks share the scale numbers that LTTNG supports, especially =
when it
>> comes to tracing user space programs ?

>> Regards,
>> Vijay
>> =E2=80=8B=E2=80=8B

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_20573_1870693024.1464291977963
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On May 26, 2016, at 8:23 AM, Vijay Anand=
 &lt;vjanandr85@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED=
_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px=
;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div di=
r=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,sans-se=
rif;font-size:small"><span style=3D"color: #000000;" data-mce-style=3D"colo=
r: #000000;" color=3D"#000000">Could anyone please let us know how do we go=
 about this ?</span></div><div class=3D"gmail_extra"><span style=3D"color: =
#000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><br clear=3D=
"all"></span><div><div class=3D"gmail_signature"><div dir=3D"ltr"><span sty=
le=3D"color: #000000; font-family: verdana,sans-serif;" data-mce-style=3D"c=
olor: #000000; font-family: verdana,sans-serif;" color=3D"#000000" face=3D"=
verdana, sans-serif">Regards,</span><div><span style=3D"color: #000000; fon=
t-family: verdana,sans-serif;" data-mce-style=3D"color: #000000; font-famil=
y: verdana,sans-serif;" color=3D"#000000" face=3D"verdana, sans-serif">Vija=
y</span></div></div></div></div><br><div class=3D"gmail_quote">On Tue, May =
24, 2016 at 11:31 AM, Vijay Anand <span dir=3D"ltr">&lt;<a href=3D"mailto:v=
janandr85@gmail.com" target=3D"_blank">vjanandr85@gmail.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div style=3D"fon=
t-family:verdana,sans-serif;font-size:small"><span style=3D"color: #000000;=
" data-mce-style=3D"color: #000000;" color=3D"#000000">Hello Folks,</span><=
/div><div style=3D"font-family:verdana,sans-serif;font-size:small"><span st=
yle=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000=
"><br></span></div><div style=3D"font-family:verdana,sans-serif;font-size:s=
mall"><span style=3D"color: #000000;" data-mce-style=3D"color: #000000;" co=
lor=3D"#000000">We have been evaluating LTTNG for use in our production sys=
tems for user space tracing. We have evaluated most of the features support=
ed by LTTNG and very much see a value add LTTNG brings into our debugging i=
nfrastructure.</span></div><div><ul><li><span style=3D"color: #000000;" dat=
a-mce-style=3D"color: #000000;" color=3D"#000000"><span style=3D"font-famil=
y:verdana,sans-serif">Our current requirement is to trace Userspace program=
s running on linux.&nbsp;</span><br></span></li><li><span style=3D"color: #=
000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><span style=
=3D"font-family:verdana,sans-serif">Each of the linux processes define thei=
r own tracepoint providers.</span></span></li></ul></div></div></blockquote=
></div></div></div></blockquote><div><br></div><div>Sounds like a good desi=
gn.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div dir=3D"ltr"><div><ul><li><span style=3D"color: #000000;" data-mc=
e-style=3D"color: #000000;" color=3D"#000000"><br></span></li><li><span sty=
le=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"=
><span style=3D"font-family:verdana,sans-serif">We would like to trace even=
t histories of each process independently.</span></span></li></ul></div></d=
iv></blockquote></div></div></div></blockquote><div><br></div><div>Why ? Yo=
u can always collect trace data into buffers shared across processes (per-u=
id buffers)</div><div>and filter after the fact.</div><div><br data-mce-bog=
us=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div dir=3D"ltr"><div><ul><li><span style=3D"colo=
r: #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000"><br></spa=
n></li><li><span style=3D"color: #000000;" data-mce-style=3D"color: #000000=
;" color=3D"#000000"><span style=3D"font-family:verdana,sans-serif">We coul=
d potentially have 1000s of such processes running simultaneously.</span></=
span></li></ul></div></div></blockquote></div></div></div></blockquote><div=
><br></div><div>Especially with that many processes, having per-process buf=
fers will degrade your cache<br data-mce-bogus=3D"1"></div><div>locality.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div dir=3D"ltr"><div><ul><li><span style=3D"color: #000000;" data-mce-sty=
le=3D"color: #000000;" color=3D"#000000"><br></span></li><li><span style=3D=
"font-family:verdana,sans-serif"><span style=3D"color: #000000;" data-mce-s=
tyle=3D"color: #000000;" color=3D"#000000">We concluded on using a session/=
channel to trace one tracepoint provider corresponding to a unique process.=
&nbsp;</span></span></li><ul><li><span style=3D"font-family:verdana,sans-se=
rif"><span style=3D"color: #000000;" data-mce-style=3D"color: #000000;" col=
or=3D"#000000">But I understand we could also create one system wide sessio=
n and use channels to trace each of the providers. Either of the approaches=
 seems to work for us.</span></span></li></ul></ul></div></div></blockquote=
></div></div></div></blockquote><div>Both approach will kill you cache loca=
lity with that many process. I don't recommend either<br></div><div>of the =
two approaches you refer to above. You might want to consider sharing your =
buffers</div><div>across processes.</div><div><br data-mce-bogus=3D"1"></di=
v><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddin=
g-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:=
none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"lt=
r"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div><ul><li><span style=3D"font-family:verd=
ana,sans-serif"><span style=3D"color: #000000;" data-mce-style=3D"color: #0=
00000;" color=3D"#000000">But upon evaluating I see that we could create on=
ly 25 active process-sessions and not traces from all the processes are log=
ged.</span></span></li></ul></div></div></blockquote></div></div></div></bl=
ockquote><div>We will need much more details on your tracing configuration =
setup (exact list of commands you<br></div><div>issue to create your tracin=
g sessions).<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></=
div><div>Also please detail what you mean by "<span style=3D"font-family: v=
erdana,sans-serif;" data-mce-style=3D"font-family: verdana,sans-serif;"><sp=
an style=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=3D"#0=
00000">not traces from all the processes are logged".</span></span><br data=
-mce-bogus=3D"1"></div><div><span style=3D"font-family: verdana,sans-serif;=
" data-mce-style=3D"font-family: verdana,sans-serif;"><span style=3D"color:=
 #000000;" data-mce-style=3D"color: #000000;" color=3D"#000000">What comman=
ds do you issue, what is the exact setup, and what is the output<br></span>=
</span></div><div><span style=3D"font-family: verdana,sans-serif;" data-mce=
-style=3D"font-family: verdana,sans-serif;"><span style=3D"color: #000000;"=
 data-mce-style=3D"color: #000000;" color=3D"#000000">you observe (exact li=
sting) which leads you to reach this conclusion.<br data-mce-bogus=3D"1"></=
span></span></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br d=
ata-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote s=
tyle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;colo=
r:#000;font-weight:normal;font-style:normal;text-decoration:none;font-famil=
y:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div dir=3D"ltr"><div><ul><ul><li><span style=3D"font-family:verdana,sans-s=
erif"><span style=3D"color: #000000;" data-mce-style=3D"color: #000000;" co=
lor=3D"#000000">Please note I have tried increasing the buffer size and the=
 number of buffers. This doesn't help.</span></span></li><li><span style=3D=
"font-family:verdana,sans-serif"><span style=3D"color: #000000;" data-mce-s=
tyle=3D"color: #000000;" color=3D"#000000">Each of the process trace 52 eve=
nts at and interval of 1 second each.</span></span></li></ul><li><span styl=
e=3D"color: #000000; font-family: verdana,sans-serif;" data-mce-style=3D"co=
lor: #000000; font-family: verdana,sans-serif;" color=3D"#000000" face=3D"v=
erdana, sans-serif">I have evaluated this with lttng in session,live and sn=
apshot modes and I have not been getting&nbsp;favourable.</span></li></ul><=
span style=3D"color: #000000;" data-mce-style=3D"color: #000000;" color=3D"=
#000000"><span style=3D"font-family:verdana,sans-serif">Could you folks sha=
re the scale numbers that LTTNG supports, especially when it comes to traci=
ng user space programs ?</span><br></span></div><div style=3D"font-family:v=
erdana,sans-serif;font-size:small"><span style=3D"color: #000000;" data-mce=
-style=3D"color: #000000;" color=3D"#000000"><br></span></div><div><div><di=
v dir=3D"ltr"><span style=3D"color: #000000; font-family: verdana,sans-seri=
f;" data-mce-style=3D"color: #000000; font-family: verdana,sans-serif;" col=
or=3D"#000000" face=3D"verdana, sans-serif">Regards,</span><div><span style=
=3D"color: #000000; font-family: verdana,sans-serif;" data-mce-style=3D"col=
or: #000000; font-family: verdana,sans-serif;" color=3D"#000000" face=3D"ve=
rdana, sans-serif">Vijay<div style=3D"font-family:verdana,sans-serif;font-s=
ize:small;display:inline">=E2=80=8B=E2=80=8B</div></span></div></div></div>=
</div></div></blockquote></div></div></div><br></blockquote></div><br><div =
data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiO=
S Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_20573_1870693024.1464291977963--

--===============5229528137565187247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5229528137565187247==--
