From: Ruslan Uvashev <ruslan.uvashev@gmail.com>
Subject: Endless waiting for data availability.
Date: Sun, 23 Mar 2014 20:45:01 -0700
Message-ID: <CACQ=--QFo0PzTgOfxDjb4Qc-sxJcMB41u0wxXxchfoT5t-krWw__7307.13263988054$1395632766$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1287336658=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ruslan.uvashev@gmail.com>) id 1WRvox-00065n-4g
	for lttng-dev@lists.lttng.org; Sun, 23 Mar 2014 23:45:10 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so6660480igc.1
	for <lttng-dev@lists.lttng.org>; Sun, 23 Mar 2014 20:45:01 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1287336658==
Content-Type: multipart/alternative; boundary=089e0111d6f268d2f504f5520f6f

--089e0111d6f268d2f504f5520f6f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello lttng developers,

While looking at UST example in  "lttng-ust/doc/examples/easy-ust" i
noticed that waiting for data availability never ends if tracing has never
been started for UST.

I would like to ask you if it is an issue/bug and if it is need to be fixed=
?

Steps:
1) create session
2) enable UST event
3) DO NOT start tracing
4) start application and then stop it
5) stop tracing <<< here tracing will never stop.

Thoughts:
This is valid only for UST.
Kernel is ok because it seems that kernel trace files are opened after
tracing is started while UST trace files are opened during application
registration.

/*
 * An empty output file is not valid. We need at least one packet
 * generated per stream, even if it contains no event, so it
 * contains at least one packet header.
 */
if (stream->output_written =3D=3D 0) {
pthread_mutex_unlock(&stream->lock);
goto data_pending;
}



logs showing issue:

rusty@u:~/code/lttng-tools$ lttng -V

lttng (LTTng Trace Control) 2.4.0-rc2 - =C9poque Opaque

rusty@u:~/code/lttng-tools$ lttng create
Session auto-20140323-202015 created.
Traces will be written in /home/rusty/lttng-traces/auto-20140323-202015
rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:message -u
UST event sample_component:message created in channel channel0
rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample
^C
rusty@u:~/code/lttng-tools$ lttng stop
Waiting for data
availability.................................................^C



I added a few printouts to lttng and consumer to understand the issue
better.

traces UST:

rusty@u:~/code/lttng-tools$ lttng create
Session auto-20140323-201048 created.
Traces will be written in /home/rusty/lttng-traces/auto-20140323-201048
rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:message -u
UST event sample_component:message created in channel channel0
rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample
^C
rusty@u:~/code/lttng-tools$ lttng stop
llm.ret_code =3D 81
Waiting for data availabilityllm.ret_code =3D 1
.llm.ret_code =3D 1
.llm.ret_code =3D 1
^C


traces UST from daemon:

DEBUG1 [6362/6465]: Processing client command 24 (in process_client_msg()
at main.c:2703)
DEBUG1 [6362/6465]: Getting session auto-20140323-201048 by name (in
process_client_msg() at main.c:2782)
DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-201048 (in
session_find_by_name() at session.c:169)
DEBUG3 [6362/6465]: Consumer data pending for id 1 (in
consumer_is_data_pending() at consumer.c:1083)
DEBUG1 [6495/6501]: Incoming command on sock (in
consumer_thread_sessiond_poll() at consumer.c:3068)
DEBUG1 [6495/6501]: UST consumer data pending command for id 1 (in
lttng_ustconsumer_recv_cmd() at ust-consumer.c:1177)
DEBUG1 [6495/6501]: Consumer data pending command on session id 1 (in
consumer_data_pending() at consumer.c:3491)
DEBUG1 [6495/6501]: >>> Go over stream_list_ht <<< (in
consumer_data_pending() at consumer.c:3525)
DEBUG1 [6495/6501]: >>> stream_try_lock(stream) ret =3D 1 <<< (in
consumer_data_pending() at consumer.c:3532)
DEBUG1 [6495/6501]: >>> cds_lfht_is_node_deleted(&stream->node.node) ret =
=3D
0 <<< (in consumer_data_pending() at consumer.c:3545)
DEBUG1 [6495/6501]: >>> !!! stream->output_written =3D=3D 0 !!! <<< (in
consumer_data_pending() at consumer.c:3553)
DEBUG1 [6495/6501]: received command on sock (in
consumer_thread_sessiond_poll() at consumer.c:3084)
DEBUG1 [6362/6465]: Consumer data is  pending for session id 1 (in
consumer_is_data_pending() at consumer.c:1119)
DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error
code) (in thread_manage_clients() at main.c:3975)




traces kernel:

rusty@u:~/code/lttng-tools$ lttng create
Session auto-20140323-201349 created.
Traces will be written in /home/rusty/lttng-traces/auto-20140323-201349
rusty@u:~/code/lttng-tools$ lttng enable-event -a -k
All Kernel events are enabled in channel channel0
rusty@u:~/code/lttng-tools$ lttng stop
llm.ret_code =3D 81
Waiting for data availabilityllm.ret_code =3D 0

Warning: Tracing already stopped for session auto-20140323-201349


traces kernel from daemon:

DEBUG1 [6362/6465]: Processing client command 24 (in process_client_msg()
at main.c:2703)
DEBUG1 [6362/6465]: Getting session auto-20140323-201349 by name (in
process_client_msg() at main.c:2782)
DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-201349 (in
session_find_by_name() at session.c:169)
DEBUG3 [6362/6465]: Consumer data pending for id 2 (in
consumer_is_data_pending() at consumer.c:1083)
DEBUG1 [6576/6582]: Incoming command on sock (in
consumer_thread_sessiond_poll() at consumer.c:3068)
DEBUG1 [6576/6582]: Kernel consumer data pending command for id 2 (in
lttng_kconsumer_recv_cmd() at kernel-consumer.c:850)
DEBUG1 [6576/6582]: Consumer data pending command on session id 2 (in
consumer_data_pending() at consumer.c:3491)
DEBUG1 [6576/6582]: >>> Go over stream_list_ht <<< (in
consumer_data_pending() at consumer.c:3525)
DEBUG1 [6576/6582]: received command on sock (in
consumer_thread_sessiond_poll() at consumer.c:3084)
DEBUG1 [6362/6465]: Consumer data is NOT pending for session id 2 (in
consumer_is_data_pending() at consumer.c:1119)
DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error
code) (in thread_manage_clients() at main.c:3975)



Thank you.

-------------------------------------
Best regards,
Ruslan Uvashev

--089e0111d6f268d2f504f5520f6f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello lttng developers,</div><div><br></div><div>Whil=
e looking at UST example in =A0&quot;lttng-ust/doc/examples/easy-ust&quot; =
i noticed that waiting for data availability never ends if tracing has neve=
r been started for UST.</div>
<div><br></div><div>I would like to ask you if it is an issue/bug and if it=
 is need to be fixed?</div><div><br></div><div>Steps:</div><div>1) create s=
ession</div><div>2) enable UST event</div><div>3) DO NOT start tracing</div=
>
<div>4) start application and then stop it</div><div>5) stop tracing &lt;&l=
t;&lt; here tracing will never stop.</div><div><br></div><div>Thoughts:</di=
v><div>This is valid only for UST.</div><div>Kernel is ok because it seems =
that kernel trace files are opened after tracing is started while UST trace=
 files are opened during application registration.=A0</div>
<div><br></div><div><div><span class=3D"" style=3D"white-space:pre">			</sp=
an>/*</div><div><span class=3D"" style=3D"white-space:pre">			</span> * An =
empty output file is not valid. We need at least one packet</div><div><span=
 class=3D"" style=3D"white-space:pre">			</span> * generated per stream, ev=
en if it contains no event, so it</div>
<div><span class=3D"" style=3D"white-space:pre">			</span> * contains at le=
ast one packet header.</div><div><span class=3D"" style=3D"white-space:pre"=
>			</span> */</div><div><span class=3D"" style=3D"white-space:pre">			</sp=
an>if (stream-&gt;output_written =3D=3D 0) {</div>
<div><span class=3D"" style=3D"white-space:pre">				</span>pthread_mutex_un=
lock(&amp;stream-&gt;lock);</div><div><span class=3D"" style=3D"white-space=
:pre">				</span>goto data_pending;<br></div><div><span class=3D"" style=3D=
"white-space:pre">			</span>}</div>
</div><div><br></div><div><br></div><div><br></div><div>logs showing issue:=
<br></div><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><=
div><div>rusty@u:~/code/lttng-tools$ lttng -V</div></div></blockquote><bloc=
kquote style=3D"margin:0 0 0 40px;border:none;padding:0px">
<div><div>lttng (LTTng Trace Control) 2.4.0-rc2 - =C9poque Opaque</div></di=
v></blockquote><blockquote style=3D"margin:0px 0px 0px 40px;border:none;pad=
ding:0px"><div><div>rusty@u:~/code/lttng-tools$ lttng create</div></div><di=
v>
<div>Session auto-20140323-202015 created.</div></div><div><div>Traces will=
 be written in /home/rusty/lttng-traces/auto-20140323-202015</div></div><di=
v><div>rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:mess=
age -u</div>
</div><div><div>UST event sample_component:message created in channel chann=
el0</div></div><div><div>rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examp=
les/easy-ust/sample</div></div><div><div>^C</div></div><div><div>rusty@u:~/=
code/lttng-tools$ lttng stop</div>
</div><div><div>Waiting for data availability..............................=
...................^C</div></div></blockquote><div><br></div><div><div><br>=
</div><div>I added a few printouts to lttng and consumer to understand the =
issue better.</div>
</div><div><br></div><div>traces UST:<br></div><blockquote style=3D"margin:=
0px 0px 0px 40px;border:none;padding:0px"><div>rusty@u:~/code/lttng-tools$ =
lttng create</div><div><div>Session auto-20140323-201048 created.</div></di=
v>
<div><div>Traces will be written in /home/rusty/lttng-traces/auto-20140323-=
201048</div></div><div><div>rusty@u:~/code/lttng-tools$ lttng enable-event =
sample_component:message -u</div></div><div><div>UST event sample_component=
:message created in channel channel0</div>
</div><div><div>rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-=
ust/sample</div></div><div><div>^C</div></div><div><div>rusty@u:~/code/lttn=
g-tools$ lttng stop</div></div><div><div>llm.ret_code =3D 81</div></div><di=
v>
<div>Waiting for data availabilityllm.ret_code =3D 1</div></div><div><div>.=
llm.ret_code =3D 1</div></div><div><div>.llm.ret_code =3D 1</div></div><div=
><div>^C<br></div></div></blockquote><div><br></div><div>traces UST from da=
emon:</div>
<blockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px"><div>=
<div>DEBUG1 [6362/6465]: Processing client command 24 (in process_client_ms=
g() at main.c:2703)</div></div><div><div>DEBUG1 [6362/6465]: Getting sessio=
n auto-20140323-201048 by name (in process_client_msg() at main.c:2782)</di=
v>
</div><div><div>DEBUG2 [6362/6465]: Trying to find session by name auto-201=
40323-201048 (in session_find_by_name() at session.c:169)</div></div><div><=
div>DEBUG3 [6362/6465]: Consumer data pending for id 1 (in consumer_is_data=
_pending() at consumer.c:1083)</div>
</div><div><div>DEBUG1 [6495/6501]: Incoming command on sock (in consumer_t=
hread_sessiond_poll() at consumer.c:3068)</div></div><div><div>DEBUG1 [6495=
/6501]: UST consumer data pending command for id 1 (in lttng_ustconsumer_re=
cv_cmd() at ust-consumer.c:1177)</div>
</div><div><div>DEBUG1 [6495/6501]: Consumer data pending command on sessio=
n id 1 (in consumer_data_pending() at consumer.c:3491)</div></div><div><div=
>DEBUG1 [6495/6501]: &gt;&gt;&gt; Go over stream_list_ht &lt;&lt;&lt; (in c=
onsumer_data_pending() at consumer.c:3525)</div>
</div><div><div>DEBUG1 [6495/6501]: &gt;&gt;&gt; stream_try_lock(stream) re=
t =3D 1 &lt;&lt;&lt; (in consumer_data_pending() at consumer.c:3532)</div><=
/div><div><div>DEBUG1 [6495/6501]: &gt;&gt;&gt; cds_lfht_is_node_deleted(&a=
mp;stream-&gt;node.node) ret =3D 0 &lt;&lt;&lt; (in consumer_data_pending()=
 at consumer.c:3545)</div>
</div><div><div>DEBUG1 [6495/6501]: &gt;&gt;&gt; !!! stream-&gt;output_writ=
ten =3D=3D 0 !!! &lt;&lt;&lt; (in consumer_data_pending() at consumer.c:355=
3)</div></div><div><div>DEBUG1 [6495/6501]: received command on sock (in co=
nsumer_thread_sessiond_poll() at consumer.c:3084)</div>
</div><div><div>DEBUG1 [6362/6465]: Consumer data is =A0pending for session=
 id 1 (in consumer_is_data_pending() at consumer.c:1119)</div></div><div><d=
iv>DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error c=
ode) (in thread_manage_clients() at main.c:3975)</div>
</div></blockquote><div><br></div><div><br></div><div><br></div><div>traces=
 kernel:</div><blockquote style=3D"margin:0px 0px 0px 40px;border:none;padd=
ing:0px"><div><div>rusty@u:~/code/lttng-tools$ lttng create=A0</div></div><=
div>
<div>Session auto-20140323-201349 created.</div></div><div><div>Traces will=
 be written in /home/rusty/lttng-traces/auto-20140323-201349</div></div><di=
v><div>rusty@u:~/code/lttng-tools$ lttng enable-event -a -k</div></div>
<div><div>All Kernel events are enabled in channel channel0</div></div><div=
><div>rusty@u:~/code/lttng-tools$ lttng stop</div></div><div><div>llm.ret_c=
ode =3D 81</div></div><div><div>Waiting for data availabilityllm.ret_code =
=3D 0</div>
</div><div><div><br></div></div><div><div>Warning: Tracing already stopped =
for session auto-20140323-201349</div></div></blockquote><div><br></div><di=
v>traces kernel from daemon:</div><blockquote style=3D"margin:0px 0px 0px 4=
0px;border:none;padding:0px">
<div><div>DEBUG1 [6362/6465]: Processing client command 24 (in process_clie=
nt_msg() at main.c:2703)</div></div><div><div>DEBUG1 [6362/6465]: Getting s=
ession auto-20140323-201349 by name (in process_client_msg() at main.c:2782=
)</div>
</div><div><div>DEBUG2 [6362/6465]: Trying to find session by name auto-201=
40323-201349 (in session_find_by_name() at session.c:169)</div></div><div><=
div>DEBUG3 [6362/6465]: Consumer data pending for id 2 (in consumer_is_data=
_pending() at consumer.c:1083)</div>
</div><div><div>DEBUG1 [6576/6582]: Incoming command on sock (in consumer_t=
hread_sessiond_poll() at consumer.c:3068)</div></div><div><div>DEBUG1 [6576=
/6582]: Kernel consumer data pending command for id 2 (in lttng_kconsumer_r=
ecv_cmd() at kernel-consumer.c:850)</div>
</div><div><div>DEBUG1 [6576/6582]: Consumer data pending command on sessio=
n id 2 (in consumer_data_pending() at consumer.c:3491)</div></div><div><div=
>DEBUG1 [6576/6582]: &gt;&gt;&gt; Go over stream_list_ht &lt;&lt;&lt; (in c=
onsumer_data_pending() at consumer.c:3525)</div>
</div><div><div>DEBUG1 [6576/6582]: received command on sock (in consumer_t=
hread_sessiond_poll() at consumer.c:3084)</div></div><div><div>DEBUG1 [6362=
/6465]: Consumer data is NOT pending for session id 2 (in consumer_is_data_=
pending() at consumer.c:1119)</div>
</div><div><div>DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Un=
known error code) (in thread_manage_clients() at main.c:3975)</div></div></=
blockquote><div><br></div><div><br></div><div>Thank you.</div><br clear=3D"=
all">
<div><div dir=3D"ltr">-------------------------------------<br>Best regards=
,<br>Ruslan Uvashev<div><br></div></div></div>
</div>

--089e0111d6f268d2f504f5520f6f--


--===============1287336658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1287336658==--
