From: Vijay Anand <vjanandr85@gmail.com>
Subject: Re: scale numbers for LTTNG
Date: Mon, 30 May 2016 12:46:46 +0530
Message-ID: <CAHxF_R86zFujOeFS-9cMU_aTS8VGSCJaFnYaAONdj6hknQQTPA__48043.7114638791$1464592628$gmane$org@mail.gmail.com>
References: <CAHxF_R8QdRQjbgfE1d+Zgi=CmDiB6SEgL2Up1G-p21YdQz9pYA@mail.gmail.com>
 <CAHxF_R9iWBOU=hawM8ZjJCVG3TV7YZOtkwvaqhm2MTdwza48jg@mail.gmail.com>
 <177841807.20574.1464291977964.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7037227428540498834=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7C360A36D0
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 07:16:46 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id a136so72267927wme.0
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 00:16:46 -0700 (PDT)
In-Reply-To: <177841807.20574.1464291977964.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jonathan.r.julien@gmail.com
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7037227428540498834==
Content-Type: multipart/alternative; boundary=f46d0444e8ab06d98205340a0aef

--f46d0444e8ab06d98205340a0aef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mathieu, Jonathan,

I have written python scripts to simulate our requirements.
https://github.com/vjanandr/sampleP/tree/master/lttng

Please refer to the README file for further details about the scripts.

Mathieu, I understand your recommendation to use per UID buffers instead of
per PID buffers.
But I dont seem to understand your suggestion to use filters...

>>>>
Why ? You can always collect trace data into buffers shared across
processes (per-uid buffers)
and filter after the fact.
<<<<<

Did you mean to say write all traces to a file but filter them while
reading based on maybe process ID ?

Regards,
Vijay

On Fri, May 27, 2016 at 1:16 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
>
> ----- On May 26, 2016, at 8:23 AM, Vijay Anand <vjanandr85@gmail.com>
> wrote:
>
> Could anyone please let us know how do we go about this ?
>
> Regards,
> Vijay
>
> On Tue, May 24, 2016 at 11:31 AM, Vijay Anand <vjanandr85@gmail.com>
> wrote:
>
>> Hello Folks,
>>
>> We have been evaluating LTTNG for use in our production systems for user
>> space tracing. We have evaluated most of the features supported by LTTNG
>> and very much see a value add LTTNG brings into our debugging
>> infrastructure.
>>
>>    - Our current requirement is to trace Userspace programs running on
>>    linux.
>>    - Each of the linux processes define their own tracepoint providers.
>>
>>
> Sounds like a good design.
>
>
>>    -
>>    - We would like to trace event histories of each process
>>    independently.
>>
>>
> Why ? You can always collect trace data into buffers shared across
> processes (per-uid buffers)
> and filter after the fact.
>
>
>>    -
>>    - We could potentially have 1000s of such processes running
>>    simultaneously.
>>
>>
> Especially with that many processes, having per-process buffers will
> degrade your cache
> locality.
>
>
>>    -
>>    - We concluded on using a session/channel to trace one tracepoint
>>    provider corresponding to a unique process.
>>       - But I understand we could also create one system wide session
>>       and use channels to trace each of the providers. Either of the app=
roaches
>>       seems to work for us.
>>
>> Both approach will kill you cache locality with that many process. I
> don't recommend either
> of the two approaches you refer to above. You might want to consider
> sharing your buffers
> across processes.
>
>
>>    - But upon evaluating I see that we could create only 25 active
>>    process-sessions and not traces from all the processes are logged.
>>
>> We will need much more details on your tracing configuration setup (exac=
t
> list of commands you
> issue to create your tracing sessions).
>
> Also please detail what you mean by "not traces from all the processes
> are logged".
> What commands do you issue, what is the exact setup, and what is the outp=
ut
> you observe (exact listing) which leads you to reach this conclusion.
>
> Thanks,
>
> Mathieu
>
>
>>    - Please note I have tried increasing the buffer size and the number
>>       of buffers. This doesn't help.
>>       - Each of the process trace 52 events at and interval of 1 second
>>       each.
>>    - I have evaluated this with lttng in session,live and snapshot modes
>>    and I have not been getting favourable.
>>
>> Could you folks share the scale numbers that LTTNG supports, especially
>> when it comes to tracing user space programs ?
>>
>> Regards,
>> Vijay
>> =E2=80=8B=E2=80=8B
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--f46d0444e8ab06d98205340a0aef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"><fo=
nt color=3D"#000000" face=3D"verdana, sans-serif">Hi Mathieu, Jonathan,</fo=
nt></div><div class=3D"gmail_default" style=3D"font-size:small"><font color=
=3D"#000000" face=3D"verdana, sans-serif"><br></font></div><div class=3D"gm=
ail_default" style=3D"font-size:small"><font color=3D"#000000" face=3D"verd=
ana, sans-serif">I have written python scripts to simulate our requirements=
.</font></div><div class=3D"gmail_default"><font color=3D"#000000" face=3D"=
verdana, sans-serif"><a href=3D"https://github.com/vjanandr/sampleP/tree/ma=
ster/lttng" target=3D"_blank">https://github.com/vjanandr/sampleP/tree/mast=
er/lttng</a><br><br></font></div><div class=3D"gmail_default"><font color=
=3D"#000000" face=3D"verdana, sans-serif">Please refer to the README file f=
or further details about the scripts.</font></div><div class=3D"gmail_defau=
lt"><font color=3D"#000000" face=3D"verdana, sans-serif"><br></font></div><=
div class=3D"gmail_default"><font color=3D"#000000" face=3D"verdana, sans-s=
erif">Mathieu, I understand your recommendation to use per UID buffers inst=
ead of per PID buffers.</font></div><div class=3D"gmail_default"><font colo=
r=3D"#000000" face=3D"verdana, sans-serif">But I dont seem to understand yo=
ur suggestion to use filters...</font></div><div class=3D"gmail_default"><f=
ont color=3D"#000000" face=3D"verdana, sans-serif"><br></font></div><div cl=
ass=3D"gmail_default"><div style=3D"color:rgb(0,0,0);font-family:arial,helv=
etica,sans-serif;font-size:16px">&gt;&gt;&gt;&gt;</div><div style=3D"color:=
rgb(0,0,0);font-family:arial,helvetica,sans-serif;font-size:16px">Why ? You=
 can always collect trace data into buffers shared across processes (per-ui=
d buffers)</div><div style=3D"color:rgb(0,0,0);font-family:arial,helvetica,=
sans-serif;font-size:16px">and filter after the fact.</div><div>&lt;&lt;&lt=
;&lt;&lt;</div><div><br>Did you mean to say write all traces to a file but =
filter them while reading based on maybe process ID ?=C2=A0</div><span clas=
s=3D"im" style=3D"font-family:arial,helvetica,sans-serif;font-size:16px"></=
span></div><div class=3D"gmail_extra"><font color=3D"#000000" face=3D"verda=
na, sans-serif"><br clear=3D"all"></font><div><div data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><font face=3D"verdana, sans-serif" color=3D"#00=
0000">Regards,</font><div><font face=3D"verdana, sans-serif" color=3D"#0000=
00">Vijay</font></div></div></div></div>
<br><div class=3D"gmail_quote">On Fri, May 27, 2016 at 1:16 AM, Mathieu Des=
noyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.c=
om" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204=
);padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-ser=
if;font-size:12pt;color:rgb(0,0,0)"><span><div><br></div><div><br></div><sp=
an>----- On May 26, 2016, at 8:23 AM, Vijay Anand &lt;<a href=3D"mailto:vja=
nandr85@gmail.com" target=3D"_blank">vjanandr85@gmail.com</a>&gt; wrote:<br=
></span></span><div><span><blockquote style=3D"border-left-width:2px;border=
-left-style:solid;border-left-color:rgb(16,16,255);margin-left:5px;padding-=
left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D=
"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;=
font-size:small"><span style=3D"color:rgb(0,0,0)" color=3D"#000000">Could a=
nyone please let us know how do we go about this ?</span></div><div class=
=3D"gmail_extra"><span style=3D"color:rgb(0,0,0)" color=3D"#000000"><br cle=
ar=3D"all"></span><div><div><div dir=3D"ltr"><span style=3D"color:rgb(0,0,0=
);font-family:verdana,sans-serif" color=3D"#000000" face=3D"verdana, sans-s=
erif">Regards,</span><div><span style=3D"color:rgb(0,0,0);font-family:verda=
na,sans-serif" color=3D"#000000" face=3D"verdana, sans-serif">Vijay</span><=
/div></div></div></div><br><div class=3D"gmail_quote">On Tue, May 24, 2016 =
at 11:31 AM, Vijay Anand <span dir=3D"ltr">&lt;<a href=3D"mailto:vjanandr85=
@gmail.com" target=3D"_blank">vjanandr85@gmail.com</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:verdana,sans-s=
erif;font-size:small"><span style=3D"color:rgb(0,0,0)" color=3D"#000000">He=
llo Folks,</span></div><div style=3D"font-family:verdana,sans-serif;font-si=
ze:small"><span style=3D"color:rgb(0,0,0)" color=3D"#000000"><br></span></d=
iv><div style=3D"font-family:verdana,sans-serif;font-size:small"><span styl=
e=3D"color:rgb(0,0,0)" color=3D"#000000">We have been evaluating LTTNG for =
use in our production systems for user space tracing. We have evaluated mos=
t of the features supported by LTTNG and very much see a value add LTTNG br=
ings into our debugging infrastructure.</span></div><div><ul><li><span styl=
e=3D"color:rgb(0,0,0)" color=3D"#000000"><span style=3D"font-family:verdana=
,sans-serif">Our current requirement is to trace Userspace programs running=
 on linux.=C2=A0</span><br></span></li><li><span style=3D"color:rgb(0,0,0)"=
 color=3D"#000000"><span style=3D"font-family:verdana,sans-serif">Each of t=
he linux processes define their own tracepoint providers.</span></span></li=
></ul></div></div></blockquote></div></div></div></blockquote><div><br></di=
v></span><div>Sounds like a good design.<br></div><span><div><br></div><blo=
ckquote style=3D"border-left-width:2px;border-left-style:solid;border-left-=
color:rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font=
-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica=
,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border=
-left-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><ul><l=
i><span style=3D"color:rgb(0,0,0)" color=3D"#000000"><br></span></li><li><s=
pan style=3D"color:rgb(0,0,0)" color=3D"#000000"><span style=3D"font-family=
:verdana,sans-serif">We would like to trace event histories of each process=
 independently.</span></span></li></ul></div></div></blockquote></div></div=
></div></blockquote><div><br></div></span><div>Why ? You can always collect=
 trace data into buffers shared across processes (per-uid buffers)</div><di=
v>and filter after the fact.</div><span><div><br></div><blockquote style=3D=
"border-left-width:2px;border-left-style:solid;border-left-color:rgb(16,16,=
255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(=
204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><ul><li><span style=3D=
"color:rgb(0,0,0)" color=3D"#000000"><br></span></li><li><span style=3D"col=
or:rgb(0,0,0)" color=3D"#000000"><span style=3D"font-family:verdana,sans-se=
rif">We could potentially have 1000s of such processes running simultaneous=
ly.</span></span></li></ul></div></div></blockquote></div></div></div></blo=
ckquote><div><br></div></span><div>Especially with that many processes, hav=
ing per-process buffers will degrade your cache<br></div><div>locality.<br>=
</div><span><div><br></div><blockquote style=3D"border-left-width:2px;borde=
r-left-style:solid;border-left-color:rgb(16,16,255);margin-left:5px;padding=
-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div><ul><li><span style=3D"color:rgb(0,0,0)" color=
=3D"#000000"><br></span></li><li><span style=3D"font-family:verdana,sans-se=
rif"><span style=3D"color:rgb(0,0,0)" color=3D"#000000">We concluded on usi=
ng a session/channel to trace one tracepoint provider corresponding to a un=
ique process.=C2=A0</span></span></li><ul><li><span style=3D"font-family:ve=
rdana,sans-serif"><span style=3D"color:rgb(0,0,0)" color=3D"#000000">But I =
understand we could also create one system wide session and use channels to=
 trace each of the providers. Either of the approaches seems to work for us=
.</span></span></li></ul></ul></div></div></blockquote></div></div></div></=
blockquote></span><div>Both approach will kill you cache locality with that=
 many process. I don&#39;t recommend either<br></div><div>of the two approa=
ches you refer to above. You might want to consider sharing your buffers</d=
iv><div>across processes.</div><span><div><br></div><blockquote style=3D"bo=
rder-left-width:2px;border-left-style:solid;border-left-color:rgb(16,16,255=
);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204=
,204,204);padding-left:1ex"><div dir=3D"ltr"><div><ul><li><span style=3D"fo=
nt-family:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)" color=3D"#00=
0000">But upon evaluating I see that we could create only 25 active process=
-sessions and not traces from all the processes are logged.</span></span></=
li></ul></div></div></blockquote></div></div></div></blockquote></span><div=
>We will need much more details on your tracing configuration setup (exact =
list of commands you<br></div><div>issue to create your tracing sessions).<=
br></div><div><br></div><div>Also please detail what you mean by &quot;<spa=
n style=3D"font-family:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)"=
 color=3D"#000000">not traces from all the processes are logged&quot;.</spa=
n></span><br></div><div><span style=3D"font-family:verdana,sans-serif"><spa=
n style=3D"color:rgb(0,0,0)" color=3D"#000000">What commands do you issue, =
what is the exact setup, and what is the output<br></span></span></div><div=
><span style=3D"font-family:verdana,sans-serif"><span style=3D"color:rgb(0,=
0,0)" color=3D"#000000">you observe (exact listing) which leads you to reac=
h this conclusion.<br></span></span></div><div><br></div><div>Thanks,<br></=
div><div><br></div><div>Mathieu<br></div><span><div><br></div><blockquote s=
tyle=3D"border-left-width:2px;border-left-style:solid;border-left-color:rgb=
(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_extra"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-col=
or:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><ul><ul><li><sp=
an style=3D"font-family:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)=
" color=3D"#000000">Please note I have tried increasing the buffer size and=
 the number of buffers. This doesn&#39;t help.</span></span></li><li><span =
style=3D"font-family:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)" c=
olor=3D"#000000">Each of the process trace 52 events at and interval of 1 s=
econd each.</span></span></li></ul><li><span style=3D"color:rgb(0,0,0);font=
-family:verdana,sans-serif" color=3D"#000000" face=3D"verdana, sans-serif">=
I have evaluated this with lttng in session,live and snapshot modes and I h=
ave not been getting=C2=A0favourable.</span></li></ul><span style=3D"color:=
rgb(0,0,0)" color=3D"#000000"><span style=3D"font-family:verdana,sans-serif=
">Could you folks share the scale numbers that LTTNG supports, especially w=
hen it comes to tracing user space programs ?</span><br></span></div><div s=
tyle=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"colo=
r:rgb(0,0,0)" color=3D"#000000"><br></span></div><div><div><div dir=3D"ltr"=
><span style=3D"color:rgb(0,0,0);font-family:verdana,sans-serif" color=3D"#=
000000" face=3D"verdana, sans-serif">Regards,</span><div><span style=3D"col=
or:rgb(0,0,0);font-family:verdana,sans-serif" color=3D"#000000" face=3D"ver=
dana, sans-serif">Vijay<div style=3D"font-family:verdana,sans-serif;font-si=
ze:small;display:inline">=E2=80=8B=E2=80=8B</div></span></div></div></div><=
/div></div></blockquote></div></div></div><br></blockquote></span></div><sp=
an><font color=3D"#888888"><br><div>-- <br></div><div>Mathieu Desnoyers<br>=
EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http=
://www.efficios.com</a></div></font></span></div></div></blockquote></div><=
br></div></div>

--f46d0444e8ab06d98205340a0aef--

--===============7037227428540498834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7037227428540498834==--
