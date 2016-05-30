From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: scale numbers for LTTNG
Date: Mon, 30 May 2016 13:03:51 +0000 (UTC)
Message-ID: <825187701.22622.1464613431308.JavaMail.zimbra__23458.7015388117$1464613456$gmane$org@efficios.com>
References: <CAHxF_R8QdRQjbgfE1d+Zgi=CmDiB6SEgL2Up1G-p21YdQz9pYA@mail.gmail.com>
 <CAHxF_R9iWBOU=hawM8ZjJCVG3TV7YZOtkwvaqhm2MTdwza48jg@mail.gmail.com>
 <177841807.20574.1464291977964.JavaMail.zimbra@efficios.com>
 <CAHxF_R86zFujOeFS-9cMU_aTS8VGSCJaFnYaAONdj6hknQQTPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2144147705320180019=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id EDAD7A36D2
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2016 13:03:55 +0000 (UTC)
In-Reply-To: <CAHxF_R86zFujOeFS-9cMU_aTS8VGSCJaFnYaAONdj6hknQQTPA@mail.gmail.com>
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

--===============2144147705320180019==
Content-Type: multipart/alternative;
	boundary="----=_Part_22621_241149895.1464613431307"

------=_Part_22621_241149895.1464613431307
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On May 30, 2016, at 9:16 AM, Vijay Anand <vjanandr85@gmail.com> wrote=
:=20

> Hi Mathieu, Jonathan,

> I have written python scripts to simulate our requirements.
> https://github.com/vjanandr/sampleP/tree/master/lttng

> Please refer to the README file for further details about the scripts.

> Mathieu, I understand your recommendation to use per UID buffers instead =
of per
> PID buffers.
> But I dont seem to understand your suggestion to use filters...


> Why ? You can always collect trace data into buffers shared across proces=
ses
> (per-uid buffers)
> and filter after the fact.
> <<<<<

> Did you mean to say write all traces to a file but filter them while read=
ing
> based on maybe process ID ?

Yes, this is what I mean,=20

Thanks,=20

Mathieu=20

> Regards,
> Vijay

> On Fri, May 27, 2016 at 1:16 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

>> ----- On May 26, 2016, at 8:23 AM, Vijay Anand < vjanandr85@gmail.com > =
wrote:

>>> Could anyone please let us know how do we go about this ?

>>> Regards,
>>> Vijay

>>> On Tue, May 24, 2016 at 11:31 AM, Vijay Anand < vjanandr85@gmail.com > =
wrote:

>>>> Hello Folks,

>>>> We have been evaluating LTTNG for use in our production systems for us=
er space
>>>> tracing. We have evaluated most of the features supported by LTTNG and=
 very
>>>> much see a value add LTTNG brings into our debugging infrastructure.

>>>>     * Our current requirement is to trace Userspace programs running o=
n linux.
>>>>     * Each of the linux processes define their own tracepoint provider=
s.

>> Sounds like a good design.

>>>>     *
>>>>     * We would like to trace event histories of each process independe=
ntly.

>> Why ? You can always collect trace data into buffers shared across proce=
sses
>> (per-uid buffers)
>> and filter after the fact.

>>>>     *
>>>>     * We could potentially have 1000s of such processes running simult=
aneously.

>> Especially with that many processes, having per-process buffers will deg=
rade
>> your cache
>> locality.

>>>>     *
>>>>    * We concluded on using a session/channel to trace one tracepoint p=
rovider
>>>>     corresponding to a unique process.

>>>>        * But I understand we could also create one system wide session=
 and use channels
>>>>         to trace each of the providers. Either of the approaches seems=
 to work for us.

>> Both approach will kill you cache locality with that many process. I don=
't
>> recommend either
>> of the two approaches you refer to above. You might want to consider sha=
ring
>> your buffers
>> across processes.

>>>>    * But upon evaluating I see that we could create only 25 active pro=
cess-sessions
>>>>     and not traces from all the processes are logged.

>> We will need much more details on your tracing configuration setup (exac=
t list
>> of commands you
>> issue to create your tracing sessions).

>> Also please detail what you mean by " not traces from all the processes =
are
>> logged".
>> What commands do you issue, what is the exact setup, and what is the out=
put
>> you observe (exact listing) which leads you to reach this conclusion.

>> Thanks,

>> Mathieu

>>>>        * Please note I have tried increasing the buffer size and the n=
umber of buffers.
>>>>         This doesn't help.
>>>>         * Each of the process trace 52 events at and interval of 1 sec=
ond each.
>>>>     *
>>>> I have evaluated this with lttng in session,live and snapshot modes an=
d I have
>>>> not been getting favourable.

>>>> Could you folks share the scale numbers that LTTNG supports, especiall=
y when it
>>>> comes to tracing user space programs ?

>>>> Regards,
>>>> Vijay
>>>> =E2=80=8B=E2=80=8B

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_22621_241149895.1464613431307
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On May 30, 2016, at 9:16 AM, Vijay Anand &lt;vjanandr85@gmail.com=
&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div clas=
s=3D"gmail_default" style=3D"font-size:small"><span style=3D"color: #000000=
; font-family: verdana,sans-serif;" data-mce-style=3D"color: #000000; font-=
family: verdana,sans-serif;" color=3D"#000000" face=3D"verdana, sans-serif"=
>Hi Mathieu, Jonathan,</span></div><div class=3D"gmail_default" style=3D"fo=
nt-size:small"><span style=3D"color: #000000; font-family: verdana,sans-ser=
if;" data-mce-style=3D"color: #000000; font-family: verdana,sans-serif;" co=
lor=3D"#000000" face=3D"verdana, sans-serif"><br></span></div><div class=3D=
"gmail_default" style=3D"font-size:small"><span style=3D"color: #000000; fo=
nt-family: verdana,sans-serif;" data-mce-style=3D"color: #000000; font-fami=
ly: verdana,sans-serif;" color=3D"#000000" face=3D"verdana, sans-serif">I h=
ave written python scripts to simulate our requirements.</span></div><div c=
lass=3D"gmail_default"><span style=3D"color: #000000; font-family: verdana,=
sans-serif;" data-mce-style=3D"color: #000000; font-family: verdana,sans-se=
rif;" color=3D"#000000" face=3D"verdana, sans-serif"><a href=3D"https://git=
hub.com/vjanandr/sampleP/tree/master/lttng" target=3D"_blank">https://githu=
b.com/vjanandr/sampleP/tree/master/lttng</a><br><br></span></div><div class=
=3D"gmail_default"><span style=3D"color: #000000; font-family: verdana,sans=
-serif;" data-mce-style=3D"color: #000000; font-family: verdana,sans-serif;=
" color=3D"#000000" face=3D"verdana, sans-serif">Please refer to the README=
 file for further details about the scripts.</span></div><div class=3D"gmai=
l_default"><span style=3D"color: #000000; font-family: verdana,sans-serif;"=
 data-mce-style=3D"color: #000000; font-family: verdana,sans-serif;" color=
=3D"#000000" face=3D"verdana, sans-serif"><br></span></div><div class=3D"gm=
ail_default"><span style=3D"color: #000000; font-family: verdana,sans-serif=
;" data-mce-style=3D"color: #000000; font-family: verdana,sans-serif;" colo=
r=3D"#000000" face=3D"verdana, sans-serif">Mathieu, I understand your recom=
mendation to use per UID buffers instead of per PID buffers.</span></div><d=
iv class=3D"gmail_default"><span style=3D"color: #000000; font-family: verd=
ana,sans-serif;" data-mce-style=3D"color: #000000; font-family: verdana,san=
s-serif;" color=3D"#000000" face=3D"verdana, sans-serif">But I dont seem to=
 understand your suggestion to use filters...</span></div><div class=3D"gma=
il_default"><span style=3D"color: #000000; font-family: verdana,sans-serif;=
" data-mce-style=3D"color: #000000; font-family: verdana,sans-serif;" color=
=3D"#000000" face=3D"verdana, sans-serif"><br></span></div><div class=3D"gm=
ail_default"><div style=3D"color:rgb(0,0,0);font-family:arial,helvetica,san=
s-serif;font-size:16px">&gt;&gt;&gt;&gt;</div><div style=3D"color:rgb(0,0,0=
);font-family:arial,helvetica,sans-serif;font-size:16px">Why ? You can alwa=
ys collect trace data into buffers shared across processes (per-uid buffers=
)</div><div style=3D"color:rgb(0,0,0);font-family:arial,helvetica,sans-seri=
f;font-size:16px">and filter after the fact.</div><div>&lt;&lt;&lt;&lt;&lt;=
</div><div><br>Did you mean to say write all traces to a file but filter th=
em while reading based on maybe process ID ?&nbsp;</div></div></div></block=
quote><div>Yes, this is what I mean,<br></div><div><br data-mce-bogus=3D"1"=
></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"b=
order-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_e=
xtra"><span style=3D"color: #000000; font-family: verdana,sans-serif;" data=
-mce-style=3D"color: #000000; font-family: verdana,sans-serif;" color=3D"#0=
00000" face=3D"verdana, sans-serif"><br clear=3D"all"></span><div><div><div=
 dir=3D"ltr"><span style=3D"color: #000000; font-family: verdana,sans-serif=
;" data-mce-style=3D"color: #000000; font-family: verdana,sans-serif;" colo=
r=3D"#000000" face=3D"verdana, sans-serif">Regards,</span><div><span style=
=3D"color: #000000; font-family: verdana,sans-serif;" data-mce-style=3D"col=
or: #000000; font-family: verdana,sans-serif;" color=3D"#000000" face=3D"ve=
rdana, sans-serif">Vijay</span></div></div></div></div><br><div class=3D"gm=
ail_quote">On Fri, May 27, 2016 at 1:16 AM, Mathieu Desnoyers <span dir=3D"=
ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank=
">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
<div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)"><span><br><br><span>----- On May 26, 2016, at 8:23 AM, Vija=
y Anand &lt;<a href=3D"mailto:vjanandr85@gmail.com" target=3D"_blank">vjana=
ndr85@gmail.com</a>&gt; wrote:<br></span></span><div><span><blockquote styl=
e=3D"border-left-width:2px;border-left-style:solid;border-left-color:rgb(16=
,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:norm=
al;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-=
serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif;font-size:small"><span style=3D"color:rg=
b(0,0,0)">Could anyone please let us know how do we go about this ?</span><=
/div><div class=3D"gmail_extra"><span style=3D"color:rgb(0,0,0)"><br clear=
=3D"all"></span><div><div><div dir=3D"ltr"><span style=3D"color:rgb(0,0,0);=
font-family:verdana,sans-serif">Regards,</span><div><span style=3D"color:rg=
b(0,0,0);font-family:verdana,sans-serif">Vijay</span></div></div></div></di=
v><br><div class=3D"gmail_quote">On Tue, May 24, 2016 at 11:31 AM, Vijay An=
and <span dir=3D"ltr">&lt;<a href=3D"mailto:vjanandr85@gmail.com" target=3D=
"_blank">vjanandr85@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div style=3D"font-family:verdana,sans-serif;font-size:small"=
><span style=3D"color:rgb(0,0,0)">Hello Folks,</span></div><div style=3D"fo=
nt-family:verdana,sans-serif;font-size:small"><span style=3D"color:rgb(0,0,=
0)"><br></span></div><div style=3D"font-family:verdana,sans-serif;font-size=
:small"><span style=3D"color:rgb(0,0,0)">We have been evaluating LTTNG for =
use in our production systems for user space tracing. We have evaluated mos=
t of the features supported by LTTNG and very much see a value add LTTNG br=
ings into our debugging infrastructure.</span></div><div><ul><li><span styl=
e=3D"color:rgb(0,0,0)"><span style=3D"font-family:verdana,sans-serif">Our c=
urrent requirement is to trace Userspace programs running on linux.&nbsp;</=
span><br></span></li><li><span style=3D"color:rgb(0,0,0)"><span style=3D"fo=
nt-family:verdana,sans-serif">Each of the linux processes define their own =
tracepoint providers.</span></span></li></ul></div></div></blockquote></div=
></div></div></blockquote><br></span><div>Sounds like a good design.<br></d=
iv><span><br><blockquote style=3D"border-left-width:2px;border-left-style:s=
olid;border-left-color:rgb(16,16,255);margin-left:5px;padding-left:5px;colo=
r:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div><ul><li><span style=3D"color:rgb(0,0,0)"><br></span></li><li><sp=
an style=3D"color:rgb(0,0,0)"><span style=3D"font-family:verdana,sans-serif=
">We would like to trace event histories of each process independently.</sp=
an></span></li></ul></div></div></blockquote></div></div></div></blockquote=
><br></span><div>Why ? You can always collect trace data into buffers share=
d across processes (per-uid buffers)</div><div>and filter after the fact.</=
div><span><br><blockquote style=3D"border-left-width:2px;border-left-style:=
solid;border-left-color:rgb(16,16,255);margin-left:5px;padding-left:5px;col=
or:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div><ul><li><span style=3D"color:rgb(0,0,0)"><br></span></li><li>=
<span style=3D"color:rgb(0,0,0)"><span style=3D"font-family:verdana,sans-se=
rif">We could potentially have 1000s of such processes running simultaneous=
ly.</span></span></li></ul></div></div></blockquote></div></div></div></blo=
ckquote><br></span><div>Especially with that many processes, having per-pro=
cess buffers will degrade your cache<br></div><div>locality.<br></div><span=
><br><blockquote style=3D"border-left-width:2px;border-left-style:solid;bor=
der-left-color:rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,=
0,0);font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"g=
mail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv><ul><li><span style=3D"color:rgb(0,0,0)"><br></span></li><li><span style=
=3D"font-family:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)">We con=
cluded on using a session/channel to trace one tracepoint provider correspo=
nding to a unique process.&nbsp;</span></span></li><ul><li><span style=3D"f=
ont-family:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)">But I under=
stand we could also create one system wide session and use channels to trac=
e each of the providers. Either of the approaches seems to work for us.</sp=
an></span></li></ul></ul></div></div></blockquote></div></div></div></block=
quote></span><div>Both approach will kill you cache locality with that many=
 process. I don't recommend either<br></div><div>of the two approaches you =
refer to above. You might want to consider sharing your buffers</div><div>a=
cross processes.</div><span><br><blockquote style=3D"border-left-width:2px;=
border-left-style:solid;border-left-color:rgb(16,16,255);margin-left:5px;pa=
dding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-d=
ecoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div =
dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div><ul><li><span style=3D"font-family:verdana,sa=
ns-serif"><span style=3D"color:rgb(0,0,0)">But upon evaluating I see that w=
e could create only 25 active process-sessions and not traces from all the =
processes are logged.</span></span></li></ul></div></div></blockquote></div=
></div></div></blockquote></span><div>We will need much more details on you=
r tracing configuration setup (exact list of commands you<br></div><div>iss=
ue to create your tracing sessions).<br></div><br><div>Also please detail w=
hat you mean by "<span style=3D"font-family:verdana,sans-serif"><span style=
=3D"color:rgb(0,0,0)">not traces from all the processes are logged".</span>=
</span><br></div><div><span style=3D"font-family:verdana,sans-serif"><span =
style=3D"color:rgb(0,0,0)">What commands do you issue, what is the exact se=
tup, and what is the output<br></span></span></div><div><span style=3D"font=
-family:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)">you observe (e=
xact listing) which leads you to reach this conclusion.<br></span></span></=
div><br><div>Thanks,<br></div><br><div>Mathieu<br></div><span><br><blockquo=
te style=3D"border-left-width:2px;border-left-style:solid;border-left-color=
:rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left=
-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><ul><ul><li=
><span style=3D"font-family:verdana,sans-serif"><span style=3D"color:rgb(0,=
0,0)">Please note I have tried increasing the buffer size and the number of=
 buffers. This doesn't help.</span></span></li><li><span style=3D"font-fami=
ly:verdana,sans-serif"><span style=3D"color:rgb(0,0,0)">Each of the process=
 trace 52 events at and interval of 1 second each.</span></span></li></ul><=
li><span style=3D"color:rgb(0,0,0);font-family:verdana,sans-serif">I have e=
valuated this with lttng in session,live and snapshot modes and I have not =
been getting&nbsp;favourable.</span></li></ul><span style=3D"color:rgb(0,0,=
0)"><span style=3D"font-family:verdana,sans-serif">Could you folks share th=
e scale numbers that LTTNG supports, especially when it comes to tracing us=
er space programs ?</span><br></span></div><div style=3D"font-family:verdan=
a,sans-serif;font-size:small"><span style=3D"color:rgb(0,0,0)"><br></span><=
/div><div><div><div dir=3D"ltr"><span style=3D"color:rgb(0,0,0);font-family=
:verdana,sans-serif">Regards,</span><div><span style=3D"color:rgb(0,0,0);fo=
nt-family:verdana,sans-serif">Vijay<div style=3D"font-family:verdana,sans-s=
erif;font-size:small;display:inline">=E2=80=8B=E2=80=8B</div></span></div><=
/div></div></div></div></blockquote></div></div></div><br></blockquote></sp=
an></div><span><span style=3D"color: #888888;" data-mce-style=3D"color: #88=
8888;" color=3D"#888888"><br><div>-- <br></div><div>Mathieu Desnoyers<br>Ef=
ficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http:/=
/www.efficios.com</a><br data-mce-bogus=3D"1"></div></span></span></div></d=
iv></blockquote></div></div></div><br></blockquote></div><div><br></div><di=
v data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Effic=
iOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_22621_241149895.1464613431307--

--===============2144147705320180019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2144147705320180019==--
