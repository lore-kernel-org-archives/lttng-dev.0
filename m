From: Rui Han <r.han@umiami.edu>
Subject: Can I use function to retrieve socket information in
 the SC_TRACE_EVENT macro?
Date: Mon, 13 Aug 2012 14:05:33 -0400
Message-ID: <CABy43G-h0eN9L5hmHhWYrQM1D1Mcwzr3So5b7_qZbFEYoPzx-w__9399.59430038488$1344881171$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0442406417=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1T0z1H-00058k-79
	for lttng-dev@lists.lttng.org; Mon, 13 Aug 2012 14:05:39 -0400
Received: by ghbz10 with SMTP id z10so3861997ghb.35
	for <lttng-dev@lists.lttng.org>; Mon, 13 Aug 2012 11:05:33 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0442406417==
Content-Type: multipart/alternative; boundary=047d7b10cf1b37e16f04c7298a22

--047d7b10cf1b37e16f04c7298a22
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

I am working on retrieving socket information for socket related syscalls
by the kernel trace, such as sys_connect() and sys_bind(). What I did is in
the .h file
"instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_pointers.h", I
modify the sys_connect SC_TRACE_EVENT. I add _field(size_t, port) and
tp_assign(port, getport() ) to the TP_STRUCT_entry() and TP_fast_assign(),
respectively. The getport() function is a function I wrote to retrieve the
port number and ip address by the function getpeername(). The lttng module
got installed correctly after the modification, (with some #ifndef
manipulations), However, when I reboot the machine and try to do the kernel
trace. It gives me error messages:

Spawning a session daemon
FATAL: Error inserting lttng_tracer
(/lib/modules/3.2.0-29-generic/extra/lttng-tracer.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
Error: Unable to load module lttng-tracer
Warning: No kernel tracer available
Warning: No tracing group detected
Session rui-session created.
Traces will be written in /root/lttng-traces/rui-session-20120813-133953
FATAL: Error inserting lttng_tracer
(/lib/modules/3.2.0-29-generic/extra/lttng-tracer.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
Error: Unable to load module lttng-tracer
Warning: No kernel tracer available

and in the syslog file: I got the following error:
[   82.001603] lttng_tracer: Unknown symbol getport (err 0)
[   82.377213] lttng_tracer: Unknown symbol getport (err 0)

I am new to the kernel module programming. My question is: should I do some
kinds of symbol register before define a function in the kernel space? Any
suggestion for solving the problem?

Thanks,
Rui

--047d7b10cf1b37e16f04c7298a22
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<div><br></div><div>I am working on retrieving socket information =
for socket related syscalls by the kernel trace, such as sys_connect() and =
sys_bind(). What I did is in the .h file &quot;instrumentation/syscalls/hea=
ders/x86-64-syscalls-3.0.4_pointers.h&quot;, I modify the sys_connect SC_TR=
ACE_EVENT. I add _field(size_t, port) and tp_assign(port, getport() ) to th=
e TP_STRUCT_entry() and TP_fast_assign(), respectively. The getport() funct=
ion is a function I wrote to retrieve the port number and ip address by the=
 function getpeername().=A0The lttng module got installed correctly after t=
he modification, (with some #ifndef manipulations), However, when I reboot =
the machine and try to do the kernel trace. It gives me error messages:=A0<=
/div>
<div><br></div><div><div>Spawning a session daemon</div><div>FATAL: Error i=
nserting lttng_tracer (/lib/modules/3.2.0-29-generic/extra/lttng-tracer.ko)=
: Unknown symbol in module, or unknown parameter (see dmesg)</div><div>
Error: Unable to load module lttng-tracer</div><div>Warning: No kernel trac=
er available</div><div>Warning: No tracing group detected</div><div>Session=
 rui-session created.</div><div>Traces will be written in /root/lttng-trace=
s/rui-session-20120813-133953</div>
<div>FATAL: Error inserting lttng_tracer (/lib/modules/3.2.0-29-generic/ext=
ra/lttng-tracer.ko): Unknown symbol in module, or unknown parameter (see dm=
esg)</div><div>Error: Unable to load module lttng-tracer</div><div>Warning:=
 No kernel tracer available</div>
</div><div><br></div><div>and in the syslog file: I got the following error=
:</div><div><div>[ =A0 82.001603] lttng_tracer: Unknown symbol getport (err=
 0)</div><div>[ =A0 82.377213] lttng_tracer: Unknown symbol getport (err 0)=
</div>
</div><div><br></div><div>I am new to the kernel module programming.=A0My q=
uestion is: should I do some kinds of=A0symbol=A0register before define a f=
unction in the kernel space? Any suggestion for solving the problem?</div><=
div>
<br></div><div>Thanks,</div><div>Rui</div><div><br></div><div><br></div>

--047d7b10cf1b37e16f04c7298a22--


--===============0442406417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0442406417==--
