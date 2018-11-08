From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Re: lost trace events
Date: Wed, 7 Nov 2018 16:12:30 -0800
Message-ID: <CADwgpi9Yc+Z15Pit8M4SDzcj9s8UoA2h1NOW8aXgqrRdSfhqYw__47420.2201040045$1541635846$gmane$org@mail.gmail.com>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
 <20181107153120.GA15594@joraj-alpa>
 <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ@mail.gmail.com>
 <20181107200929.GA12330@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1562624213189557199=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by lists.lttng.org (Postfix) with ESMTPS id 42r3dR3G3Fzqs1
 for <lttng-dev@lists.lttng.org>; Wed,  7 Nov 2018 19:12:43 -0500 (EST)
Received: by mail-yb1-xb35.google.com with SMTP id g192-v6so7564638ybf.3
 for <lttng-dev@lists.lttng.org>; Wed, 07 Nov 2018 16:12:43 -0800 (PST)
In-Reply-To: <20181107200929.GA12330@joraj-alpa>
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

--===============1562624213189557199==
Content-Type: multipart/alternative; boundary="000000000000e10d07057a1c17f3"

--000000000000e10d07057a1c17f3
Content-Type: text/plain; charset="UTF-8"

A custom trace event class emits "begin" and "end" events in its
constructor and destructor respectively. So I do not think this is due to
conditional path.

Sequence of commands to capture a snapshot are:
lttng create --snapshot
lttng enable-event --userspace --all
lttng add-context --userspace -t vpid -t vtid
lttng start
lttng stop
lttng snapshot record

We create a new session for each snapshot to make sure that the buffer does
not have any left-over events from the previous session. But I am curious
if lttng shares buffers between sessions or re-uses buffers from an old
session without flushing?

Note that I am using the default LTTNG_BUFFER_PER_UID mode. All processes
for our application run under one UID, and only one tracing session is
active at a time.

On Wed, Nov 7, 2018 at 12:09 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Alok,
>
> On Wed, Nov 07, 2018 at 11:53:25AM -0800, Alok Priyadarshi wrote:
> > Hi Jonathan,
> >
> > Thanks for your response.
> >
> > We are tracing function scopes. Each scope emits two events - begin and
> > end. We noticed that some begin events did not have corresponding end
> > events in the trace.
>
> Seems like a solid ground as long as the corresponding ending event is not
> inside any conditional paths. I'm sure you already validated that but we
> never
> know.
>
> >
> > I have the trace with this problem available. Would that provide any
> clue?
>
> It could help but I presume it might contains confidential or sensible
> information. Let's define the scenario first and we will go back to actual
> trace data if needed.
>
> > If not, I will try to extract a small reproducer.
>
> That would be best. In the meantime, could you provide the exact lttng
> commands
> used to setup everything and describe subsequent lttng commands used for
> snapshot etc.
>
> You can omit event name or replace them with dummy name if necessary.
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000e10d07057a1c17f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>A custom trace event class emits &quot;begin&quot; an=
d &quot;end&quot; events in its constructor and destructor respectively. So=
 I do not think this is due to conditional path.</div><div><br></div>Sequen=
ce of commands to capture a snapshot are:<div><div>lttng create --snapshot<=
/div><div>lttng enable-event --userspace --all</div><div>lttng add-context =
--userspace -t vpid -t vtid</div><div>lttng start<br></div><div>lttng stop<=
/div><div>lttng snapshot record</div></div><div dir=3D"ltr"><div dir=3D"ltr=
"><div><br></div><div>We create a new session for each snapshot to make sur=
e that the buffer does not have any left-over events from the previous sess=
ion. But I am curious if lttng shares buffers between sessions or re-uses b=
uffers from an old session without flushing?</div><div><br></div><div>Note =
that I am using the default=C2=A0LTTNG_BUFFER_PER_UID mode. All processes f=
or our application run under one UID, and only one tracing session is activ=
e at a time.</div><div><br></div><div><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Wed, Nov 7, 2018 at 12:09 PM Jonathan Rajotte-Julien &lt;<a hre=
f=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonatha=
n.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Hi Alok,<br>
<br>
On Wed, Nov 07, 2018 at 11:53:25AM -0800, Alok Priyadarshi wrote:<br>
&gt; Hi Jonathan,<br>
&gt; <br>
&gt; Thanks for your response.<br>
&gt; <br>
&gt; We are tracing function scopes. Each scope emits two events - begin an=
d<br>
&gt; end. We noticed that some begin events did not have corresponding end<=
br>
&gt; events in the trace.<br>
<br>
Seems like a solid ground as long as the corresponding ending event is not<=
br>
inside any conditional paths. I&#39;m sure you already validated that but w=
e never<br>
know.<br>
<br>
&gt; <br>
&gt; I have the trace with this problem available. Would that provide any c=
lue?<br>
<br>
It could help but I presume it might contains confidential or sensible<br>
information. Let&#39;s define the scenario first and we will go back to act=
ual<br>
trace data if needed.<br>
<br>
&gt; If not, I will try to extract a small reproducer.<br>
<br>
That would be best. In the meantime, could you provide the exact lttng comm=
ands<br>
used to setup everything and describe subsequent lttng commands used for<br=
>
snapshot etc.<br>
<br>
You can omit event name or replace them with dummy name if necessary.<br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div></div></div></div>

--000000000000e10d07057a1c17f3--

--===============1562624213189557199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1562624213189557199==--
