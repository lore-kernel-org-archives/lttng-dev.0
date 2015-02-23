From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: adding new channel
Date: Mon, 23 Feb 2015 17:53:17 +0530
Message-ID: <CAM5kDqzuEqiN0max-4+SpfgGm1oJGzsxBZHa1fZc8phH7jJJ9g__31786.4791294143$1424694287$gmane$org@mail.gmail.com>
References: <CAM5kDqydAEebJm0_MotZ0xTAMJo51j+Zxxw5-skppaJYcN6g0Q@mail.gmail.com>
 <CAB4xu_3QRDuKefYVY4Bc_eTs5tnmaYDb4+Um1Rf3t2zYtZO1jQ@mail.gmail.com>
 <CAM5kDqzCq1ALXOSy2aAE+hB6=e2aFOQQ2snHdGx1WA0vjnBHtA@mail.gmail.com>
 <54E79EF3.3070506@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0039655053=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YPs2l-0006Kk-G4
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 07:23:28 -0500
Received: by mail-wi0-f177.google.com with SMTP id bs8so16177448wib.4
 for <lttng-dev@lists.lttng.org>; Mon, 23 Feb 2015 04:23:17 -0800 (PST)
In-Reply-To: <54E79EF3.3070506@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0039655053==
Content-Type: multipart/alternative; boundary=f46d0435c07893b909050fc07780

--f46d0435c07893b909050fc07780
Content-Type: text/plain; charset=UTF-8

Well, i can create a new session for this use-case.
But what will be the use of channels if they can be added on the fly.
The dynamic configuration of adding/deleting events and channels wont be
much useful if user has to pre-decide on what config is he going to do.
I hope you get my point on the flexibility here.

Thanks,
Anand Neeli


On Sat, Feb 21, 2015 at 2:24 AM, Julien Desfossez <jdesfossez@efficios.com>
wrote:

> Hi,
>
> I'm just curious, is there a problem with creating new sessions when
> needed for this kind of use-case ?
>
> Thanks,
>
> Julien
>
> On 15-02-20 02:25 PM, Anand Neeli wrote:
> > Thanks for the reply.
> >
> > I think adding channels on the fly must be supported.
> > From debugging point of view, it will be good if we can add channels on
> > the fly with each channel having different set of events.
> > Even "stop tracing" and adding channel doesnt help now.
> >
> > Thanks,
> > Anand Neeli
> >
> > On Sat, Feb 21, 2015 at 12:35 AM, Philippe Proulx
> > <eeppeliteloop@gmail.com <mailto:eeppeliteloop@gmail.com>> wrote:
> >
> >     On Fri, Feb 20, 2015 at 2:00 PM, Anand Neeli <anand.neeli@gmail.com
> >     <mailto:anand.neeli@gmail.com>> wrote:
> >     > Hi All,
> >     > Is adding a new channel to an existing(running) session supported?
> >
> >     No.
> >     >
> >     > i get following error when doing this.
> >     > Error: Channel myc5: Tracing already started
> >     >
> >     > Is there any way to add channels on the fly?
> >
> >     No. LTTng's documentation [1] states:
> >
> >         Note: Because of a current limitation, all channels must be
> >         created prior to beginning tracing in a given tracing session,
> >         i.e. before the first time you do lttng start.
> >
> >         Since a channel is automatically created by enable-event
> >         only for the specified domain, you cannot, for example, enable
> >         a kernel domain event, start tracing and then enable a user
> >         space domain event because no user space channel exists
> >         yet and it's too late to create one.
> >
> >         For this reason, make sure to configure your channels
> >         properly before starting the tracers for the first time!
> >
> >     Phil
> >
> >     [1] http://lttng.org/docs/#doc-enabling-disabling-channels
> >
> >     > I'm using 2.4.1 version
> >     >
> >     > Thanks,
> >     > Anand Neeli
> >     >
> >     > _______________________________________________
> >     > lttng-dev mailing list
> >     > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >     > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >     >
> >
> >
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--f46d0435c07893b909050fc07780
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Well, i can create a new session for this use-case.<div>Bu=
t what will be the use of channels if they can be added on the fly.</div><d=
iv>The dynamic configuration of adding/deleting events and channels wont be=
 much useful if user has to pre-decide on what config is he going to do.</d=
iv><div>I hope you get my point on the flexibility here.</div><div><br></di=
v><div>Thanks,</div><div>Anand Neeli</div><div><br><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Sat, Feb 21, 2015 at 2:24 AM, Julien D=
esfossez <span dir=3D"ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" t=
arget=3D"_blank">jdesfossez@efficios.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Hi,<br>
<br>
I&#39;m just curious, is there a problem with creating new sessions when<br=
>
needed for this kind of use-case ?<br>
<br>
Thanks,<br>
<br>
Julien<br>
<span class=3D""><br>
On 15-02-20 02:25 PM, Anand Neeli wrote:<br>
&gt; Thanks for the reply.<br>
&gt;<br>
&gt; I think adding channels on the fly must be supported.<br>
&gt; From debugging point of view, it will be good if we can add channels o=
n<br>
&gt; the fly with each channel having different set of events.<br>
&gt; Even &quot;stop tracing&quot; and adding channel doesnt help now.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Anand Neeli<br>
&gt;<br>
&gt; On Sat, Feb 21, 2015 at 12:35 AM, Philippe Proulx<br>
</span><span class=3D"">&gt; &lt;<a href=3D"mailto:eeppeliteloop@gmail.com"=
>eeppeliteloop@gmail.com</a> &lt;mailto:<a href=3D"mailto:eeppeliteloop@gma=
il.com">eeppeliteloop@gmail.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On Fri, Feb 20, 2015 at 2:00 PM, Anand Neeli &lt;<a=
 href=3D"mailto:anand.neeli@gmail.com">anand.neeli@gmail.com</a><br>
</span><div><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D=
"mailto:anand.neeli@gmail.com">anand.neeli@gmail.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi All,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Is adding a new channel to an existing(running=
) session supported?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0No.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; i get following error when doing this.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Error: Channel myc5: Tracing already started<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Is there any way to add channels on the fly?<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0No. LTTng&#39;s documentation [1] states:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Note: Because of a current limitation=
, all channels must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0created prior to beginning tracing in=
 a given tracing session,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i.e. before the first time you do ltt=
ng start.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Since a channel is automatically crea=
ted by enable-event<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0only for the specified domain, you ca=
nnot, for example, enable<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a kernel domain event, start tracing =
and then enable a user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0space domain event because no user sp=
ace channel exists<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0yet and it&#39;s too late to create o=
ne.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For this reason, make sure to configu=
re your channels<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0properly before starting the tracers =
for the first time!<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Phil<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0[1] <a href=3D"http://lttng.org/docs/#doc-enabling-=
disabling-channels" target=3D"_blank">http://lttng.org/docs/#doc-enabling-d=
isabling-channels</a><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m using 2.4.1 version<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Anand Neeli<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ______________________________________________=
_<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; lttng-dev mailing list<br>
</div></div>&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"mailto:lttng-dev@lists.=
lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lttng=
-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
</div></div></blockquote></div><br></div></div></div>

--f46d0435c07893b909050fc07780--


--===============0039655053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0039655053==--
