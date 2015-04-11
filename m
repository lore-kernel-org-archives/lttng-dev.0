From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: Warning: HOME environment variable not set.
Date: Sat, 11 Apr 2015 06:01:19 +0530
Message-ID: <CAM5kDqx+cyMqQavqT4DiVxjjkgtfdAqfVH0pVXp5goJAW2Pz4Q__35681.4140374356$1428712365$gmane$org@mail.gmail.com>
References: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
 <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA@mail.gmail.com>
 <CAM5kDqxMTOj0TqZQjT0i+0MHmPxfvPUocgV0_erw4_7+pBtSDA@mail.gmail.com>
 <218306271.74676.1427117803698.JavaMail.zimbra@efficios.com>
 <CAB4xu_2F1QF=_iO-_jHj_YszLNq=ia1sPrchHP9aBBbmot5ADw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808937071=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YgjKW-00079b-Th
 for lttng-dev@lists.lttng.org; Fri, 10 Apr 2015 20:31:33 -0400
Received: by wizk4 with SMTP id k4so13486446wiz.1
 for <lttng-dev@lists.lttng.org>; Fri, 10 Apr 2015 17:31:19 -0700 (PDT)
In-Reply-To: <CAB4xu_2F1QF=_iO-_jHj_YszLNq=ia1sPrchHP9aBBbmot5ADw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1808937071==
Content-Type: multipart/alternative; boundary=f46d043be13ce5cf27051367ff4b

--f46d043be13ce5cf27051367ff4b
Content-Type: text/plain; charset=UTF-8

What's the impact of this?
What will happen if we see this error "disabling per-user tracing".
Will the app stop tracing?

Thanks
Anand Neeli
On Apr 11, 2015 5:27 AM, "Philippe Proulx" <eeppeliteloop@gmail.com> wrote:

> On Mon, Mar 23, 2015 at 9:36 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > Perhaps your program is clearing its environment
> > variables ? Or launched by a wrapper that clears
> > the env. var. ?
>
> Perhaps LTTng-UST should do like LTTng-tools: try $LTTNG_HOME, then
> $HOME, then the current UID's entry in /etc/passwd? This would avoid
> disabling per-user tracing even when the environment variables are cleared.
>
> WDYT?
>
> Phil
>
> >
> > Can you try with a simple demo program to find our
> > what is clearing those ?
> >
> > Thanks,
> >
> > Mathieu
> >
> >
> > ________________________________
> >
> > Hi All,
> > I'm sorry to bump on this thread again.
> >
> > Is there any way to overcome this issue?
> >
> > Thanks,
> > Anand Neeli
> >
> > On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R <chid1989@gmail.com> wrote:
> >>
> >> I too am getting the same errors. Inspite of setting LTTNG_HOME in my
> >> program.
> >>
> >> On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <anand.neeli@gmail.com>
> >> wrote:
> >>>
> >>> Hi All,
> >>>
> >>> any idea when do we get this error?
> >>>
> >>> app: libust[4745/4745]: Warning: HOME environment variable not set.
> >>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> >>> lttng-ust-comm.c:385)
> >>> app: libust[4751/4751]: Warning: HOME environment variable not set.
> >>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> >>> lttng-ust-comm.c:385)
> >>> app: libust[4760/4760]: Warning: HOME environment variable not set.
> >>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> >>> lttng-ust-comm.c:385)
> >>> app: libust[4780/4780]: Warning: HOME environment variable not set.
> >>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
> >>> lttng-ust-comm.c:385)
> >>>
> >>> i have set LTTNG_HOME=HOME=/home/root
> >>> using 2.6
> >>>
> >>> Thanks,
> >>> Anand Neeli
> >>>
> >>>
> >>> _______________________________________________
> >>> lttng-dev mailing list
> >>> lttng-dev@lists.lttng.org
> >>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>>
> >>
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--f46d043be13ce5cf27051367ff4b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">What&#39;s the impact of this?<br>
What will happen if we see this error &quot;disabling per-user tracing&quot=
;.<br>
Will the app stop tracing?</p>
<p dir=3D"ltr">Thanks<br>
Anand Neeli</p>
<div class=3D"gmail_quote">On Apr 11, 2015 5:27 AM, &quot;Philippe Proulx&q=
uot; &lt;<a href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com=
</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On M=
on, Mar 23, 2015 at 9:36 AM, Mathieu Desnoyers<br>
&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@eff=
icios.com</a>&gt; wrote:<br>
&gt; Perhaps your program is clearing its environment<br>
&gt; variables ? Or launched by a wrapper that clears<br>
&gt; the env. var. ?<br>
<br>
Perhaps LTTng-UST should do like LTTng-tools: try $LTTNG_HOME, then<br>
$HOME, then the current UID&#39;s entry in /etc/passwd? This would avoid<br=
>
disabling per-user tracing even when the environment variables are cleared.=
<br>
<br>
WDYT?<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt; Can you try with a simple demo program to find our<br>
&gt; what is clearing those ?<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Mathieu<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; Hi All,<br>
&gt; I&#39;m sorry to bump on this thread again.<br>
&gt;<br>
&gt; Is there any way to overcome this issue?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Anand Neeli<br>
&gt;<br>
&gt; On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R &lt;<a href=3D"mailto:chid1=
989@gmail.com">chid1989@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; I too am getting the same errors. Inspite of setting LTTNG_HOME in=
 my<br>
&gt;&gt; program.<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli &lt;<a href=3D"mailto=
:anand.neeli@gmail.com">anand.neeli@gmail.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi All,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; any idea when do we get this error?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; app: libust[4745/4745]: Warning: HOME environment variable not=
 set.<br>
&gt;&gt;&gt; Disabling LTTng-UST per-user tracing. (in setup_local_apps() a=
t<br>
&gt;&gt;&gt; lttng-ust-comm.c:385)<br>
&gt;&gt;&gt; app: libust[4751/4751]: Warning: HOME environment variable not=
 set.<br>
&gt;&gt;&gt; Disabling LTTng-UST per-user tracing. (in setup_local_apps() a=
t<br>
&gt;&gt;&gt; lttng-ust-comm.c:385)<br>
&gt;&gt;&gt; app: libust[4760/4760]: Warning: HOME environment variable not=
 set.<br>
&gt;&gt;&gt; Disabling LTTng-UST per-user tracing. (in setup_local_apps() a=
t<br>
&gt;&gt;&gt; lttng-ust-comm.c:385)<br>
&gt;&gt;&gt; app: libust[4780/4780]: Warning: HOME environment variable not=
 set.<br>
&gt;&gt;&gt; Disabling LTTng-UST per-user tracing. (in setup_local_apps() a=
t<br>
&gt;&gt;&gt; lttng-ust-comm.c:385)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; i have set LTTNG_HOME=3DHOME=3D/home/root<br>
&gt;&gt;&gt; using 2.6<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Anand Neeli<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; lttng-dev mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.l=
ttng.org</a><br>
&gt;&gt;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/ltt=
ng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
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
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effic=
ios.com</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
</blockquote></div>

--f46d043be13ce5cf27051367ff4b--


--===============1808937071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1808937071==--
