From: Ruslan Uvashev <ruslan.uvashev@gmail.com>
Subject: Re: Endless waiting for data availability.
Date: Mon, 24 Mar 2014 11:15:44 -0700
Message-ID: <CACQ=--Q8KZjjJOW8T7v3NZ0hQ+5gHmhRvYW+=DRW1pg79aupNw__44440.5813272626$1395686254$gmane$org@mail.gmail.com>
References: <CACQ=--QFo0PzTgOfxDjb4Qc-sxJcMB41u0wxXxchfoT5t-krWw@mail.gmail.com>
	<20140324150124.GB9170@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0702683394=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ruslan.uvashev@gmail.com>) id 1WS9Pa-0004qX-LO
	for lttng-dev@lists.lttng.org; Mon, 24 Mar 2014 14:15:57 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so5964389iec.18
	for <lttng-dev@lists.lttng.org>; Mon, 24 Mar 2014 11:15:45 -0700 (PDT)
In-Reply-To: <20140324150124.GB9170@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0702683394==
Content-Type: multipart/alternative; boundary=089e0111d6f25d410704f55e39ac

--089e0111d6f25d410704f55e39ac
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for email, David!
Bug #770 has been opened :
http://bugs.lttng.org/issues/770


-------------------------------------
Best regards,
Ruslan Uvashev




On Mon, Mar 24, 2014 at 8:01 AM, <dgoulet@efficios.com> wrote:

> On 23 Mar (20:45:01), Ruslan Uvashev wrote:
> > Hello lttng developers,
>
> Hi Ruslan,
>
> I have to say that you found quite a nice and important bug! :) I can
> reproduce it here in no time so can you please open an issue on
> bugs.lttng.org in the lttng-tools project and flag it high?
>
> You basically just need to add the steps to reproduce and the version of
> tools you are using. I'll link this email in the archive to the issue
> you will open.
>
> Big thanks!
> David
>
> >
> > While looking at UST example in  "lttng-ust/doc/examples/easy-ust" i
> > noticed that waiting for data availability never ends if tracing has
> never
> > been started for UST.
> >
> > I would like to ask you if it is an issue/bug and if it is need to be
> fixed?
> >
> > Steps:
> > 1) create session
> > 2) enable UST event
> > 3) DO NOT start tracing
> > 4) start application and then stop it
> > 5) stop tracing <<< here tracing will never stop.
> >
> > Thoughts:
> > This is valid only for UST.
> > Kernel is ok because it seems that kernel trace files are opened after
> > tracing is started while UST trace files are opened during application
> > registration.
> >
> > /*
> >  * An empty output file is not valid. We need at least one packet
> >  * generated per stream, even if it contains no event, so it
> >  * contains at least one packet header.
> >  */
> > if (stream->output_written =3D=3D 0) {
> > pthread_mutex_unlock(&stream->lock);
> > goto data_pending;
> > }
> >
> >
> >
> > logs showing issue:
> >
> > rusty@u:~/code/lttng-tools$ lttng -V
> >
> > lttng (LTTng Trace Control) 2.4.0-rc2 - =C9poque Opaque
> >
> > rusty@u:~/code/lttng-tools$ lttng create
> > Session auto-20140323-202015 created.
> > Traces will be written in /home/rusty/lttng-traces/auto-20140323-202015
> > rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:message
> -u
> > UST event sample_component:message created in channel channel0
> > rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample
> > ^C
> > rusty@u:~/code/lttng-tools$ lttng stop
> > Waiting for data
> > availability.................................................^C
> >
> >
> >
> > I added a few printouts to lttng and consumer to understand the issue
> > better.
> >
> > traces UST:
> >
> > rusty@u:~/code/lttng-tools$ lttng create
> > Session auto-20140323-201048 created.
> > Traces will be written in /home/rusty/lttng-traces/auto-20140323-201048
> > rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:message
> -u
> > UST event sample_component:message created in channel channel0
> > rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample
> > ^C
> > rusty@u:~/code/lttng-tools$ lttng stop
> > llm.ret_code =3D 81
> > Waiting for data availabilityllm.ret_code =3D 1
> > .llm.ret_code =3D 1
> > .llm.ret_code =3D 1
> > ^C
> >
> >
> > traces UST from daemon:
> >
> > DEBUG1 [6362/6465]: Processing client command 24 (in process_client_msg=
()
> > at main.c:2703)
> > DEBUG1 [6362/6465]: Getting session auto-20140323-201048 by name (in
> > process_client_msg() at main.c:2782)
> > DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-201048
> (in
> > session_find_by_name() at session.c:169)
> > DEBUG3 [6362/6465]: Consumer data pending for id 1 (in
> > consumer_is_data_pending() at consumer.c:1083)
> > DEBUG1 [6495/6501]: Incoming command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3068)
> > DEBUG1 [6495/6501]: UST consumer data pending command for id 1 (in
> > lttng_ustconsumer_recv_cmd() at ust-consumer.c:1177)
> > DEBUG1 [6495/6501]: Consumer data pending command on session id 1 (in
> > consumer_data_pending() at consumer.c:3491)
> > DEBUG1 [6495/6501]: >>> Go over stream_list_ht <<< (in
> > consumer_data_pending() at consumer.c:3525)
> > DEBUG1 [6495/6501]: >>> stream_try_lock(stream) ret =3D 1 <<< (in
> > consumer_data_pending() at consumer.c:3532)
> > DEBUG1 [6495/6501]: >>> cds_lfht_is_node_deleted(&stream->node.node) re=
t
> =3D
> > 0 <<< (in consumer_data_pending() at consumer.c:3545)
> > DEBUG1 [6495/6501]: >>> !!! stream->output_written =3D=3D 0 !!! <<< (in
> > consumer_data_pending() at consumer.c:3553)
> > DEBUG1 [6495/6501]: received command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3084)
> > DEBUG1 [6362/6465]: Consumer data is  pending for session id 1 (in
> > consumer_is_data_pending() at consumer.c:1119)
> > DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error
> > code) (in thread_manage_clients() at main.c:3975)
> >
> >
> >
> >
> > traces kernel:
> >
> > rusty@u:~/code/lttng-tools$ lttng create
> > Session auto-20140323-201349 created.
> > Traces will be written in /home/rusty/lttng-traces/auto-20140323-201349
> > rusty@u:~/code/lttng-tools$ lttng enable-event -a -k
> > All Kernel events are enabled in channel channel0
> > rusty@u:~/code/lttng-tools$ lttng stop
> > llm.ret_code =3D 81
> > Waiting for data availabilityllm.ret_code =3D 0
> >
> > Warning: Tracing already stopped for session auto-20140323-201349
> >
> >
> > traces kernel from daemon:
> >
> > DEBUG1 [6362/6465]: Processing client command 24 (in process_client_msg=
()
> > at main.c:2703)
> > DEBUG1 [6362/6465]: Getting session auto-20140323-201349 by name (in
> > process_client_msg() at main.c:2782)
> > DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-201349
> (in
> > session_find_by_name() at session.c:169)
> > DEBUG3 [6362/6465]: Consumer data pending for id 2 (in
> > consumer_is_data_pending() at consumer.c:1083)
> > DEBUG1 [6576/6582]: Incoming command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3068)
> > DEBUG1 [6576/6582]: Kernel consumer data pending command for id 2 (in
> > lttng_kconsumer_recv_cmd() at kernel-consumer.c:850)
> > DEBUG1 [6576/6582]: Consumer data pending command on session id 2 (in
> > consumer_data_pending() at consumer.c:3491)
> > DEBUG1 [6576/6582]: >>> Go over stream_list_ht <<< (in
> > consumer_data_pending() at consumer.c:3525)
> > DEBUG1 [6576/6582]: received command on sock (in
> > consumer_thread_sessiond_poll() at consumer.c:3084)
> > DEBUG1 [6362/6465]: Consumer data is NOT pending for session id 2 (in
> > consumer_is_data_pending() at consumer.c:1119)
> > DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error
> > code) (in thread_manage_clients() at main.c:3975)
> >
> >
> >
> > Thank you.
> >
> > -------------------------------------
> > Best regards,
> > Ruslan Uvashev
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--089e0111d6f25d410704f55e39ac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for email, David!<div>Bug #770 has been opened :</d=
iv><div><a href=3D"http://bugs.lttng.org/issues/770">http://bugs.lttng.org/=
issues/770</a><br></div><div><br></div><div class=3D"gmail_extra"><br clear=
=3D"all">
<div><div dir=3D"ltr">-------------------------------------<br>Best regards=
,<br>Ruslan Uvashev<div><br></div><div><br></div></div></div>
<br><br><div class=3D"gmail_quote">On Mon, Mar 24, 2014 at 8:01 AM,  <span =
dir=3D"ltr">&lt;<a href=3D"mailto:dgoulet@efficios.com" target=3D"_blank">d=
goulet@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
On 23 Mar (20:45:01), Ruslan Uvashev wrote:<br>
&gt; Hello lttng developers,<br>
<br>
Hi Ruslan,<br>
<br>
I have to say that you found quite a nice and important bug! :) I can<br>
reproduce it here in no time so can you please open an issue on<br>
<a href=3D"http://bugs.lttng.org" target=3D"_blank">bugs.lttng.org</a> in t=
he lttng-tools project and flag it high?<br>
<br>
You basically just need to add the steps to reproduce and the version of<br=
>
tools you are using. I&#39;ll link this email in the archive to the issue<b=
r>
you will open.<br>
<br>
Big thanks!<br>
David<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; While looking at UST example in =A0&quot;lttng-ust/doc/examples/easy-u=
st&quot; i<br>
&gt; noticed that waiting for data availability never ends if tracing has n=
ever<br>
&gt; been started for UST.<br>
&gt;<br>
&gt; I would like to ask you if it is an issue/bug and if it is need to be =
fixed?<br>
&gt;<br>
&gt; Steps:<br>
&gt; 1) create session<br>
&gt; 2) enable UST event<br>
&gt; 3) DO NOT start tracing<br>
&gt; 4) start application and then stop it<br>
&gt; 5) stop tracing &lt;&lt;&lt; here tracing will never stop.<br>
&gt;<br>
&gt; Thoughts:<br>
&gt; This is valid only for UST.<br>
&gt; Kernel is ok because it seems that kernel trace files are opened after=
<br>
&gt; tracing is started while UST trace files are opened during application=
<br>
&gt; registration.<br>
&gt;<br>
&gt; /*<br>
&gt; =A0* An empty output file is not valid. We need at least one packet<br=
>
&gt; =A0* generated per stream, even if it contains no event, so it<br>
&gt; =A0* contains at least one packet header.<br>
&gt; =A0*/<br>
&gt; if (stream-&gt;output_written =3D=3D 0) {<br>
&gt; pthread_mutex_unlock(&amp;stream-&gt;lock);<br>
&gt; goto data_pending;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; logs showing issue:<br>
&gt;<br>
&gt; rusty@u:~/code/lttng-tools$ lttng -V<br>
&gt;<br>
&gt; lttng (LTTng Trace Control) 2.4.0-rc2 - =C9poque Opaque<br>
&gt;<br>
&gt; rusty@u:~/code/lttng-tools$ lttng create<br>
&gt; Session auto-20140323-202015 created.<br>
&gt; Traces will be written in /home/rusty/lttng-traces/auto-20140323-20201=
5<br>
&gt; rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:messag=
e -u<br>
&gt; UST event sample_component:message created in channel channel0<br>
&gt; rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample<=
br>
&gt; ^C<br>
&gt; rusty@u:~/code/lttng-tools$ lttng stop<br>
&gt; Waiting for data<br>
&gt; availability.................................................^C<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I added a few printouts to lttng and consumer to understand the issue<=
br>
&gt; better.<br>
&gt;<br>
&gt; traces UST:<br>
&gt;<br>
&gt; rusty@u:~/code/lttng-tools$ lttng create<br>
&gt; Session auto-20140323-201048 created.<br>
&gt; Traces will be written in /home/rusty/lttng-traces/auto-20140323-20104=
8<br>
&gt; rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:messag=
e -u<br>
&gt; UST event sample_component:message created in channel channel0<br>
&gt; rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample<=
br>
&gt; ^C<br>
&gt; rusty@u:~/code/lttng-tools$ lttng stop<br>
&gt; llm.ret_code =3D 81<br>
&gt; Waiting for data availabilityllm.ret_code =3D 1<br>
&gt; .llm.ret_code =3D 1<br>
&gt; .llm.ret_code =3D 1<br>
&gt; ^C<br>
&gt;<br>
&gt;<br>
&gt; traces UST from daemon:<br>
&gt;<br>
&gt; DEBUG1 [6362/6465]: Processing client command 24 (in process_client_ms=
g()<br>
&gt; at main.c:2703)<br>
&gt; DEBUG1 [6362/6465]: Getting session auto-20140323-201048 by name (in<b=
r>
&gt; process_client_msg() at main.c:2782)<br>
&gt; DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-20104=
8 (in<br>
&gt; session_find_by_name() at session.c:169)<br>
&gt; DEBUG3 [6362/6465]: Consumer data pending for id 1 (in<br>
&gt; consumer_is_data_pending() at consumer.c:1083)<br>
&gt; DEBUG1 [6495/6501]: Incoming command on sock (in<br>
&gt; consumer_thread_sessiond_poll() at consumer.c:3068)<br>
&gt; DEBUG1 [6495/6501]: UST consumer data pending command for id 1 (in<br>
&gt; lttng_ustconsumer_recv_cmd() at ust-consumer.c:1177)<br>
&gt; DEBUG1 [6495/6501]: Consumer data pending command on session id 1 (in<=
br>
&gt; consumer_data_pending() at consumer.c:3491)<br>
&gt; DEBUG1 [6495/6501]: &gt;&gt;&gt; Go over stream_list_ht &lt;&lt;&lt; (=
in<br>
&gt; consumer_data_pending() at consumer.c:3525)<br>
&gt; DEBUG1 [6495/6501]: &gt;&gt;&gt; stream_try_lock(stream) ret =3D 1 &lt=
;&lt;&lt; (in<br>
&gt; consumer_data_pending() at consumer.c:3532)<br>
&gt; DEBUG1 [6495/6501]: &gt;&gt;&gt; cds_lfht_is_node_deleted(&amp;stream-=
&gt;node.node) ret =3D<br>
&gt; 0 &lt;&lt;&lt; (in consumer_data_pending() at consumer.c:3545)<br>
&gt; DEBUG1 [6495/6501]: &gt;&gt;&gt; !!! stream-&gt;output_written =3D=3D =
0 !!! &lt;&lt;&lt; (in<br>
&gt; consumer_data_pending() at consumer.c:3553)<br>
&gt; DEBUG1 [6495/6501]: received command on sock (in<br>
&gt; consumer_thread_sessiond_poll() at consumer.c:3084)<br>
&gt; DEBUG1 [6362/6465]: Consumer data is =A0pending for session id 1 (in<b=
r>
&gt; consumer_is_data_pending() at consumer.c:1119)<br>
&gt; DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error=
<br>
&gt; code) (in thread_manage_clients() at main.c:3975)<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; traces kernel:<br>
&gt;<br>
&gt; rusty@u:~/code/lttng-tools$ lttng create<br>
&gt; Session auto-20140323-201349 created.<br>
&gt; Traces will be written in /home/rusty/lttng-traces/auto-20140323-20134=
9<br>
&gt; rusty@u:~/code/lttng-tools$ lttng enable-event -a -k<br>
&gt; All Kernel events are enabled in channel channel0<br>
&gt; rusty@u:~/code/lttng-tools$ lttng stop<br>
&gt; llm.ret_code =3D 81<br>
&gt; Waiting for data availabilityllm.ret_code =3D 0<br>
&gt;<br>
&gt; Warning: Tracing already stopped for session auto-20140323-201349<br>
&gt;<br>
&gt;<br>
&gt; traces kernel from daemon:<br>
&gt;<br>
&gt; DEBUG1 [6362/6465]: Processing client command 24 (in process_client_ms=
g()<br>
&gt; at main.c:2703)<br>
&gt; DEBUG1 [6362/6465]: Getting session auto-20140323-201349 by name (in<b=
r>
&gt; process_client_msg() at main.c:2782)<br>
&gt; DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-20134=
9 (in<br>
&gt; session_find_by_name() at session.c:169)<br>
&gt; DEBUG3 [6362/6465]: Consumer data pending for id 2 (in<br>
&gt; consumer_is_data_pending() at consumer.c:1083)<br>
&gt; DEBUG1 [6576/6582]: Incoming command on sock (in<br>
&gt; consumer_thread_sessiond_poll() at consumer.c:3068)<br>
&gt; DEBUG1 [6576/6582]: Kernel consumer data pending command for id 2 (in<=
br>
&gt; lttng_kconsumer_recv_cmd() at kernel-consumer.c:850)<br>
&gt; DEBUG1 [6576/6582]: Consumer data pending command on session id 2 (in<=
br>
&gt; consumer_data_pending() at consumer.c:3491)<br>
&gt; DEBUG1 [6576/6582]: &gt;&gt;&gt; Go over stream_list_ht &lt;&lt;&lt; (=
in<br>
&gt; consumer_data_pending() at consumer.c:3525)<br>
&gt; DEBUG1 [6576/6582]: received command on sock (in<br>
&gt; consumer_thread_sessiond_poll() at consumer.c:3084)<br>
&gt; DEBUG1 [6362/6465]: Consumer data is NOT pending for session id 2 (in<=
br>
&gt; consumer_is_data_pending() at consumer.c:1119)<br>
&gt; DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error=
<br>
&gt; code) (in thread_manage_clients() at main.c:3975)<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thank you.<br>
&gt;<br>
&gt; -------------------------------------<br>
&gt; Best regards,<br>
&gt; Ruslan Uvashev<br>
<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
</blockquote></div><br></div></div>

--089e0111d6f25d410704f55e39ac--


--===============0702683394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0702683394==--
