From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH lttng-ust] Add ctor/dtor priorities for
 tracepoints/events
Date: Mon, 13 Jul 2020 15:44:56 -0400
Message-ID: <87pn8z6vyf.fsf@clara>
References: <20200711152907.676582-1-olivier.dion@polymtl.ca>
 <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
 <87tuycybqx.fsf@clara>
 <1851244021.9798.1594646692671.JavaMail.zimbra@efficios.com>
 <87r1tfxx1l.fsf@clara>
 <2029726158.10046.1594654110710.JavaMail.zimbra@efficios.com>
 <87lfjnxngn.fsf@clara>
 <1150223945.10384.1594666728119.JavaMail.zimbra@efficios.com>
Reply-To: Olivier Dion <olivier.dion@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B5Dbj3Tdxz1WBp
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2020 15:43:45 -0400 (EDT)
In-Reply-To: <1150223945.10384.1594666728119.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- On Jul 13, 2020, at 2:46 PM, Olivier Dion olivier.dion@polymtl.ca wrote:
>
>> On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> ----- On Jul 13, 2020, at 11:19 AM, Olivier Dion olivier.dion@polymtl.ca wrote:
>>>
>>>> On Mon, 13 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> [...]
>>>> 
>>>>>>> Also, we should compare two approaches to fulfill your goal:
>>>>>>> one alternative would be to have application/library constructors
>>>>>>> explicitly call tracepoint constructors if they wish to use them.
>>>>>> 
>>>>>> I would prefer this way.  The former solution might not work in some
>>>>>> cases (e.g. with LD_PRELOAD and priority =101) and I prefer explicit
>>>>>> initialization in that case.
>>>>>> 
>>>>>> I don't see any cons for the second approach, except making the symbols
>>>>>> table a few bytes larger.  I'll post a patch soon so we can compare and
>>>>>> try to find more documentation on ctor priority.
>>>>>
>>>>> And users will have to explicitly call the constructor on which they
>>>>> depend, but I don't see it as a huge burden.
>>>> 
>>>> The burden is small indeed.  But users should pay close attention to
>>>> release the references in a destructor too.
>>>> 
>>>>> Beware though that there are a few configurations which can be used for
>>>>> probe providers (see lttng-ust(3)).
>>>> 
>>>> I'm not following you here.  I don't see any configuration for provider
>>>> except TRACEPOINT_LOGLEVEL.  What should I be aware of?
>>>
>>> See sections "Statically linking the tracepoint provider" and
>>> "Dynamically loading the tracepoint provider" from lttng-ust(3). It's
>>> especially the dynamic loading I am concerned about, because then it
>>> becomes tricky for an instrumented .so (or app) to call the probe provider's
>>> constructor without dlopening it beforehand, because there are no dependencies
>>> from the instrumented module on probe symbols. And given you plan to call
>>> this from a constructor, it means the dynamic loader lock is already held,
>>> so even if we dlopen the probe provider from the instrumented constructor,
>>> I am not sure the dlopen'd .so's constructor will be allowed to run
>>> immediately.
>>>
>>> Maybe one thing that could work for the dynamic loading case would be to:
>>>
>>> - let the instrumented constructor dlopen its probe,
>>> - from the instrumented constructor, use dlsym to get the probe's constructor
>>>   symbols.
>>> - call those constructors.
>>>
>>> If this is common enough, maybe we would want to provide helpers for
>>> this.
>> 
>> Okay so to be clear.  __tracepoints__init() should be call first, then
>> __tracepoints__ptrs_init()
>
> I don't think the order matters. What makes you think otherwise ?

I assumed __tracepoints_init() initialized rcu, but apparently __ptrs do
the same and more.

>
>> and then dlsym(3) on
>> __lttng_events_init__provider() _if_ TRACEPOINT_PROBE_DYNAMIC_LINKAGE.
>
> Yes.
>
>> 
>> Reverse the steps in destructor.
>> 
>> And so would something along these lines work?
>> --------------------------------------------------------------------------------
>> #ifdef TRACEPOINT_PROBE_DYNAMIC_LINKAGE
>> 
>> #  define tracepoint_acquire(provider)                           \
>>        do {                                                     \
>>                void (*init)(void);                              \
>>                __tracepoints__init();                           \
>>                __tracepoints__ptrs_init();                      \
>
> Where is the dlopen() done ? What code is responsible for it ?

I assume here that the desired trace provider is part of a share object
that has already been dlopen() before.

Using RTLD_DEFAULT or simply NULL should find the correct symbol in the
executable if the share object that has the trace provider is _already_
loaded in memory.

Otherwise, the macro should be something like
'tracepoint_acquire(provider, so_path)' I guess?  And so this would
indeed require a dlopen() on so_path and so on.

>
>>                init = dlsym(RTLD_DEFAULT,                       \
>
> This should use the handled returned by dlopen.
>
>>                             "__lttng_events_init__" #provider); \
>>                if (init) {                                      \
>>                        init();                                  \
>>                }                                                \
>>        } while(0)
>> 
>
> We may want a dlclose on the release (?)

Yes of course!

>
>> #else
>> 
>> #  define tracepoint_acquire(provider)                                 \
>>        do {                                                           \
>>                __tracepoint__init();                                  \
>>                __tracepoints_ptrs_init();                             \
>>                _TP_COMBINE_TOKENS(__lttng_events_init__, provider)(); \
>>        } while(0)
>> 
>> #endif
>> --------------------------------------------------------------------------------
>> 
>> And then:
>> ----------------------------------------------------------------------
>> #include "my-trace.h"
>> 
>> __attribute__((constructor))
>> static void my_ctor(void)
>> {
>>        tracepoint_acquire(my_provider);
>>        tracepoint(my_provider, my_event, my_state);
>> }
>> 
>> __attribute__((destructor))
>> static void my_ctor(void)
>> {
>>        tracepoint_release(my_provider)
>> }
>> ----------------------------------------------------------------------
>> 
>> Of course, this requires making __tracepoints__* externally visibile.
>
> Why is that so ?

__tracepoints__init() is statically defined in every compilation units
that include the trace header.  So this one doesn't actually need to be
externally visible, my mistake.  Although I don't understand why this
initializer is duplicated across units.

However, __tracepoints__ptrs__init() is statically defined in one
compilation unit, the unit that has defined the TRACEPOINT_DEFINE macro.
So I guess that the pointer tables is unique for every exe/so.  If
that's the case, then this initializer should also be find with dlsym()?

-- 
Olivier Dion
PolyMtl
