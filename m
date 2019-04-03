From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Re: Creating custom application
Date: Wed, 3 Apr 2019 09:08:45 -0400
Message-ID: <CAJyWpKFxRqsVYc=dDvaoTMGkrkLmktaudYJgvVkzzvUyeFx-NQ__23432.9114014812$1554296953$gmane$org@mail.gmail.com>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
 <20190326152942.GE17481@joraj-alpa>
 <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
 <20190327175251.GA7976@joraj-alpa>
 <CAJyWpKEhLdREuCFJEfSojHuqQ9jTA12SWE_FAJ3HTdP1irO-sw@mail.gmail.com>
 <20190402211757.GA23381@joraj-alpa>
 <CAJyWpKGDrF9J=yDALm+1cn7cTd+TJZK30tXLHKKKXvkntmQDoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6595218540099471726=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by lists.lttng.org (Postfix) with ESMTPS id 44Z5xj4D3Mz1JyV
 for <lttng-dev@lists.lttng.org>; Wed,  3 Apr 2019 09:08:57 -0400 (EDT)
Received: by mail-io1-xd2d.google.com with SMTP id b9so13963361iot.13
 for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2019 06:08:57 -0700 (PDT)
In-Reply-To: <CAJyWpKGDrF9J=yDALm+1cn7cTd+TJZK30tXLHKKKXvkntmQDoQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6595218540099471726==
Content-Type: multipart/alternative; boundary="000000000000c5f99205859ff487"

--000000000000c5f99205859ff487
Content-Type: text/plain; charset="UTF-8"

Hello,

Sorry, I should be more specific. I am creating a custom yocto build. I
have seen some examples where systemd is utilized to start the sessiond as
a service. The limitation I have is that I don't want to include the whole
lttng-tools librray in my build. I understand that the sessiond is an
executable, I am just unsure how I could build or get this in my build.
Moving forward from this I could use fork/exec to daemonize which would be
simple.
Is there perhaps a existing recipe?

Regards,
Mosleh

On Tue, Apr 2, 2019 at 6:01 PM Mosleh Uddin <mosleh1235@gmail.com> wrote:

> Hi,
>
> That makes complete sense. I was more curious about the sessiond
> executable. I'm guessing this is something I will have to create along with
> my build?
>
> Regards,
> Mosleh
>
> On Tue, Apr 2, 2019 at 5:18 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
>
>> On Tue, Apr 02, 2019 at 04:54:00PM -0400, Mosleh Uddin wrote:
>> > Hello,
>> >
>> > Could you give me some more insight into spawning my own sessiond? Sorry
>> > I'm not completely clear on the topic.
>> > Thank you for all your assistance.
>>
>> Normally lttng-sessiond is treated as a "server/service/daemon" (think
>> http
>> server as apache) and is *normally* launched as a daemon
>> (systemd/sysVinit) at
>> boot time.
>>
>> Managing manually the lifetime of a lttng-sessiond process is done the
>> same way
>> as any other process. You can manage it via the command line
>> (./lttng-sessiond), via a
>> service manager (systemd/upstart etc.) or with a custom service manager (a
>> python script/c etc.).
>>
>> You could spawn a lttng-sessiond from your application with the
>> appropriate
>> parameters set to isolate it if you need. LTTNG_HOME is an important one.
>> The
>> output directory also can be manipulated. See man lttng-sessiond for more
>> details. You will need to manage the process or leave it to a system
>> administrator and only active tracing when a sessiond is present for
>> example.
>>
>> Cheers
>>
>> >
>> > Regards,
>> > Mosleh
>> >
>> > On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien <
>> > jonathan.rajotte-julien@efficios.com> wrote:
>> >
>> > > Hi Mosleh,
>> > >
>> > > On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:
>> > > > Hello,
>> > > >
>> > > > Thank you for the quick response. I was able to use the
>> documentation you
>> > > > provided to start a session and get tracepoint list. I do have some
>> > > > follow-up questions:
>> > > >
>> > > > 1) I needed to create a session daemon before executing my custom
>> > > > application. In the API I did see functionality to see if a daemon
>> is
>> > > > active, however, it is possible to spawn a session daemon in my
>> custom
>> > > app?
>> > >
>> > > liblttng-ctl does not expose a lttng-sessiond spawning function since
>> by
>> > > definition it is a daemon executable (think apache,mysql etc.), you
>> will
>> > > have to
>> > > use system/popen/exec.. to spawn the lttng-sessiond process etc. if
>> you
>> > > want to
>> > > control its lifetime using your custom application.
>> > >
>> > > >
>> > > > 2) I am able to get a list of active traces lttng can see in
>> userspace, I
>> > > > enable all the traces and start tracing. The traces however seem to
>> not
>> > > be
>> > > > written anywhere on my filesystem. Do I have to specify a location?
>> Or
>> > > am I
>> > > > missing something? My current flow is:
>> > >
>> > > Please refer to the create command. If outputting locally you will
>> need to
>> > > pass
>> > > a "file://...." url to lttng_create_session.
>> > >
>> > > You can check on the result for each steps using "lttng list" and
>> "lttng
>> > > list
>> > > <session_name>" as you go to troubleshot your setup script.
>> > >
>> > > While debugging you can also start the lttng-sessiond in verbose mode
>> to
>> > > understand what is going on.
>> > >
>> > > Also note that you could also use the lttng "load" api if the session
>> you
>> > > are
>> > > trying to load is "static" and always the same. You would only need to
>> > > ship an
>> > > xml file with your application.
>> > >
>> > > Cheers
>> > >
>> > > >
>> > > >    - Creating a session
>> > > >    - Specifying the domain
>> > > >    - Creating a handle
>> > > >    - Creating a channel (with default attributes)
>> > > >    - Enabling the channel
>> > > >    - Enabling event (for all traces)
>> > > >    - Start tracing
>> > > >
>> > > > Thanks again for all the assistance.
>> > > >
>> > > > Regards,
>> > > > Mosleh
>> > > >
>> > > > On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien <
>> > > > jonathan.rajotte-julien@efficios.com> wrote:
>> > > >
>> > >
>>
>> --
>> Jonathan Rajotte-Julien
>> EfficiOS
>>
>

--000000000000c5f99205859ff487
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Sorry, I should be more specific=
. I am creating a custom yocto build. I have seen some examples where syste=
md is utilized to start the sessiond as a service. The limitation I have is=
 that I don&#39;t want to include the whole lttng-tools librray in my build=
. I understand that the sessiond is an executable, I am just unsure how I c=
ould build or get this in my build. Moving forward from this I could use fo=
rk/exec to daemonize which would be simple.=C2=A0</div><div>Is there perhap=
s a existing recipe?</div><div><br></div><div>Regards,</div><div>Mosleh</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Apr 2, 2019 at 6:01 PM Mosleh Uddin &lt;<a href=3D"mailto:mosleh1=
235@gmail.com">mosleh1235@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>=
That makes complete sense. I was more curious about the sessiond executable=
. I&#39;m guessing this is something I will have to create along with my bu=
ild?=C2=A0</div><div><br></div><div>Regards,</div><div>Mosleh</div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Apr 2, 2019 at 5:18 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonath=
an.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@e=
fficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Apr 02, 2019 at 04:54:00PM -0400, Mosleh Uddin wrote:<br=
>
&gt; Hello,<br>
&gt; <br>
&gt; Could you give me some more insight into spawning my own sessiond? Sor=
ry<br>
&gt; I&#39;m not completely clear on the topic.<br>
&gt; Thank you for all your assistance.<br>
<br>
Normally lttng-sessiond is treated as a &quot;server/service/daemon&quot; (=
think http<br>
server as apache) and is *normally* launched as a daemon (systemd/sysVinit)=
 at<br>
boot time.<br>
<br>
Managing manually the lifetime of a lttng-sessiond process is done the same=
 way<br>
as any other process. You can manage it via the command line (./lttng-sessi=
ond), via a<br>
service manager (systemd/upstart etc.) or with a custom service manager (a<=
br>
python script/c etc.).<br>
<br>
You could spawn a lttng-sessiond from your application with the appropriate=
<br>
parameters set to isolate it if you need. LTTNG_HOME is an important one. T=
he<br>
output directory also can be manipulated. See man lttng-sessiond for more<b=
r>
details. You will need to manage the process or leave it to a system<br>
administrator and only active tracing when a sessiond is present for exampl=
e.<br>
<br>
Cheers<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Mosleh<br>
&gt; <br>
&gt; On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien &lt;<br>
&gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_bla=
nk">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi Mosleh,<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:<br>
&gt; &gt; &gt; Hello,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thank you for the quick response. I was able to use the docu=
mentation you<br>
&gt; &gt; &gt; provided to start a session and get tracepoint list. I do ha=
ve some<br>
&gt; &gt; &gt; follow-up questions:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 1) I needed to create a session daemon before executing my c=
ustom<br>
&gt; &gt; &gt; application. In the API I did see functionality to see if a =
daemon is<br>
&gt; &gt; &gt; active, however, it is possible to spawn a session daemon in=
 my custom<br>
&gt; &gt; app?<br>
&gt; &gt;<br>
&gt; &gt; liblttng-ctl does not expose a lttng-sessiond spawning function s=
ince by<br>
&gt; &gt; definition it is a daemon executable (think apache,mysql etc.), y=
ou will<br>
&gt; &gt; have to<br>
&gt; &gt; use system/popen/exec.. to spawn the lttng-sessiond process etc. =
if you<br>
&gt; &gt; want to<br>
&gt; &gt; control its lifetime using your custom application.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 2) I am able to get a list of active traces lttng can see in=
 userspace, I<br>
&gt; &gt; &gt; enable all the traces and start tracing. The traces however =
seem to not<br>
&gt; &gt; be<br>
&gt; &gt; &gt; written anywhere on my filesystem. Do I have to specify a lo=
cation? Or<br>
&gt; &gt; am I<br>
&gt; &gt; &gt; missing something? My current flow is:<br>
&gt; &gt;<br>
&gt; &gt; Please refer to the create command. If outputting locally you wil=
l need to<br>
&gt; &gt; pass<br>
&gt; &gt; a &quot;file://....&quot; url to lttng_create_session.<br>
&gt; &gt;<br>
&gt; &gt; You can check on the result for each steps using &quot;lttng list=
&quot; and &quot;lttng<br>
&gt; &gt; list<br>
&gt; &gt; &lt;session_name&gt;&quot; as you go to troubleshot your setup sc=
ript.<br>
&gt; &gt;<br>
&gt; &gt; While debugging you can also start the lttng-sessiond in verbose =
mode to<br>
&gt; &gt; understand what is going on.<br>
&gt; &gt;<br>
&gt; &gt; Also note that you could also use the lttng &quot;load&quot; api =
if the session you<br>
&gt; &gt; are<br>
&gt; &gt; trying to load is &quot;static&quot; and always the same. You wou=
ld only need to<br>
&gt; &gt; ship an<br>
&gt; &gt; xml file with your application.<br>
&gt; &gt;<br>
&gt; &gt; Cheers<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a session<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 - Specifying the domain<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a handle<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a channel (with default attributes)<=
br>
&gt; &gt; &gt;=C2=A0 =C2=A0 - Enabling the channel<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 - Enabling event (for all traces)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 - Start tracing<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks again for all the assistance.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; Mosleh<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien &lt=
;<br>
&gt; &gt; &gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" targ=
et=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>
</blockquote></div>

--000000000000c5f99205859ff487--

--===============6595218540099471726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6595218540099471726==--
