From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
Subject: Re: newbie and kernel trace
Date: Tue, 21 May 2013 11:54:42 +0200
Message-ID: <519B4462.2030103__40441.1218748011$1369130446$gmane$org@free.fr>
References: <519645B2.5090709@free.fr>
	<CA+jJMxt8jUGiVTBy-1tm0oSAzcvSKv8VuCTsvHnmEthUCO9ctQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp1-g21.free.fr ([212.27.42.1])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sancelot@free.fr>) id 1UejHN-00043A-KU
	for lttng-dev@lists.lttng.org; Tue, 21 May 2013 05:54:50 -0400
Received: from [192.168.1.242] (num-trut.pck.nerim.net [62.212.97.179])
	(Authenticated sender: sancelot)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id B6A3E94029A
	for <lttng-dev@lists.lttng.org>; Tue, 21 May 2013 11:54:44 +0200 (CEST)
In-Reply-To: <CA+jJMxt8jUGiVTBy-1tm0oSAzcvSKv8VuCTsvHnmEthUCO9ctQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,
I have read the Documentation/trace/tracepoints.txt file.

I modified my code to acknowledge it.

I am again unable to list my tracepoints using lttng list . (I also =

tried lttng enable-channel before...).

So , only one step I have not made :
Is it mandatory to register the probe functions ???


Regards,
S.Ancelot




On 17/05/2013 17:13, J=E9r=E9mie Galarneau wrote:
> Hi St=E9phane,
>
> We're going to need more details than that. Which kernel version are you =
using?
> Can you see the other kernel events in your trace? If not, can you
> show us how you are setting up your session?
>
> Thanks,
> J=E9r=E9mie
>
> On Fri, May 17, 2013 at 10:58 AM, St=E9phane ANCELOT <sancelot@free.fr> w=
rote:
>> Hi,
>>
>> I am trying to reimplement LTTNG 2. in xenomai api.
>>
>> the main problem is that I do not sea any of my new events available in
>> lttng 2.
>>
>>
>> my kernel compiles fine and  here is what I done to set it up :
>>
>> file include/trace/events/pod.h :
>>
>> #undef TRACE_SYSTEM
>> #define TRACE_SYSTEM xenotrace
>>
>> #if !defined(_XENOTRACE_H) || defined(TRACE_HEADER_MULTI_READ)
>>
>> #define _XENOTRACE_H
>>
>> #include <linux/tracepoint.h>
>>
>>
>> TRACE_EVENT(    xn_nucleus_thread_init,
>>                  TP_PROTO(struct xnthread *thread,char *thread_name,xnfl=
ags_t
>> flags,const char *class,int prio),
>>                  TP_ARGS(thread,thread_name,flags,class,prio),
>>
>>                  TP_STRUCT__entry(
>>                   __field(struct xnthread *,thread)
>>                   __array(char ,thread_name,      XNOBJECT_NAME_LEN   )
>>                   __field(xnflags_t,flags)
>>                   __array(char,class,      XNOBJECT_NAME_LEN  )
>>                   __field(int,    prio                       )
>>                  ),
>>
>>                TP_fast_assign(
>>                 __entry->thread   =3D thread;
>>                 memcpy(__entry->thread_name,thread_name, XNOBJECT_NAME_L=
EN);
>>                 __entry->flags   =3D flags;
>>                 memcpy(__entry->class,class, XNOBJECT_NAME_LEN);
>>                 __entry->prio   =3D prio;
>>                  ),
>>
>>                 TP_printk("thread %p thread_name %s flags %lu class %s p=
rio
>> %d",
>>                 __entry->thread, __entry->thread_name,
>> __entry->flags,__entry->class,
>>                 __entry->prio)
>> );
>>
>> #endif
>>
>> /* This part must be outside protection */
>> #include <trace/define_trace.h>
>>
>>
>>
>> in pod.h :
>> #define CREATE_TRACE_POINTS
>> #include <trace/events/pod.h>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
