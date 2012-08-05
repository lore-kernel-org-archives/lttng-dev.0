From: Rui Han <r.han@umiami.edu>
Subject: ERROR: No buffer space available
Date: Sun, 5 Aug 2012 00:41:52 -0400
Message-ID: <CABy43G8ANPh0ZM_3y5hHAQdsDYjt+UbZMsdJDeZxFHWRizXngQ__37091.5245301605$1344141748$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0858884169=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1Sxsf8-0005JS-5c
	for lttng-dev@lists.lttng.org; Sun, 05 Aug 2012 00:41:58 -0400
Received: by qcsc21 with SMTP id c21so1438583qcs.35
	for <lttng-dev@lists.lttng.org>; Sat, 04 Aug 2012 21:41:52 -0700 (PDT)
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

--===============0858884169==
Content-Type: multipart/alternative; boundary=20cf3074b4924bd48104c67d610a

--20cf3074b4924bd48104c67d610a
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I try to modified the lttng2.0 source code for my research. For example, I
try to log the "comm" for the write system call, I add the following filed
in the file x86-64-syscalls-3.0.4_pointers.h located at the path
lttng-modules-2.0.3/instrumentation/syscalls/headers. I modify the
TRACE_EVENTS() macro from the original one:

#ifndef OVERRIDE_64_sys_write
SC_TRACE_EVENT(sys_write,
TP_PROTO(unsigned int fd, const char * buf, size_t count),
TP_ARGS(fd, buf, count),
TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(const char *, buf)
__field(size_t, count)),
TP_fast_assign(tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count,
count)),
TP_printk()
)
#endif

to the following one:

#ifndef OVERRIDE_64_sys_write
SC_TRACE_EVENT(sys_write,
TP_PROTO(unsigned int fd, const char * buf, size_t count, struct
task_struct *p),
TP_ARGS(fd, buf, count, p),
TP_STRUCT__entry( __field(unsigned int, fd) __field_hex(const char *,
buf) __field(size_t,
count) __array_text(char, comm, TASK_COMM_LEN)),
TP_fast_assign( tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count,
2064) tp_memcpy(comm,
p->comm, TASK_COMM_LEN)),
TP_printk()
)
#endif

I add one argument *p and one filed "comm"  for the macro. It was able to
be compiled, however, after reload the lttng modules, It will show the
following error messages when I start lttng.

PERROR: ioctl start session: No buffer space available [in
kernel_start_session() at kernel.c:397]
Error: Starting kernel trace failed

It won't work. Please help me out with this. My next step is try to add
extra fields in the sys_connect macros to enable the logging of the
connected IP/port from the socket. Is this method right? what are other
possible solutions in order to logging the details of the socket
information?

Thank you very much.

Regards,
Rui

--20cf3074b4924bd48104c67d610a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I try to modified the lttng2.0 source code for my re=
search. For example, I try to log the &quot;comm&quot; for the write system=
 call, I add the following filed in the file=A0x86-64-syscalls-3.0.4_pointe=
rs.h located at the path lttng-modules-2.0.3/instrumentation/syscalls/heade=
rs. I modify the TRACE_EVENTS() macro from the original one:</div>
<div><br></div><div><div><div>#ifndef OVERRIDE_64_sys_write</div><div>SC_TR=
ACE_EVENT(sys_write,</div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">	</span>TP_PROTO(unsigned int fd, const char * buf, size_t cou=
nt),</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>TP_AR=
GS(fd, buf, count),</div><div><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">	</span>TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(=
const char *, buf) __field(size_t, count)),</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>TP_fa=
st_assign(tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count, count)),</=
div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>T=
P_printk()</div>
<div>)</div><div>#endif</div></div><div><br></div><div>to the following one=
:</div><div><br></div><div>#ifndef OVERRIDE_64_sys_write</div><div>SC_TRACE=
_EVENT(sys_write,</div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>TP_PROTO(unsigned int fd, const char * buf, size_t count,=
 struct task_struct *p),</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>TP_AR=
GS(fd, buf, count, p),</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>TP_STRUCT__entry(<span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>__field(unsigned int, fd)<span class=3D"Apple=
-tab-span" style=3D"white-space:pre">	</span>__field_hex(const char *, buf)=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>__field(si=
ze_t, count)<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>__array_text(char, comm, TASK_COMM_LEN)),</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>TP_fa=
st_assign(<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span=
>tp_assign(fd, fd)<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
			</span>tp_assign(buf, buf)<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">				</span>tp_assign(count, 2064)<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>tp_memcpy(comm, p-&gt;comm, TASK_COMM_LEN=
)),</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>TP_pr=
intk()</div><div>)</div><div>#endif</div></div><div><br></div><div>I add on=
e argument *p and one filed &quot;comm&quot; =A0for the macro. It was able =
to be compiled, however, after reload the lttng modules, It will show the f=
ollowing error messages when I start lttng.=A0</div>
<div><br></div><div><div>PERROR: ioctl start session: No buffer space avail=
able [in kernel_start_session() at kernel.c:397]</div><div>Error: Starting =
kernel trace failed</div></div><div><br></div><div>It won&#39;t work. Pleas=
e help me out with this. My next step is try to add extra fields in the sys=
_connect macros to enable the logging of the connected IP/port from the soc=
ket. Is this method right? what are other possible solutions in order to lo=
gging the details of the socket information?=A0</div>
<div><br></div><div>Thank you very much.</div><div><br></div><div>Regards,<=
/div><div>Rui</div><div><br></div>

--20cf3074b4924bd48104c67d610a--


--===============0858884169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0858884169==--
