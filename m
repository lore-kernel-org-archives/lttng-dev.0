From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: [RFC] User space stack trace on system calls
Date: Sat, 31 Aug 2013 01:16:49 -0400
Message-ID: <52217C41.20604__20705.6867111989$1377926266$gmane$org@gmail.com>
References: <52216536.40709@gmail.com> <52216A3F.8000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VFdYT-0003gI-Rp
	for lttng-dev@lists.lttng.org; Sat, 31 Aug 2013 01:17:04 -0400
Received: by mail-qa0-f54.google.com with SMTP id cm18so115518qab.6
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 22:16:56 -0700 (PDT)
In-Reply-To: <52216A3F.8000200@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Le 2013-08-30 23:59, Francis Giraldeau a =E9crit :
> On 2013-08-30 23:38, Francis Giraldeau wrote :
>> We actually
>> found a way to insert code inside the probe with code blocks that
>> returns a value. Thanks to Simon Marchi for this C trick!
> =

> Well, it turns out that the function save_stack_trace_user() is called
> even when the tracepoint is not enabled, so this is a major issue.
> Hum... Then why does it work for UST tracepoint macro?

By moving the probe custom code inside the macro itself, it's called
only when the tracepoint is enabled. The difference is that the UST
tracepoint in the C code is a macro that gets expanded, while in the
kernel trace_somethig is an actual function call.

diff --git a/instrumentation/events/lttng-module/addons.h
b/instrumentation/events/lttng-module/addons.h
index 8a764b0..26623b3 100644
--- a/instrumentation/events/lttng-module/addons.h
+++ b/instrumentation/events/lttng-module/addons.h
@@ -200,15 +200,23 @@ TRACE_EVENT(sys_entry,
 )

 TRACE_EVENT(sys_entry_callsite,
-       TP_PROTO(int id, int len, unsigned long *entries),
-       TP_ARGS(id, len, entries),
+       TP_PROTO(int id),
+       TP_ARGS(id),
        TP_STRUCT__entry(
                __field(short, id)
-               __dynamic_array_hex(unsigned long, callsite, len)
+               __dynamic_array_hex(unsigned long, callsite, ({
+                       extern int stack_trace_get_size(void);
+                       int x =3D stack_trace_get_size();
+                       x;
+               }))
        ),
        TP_fast_assign(
                tp_assign(id, id)
-               tp_memcpy_dyn(callsite, entries)
+               tp_memcpy_dyn(callsite, ({
+                       extern unsigned long *stack_trace_get_entries(void);
+                       unsigned long *entries =3D stack_trace_get_entries(=
);
+                       entries;
+               }))
        ),
        TP_printk("%d", __entry->id)
 )
