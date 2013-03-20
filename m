From: Francis Deslauriers <fdeslaur@gmail.com>
Subject: Re: [RFC-PATCH] Adding trap tracepoints definitions
Date: Wed, 20 Mar 2013 16:00:13 -0400
Message-ID: <CADcCL0hzY8-pZWSUBCe64oRqKUDLapA_c22Cv3GeKA6_oxWt1Q__12337.6285228462$1363809691$gmane$org@mail.gmail.com>
References: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
	<1363809323-12154-1-git-send-email-fdeslaur@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1866227719=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f54.google.com ([209.85.215.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <fdeslaur@gmail.com>) id 1UIPBg-0003ZU-Ec
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 16:00:40 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so3651567lab.41
	for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2013 13:00:34 -0700 (PDT)
In-Reply-To: <1363809323-12154-1-git-send-email-fdeslaur@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1866227719==
Content-Type: multipart/alternative; boundary=14dae94edc77ca9e6104d860ac19

--14dae94edc77ca9e6104d860ac19
Content-Type: text/plain; charset=ISO-8859-1

Here is reworked version on the trap tracepoints.

If it looks good, i will go on by sending a lttng-modules patch adding the
trap-probe.

Comments are welcome.

Francis


On Wed, Mar 20, 2013 at 3:55 PM, Francis Deslauriers <fdeslaur@gmail.com>wrote:

> This patch adds new trap tracepoint definitions. Both trap entry and trap
> exit
> tracepoints can be added.
>
> Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
> ---
>  include/trace/events/trap.h |   45
> +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 include/trace/events/trap.h
>
> diff --git a/include/trace/events/trap.h b/include/trace/events/trap.h
> new file mode 100644
> index 0000000..e79e8c0
> --- /dev/null
> +++ b/include/trace/events/trap.h
> @@ -0,0 +1,45 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM trap
> +
> +#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_TRAP_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(trap_entry,
> +
> +       TP_PROTO(struct pt_regs *regs, long trap),
> +
> +       TP_ARGS(regs, trap),
> +
> +       TP_STRUCT__entry(
> +               __field(    long,    trap )
> +               __field(  unsigned long,        ip)
> +       ),
> +       TP_fast_assign(
> +               __entry->trap = trap;
> +               __entry->ip = regs ? instruction_pointer(regs) : 0UL;
> +       ),
> +
> +       TP_printk("number=%ld, ip = %lu", __entry->trap, __entry->ip)
> +);
> +
> +TRACE_EVENT(trap_exit,
> +
> +       TP_PROTO(long trap),
> +
> +       TP_ARGS(trap),
> +
> +       TP_STRUCT__entry(
> +               __field(    long,    trap )
> +       ),
> +       TP_fast_assign(
> +               __entry->trap = trap;
> +       ),
> +
> +       TP_printk("number=%ld", __entry->trap)
> +);
> +
> +#endif /* _TRACE_TRAP_H */
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> --
> 1.7.10.4
>
>

--14dae94edc77ca9e6104d860ac19
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Here is reworked version on the trap tracepoints.<div><br>=
<div style>If it looks good, i will go on by sending a lttng-modules patch =
adding the trap-probe.</div></div><div style><br></div><div style>Comments =
are welcome.</div>

<div style><br></div><div style>Francis</div></div><div class=3D"gmail_extr=
a"><br><br><div class=3D"gmail_quote">On Wed, Mar 20, 2013 at 3:55 PM, Fran=
cis Deslauriers <span dir=3D"ltr">&lt;<a href=3D"mailto:fdeslaur@gmail.com"=
 target=3D"_blank">fdeslaur@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">This=
 patch adds new trap tracepoint definitions. Both trap entry and trap exit<=
br>

tracepoints can be added.<br>
<br>
Signed-off-by: Francis Deslauriers &lt;<a href=3D"mailto:fdeslaur@gmail.com=
">fdeslaur@gmail.com</a>&gt;<br>
---<br>
=A0include/trace/events/trap.h | =A0 45 +++++++++++++++++++++++++++++++++++=
++++++++<br>
=A01 file changed, 45 insertions(+)<br>
=A0create mode 100644 include/trace/events/trap.h<br>
<br>
diff --git a/include/trace/events/trap.h b/include/trace/events/trap.h<br>
new file mode 100644<br>
index 0000000..e79e8c0<br>
--- /dev/null<br>
+++ b/include/trace/events/trap.h<br>
@@ -0,0 +1,45 @@<br>
+#undef TRACE_SYSTEM<br>
+#define TRACE_SYSTEM trap<br>
+<br>
+#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)<br>
+#define _TRACE_TRAP_H<br>
+<br>
+#include &lt;linux/tracepoint.h&gt;<br>
+<br>
+TRACE_EVENT(trap_entry,<br>
+<br>
+ =A0 =A0 =A0 TP_PROTO(struct pt_regs *regs, long trap),<br>
+<br>
+ =A0 =A0 =A0 TP_ARGS(regs, trap),<br>
+<br>
+ =A0 =A0 =A0 TP_STRUCT__entry(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0long, =A0 =A0trap )<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0unsigned long, =A0 =A0 =A0 =A0ip)=
<br>
+ =A0 =A0 =A0 ),<br>
+ =A0 =A0 =A0 TP_fast_assign(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;trap =3D trap;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;ip =3D regs ? instruction_pointer=
(regs) : 0UL;<br>
+ =A0 =A0 =A0 ),<br>
+<br>
+ =A0 =A0 =A0 TP_printk(&quot;number=3D%ld, ip =3D %lu&quot;, __entry-&gt;t=
rap, __entry-&gt;ip)<br>
+);<br>
+<br>
+TRACE_EVENT(trap_exit,<br>
+<br>
+ =A0 =A0 =A0 TP_PROTO(long trap),<br>
+<br>
+ =A0 =A0 =A0 TP_ARGS(trap),<br>
+<br>
+ =A0 =A0 =A0 TP_STRUCT__entry(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0long, =A0 =A0trap )<br>
+ =A0 =A0 =A0 ),<br>
+ =A0 =A0 =A0 TP_fast_assign(<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;trap =3D trap;<br>
+ =A0 =A0 =A0 ),<br>
+<br>
+ =A0 =A0 =A0 TP_printk(&quot;number=3D%ld&quot;, __entry-&gt;trap)<br>
+);<br>
+<br>
+#endif /* _TRACE_TRAP_H */<br>
+/* This part must be outside protection */<br>
+#include &lt;trace/define_trace.h&gt;<br>
--<br>
1.7.10.4<br>
<br>
</div></div></blockquote></div><br></div>

--14dae94edc77ca9e6104d860ac19--


--===============1866227719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1866227719==--
