From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: multiple tracing sessions using relayd
Date: Tue, 11 Nov 2014 07:35:52 +0530
Message-ID: <CAM5kDqwz4_q2qfZ-SOhd=ic2QZ-tZ37ACEuu8cVdvJ3mRu8DDw__23205.8096131825$1415671606$gmane$org@mail.gmail.com>
References: <CAM5kDqxUdQtOEQb=wYO6tzB3z=Vboe66B=Ky0KW4ZkbS6OfySQ@mail.gmail.com>
 <CA+jJMxttLJ96e5ythsUSBfD0nt8bdHL+wXPwkgEMAS6tELksuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1511571244=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Xo0qE-0003Y0-Km
 for lttng-dev@lists.lttng.org; Mon, 10 Nov 2014 21:06:01 -0500
Received: by mail-wg0-f43.google.com with SMTP id y10so10382666wgg.30
 for <lttng-dev@lists.lttng.org>; Mon, 10 Nov 2014 18:05:53 -0800 (PST)
In-Reply-To: <CA+jJMxttLJ96e5ythsUSBfD0nt8bdHL+wXPwkgEMAS6tELksuQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1511571244==
Content-Type: multipart/alternative; boundary=f46d0442885c0882c705078bb8af

--f46d0442885c0882c705078bb8af
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm using 2.4.1 version. And I'm trying to relay all the sessions.

If a user is creating multiple sessions, is it required to run multiple
session daemons ?

Can you please send me the config you have used.

Thanks
Anand Neeli
On 10 Nov 2014 23:32, "J=C3=A9r=C3=A9mie Galarneau" <jeremie.galarneau@effi=
cios.com>
wrote:

> On Sat, Nov 8, 2014 at 1:31 PM, Anand Neeli <anand.neeli@gmail.com> wrote=
:
> > Hi,
> > i'm trying to create multiple tracing sessions which will relay to the
> same
> > relayd.
> > And i'm not able to create more than one session.
> > create channel of the second session hangs and doesn't give me the
> console
> > back.
> >
> > Here are the steps i followed
> > $> lttng-relayd -d -g mygrp
> >
> >  $> /usr/bin/lttng-sessiond --consumerd32-path
> > /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/
> > --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd
> > --consumerd64-libdir /usr/lib64/ -b --no-kernel -g mygrp
> > Warning: No tracing group detected
> >
> > $> /usr/bin/lttng create mysession  --live 1000000 -U net://128.0.0.4
> > Session mysession created.
> > Traces will be written in net://128.0.0.4
> > Live timer set to 1000000 usec
> >
> >  $> /usr/bin/lttng enable-channel mychannel --userspace --buffers-pid -=
s
> > mysession --tracefile-size 8388608 --tracefile-count 8Warning: No traci=
ng
> > group detected
> > Warning: No tracing group detected
> > UST channel mychannel enabled for session mysession
> >
> >  $> /usr/bin/lttng enable-event --channel mychannel --userspace --all
> > --exclude 'ust_libc:*' -s mysession
> > All UST events excluding ust_libc:* are enabled in channel mychannel
> >
> > =3D=3D> With this first session is created. Now i'm trying to create an=
other
> > session.
> >
> >  $>  /usr/bin/lttng create mysession2  --live 1000000 -U net://128.0.0.=
4
> > Session mysession2 created.
> > Traces will be written in net://128.0.0.4
> > Live timer set to 1000000 usec
> >
> >  $>  /usr/bin/lttng enable-channel mychannel2 --userspace --buffers-pid
> -s
> > mysession2 --tracefile-size 8388608 --tracefile-count 8
> >
> > =3D=3D>>>> Console is stuck here and the command never returns.
> >
>
> I can't reproduce this problem on master here. Which version are you usin=
g?
>
> >
> > I tried to create same without relayd and it works. Am i missing anythi=
ng
> > here?
> >
> > Although in the above example i'm enabling same/all events in session1
> and
> > session2, but i think this should work and capture same events in both
> the
> > sessions.
>
> That's the expected behavior.
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> > Please let me know the correct way to enable this.
> >
> > Thanks,
> > Anand Neeli
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--f46d0442885c0882c705078bb8af
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I&#39;m using 2.4.1 version. And I&#39;m trying to relay all=
 the sessions.</p>
<p dir=3D"ltr">If a user is creating multiple sessions, is it required to r=
un multiple session daemons ?</p>
<p dir=3D"ltr">Can you please send me the config you have used.</p>
<p dir=3D"ltr">Thanks<br>
Anand Neeli</p>
<div class=3D"gmail_quote">On 10 Nov 2014 23:32, &quot;J=C3=A9r=C3=A9mie Ga=
larneau&quot; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie=
.galarneau@efficios.com</a>&gt; wrote:<br type=3D"attribution"><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On Sat, Nov 8, 2014 at 1:31 PM, Anand Neeli &lt;<a href=
=3D"mailto:anand.neeli@gmail.com">anand.neeli@gmail.com</a>&gt; wrote:<br>
&gt; Hi,<br>
&gt; i&#39;m trying to create multiple tracing sessions which will relay to=
 the same<br>
&gt; relayd.<br>
&gt; And i&#39;m not able to create more than one session.<br>
&gt; create channel of the second session hangs and doesn&#39;t give me the=
 console<br>
&gt; back.<br>
&gt;<br>
&gt; Here are the steps i followed<br>
&gt; $&gt; lttng-relayd -d -g mygrp<br>
&gt;<br>
&gt;=C2=A0 $&gt; /usr/bin/lttng-sessiond --consumerd32-path<br>
&gt; /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/<=
br>
&gt; --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd<br>
&gt; --consumerd64-libdir /usr/lib64/ -b --no-kernel -g mygrp<br>
&gt; Warning: No tracing group detected<br>
&gt;<br>
&gt; $&gt; /usr/bin/lttng create mysession=C2=A0 --live 1000000 -U net://<a=
 href=3D"http://128.0.0.4" target=3D"_blank">128.0.0.4</a><br>
&gt; Session mysession created.<br>
&gt; Traces will be written in net://<a href=3D"http://128.0.0.4" target=3D=
"_blank">128.0.0.4</a><br>
&gt; Live timer set to 1000000 usec<br>
&gt;<br>
&gt;=C2=A0 $&gt; /usr/bin/lttng enable-channel mychannel --userspace --buff=
ers-pid -s<br>
&gt; mysession --tracefile-size 8388608 --tracefile-count 8Warning: No trac=
ing<br>
&gt; group detected<br>
&gt; Warning: No tracing group detected<br>
&gt; UST channel mychannel enabled for session mysession<br>
&gt;<br>
&gt;=C2=A0 $&gt; /usr/bin/lttng enable-event --channel mychannel --userspac=
e --all<br>
&gt; --exclude &#39;ust_libc:*&#39; -s mysession<br>
&gt; All UST events excluding ust_libc:* are enabled in channel mychannel<b=
r>
&gt;<br>
&gt; =3D=3D&gt; With this first session is created. Now i&#39;m trying to c=
reate another<br>
&gt; session.<br>
&gt;<br>
&gt;=C2=A0 $&gt;=C2=A0 /usr/bin/lttng create mysession2=C2=A0 --live 100000=
0 -U net://<a href=3D"http://128.0.0.4" target=3D"_blank">128.0.0.4</a><br>
&gt; Session mysession2 created.<br>
&gt; Traces will be written in net://<a href=3D"http://128.0.0.4" target=3D=
"_blank">128.0.0.4</a><br>
&gt; Live timer set to 1000000 usec<br>
&gt;<br>
&gt;=C2=A0 $&gt;=C2=A0 /usr/bin/lttng enable-channel mychannel2 --userspace=
 --buffers-pid -s<br>
&gt; mysession2 --tracefile-size 8388608 --tracefile-count 8<br>
&gt;<br>
&gt; =3D=3D&gt;&gt;&gt;&gt; Console is stuck here and the command never ret=
urns.<br>
&gt;<br>
<br>
I can&#39;t reproduce this problem on master here. Which version are you us=
ing?<br>
<br>
&gt;<br>
&gt; I tried to create same without relayd and it works. Am i missing anyth=
ing<br>
&gt; here?<br>
&gt;<br>
&gt; Although in the above example i&#39;m enabling same/all events in sess=
ion1 and<br>
&gt; session2, but i think this should work and capture same events in both=
 the<br>
&gt; sessions.<br>
<br>
That&#39;s the expected behavior.<br>
<br>
Regards,<br>
J=C3=A9r=C3=A9mie<br>
<br>
&gt; Please let me know the correct way to enable this.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Anand Neeli<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</blockquote></div>

--f46d0442885c0882c705078bb8af--


--===============1511571244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1511571244==--
