From: Vivek Kumar <vivekkumar.p@gmail.com>
Subject: Re: Issue faced in logging the traces
Date: Wed, 20 Feb 2013 10:34:07 +0530
Message-ID: <CAG15VGDe4wvC0gzt8e3zGff-ow=NThetDMiZFZWk5u1dGmfFLQ__30621.0074959838$1361336704$gmane$org@mail.gmail.com>
References: <CAG15VGA_O+6P9cLT8h3U-_W=YUVHEVFiBN5Zrm6Gj4i1qBV6BQ@mail.gmail.com>
	<511E463F.2080605@efficios.com>
	<CAG15VGC0HbAaJXwzkwbf5QTDPS8NPN_sW1UieA1oeoQb_iurcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0730727009=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vivekkumar.p@gmail.com>) id 1U81qn-00043U-IO
	for lttng-dev@lists.lttng.org; Wed, 20 Feb 2013 00:04:13 -0500
Received: by mail-vc0-f181.google.com with SMTP id f13so1574239vcb.26
	for <lttng-dev@lists.lttng.org>; Tue, 19 Feb 2013 21:04:07 -0800 (PST)
In-Reply-To: <CAG15VGC0HbAaJXwzkwbf5QTDPS8NPN_sW1UieA1oeoQb_iurcQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0730727009==
Content-Type: multipart/alternative; boundary=047d7b6dcf4650264004d620e3e5

--047d7b6dcf4650264004d620e3e5
Content-Type: text/plain; charset=UTF-8

Hi David,

Any update?

Please let me know if more info is required.

Regards, Vivek

On Mon, Feb 18, 2013 at 4:26 PM, Vivek Kumar <vivekkumar.p@gmail.com> wrote:

> Hi David,
>
> Thanks for the response. LTTng-ust is also ported.
> Please find attached the PPT where I have taken the snaps and described
> the issue faced.
> At present I am trying to port and instrument LTTng for userspace only.
>
> My SoC is ARM-Cortex A9 from Mindspeed and the os is openWRT Linux.
>
> LTTng doesn't report any issue when I run it to instrument in userspace
> but CTF is not logged in the Home directory, please take a look to the
> powerpoint slides for descriptions and commands that I give.
>
> Regards, Vivek
>
>
>
> On Fri, Feb 15, 2013 at 7:59 PM, David Goulet <dgoulet@efficios.com>wrote:
>
>> Hi Vivek,
>>
>> In order to collect a trace you need to instrument your application with
>> LTTng-UST tracepoints.
>>
>> If you like to gather the syscalls for instance, you need to install the
>> LTTng modules and start your session daemon as root.
>>
>> If you are still experiencing problem, please provide the commands you
>> use and setup.
>>
>> Thanks!
>> David
>>
>> Vivek Kumar:
>> > Hi,
>> >
>> > I am trying to port LTTng to my arm based board.
>> > For userspace tracing, I have been able to successfully port followings:
>> > LTTng-tools,
>> > LTT-ust Library
>> > Userspace-rcu
>> > libpopt
>> >
>> > Now I can see that lttng-sessiond is running, and am able to create
>> > sessions, enable-event and start and stop tracing.
>> > But, I don't see traces be logged in the home directory (indeed nothing
>> > happens, i.e, not even the creation of the base directory ->
>> lttng-traces).
>> > Am I missing anything because of that LTTng is failing to log traces?
>> > Please help.
>> >
>> > Regards, Vivek
>> >
>> >
>> > --
>> > Best, Vivek
>> >
>> >
>> > This body part will be downloaded on demand.
>>
>
>
>
> --
> Best, Vivek




-- 
Best, Vivek

--047d7b6dcf4650264004d620e3e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hi David,</div><div>=C2=A0</div><div>Any update?</div><div>=C2=A0</div=
><div>Please let me know if more info is required.</div><div>=C2=A0</div><d=
iv>Regards, Vivek<br><br></div><div class=3D"gmail_quote">On Mon, Feb 18, 2=
013 at 4:26 PM, Vivek Kumar <span dir=3D"ltr">&lt;<a href=3D"mailto:vivekku=
mar.p@gmail.com" target=3D"_blank">vivekkumar.p@gmail.com</a>&gt;</span> wr=
ote:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;padding-left:1ex;border-left-=
color:rgb(204,204,204);border-left-width:1px;border-left-style:solid" class=
=3D"gmail_quote"><div>Hi David,</div><div>=C2=A0</div><div>Thanks for the r=
esponse. LTTng-ust is also ported.</div>
<div>Please find attached the PPT where I have taken the snaps and describe=
d the issue faced.</div><div>At present I am trying to port and=C2=A0instru=
ment LTTng for userspace only. =C2=A0</div>
<div>=C2=A0</div><div>My SoC is ARM-Cortex A9 from Mindspeed and the os is =
openWRT Linux.</div><div>=C2=A0</div><div>LTTng doesn&#39;t report any issu=
e when I run it to instrument in userspace but CTF is not logged in the Hom=
e directory, please take a look to the powerpoint slides for descriptions a=
nd commands that I give.</div>

<div>=C2=A0</div><div>Regards, Vivek</div><div class=3D"HOEnZb"><div class=
=3D"h5"><div><br><br>=C2=A0</div><div class=3D"gmail_quote">On Fri, Feb 15,=
 2013 at 7:59 PM, David Goulet <span dir=3D"ltr">&lt;<a href=3D"mailto:dgou=
let@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;</span> wro=
te:<br>

<blockquote style=3D"margin:0px 0px 0px 0.8ex;padding-left:1ex;border-left-=
color:rgb(204,204,204);border-left-width:1px;border-left-style:solid" class=
=3D"gmail_quote">Hi Vivek,<br>
<br>
In order to collect a trace you need to instrument your application with<br=
>
LTTng-UST tracepoints.<br>
<br>
If you like to gather the syscalls for instance, you need to install the<br=
>
LTTng modules and start your session daemon as root.<br>
<br>
If you are still experiencing problem, please provide the commands you<br>
use and setup.<br>
<br>
Thanks!<br>
David<br>
<br>
Vivek Kumar:<br>
<div><div>&gt; Hi,<br>
&gt;<br>
&gt; I am trying to port LTTng to my arm based board.<br>
&gt; For userspace tracing, I have been able to successfully port following=
s:<br>
&gt; LTTng-tools,<br>
&gt; LTT-ust Library<br>
&gt; Userspace-rcu<br>
&gt; libpopt<br>
&gt;<br>
&gt; Now I can see that lttng-sessiond is running, and am able to create<br=
>
&gt; sessions, enable-event and start and stop tracing.<br>
&gt; But, I don&#39;t see traces be logged in the home directory (indeed no=
thing<br>
&gt; happens, i.e, not even the creation of the base directory -&gt; lttng-=
traces).<br>
&gt; Am I missing anything because of that LTTng is failing to log traces?<=
br>
&gt; Please help.<br>
&gt;<br>
&gt; Regards, Vivek<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best, Vivek<br>
&gt;<br>
&gt;<br>
</div></div>&gt; This body part will be downloaded on demand.<br>
</blockquote></div><br><br clear=3D"all"><br></div></div><span class=3D"HOE=
nZb"><font color=3D"#888888">-- <br>Best, Vivek
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Best, Viv=
ek

--047d7b6dcf4650264004d620e3e5--


--===============0730727009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0730727009==--
