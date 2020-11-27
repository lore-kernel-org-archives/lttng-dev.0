Return-Path: <SRS0=ImaU=FB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B07C63798
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 16:04:36 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49ED4208D5
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="nR6dbhz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ED4208D5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CjKFY2nHDz1Q2T;
	Fri, 27 Nov 2020 11:04:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606493074;
	bh=4vfGBh2bhbNNdbBF7Y6vOetyhWv8mjBzE6tFMfYV5XM=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nR6dbhz1I2APciEw0eiBsIK1R4K51RIJmtDKragPaRQVnYlOeXsMI9If+tiwaDBC6
	 4MZ52P1WVNhxGPQP0Y+1NT+whFK4bBQpTrjN3DcTJ+bAWerZN5O8WHNsm+Tkit5L69
	 KLX6l8h0lFCikdByfJn4nHAV4p1BjThwFlougSg+fNZvuIasns3TSNR1kb88DhnO0z
	 vJO6/dLNmsGC41oJ4lspTAMVnkey+0ytS5ziy+uStNGLNHo3GV8FNpJnBUJEZ0FRHy
	 6yQC1vn49fvfGCO84GvJcNBewvWtq3LfPSRjYbcGtvuFhmMw5Vbo3785J0lAWSo1M9
	 OP8wMMwJiWQZQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CjKFW4GHWz1Pl3
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2020 11:04:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 415C127C360
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2020 11:04:25 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id pJB04G2_6XAx; Fri, 27 Nov 2020 11:04:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1B3A827C593;
 Fri, 27 Nov 2020 11:04:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1B3A827C593
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id B7_0ArZQRytn; Fri, 27 Nov 2020 11:04:24 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 099C227C0F3;
 Fri, 27 Nov 2020 11:04:24 -0500 (EST)
Date: Fri, 27 Nov 2020 11:04:23 -0500 (EST)
To: =?utf-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <828264314.65604.1606493063962.JavaMail.zimbra@efficios.com>
In-Reply-To: <25e54ac4.4261.1760a553e88.Coremail.xiongyuhua@zju.edu.cn>
References: <40a80cf.2b99.176086d97b1.Coremail.xiongyuhua@zju.edu.cn>
 <20201127140548.GB3947@joraj-alpa>
 <25e54ac4.4261.1760a553e88.Coremail.xiongyuhua@zju.edu.cn>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - GC86 (Linux)/8.8.15_GA_3975)
Thread-Topic: Some confusion about cpu usage of the lttng-consumerd process
Thread-Index: yp5QYAUpKnzdSMpykx0c2/cDegrSAg==
Subject: Re: [lttng-dev] Some confusion about cpu usage of the
 lttng-consumerd process
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: multipart/mixed; boundary="===============1031602953658582660=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1031602953658582660==
Content-Type: multipart/alternative; 
	boundary="=_969e784f-864a-41e7-9b10-6df4f78292ab"

--=_969e784f-864a-41e7-9b10-6df4f78292ab
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> From: "=E7=86=8A=E6=AF=93=E5=8D=8E" <xiongyuhua@zju.edu.cn>
> To: "Jonathan Rajotte-Julien" <jonathan.rajotte-julien@efficios.com>,
> "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Friday, November 27, 2020 10:32:07 AM
> Subject: Re: Re: [lttng-dev] Some confusion about cpu usage of the
> lttng-consumerd process

> Hi=EF=BC=8CDear.

Side note, you can remove the "Dear" here. ;)=20

> The test script was used to generate some common fileIO,netIO events.

Please provide a complete code repository if possible. So that we can at le=
ast have a baseline for reproduction.=20

> On all servers, the monitoring strategy I set up when I start lttng is th=
e same,
> monitoring all fileIO, netIO and some related system calls.
> The following table records the amount of events generated by the test sc=
ript
> per minute, and one babeltrace record represents one event.

For some reason the image does not load here. Please provide a text based a=
lternative for this figure.=20

> The unit of the number is every ten thousand events per minute. And the n=
umber
> were read out after parsing by babeltrace.
> In addition, the server1 is 1core4G, server2 is 2core8G, server3 is 4core=
16G,
> server4 and server5 are 8core16G.

> It can be seen that the average amount of data generated per minute on al=
l
> servers is roughly the same.However, the CPU usage of the lttng-consumerd
> process behave differently on server4 and server5, as I mentioned in my l=
ast
> email.

> In addition, the usage of cpu is recorded using the "top" command.

> My test concluded that, while the same number of events collected,
> lttng-consumerd process need to consume more cpu on the 8-core server.

> I want to know why is this and what else information do you need?

Well we also want to know why! You will understand that albeit we develop l=
ttng we do not always have a quick and easy answer to all problems. Perform=
ance related problem are always tricky.=20
And we also have to keep in mind that we do not necessarily optimize for lo=
w-cpu usage on the lttng-consumerd side.=20

We have to take a look at what "work" scale with the number of CPU on the l=
ttng-consumerd side. One such thing is the live timer which is fired on an =
interval (default is 1s (1000000us)).=20

You could test this hypothesis by streaming the trace instead of using the =
live feature.=20

lttng create --set-url ....=20

Cheers=20

> Looking forward to your reply.
> thanks,
> yuhua.
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Jonathan Rajotte-Julien" < jonathan.rajot=
te-julien@efficios.com >
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: [ callto:2020-11-27 22 | 2020-11-=
27=C2=A022 ] :05:48 (=E6=98=9F=E6=9C=9F=E4=BA=94)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "=E7=86=8A=E6=AF=93=E5=8D=8E" < xiongyuhua=
@zju.edu.cn >
> > =E6=8A=84=E9=80=81: lttng-dev@lists.lttng.org
>> =E4=B8=BB=E9=A2=98: Re: [lttng-dev] Some confusion about cpu usage of th=
e lttng-consumerd
> > process

> > Hi,

> > On Fri, Nov 27 , 2020 at 02:39:28PM +0800, =E7=86=8A=E6=AF=93=E5=8D=8E =
via lttng-dev wrote:
> > > Hi=EF=BC=8Cdear.

>> > I have been using lttng to monitor my server these days=EF=BC=8Cbut I =
found something
> > > interesting.

> > > The cpu usage of lttng varies with the number of cpu cores of the ser=
ver.

> > Which is a bit expected since more CPU means more "data" source from th=
e point
> > of view of lttng hence more "work" overall.


>> > On the server, I create a tracing session in live mode, using "lttng c=
reate
> > > my-session --live".

>> > Then,I Start the babeltrace2 and configure it to connect to the relay
> > > daemon,using "--input-format=3Dlttng-live" mode.

> > > I used 5 cloud servers=EF=BC=8C1core4G 2core8G 4core16G 8core16G 8cor=
e16G.

> > > And,the same test script was executed above to provide the same workl=
oad.

> > We would need the test script to have some context here of the workload=
.


> > > As we all know,lttng has 5 processes,

> > > 1.lttng-runas --daemonize

>> > 2.lttng-runas -k --consumerd-cmd-sock /var/run/lttng/kconsumerd/comman=
d
> > > --consumerd-err-sock /var/run/lttng/kconsumerd/error --group tracing

> > Based on this you are performing kernel tracing.


> > > 3.lttng-sessiond --daemonize

> > > 4.lttng-relayd -L tcp://localhost:5344

>> > 5.lttng-consumerd -k --consumerd-cmd-sock /var/run/lttng/kconsumerd/co=
mmand
> > > --consumerd-err-sock /var/run/lttng/kconsumerd/error --group tracing


>> > The CPU usage of the first four processes is below 2% on the 5 servers=
,but the
> > > lttng-consumerd process is different.

>> > On 1-core=E3=80=812-core=E3=80=814-core servers=EF=BC=8Cthe CPU usage =
of the lttng-consumerd process is
> > > below 2%.

> > How is the cpu usage measured here?


>> > But on two 8-core machines, the cpu usage of the lttng-consumerd proce=
ss reached
> > > 10% or more.

> > Consumerd is responsible of "fetching" data from the ring buffers and "=
saving"
>> it either locally (trace on disk) or remotely (streaming/live session). =
CPU
> > usage
>> should be a bit correlated with the event production rate. Did you have =
a look
> > at the
> > number of events generated for a similar interval?

>> > And,the cpu usage of the babeltrace process is not much different,just=
 the cpu
>> > usage of the lttng-consumerd process varies with the number of cpu cor=
es of the
> > > server.

> > > Why it is like this=EF=BC=9FHow should this phenomenon be analyzed?

> > > Looking forward to your reply.

> > > thanks,
> > > yuhua

> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
>> > [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
> > > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]


> > --
> > Jonathan Rajotte-Julien
> > EfficiOS

--=_969e784f-864a-41e7-9b10-6df4f78292ab
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><hr id=3D"zwchr" data-marker=3D"_=
_DIVIDER__"><div data-marker=3D"__HEADERS__"><blockquote style=3D"border-le=
ft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weigh=
t:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial=
,sans-serif;font-size:12pt;"><b>From: </b>"=E7=86=8A=E6=AF=93=E5=8D=8E" &lt=
;xiongyuhua@zju.edu.cn&gt;<br><b>To: </b>"Jonathan Rajotte-Julien" &lt;jona=
than.rajotte-julien@efficios.com&gt;, "lttng-dev" &lt;lttng-dev@lists.lttng=
.org&gt;<br><b>Sent: </b>Friday, November 27, 2020 10:32:07 AM<br><b>Subjec=
t: </b>Re: Re: [lttng-dev] Some confusion about cpu usage of the lttng-cons=
umerd process<br></blockquote></div><div data-marker=3D"__QUOTED_TEXT__"><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div>Hi=EF=BC=8CDe=
ar.</div></blockquote><div><br></div><div>Side note, you can remove the "De=
ar" here. ;)</div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;"><div><br>
<br>
The test script was used to generate some common fileIO,netIO events.</div>=
</blockquote><div><br></div><div>Please provide a complete code repository =
if possible. So that we can at least have a baseline for reproduction.</div=
><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;"><div><br>
<br>
On all servers, the monitoring strategy I set up when I start lttng is the =
same, monitoring all fileIO, netIO and some related system calls.&nbsp;<br>
The following table records the amount of events generated by the test scri=
pt per minute, and one babeltrace record represents one event.<br>
<p>
=09<img width=3D"800" height=3D"256" title=3D"" align=3D"" alt=3D"" style=
=3D"white-space: normal;" src=3D"https://mail.zju.edu.cn/coremail/s/json?fu=
nc=3Dmbox:getComposeData&amp;sid=3D*&amp;composeId=3D1606487214111&amp;atta=
chId=3D2" saveddisplaymode=3D""></p></div></blockquote><div><br></div><div>=
For some reason the image does not load here. Please provide a text based a=
lternative for this figure.</div><div><br data-mce-bogus=3D"1"></div><block=
quote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5=
px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fon=
t-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div><p>
</p>
<p>
=09The unit of the number is every ten thousand events per minute. And the =
number were read out after parsing by babeltrace.<br>
In addition, the server1 is 1core4G, server2 is 2core8G, server3 is 4core16=
G, server4 and server5 are 8core16G.<br>
<br>
It can be seen that the average amount of data generated per minute on all =
servers is roughly the same.However, the CPU usage of the lttng-consumerd p=
rocess behave differently on server4 and server5, as I mentioned in my last=
 email.
</p>
<p>
=09<br>
In addition, the usage of cpu is recorded using the "top" command.
</p>
<p>
=09<br>
</p>
<p>
=09My test concluded that, while the same number of events collected, lttng=
-consumerd process need to consume more cpu on the 8-core server.<br>
<br>
I want to know why is this and what else information do you need?</p></div>=
</blockquote><div><br></div><div>Well we also want to know why! You will un=
derstand that albeit we develop lttng we do not always have a quick and eas=
y answer to all problems. Performance related problem are always tricky.</d=
iv><div>And we also have to keep in mind that we do not necessarily optimiz=
e for low-cpu usage on the lttng-consumerd side.&nbsp;</div><div><br data-m=
ce-bogus=3D"1"></div><div>We have to take a look at what "work" scale with =
the number of CPU on the lttng-consumerd side. One such thing is the live t=
imer which is fired on an interval (default is 1s (1000000us)).</div><div><=
br data-mce-bogus=3D"1"></div><div>You could test this hypothesis by stream=
ing the trace instead of using the live feature.</div><div><br data-mce-bog=
us=3D"1"></div><div>lttng create --set-url ....</div><div><br data-mce-bogu=
s=3D"1"></div><div>Cheers</div><blockquote style=3D"border-left:2px solid #=
1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt;"><div><p><br>
<br>
Looking forward to your reply.<br>
thanks,<br>
yuhua.
</p>
<br>
&gt;&nbsp;-----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----<br>
&gt;&nbsp;=E5=8F=91=E4=BB=B6=E4=BA=BA:&nbsp;"Jonathan&nbsp;Rajotte-Julien"&=
nbsp;&lt;<span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_DWT61_ZmEmai=
lObjectHandler"><span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_DWT68=
_ZmEmailObjectHandler">jonathan.rajotte-julien@efficios.com</span></span>&g=
t;<br>
&gt;&nbsp;=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:&nbsp;<span class=3D"Object"=
 role=3D"link" id=3D"OBJ_PREFIX_DWT62_com_zimbra_phone"><a href=3D"callto:2=
020-11-27 22" onclick=3D"window.top.Com_Zimbra_Phone.unsetOnbeforeunload()"=
>2020-11-27&nbsp;22</a></span>:05:48&nbsp;(=E6=98=9F=E6=9C=9F=E4=BA=94)<br>
&gt;&nbsp;=E6=94=B6=E4=BB=B6=E4=BA=BA:&nbsp;"=E7=86=8A=E6=AF=93=E5=8D=8E"&n=
bsp;&lt;<span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_DWT63_ZmEmail=
ObjectHandler"><span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_DWT69_=
ZmEmailObjectHandler">xiongyuhua@zju.edu.cn</span></span>&gt;<br>
&gt;&nbsp;=E6=8A=84=E9=80=81:&nbsp;<span class=3D"Object" role=3D"link" id=
=3D"OBJ_PREFIX_DWT64_ZmEmailObjectHandler"><span class=3D"Object" role=3D"l=
ink" id=3D"OBJ_PREFIX_DWT70_ZmEmailObjectHandler">lttng-dev@lists.lttng.org=
</span></span><br>
&gt;&nbsp;=E4=B8=BB=E9=A2=98:&nbsp;Re:&nbsp;[lttng-dev]&nbsp;Some&nbsp;conf=
usion&nbsp;about&nbsp;cpu&nbsp;usage&nbsp;of&nbsp;the&nbsp;lttng-consumerd&=
nbsp;process<br>
&gt;&nbsp;<br>
&gt;&nbsp;Hi,<br>
&gt;&nbsp;<br>
&gt;&nbsp;On&nbsp;<span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_DWT=
65_com_zimbra_date"><span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_D=
WT71_com_zimbra_date">Fri,&nbsp;Nov&nbsp;27</span></span>,&nbsp;2020&nbsp;a=
t&nbsp;02:39:28PM&nbsp;+0800,&nbsp;=E7=86=8A=E6=AF=93=E5=8D=8E&nbsp;via&nbs=
p;lttng-dev&nbsp;wrote:<br>
&gt;&nbsp;&gt;&nbsp;Hi=EF=BC=8Cdear.<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;I&nbsp;have&nbsp;been&nbsp;using&nbsp;lttng&nbsp;to&nbs=
p;monitor&nbsp;my&nbsp;server&nbsp;these&nbsp;days=EF=BC=8Cbut&nbsp;I&nbsp;=
found&nbsp;something&nbsp;interesting.<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;The&nbsp;cpu&nbsp;usage&nbsp;of&nbsp;lttng&nbsp;varies&=
nbsp;with&nbsp;the&nbsp;number&nbsp;of&nbsp;cpu&nbsp;cores&nbsp;of&nbsp;the=
&nbsp;server.<br>
&gt;&nbsp;<br>
&gt;&nbsp;Which&nbsp;is&nbsp;a&nbsp;bit&nbsp;expected&nbsp;since&nbsp;more&=
nbsp;CPU&nbsp;means&nbsp;more&nbsp;"data"&nbsp;source&nbsp;from&nbsp;the&nb=
sp;point<br>
&gt;&nbsp;of&nbsp;view&nbsp;of&nbsp;lttng&nbsp;hence&nbsp;more&nbsp;"work"&=
nbsp;overall.<br>
&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;On&nbsp;the&nbsp;server,&nbsp;I&nbsp;create&nbsp;a&nbsp=
;tracing&nbsp;session&nbsp;in&nbsp;live&nbsp;mode,&nbsp;using&nbsp;"lttng&n=
bsp;create&nbsp;my-session&nbsp;--live".&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;Then,I&nbsp;Start&nbsp;the&nbsp;babeltrace2&nbsp;and&nb=
sp;configure&nbsp;it&nbsp;to&nbsp;connect&nbsp;to&nbsp;the&nbsp;relay&nbsp;=
daemon,using&nbsp;"--input-format=3Dlttng-live"&nbsp;mode.<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;I&nbsp;used&nbsp;5&nbsp;cloud&nbsp;servers=EF=BC=8C1cor=
e4G&nbsp;2core8G&nbsp;4core16G&nbsp;8core16G&nbsp;8core16G.<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;And,the&nbsp;same&nbsp;test&nbsp;script&nbsp;was&nbsp;e=
xecuted&nbsp;above&nbsp;to&nbsp;provide&nbsp;the&nbsp;same&nbsp;workload.<b=
r>
&gt;&nbsp;<br>
&gt;&nbsp;We&nbsp;would&nbsp;need&nbsp;the&nbsp;test&nbsp;script&nbsp;to&nb=
sp;have&nbsp;some&nbsp;context&nbsp;here&nbsp;of&nbsp;the&nbsp;workload.<br=
>
&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;As&nbsp;we&nbsp;all&nbsp;know,lttng&nbsp;has&nbsp;5&nbs=
p;processes,<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;1.lttng-runas&nbsp;&nbsp;&nbsp;&nbsp;--daemonize<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;2.lttng-runas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-k&nbs=
p;--consumerd-cmd-sock&nbsp;/var/run/lttng/kconsumerd/command&nbsp;--consum=
erd-err-sock&nbsp;/var/run/lttng/kconsumerd/error&nbsp;--group&nbsp;tracing=
<br>
&gt;&nbsp;<br>
&gt;&nbsp;Based&nbsp;on&nbsp;this&nbsp;you&nbsp;are&nbsp;performing&nbsp;ke=
rnel&nbsp;tracing.<br>
&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;3.lttng-sessiond&nbsp;--daemonize<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;4.lttng-relayd&nbsp;-L&nbsp;tcp://localhost:5344<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;5.lttng-consumerd&nbsp;&nbsp;-k&nbsp;--consumerd-cmd-so=
ck&nbsp;/var/run/lttng/kconsumerd/command&nbsp;--consumerd-err-sock&nbsp;/v=
ar/run/lttng/kconsumerd/error&nbsp;--group&nbsp;tracing<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;The&nbsp;CPU&nbsp;usage&nbsp;of&nbsp;the&nbsp;first&nbs=
p;four&nbsp;processes&nbsp;is&nbsp;below&nbsp;2%&nbsp;on&nbsp;the&nbsp;5&nb=
sp;servers,but&nbsp;the&nbsp;lttng-consumerd&nbsp;process&nbsp;is&nbsp;diff=
erent.<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;On&nbsp;1-core=E3=80=812-core=E3=80=814-core&nbsp;serve=
rs=EF=BC=8Cthe&nbsp;CPU&nbsp;usage&nbsp;of&nbsp;the&nbsp;lttng-consumerd&nb=
sp;process&nbsp;is&nbsp;below&nbsp;2%.<br>
&gt;&nbsp;<br>
&gt;&nbsp;How&nbsp;is&nbsp;the&nbsp;cpu&nbsp;usage&nbsp;measured&nbsp;here?=
<br>
&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;But&nbsp;on&nbsp;two&nbsp;8-core&nbsp;machines,&nbsp;th=
e&nbsp;cpu&nbsp;usage&nbsp;of&nbsp;the&nbsp;lttng-consumerd&nbsp;process&nb=
sp;reached&nbsp;10%&nbsp;or&nbsp;more.<br>
&gt;&nbsp;<br>
&gt;&nbsp;Consumerd&nbsp;is&nbsp;responsible&nbsp;of&nbsp;"fetching"&nbsp;d=
ata&nbsp;from&nbsp;the&nbsp;ring&nbsp;buffers&nbsp;and&nbsp;"saving"<br>
&gt;&nbsp;it&nbsp;either&nbsp;locally&nbsp;(trace&nbsp;on&nbsp;disk)&nbsp;o=
r&nbsp;remotely&nbsp;(streaming/live&nbsp;session).&nbsp;CPU&nbsp;usage<br>
&gt;&nbsp;should&nbsp;be&nbsp;a&nbsp;bit&nbsp;correlated&nbsp;with&nbsp;the=
&nbsp;event&nbsp;production&nbsp;rate.&nbsp;Did&nbsp;you&nbsp;have&nbsp;a&n=
bsp;look&nbsp;at&nbsp;the<br>
&gt;&nbsp;number&nbsp;of&nbsp;events&nbsp;generated&nbsp;for&nbsp;a&nbsp;si=
milar&nbsp;interval?<br>
&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;And,the&nbsp;cpu&nbsp;usage&nbsp;of&nbsp;the&nbsp;babel=
trace&nbsp;process&nbsp;is&nbsp;not&nbsp;much&nbsp;different,just&nbsp;the&=
nbsp;cpu&nbsp;usage&nbsp;of&nbsp;the&nbsp;lttng-consumerd&nbsp;process&nbsp=
;varies&nbsp;with&nbsp;the&nbsp;number&nbsp;of&nbsp;cpu&nbsp;cores&nbsp;of&=
nbsp;the&nbsp;server.<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;Why&nbsp;it&nbsp;is&nbsp;like&nbsp;this=EF=BC=9FHow&nbs=
p;should&nbsp;this&nbsp;phenomenon&nbsp;be&nbsp;analyzed?<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;Looking&nbsp;forward&nbsp;to&nbsp;your&nbsp;reply.<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;thanks,<br>
&gt;&nbsp;&gt;&nbsp;yuhua<br>
&gt;&nbsp;&gt;&nbsp;<br>
&gt;&nbsp;&gt;&nbsp;_______________________________________________<br>
&gt;&nbsp;&gt;&nbsp;lttng-dev&nbsp;mailing&nbsp;list<br>
&gt;&nbsp;&gt;&nbsp;<span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_D=
WT66_ZmEmailObjectHandler"><span class=3D"Object" role=3D"link" id=3D"OBJ_P=
REFIX_DWT72_ZmEmailObjectHandler">lttng-dev@lists.lttng.org</span></span><b=
r>
&gt;&nbsp;&gt;&nbsp;<span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_D=
WT67_com_zimbra_url"><span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_=
DWT73_com_zimbra_url"><a target=3D"_blank" href=3D"https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a></span></span><br>
&gt;&nbsp;<br>
&gt;&nbsp;<br>
&gt;&nbsp;--&nbsp;<br>
&gt;&nbsp;Jonathan&nbsp;Rajotte-Julien<br>
&gt;&nbsp;EfficiOS<br>
<br>
</div><br></blockquote></div></div></body></html>
--=_969e784f-864a-41e7-9b10-6df4f78292ab--

--===============1031602953658582660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1031602953658582660==--
