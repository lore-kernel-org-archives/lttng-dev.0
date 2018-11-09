From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Re: lost trace events
Date: Thu, 8 Nov 2018 16:53:49 -0800
Message-ID: <CADwgpi_DZtcS=sqj1ZgBi16DLh33XUW75CCCn1s2v087znSeJA__30806.5703291961$1541724728$gmane$org@mail.gmail.com>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
 <20181107153120.GA15594@joraj-alpa>
 <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ@mail.gmail.com>
 <20181107200929.GA12330@joraj-alpa>
 <CADwgpi9Yc+Z15Pit8M4SDzcj9s8UoA2h1NOW8aXgqrRdSfhqYw@mail.gmail.com>
 <1342273247.2139.1541699566757.JavaMail.zimbra@efficios.com>
 <CADwgpi8D2rdsZo6M9SWFvuw1G_kxQKb-PKPA0b-MBoWbK3xDwg@mail.gmail.com>
 <CA+jJMxuudFyD8ER1qYkUACe9MxsExaFJE8pEr=J3DxXs_N46Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5179556880194880626=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by lists.lttng.org (Postfix) with ESMTPS id 42rhVg3WKjzpY9
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 19:54:03 -0500 (EST)
Received: by mail-yb1-xb30.google.com with SMTP id g192-v6so163255ybf.3
 for <lttng-dev@lists.lttng.org>; Thu, 08 Nov 2018 16:54:03 -0800 (PST)
In-Reply-To: <CA+jJMxuudFyD8ER1qYkUACe9MxsExaFJE8pEr=J3DxXs_N46Sw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5179556880194880626==
Content-Type: multipart/alternative; boundary="00000000000084b44d057a30c9fc"

--00000000000084b44d057a30c9fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Awesome, I tried the intersect_mode parameter and it worked. No more lost
events. Thanks for your support.

On Thu, Nov 8, 2018 at 3:44 PM J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Thu, 8 Nov 2018 at 18:31, Alok Priyadarshi <alokpr@gmail.com> wrote:
> >
> > Jonathan: The system is x86_64, 16 cores, no cpu affinity set. Not too
> sure about load yet.
> >
> > Mathieu: The explanation makes sense. Running babeltrace with
> --stream-intersection flag did filter out a lot of events. However it is
> hard to verify the filtered result because we do not yet know how to read
> the text format. Does the babeltrace python API support stream intersecti=
on
> by any chance?
>
> Hi Alok,
>
> The TraceCollection constructor accepts an "intersect_mode" parameter
> which will provide the same semantics as --stream-intersection.
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> >
> >
> > On Thu, Nov 8, 2018 at 9:52 AM Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
> >>
> >> Hi Alok,
> >>
> >> With a snapshot trace, you can end up with some per-cpu buffers that
> contain information
> >> going further back in time compared to other per-cpu buffers. This
> depends on the level of
> >> system activity and tracing throughput for each CPU.
> >>
> >> The situation you experience can very well be triggered by having the
> begin event on one CPU,
> >> being migrated to another CPU, and having the end event on another CPU=
.
> If either the
> >> source or destination CPU has been more active than the other, you may
> find that you
> >> have only the begin or the end event in your trace.
> >>
> >> This is why we implemented the "stream intersection" mode in
> babeltrace. It ensures that
> >> babeltrace cuts away trace data belonging to time spans that only
> appear in some of
> >> the streams. It is not however activated by default.
> >>
> >> To try it out, you can do this:
> >>
> >> babeltrace --stream-intersection path/to/trace
> >>
> >> Does it help ?
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> ----- On Nov 7, 2018, at 7:12 PM, Alok Priyadarshi <alokpr@gmail.com>
> wrote:
> >>
> >> A custom trace event class emits "begin" and "end" events in its
> constructor and destructor respectively. So I do not think this is due to
> conditional path.
> >>
> >> Sequence of commands to capture a snapshot are:
> >> lttng create --snapshot
> >> lttng enable-event --userspace --all
> >> lttng add-context --userspace -t vpid -t vtid
> >> lttng start
> >> lttng stop
> >> lttng snapshot record
> >>
> >> We create a new session for each snapshot to make sure that the buffer
> does not have any left-over events from the previous session. But I am
> curious if lttng shares buffers between sessions or re-uses buffers from =
an
> old session without flushing?
> >>
> >> Note that I am using the default LTTNG_BUFFER_PER_UID mode. All
> processes for our application run under one UID, and only one tracing
> session is active at a time.
> >>
> >> On Wed, Nov 7, 2018 at 12:09 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> >>>
> >>> Hi Alok,
> >>>
> >>> On Wed, Nov 07, 2018 at 11:53:25AM -0800, Alok Priyadarshi wrote:
> >>> > Hi Jonathan,
> >>> >
> >>> > Thanks for your response.
> >>> >
> >>> > We are tracing function scopes. Each scope emits two events - begin
> and
> >>> > end. We noticed that some begin events did not have corresponding e=
nd
> >>> > events in the trace.
> >>>
> >>> Seems like a solid ground as long as the corresponding ending event i=
s
> not
> >>> inside any conditional paths. I'm sure you already validated that but
> we never
> >>> know.
> >>>
> >>> >
> >>> > I have the trace with this problem available. Would that provide an=
y
> clue?
> >>>
> >>> It could help but I presume it might contains confidential or sensibl=
e
> >>> information. Let's define the scenario first and we will go back to
> actual
> >>> trace data if needed.
> >>>
> >>> > If not, I will try to extract a small reproducer.
> >>>
> >>> That would be best. In the meantime, could you provide the exact lttn=
g
> commands
> >>> used to setup everything and describe subsequent lttng commands used
> for
> >>> snapshot etc.
> >>>
> >>> You can omit event name or replace them with dummy name if necessary.
> >>>
> >>> Cheers
> >>>
> >>> --
> >>> Jonathan Rajotte-Julien
> >>> EfficiOS
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--00000000000084b44d057a30c9fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Awesome, I tried the intersect_mode parameter and it worke=
d. No more lost events. Thanks for your support.</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr">On Thu, Nov 8, 2018 at 3:44 PM J=C3=A9r=C3=A9mie=
 Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.ga=
larneau@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On Thu, 8 Nov 2018 at 18:31, Alok Priyadarshi &lt;<a href=3D"mailto:alokpr=
@gmail.com" target=3D"_blank">alokpr@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Jonathan: The system is x86_64, 16 cores, no cpu affinity set. Not too=
 sure about load yet.<br>
&gt;<br>
&gt; Mathieu: The explanation makes sense. Running babeltrace with --stream=
-intersection flag did filter out a lot of events. However it is hard to ve=
rify the filtered result because we do not yet know how to read the text fo=
rmat. Does the babeltrace python API support stream intersection by any cha=
nce?<br>
<br>
Hi Alok,<br>
<br>
The TraceCollection constructor accepts an &quot;intersect_mode&quot; param=
eter<br>
which will provide the same semantics as --stream-intersection.<br>
<br>
Regards,<br>
J=C3=A9r=C3=A9mie<br>
<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Nov 8, 2018 at 9:52 AM Mathieu Desnoyers &lt;<a href=3D"mailto=
:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@effici=
os.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Alok,<br>
&gt;&gt;<br>
&gt;&gt; With a snapshot trace, you can end up with some per-cpu buffers th=
at contain information<br>
&gt;&gt; going further back in time compared to other per-cpu buffers. This=
 depends on the level of<br>
&gt;&gt; system activity and tracing throughput for each CPU.<br>
&gt;&gt;<br>
&gt;&gt; The situation you experience can very well be triggered by having =
the begin event on one CPU,<br>
&gt;&gt; being migrated to another CPU, and having the end event on another=
 CPU. If either the<br>
&gt;&gt; source or destination CPU has been more active than the other, you=
 may find that you<br>
&gt;&gt; have only the begin or the end event in your trace.<br>
&gt;&gt;<br>
&gt;&gt; This is why we implemented the &quot;stream intersection&quot; mod=
e in babeltrace. It ensures that<br>
&gt;&gt; babeltrace cuts away trace data belonging to time spans that only =
appear in some of<br>
&gt;&gt; the streams. It is not however activated by default.<br>
&gt;&gt;<br>
&gt;&gt; To try it out, you can do this:<br>
&gt;&gt;<br>
&gt;&gt; babeltrace --stream-intersection path/to/trace<br>
&gt;&gt;<br>
&gt;&gt; Does it help ?<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt;<br>
&gt;&gt; Mathieu<br>
&gt;&gt;<br>
&gt;&gt; ----- On Nov 7, 2018, at 7:12 PM, Alok Priyadarshi &lt;<a href=3D"=
mailto:alokpr@gmail.com" target=3D"_blank">alokpr@gmail.com</a>&gt; wrote:<=
br>
&gt;&gt;<br>
&gt;&gt; A custom trace event class emits &quot;begin&quot; and &quot;end&q=
uot; events in its constructor and destructor respectively. So I do not thi=
nk this is due to conditional path.<br>
&gt;&gt;<br>
&gt;&gt; Sequence of commands to capture a snapshot are:<br>
&gt;&gt; lttng create --snapshot<br>
&gt;&gt; lttng enable-event --userspace --all<br>
&gt;&gt; lttng add-context --userspace -t vpid -t vtid<br>
&gt;&gt; lttng start<br>
&gt;&gt; lttng stop<br>
&gt;&gt; lttng snapshot record<br>
&gt;&gt;<br>
&gt;&gt; We create a new session for each snapshot to make sure that the bu=
ffer does not have any left-over events from the previous session. But I am=
 curious if lttng shares buffers between sessions or re-uses buffers from a=
n old session without flushing?<br>
&gt;&gt;<br>
&gt;&gt; Note that I am using the default LTTNG_BUFFER_PER_UID mode. All pr=
ocesses for our application run under one UID, and only one tracing session=
 is active at a time.<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Nov 7, 2018 at 12:09 PM Jonathan Rajotte-Julien &lt;<a hre=
f=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonatha=
n.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Alok,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Wed, Nov 07, 2018 at 11:53:25AM -0800, Alok Priyadarshi wro=
te:<br>
&gt;&gt;&gt; &gt; Hi Jonathan,<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Thanks for your response.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; We are tracing function scopes. Each scope emits two even=
ts - begin and<br>
&gt;&gt;&gt; &gt; end. We noticed that some begin events did not have corre=
sponding end<br>
&gt;&gt;&gt; &gt; events in the trace.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Seems like a solid ground as long as the corresponding ending =
event is not<br>
&gt;&gt;&gt; inside any conditional paths. I&#39;m sure you already validat=
ed that but we never<br>
&gt;&gt;&gt; know.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; I have the trace with this problem available. Would that =
provide any clue?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It could help but I presume it might contains confidential or =
sensible<br>
&gt;&gt;&gt; information. Let&#39;s define the scenario first and we will g=
o back to actual<br>
&gt;&gt;&gt; trace data if needed.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; If not, I will try to extract a small reproducer.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; That would be best. In the meantime, could you provide the exa=
ct lttng commands<br>
&gt;&gt;&gt; used to setup everything and describe subsequent lttng command=
s used for<br>
&gt;&gt;&gt; snapshot etc.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You can omit event name or replace them with dummy name if nec=
essary.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Cheers<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Jonathan Rajotte-Julien<br>
&gt;&gt;&gt; EfficiOS<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Mathieu Desnoyers<br>
&gt;&gt; EfficiOS Inc.<br>
&gt;&gt; <a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_=
blank">http://www.efficios.com</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
<br>
<br>
-- <br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></div>

--00000000000084b44d057a30c9fc--

--===============5179556880194880626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5179556880194880626==--
