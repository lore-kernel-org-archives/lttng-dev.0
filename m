From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Test if tracepoint is enabled
Date: Tue, 4 Dec 2012 09:02:45 -0500
Message-ID: <20121204140244.GA5298__27206.6944082782$1354629838$gmane$org@Krystal>
References: <50B43D06.7020709@quantum.com> <20121203143421.GA4458@Krystal>
	<50BD3499.3000509@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tft5G-0002HG-NH
	for lttng-dev@lists.lttng.org; Tue, 04 Dec 2012 09:02:51 -0500
Content-Disposition: inline
In-Reply-To: <50BD3499.3000509@quantum.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Bryant <david.bryant@quantum.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David Bryant (david.bryant@quantum.com) wrote:
> On 04/12/12 01:04, Mathieu Desnoyers wrote:
>> * David Bryant (david.bryant@quantum.com) wrote:
>>> Hi all,
>>>
>>> Is it feasible to have an officially supported way of determining if a
>>> tracepoint is currently enabled?
>>>
>>> In my code I would like to test if the tracepoint is enabled, and if it
>>> isn't, avoid doing expensive setup work.
>>>
>>> I've been doing the following:
>>>
>>>    if
>>> (__builtin_expect(!!(__tracepoint_sample_component___message.state), 0))
>>> {
>>>        /* setup work */
>>>        tracepoint(sample_component, message);
>>>        /* cleanup work */
>>>    }
>>>
>>> But it's weak for two reasons:
>>>
>>>   * The 'state' attribute goes true when the tracepoint is enabled, but
>>>     stays true after the tracepoint is disabled. It only goes false when
>>>     the session is destroyed.
>>>   * It uses a private / unofficial API
>>>
>>> What I'd like is an official API that correctly evaluates whether a
>>> tracepoint is enabled or not?
>>>
>>> Is this possible?
>> Something like:
>>
>>     tracepoint_cond(provider, name, cond, ...)
>>
>> might do it.
>>
>> Where "cond" would be an expression (could be a statement-expression),
>> e.g.:
>>
>> tracepoint_cond(myprovider, myevent,
>>          ({
>>                  a = something;
>>                  z = other;
>>                  a == z;
>>          }),
>>          a, z);
>>
>> So we could, in addition to perform some setup, also evaluate a
>> condition before calling the tracepoint. The macro might look like
>> (without the '\' at EOL):
>>
>> #define tracepoint_cond(provider, name, cond, ...)
>>          do {
>>                  if (caa_unlikely(__tracepoint_##provider##___##name.state)) {
>>                          if (cond)
>>                                  __tracepoint_cb_##provider##___##name(__VA_ARGS__);
>>                  }
>>          } while (0)
> Hi Mathieu,
>
> Your proposal seems to introduce a way of providing an additional  
> condition for whether to trigger the tracepoint, ie, not only would the  
> tracepoint need to be enabled but also 'cond' must be satisfied. This is  
> cool, but what I want right now is simply a way of determining whether a  
> tracepoint is enabled. If it isn't enabled then I won't do the  
> setup/cleanup work to prepare the arguments.
>
> I've been consulting __tracepoint_##provider##___##name.state but am  
> unsatisfied because it's unofficial API and it isn't quite the right 
> test.

Hrm. So what you would like is something like:

int tracepoint_get_state(provider, name);

So you could use it for your setup and cleanup. However, let's see the
possible use of this construct:

1 - this construct would be OK:

if (tracepoint_get_state(myprovider, myname)) {
        setup();
        tracepoint(myprovider, myname, args...);
        cleanup();
}

but we see that the state test would happen twice, which is somewhat
inefficient.

But the actual problem comes from this construct, which is _not_ OK, and
racy:

2 - 

if (tracepoint_get_state(myprovider, myname))
        setup();
tracepoint(myprovider, myname, args...);
if (tracepoint_get_state(myprovider, myname))
        cleanup();

The problem is that users would expect that some synchronization
magically happen when enabling/disabling tracepoints, but it's not the
case. So we could very well end up executing just the cleanup, or just
the tracepoint, or 2 of the 3, if we hit the tracepoint while it is
being enabled/disabled.

Providing this level of deep access into the tracepoint structures seems
error-prone (as shown by construct #2), and inefficient (as shown by the
2 tests performed by construct #1).

This is why I am tempted to introduce a tracepoint_cond() or something
similar, to ensure that no racy construct can be created, and ensure
that we only test the tracepoint state once per site.

Thoughts ?

Thanks,

Mathieu

>
> Thanks,
> Dave
>> So in your case, a statement-expression that evaluates to "true" would
>> be fine.
>>
>> Note that adding support for STAP_PROBEV in there might be a bit less
>> straightforward, because STAP_PROBEV don't depend on the tracepoint
>> state.
>>
>> Thoughts ?
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>>> Thanks,
>>> Dave
>>>
>>> ----------------------------------------------------------------------
>>> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
