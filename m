From: David Boles <biblioboles@gmail.com>
Subject: Difficulty extending existing tracepoint's reporting
Date: Mon, 14 Oct 2019 16:23:51 -0500
Message-ID: <CAOxd4f5xL_OWh79s0kG0X9cFbgdkqZqzodnkOjVHwGndHOT75g__7975.6045060762$1571146015$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3100593212364199261=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by lists.lttng.org (Postfix) with ESMTPS id 46sWlS3rXjzpdF
 for <lttng-dev@lists.lttng.org>; Mon, 14 Oct 2019 17:24:04 -0400 (EDT)
Received: by mail-io1-xd43.google.com with SMTP id z19so41204701ior.0
 for <lttng-dev@lists.lttng.org>; Mon, 14 Oct 2019 14:24:04 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3100593212364199261==
Content-Type: multipart/alternative; boundary="000000000000a37a8b0594e57ca2"

--000000000000a37a8b0594e57ca2
Content-Type: text/plain; charset="UTF-8"

I am trying to widen the information reported by the block_rq_complete()
tracepoint, but am unable to get my extension to take affect. Basically,
I'd like 3 additional numbers captured at that point.

So far, I've failed to succeed in this effort. As part of trying to
determine what is going on, I've created a new tracepoint definition in
include/trace/event/block.h which defines block_rq_complete_ex, which is
just like block_rq_complete but with my additional fields. I've altered the
trace_block_rq_complete() call in block/blk-core.c to be
trace_block_rq_complete_ex().

Other than block_rq_complete being mentioned in blktrace.c (which *seems*
to be unrelated to the LTTng tracing), everywhere there is a mention of
block_rq_complete there is a matching mention of block_rq_complete_ex.

When I build a kernel (LTTng built in mode), the resulting kernel has
block_rq_complete_ex text in it. When I boot it, start an LTTng session,
and list the kernel tracepoints - my new tracepoint isn't listed. If I've
put a new printk in the kernel, it's output is visible. Any ideas on what
I'm missing? Things I've checked:

 - Built from a distclean'd kernel tree
 - lttng is "built in" (I ran the scripts/built_in.sh script and confirmed
the CONFIG_* flags
 - I can enable the original block_rq_complete tracepoint and collect data
through it
 - If instead of having a new tracepoint I just extend the old one, the new
data doesn't show up

It really seems like there is a cached or overriding definition of these
tracepoints that I'm getting instead of what I've compiled. There are
multiple kernels on the system, but I am booting the kernel I intend to.

Any ideas would be highly appreciated.

 - db

--000000000000a37a8b0594e57ca2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I am trying to widen the information reported by=
 the block_rq_complete() tracepoint, but am unable to get my extension to t=
ake affect. Basically, I&#39;d like 3 additional numbers captured at that p=
oint.<br></div><div><br></div><div>So far, I&#39;ve failed to succeed in th=
is effort. As part of trying to determine what is going on, I&#39;ve create=
d a new tracepoint definition in include/trace/event/block.h which defines =
block_rq_complete_ex, which is just like block_rq_complete but with my addi=
tional fields. I&#39;ve altered the trace_block_rq_complete() call in block=
/blk-core.c to be trace_block_rq_complete_ex().</div><div><br></div><div> O=
ther than block_rq_complete being mentioned in blktrace.c (which *seems* to=
 be unrelated to the LTTng tracing), everywhere there is a mention of block=
_rq_complete there is a matching mention of block_rq_complete_ex.</div><div=
><br></div><div>When I build a kernel (LTTng built in mode), the resulting =
kernel has block_rq_complete_ex text in it. When I boot it, start an LTTng =
session, and list the kernel tracepoints - my new tracepoint isn&#39;t list=
ed.  If I&#39;ve put a new printk in the kernel, it&#39;s output is visible=
. Any ideas on what I&#39;m missing? Things I&#39;ve checked:</div><div><br=
></div><div>=C2=A0- Built from a distclean&#39;d kernel tree</div><div>=C2=
=A0- lttng is &quot;built in&quot; (I ran the scripts/built_in.sh script an=
d confirmed the CONFIG_* flags</div><div>=C2=A0- I can enable the original =
block_rq_complete tracepoint and collect data through it</div><div>=C2=A0- =
If instead of having a new tracepoint I just extend the old one, the new da=
ta doesn&#39;t show up<br></div><br></div><div>It really seems like there i=
s a cached or overriding definition of these tracepoints that I&#39;m getti=
ng instead of what I&#39;ve compiled. There are multiple kernels on the sys=
tem, but I am booting the kernel I intend to.</div><div><br></div><div>Any =
ideas would be highly appreciated.</div><div><br></div><div>=C2=A0- db</div=
><div><br></div></div>

--000000000000a37a8b0594e57ca2--

--===============3100593212364199261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3100593212364199261==--
