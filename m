From: Alok Priyadarshi <alokpr@gmail.com>
Subject: Re: lost trace events
Date: Thu, 8 Nov 2018 15:31:12 -0800
Message-ID: <CADwgpi8D2rdsZo6M9SWFvuw1G_kxQKb-PKPA0b-MBoWbK3xDwg__30978.3772485845$1541719770$gmane$org@mail.gmail.com>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
 <20181107153120.GA15594@joraj-alpa>
 <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ@mail.gmail.com>
 <20181107200929.GA12330@joraj-alpa>
 <CADwgpi9Yc+Z15Pit8M4SDzcj9s8UoA2h1NOW8aXgqrRdSfhqYw@mail.gmail.com>
 <1342273247.2139.1541699566757.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6396376569934161077=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by lists.lttng.org (Postfix) with ESMTPS id 42rfgL46xrzqtS
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 18:31:26 -0500 (EST)
Received: by mail-yb1-xb2a.google.com with SMTP id i17-v6so2887074ybp.13
 for <lttng-dev@lists.lttng.org>; Thu, 08 Nov 2018 15:31:26 -0800 (PST)
In-Reply-To: <1342273247.2139.1541699566757.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6396376569934161077==
Content-Type: multipart/alternative; boundary="0000000000000ff3fd057a2fa2f1"

--0000000000000ff3fd057a2fa2f1
Content-Type: text/plain; charset="UTF-8"

Jonathan: The system is x86_64, 16 cores, no cpu affinity set. Not too sure
about load yet.

Mathieu: The explanation makes sense. Running babeltrace with
--stream-intersection flag did filter out a lot of events. However it is
hard to verify the filtered result because we do not yet know how to read
the text format. Does the babeltrace python API support stream intersection
by any chance?


On Thu, Nov 8, 2018 at 9:52 AM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi Alok,
>
> With a snapshot trace, you can end up with some per-cpu buffers that
> contain information
> going further back in time compared to other per-cpu buffers. This depends
> on the level of
> system activity and tracing throughput for each CPU.
>
> The situation you experience can very well be triggered by having the
> begin event on one CPU,
> being migrated to another CPU, and having the end event on another CPU. If
> either the
> source or destination CPU has been more active than the other, you may
> find that you
> have only the begin or the end event in your trace.
>
> This is why we implemented the "stream intersection" mode in babeltrace.
> It ensures that
> babeltrace cuts away trace data belonging to time spans that only appear
> in some of
> the streams. It is not however activated by default.
>
> To try it out, you can do this:
>
> babeltrace --stream-intersection path/to/trace
>
> Does it help ?
>
> Thanks,
>
> Mathieu
>
> ----- On Nov 7, 2018, at 7:12 PM, Alok Priyadarshi <alokpr@gmail.com>
> wrote:
>
> A custom trace event class emits "begin" and "end" events in its
> constructor and destructor respectively. So I do not think this is due to
> conditional path.
>
> Sequence of commands to capture a snapshot are:
> lttng create --snapshot
> lttng enable-event --userspace --all
> lttng add-context --userspace -t vpid -t vtid
> lttng start
> lttng stop
> lttng snapshot record
>
> We create a new session for each snapshot to make sure that the buffer
> does not have any left-over events from the previous session. But I am
> curious if lttng shares buffers between sessions or re-uses buffers from an
> old session without flushing?
>
> Note that I am using the default LTTNG_BUFFER_PER_UID mode. All processes
> for our application run under one UID, and only one tracing session is
> active at a time.
>
> On Wed, Nov 7, 2018 at 12:09 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
>
>> Hi Alok,
>>
>> On Wed, Nov 07, 2018 at 11:53:25AM -0800, Alok Priyadarshi wrote:
>> > Hi Jonathan,
>> >
>> > Thanks for your response.
>> >
>> > We are tracing function scopes. Each scope emits two events - begin and
>> > end. We noticed that some begin events did not have corresponding end
>> > events in the trace.
>>
>> Seems like a solid ground as long as the corresponding ending event is not
>> inside any conditional paths. I'm sure you already validated that but we
>> never
>> know.
>>
>> >
>> > I have the trace with this problem available. Would that provide any
>> clue?
>>
>> It could help but I presume it might contains confidential or sensible
>> information. Let's define the scenario first and we will go back to actual
>> trace data if needed.
>>
>> > If not, I will try to extract a small reproducer.
>>
>> That would be best. In the meantime, could you provide the exact lttng
>> commands
>> used to setup everything and describe subsequent lttng commands used for
>> snapshot etc.
>>
>> You can omit event name or replace them with dummy name if necessary.
>>
>> Cheers
>>
>> --
>> Jonathan Rajotte-Julien
>> EfficiOS
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--0000000000000ff3fd057a2fa2f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Jonathan: The system is x86_64, 16 cores, no cpu affinity =
set. Not too sure about load yet.<div><br><div>Mathieu: The explanation mak=
es sense. Running babeltrace with --stream-intersection flag did filter out=
 a lot of events. However it is hard to verify the filtered result because =
we do not yet know how to read the text format. Does the babeltrace python =
API support stream intersection by any chance?<br><div><br></div></div></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Nov 8, 2018=
 at 9:52 AM Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@effic=
ios.com">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-ser=
if;font-size:12pt;color:#000000"><div>Hi Alok,</div><div><br></div><div>Wit=
h a snapshot trace, you can end up with some per-cpu buffers that contain i=
nformation<br></div><div>going further back in time compared to other per-c=
pu buffers. This depends on the level of<br></div><div>system activity and =
tracing throughput for each CPU.<br></div><div><br></div><div>The situation=
 you experience can very well be triggered by having the begin event on one=
 CPU,</div><div>being migrated to another CPU, and having the end event on =
another CPU. If either the<br></div><div>source or destination CPU has been=
 more active than the other, you may find that you<br></div><div>have only =
the begin or the end event in your trace.<br></div><div><br></div><div>This=
 is why we implemented the &quot;stream intersection&quot; mode in babeltra=
ce. It ensures that<br></div><div>babeltrace cuts away trace data belonging=
 to time spans that only appear in some of<br></div><div>the streams. It is=
 not however activated by default.</div><div><br></div><div>To try it out, =
you can do this:<br></div><div><br></div><div>babeltrace --stream-intersect=
ion path/to/trace<br></div><div><br></div><div>Does it help ?<br></div><div=
><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div></div=
></div><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:=
12pt;color:#000000"><div><br></div><div><span id=3D"m_-9171930826021529964z=
wchr">----- On Nov 7, 2018, at 7:12 PM, Alok Priyadarshi &lt;<a href=3D"mai=
lto:alokpr@gmail.com" target=3D"_blank">alokpr@gmail.com</a>&gt; wrote:<br>=
</span></div></div></div><div><div style=3D"font-family:arial,helvetica,san=
s-serif;font-size:12pt;color:#000000"><div><blockquote style=3D"border-left=
:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt"><div dir=3D"ltr"><div>A custom trace event class =
emits &quot;begin&quot; and &quot;end&quot; events in its constructor and d=
estructor respectively. So I do not think this is due to conditional path.<=
/div><br>Sequence of commands to capture a snapshot are:<div><div>lttng cre=
ate --snapshot</div><div>lttng enable-event --userspace --all</div><div>ltt=
ng add-context --userspace -t vpid -t vtid</div><div>lttng start<br></div><=
div>lttng stop</div><div>lttng snapshot record</div></div><div dir=3D"ltr">=
<div dir=3D"ltr"><br><div>We create a new session for each snapshot to make=
 sure that the buffer does not have any left-over events from the previous =
session. But I am curious if lttng shares buffers between sessions or re-us=
es buffers from an old session without flushing?</div><br><div>Note that I =
am using the default=C2=A0LTTNG_BUFFER_PER_UID mode. All processes for our =
application run under one UID, and only one tracing session is active at a =
time.</div><br><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Nov=
 7, 2018 at 12:09 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan=
.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@eff=
icios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Alok,=
<br>
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
<br></blockquote></div></div></div><div><div style=3D"font-family:arial,hel=
vetica,sans-serif;font-size:12pt;color:#000000"><div><blockquote style=3D"b=
order-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt">_______________________________________=
________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.ltt=
ng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br></blockquot=
e></div></div></div><div><div style=3D"font-family:arial,helvetica,sans-ser=
if;font-size:12pt;color:#000000"><div><br></div><div>-- <br></div><div>Math=
ieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" targe=
t=3D"_blank">http://www.efficios.com</a></div></div></div></blockquote></di=
v>

--0000000000000ff3fd057a2fa2f1--

--===============6396376569934161077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6396376569934161077==--
