From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: newbie and kernel trace
Date: Fri, 17 May 2013 11:13:25 -0400
Message-ID: <CA+jJMxt8jUGiVTBy-1tm0oSAzcvSKv8VuCTsvHnmEthUCO9ctQ__15417.0068832629$1368803651$gmane$org@mail.gmail.com>
References: <519645B2.5090709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UdMLb-00047v-O6
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 11:13:31 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so4514472lbf.14
	for <lttng-dev@lists.lttng.org>; Fri, 17 May 2013 08:13:25 -0700 (PDT)
In-Reply-To: <519645B2.5090709@free.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi St=E9phane,

We're going to need more details than that. Which kernel version are you us=
ing?
Can you see the other kernel events in your trace? If not, can you
show us how you are setting up your session?

Thanks,
J=E9r=E9mie

On Fri, May 17, 2013 at 10:58 AM, St=E9phane ANCELOT <sancelot@free.fr> wro=
te:
> Hi,
>
> I am trying to reimplement LTTNG 2. in xenomai api.
>
> the main problem is that I do not sea any of my new events available in
> lttng 2.
>
>
> my kernel compiles fine and  here is what I done to set it up :
>
> file include/trace/events/pod.h :
>
> #undef TRACE_SYSTEM
> #define TRACE_SYSTEM xenotrace
>
> #if !defined(_XENOTRACE_H) || defined(TRACE_HEADER_MULTI_READ)
>
> #define _XENOTRACE_H
>
> #include <linux/tracepoint.h>
>
>
> TRACE_EVENT(    xn_nucleus_thread_init,
>                 TP_PROTO(struct xnthread *thread,char *thread_name,xnflag=
s_t
> flags,const char *class,int prio),
>                 TP_ARGS(thread,thread_name,flags,class,prio),
>
>                 TP_STRUCT__entry(
>                  __field(struct xnthread *,thread)
>                  __array(char ,thread_name,      XNOBJECT_NAME_LEN   )
>                  __field(xnflags_t,flags)
>                  __array(char,class,      XNOBJECT_NAME_LEN  )
>                  __field(int,    prio                       )
>                 ),
>
>               TP_fast_assign(
>                __entry->thread   =3D thread;
>                memcpy(__entry->thread_name,thread_name, XNOBJECT_NAME_LEN=
);
>                __entry->flags   =3D flags;
>                memcpy(__entry->class,class, XNOBJECT_NAME_LEN);
>                __entry->prio   =3D prio;
>                 ),
>
>                TP_printk("thread %p thread_name %s flags %lu class %s prio
> %d",
>                __entry->thread, __entry->thread_name,
> __entry->flags,__entry->class,
>                __entry->prio)
> );
>
> #endif
>
> /* This part must be outside protection */
> #include <trace/define_trace.h>
>
>
>
> in pod.h :
> #define CREATE_TRACE_POINTS
> #include <trace/events/pod.h>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
