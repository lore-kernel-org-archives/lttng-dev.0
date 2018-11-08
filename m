From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lost trace events
Date: Thu, 8 Nov 2018 12:52:46 -0500 (EST)
Message-ID: <1342273247.2139.1541699566757.JavaMail.zimbra__26827.2791443907$1541699463$gmane$org@efficios.com>
References: <CADwgpi8TmCUgz4uF8CpPs-1-SooENXvYgA2ZqjXbcMgsSwzRdg@mail.gmail.com>
 <20181107153120.GA15594@joraj-alpa>
 <CADwgpi9Hpm9hYuRi9y9qOVyUvoGWcVkX0ZEm6AvQaPyeN_QWkQ@mail.gmail.com>
 <20181107200929.GA12330@joraj-alpa>
 <CADwgpi9Yc+Z15Pit8M4SDzcj9s8UoA2h1NOW8aXgqrRdSfhqYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5140760320375315994=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rW8k3K36zptx
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 12:52:54 -0500 (EST)
In-Reply-To: <CADwgpi9Yc+Z15Pit8M4SDzcj9s8UoA2h1NOW8aXgqrRdSfhqYw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alok Priyadarshi <alokpr@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5140760320375315994==
Content-Type: multipart/alternative;
	boundary="=_ec5db368-beb7-4feb-aa5b-a14f2090b678"

--=_ec5db368-beb7-4feb-aa5b-a14f2090b678
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Alok, 

With a snapshot trace, you can end up with some per-cpu buffers that contain information 
going further back in time compared to other per-cpu buffers. This depends on the level of 
system activity and tracing throughput for each CPU. 

The situation you experience can very well be triggered by having the begin event on one CPU, 
being migrated to another CPU, and having the end event on another CPU. If either the 
source or destination CPU has been more active than the other, you may find that you 
have only the begin or the end event in your trace. 

This is why we implemented the "stream intersection" mode in babeltrace. It ensures that 
babeltrace cuts away trace data belonging to time spans that only appear in some of 
the streams. It is not however activated by default. 

To try it out, you can do this: 

babeltrace --stream-intersection path/to/trace 

Does it help ? 

Thanks, 

Mathieu 

----- On Nov 7, 2018, at 7:12 PM, Alok Priyadarshi <alokpr@gmail.com> wrote: 

> A custom trace event class emits "begin" and "end" events in its constructor and
> destructor respectively. So I do not think this is due to conditional path.

> Sequence of commands to capture a snapshot are:
> lttng create --snapshot
> lttng enable-event --userspace --all
> lttng add-context --userspace -t vpid -t vtid
> lttng start
> lttng stop
> lttng snapshot record

> We create a new session for each snapshot to make sure that the buffer does not
> have any left-over events from the previous session. But I am curious if lttng
> shares buffers between sessions or re-uses buffers from an old session without
> flushing?

> Note that I am using the default LTTNG_BUFFER_PER_UID mode. All processes for
> our application run under one UID, and only one tracing session is active at a
> time.

> On Wed, Nov 7, 2018 at 12:09 PM Jonathan Rajotte-Julien < [
> mailto:jonathan.rajotte-julien@efficios.com |
> jonathan.rajotte-julien@efficios.com ] > wrote:

>> Hi Alok,

>> On Wed, Nov 07, 2018 at 11:53:25AM -0800, Alok Priyadarshi wrote:
>> > Hi Jonathan,

>> > Thanks for your response.

>> > We are tracing function scopes. Each scope emits two events - begin and
>> > end. We noticed that some begin events did not have corresponding end
>> > events in the trace.

>> Seems like a solid ground as long as the corresponding ending event is not
>> inside any conditional paths. I'm sure you already validated that but we never
>> know.


>> > I have the trace with this problem available. Would that provide any clue?

>> It could help but I presume it might contains confidential or sensible
>> information. Let's define the scenario first and we will go back to actual
>> trace data if needed.

>> > If not, I will try to extract a small reproducer.

>> That would be best. In the meantime, could you provide the exact lttng commands
>> used to setup everything and describe subsequent lttng commands used for
>> snapshot etc.

>> You can omit event name or replace them with dummy name if necessary.

>> Cheers

>> --
>> Jonathan Rajotte-Julien
>> EfficiOS

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_ec5db368-beb7-4feb-aa5b-a14f2090b678
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Alok,</div><div><br data-mce-bogus=3D"1"=
></div><div>With a snapshot trace, you can end up with some per-cpu buffers=
 that contain information<br></div><div>going further back in time compared=
 to other per-cpu buffers. This depends on the level of<br data-mce-bogus=
=3D"1"></div><div>system activity and tracing throughput for each CPU.<br d=
ata-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>The situ=
ation you experience can very well be triggered by having the begin event o=
n one CPU,</div><div>being migrated to another CPU, and having the end even=
t on another CPU. If either the<br data-mce-bogus=3D"1"></div><div>source o=
r destination CPU has been more active than the other, you may find that yo=
u<br data-mce-bogus=3D"1"></div><div>have only the begin or the end event i=
n your trace.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div>This is why we implemented the "stream intersection" mode in babe=
ltrace. It ensures that<br data-mce-bogus=3D"1"></div><div>babeltrace cuts =
away trace data belonging to time spans that only appear in some of<br data=
-mce-bogus=3D"1"></div><div>the streams. It is not however activated by def=
ault.</div><div><br data-mce-bogus=3D"1"></div><div>To try it out, you can =
do this:<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div>=
<div>babeltrace --stream-intersection path/to/trace<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>Does it help ?<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br d=
ata-mce-bogus=3D"1"></div><div><br></div><div><span id=3D"zwchr" data-marke=
r=3D"__DIVIDER__">----- On Nov 7, 2018, at 7:12 PM, Alok Priyadarshi &lt;al=
okpr@gmail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT=
__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padd=
ing-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"=
ltr"><div>A custom trace event class emits "begin" and "end" events in its =
constructor and destructor respectively. So I do not think this is due to c=
onditional path.</div><br>Sequence of commands to capture a snapshot are:<d=
iv><div>lttng create --snapshot</div><div>lttng enable-event --userspace --=
all</div><div>lttng add-context --userspace -t vpid -t vtid</div><div>lttng=
 start<br></div><div>lttng stop</div><div>lttng snapshot record</div></div>=
<div dir=3D"ltr"><div dir=3D"ltr"><br><div>We create a new session for each=
 snapshot to make sure that the buffer does not have any left-over events f=
rom the previous session. But I am curious if lttng shares buffers between =
sessions or re-uses buffers from an old session without flushing?</div><br>=
<div>Note that I am using the default&nbsp;LTTNG_BUFFER_PER_UID mode. All p=
rocesses for our application run under one UID, and only one tracing sessio=
n is active at a time.</div><br><div><div class=3D"gmail_quote"><div dir=3D=
"ltr">On Wed, Nov 7, 2018 at 12:09 PM Jonathan Rajotte-Julien &lt;<a href=
=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan=
.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi Alok,<br>
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
inside any conditional paths. I'm sure you already validated that but we ne=
ver<br>
know.<br>
<br>
&gt; <br>
&gt; I have the trace with this problem available. Would that provide any c=
lue?<br>
<br>
It could help but I presume it might contains confidential or sensible<br>
information. Let's define the scenario first and we will go back to actual<=
br>
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
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_ec5db368-beb7-4feb-aa5b-a14f2090b678--

--===============5140760320375315994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5140760320375315994==--
