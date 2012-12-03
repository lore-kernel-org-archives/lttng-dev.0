From: David Bryant <david.bryant@quantum.com>
Subject: Re: Test if tracepoint is enabled
Date: Tue, 4 Dec 2012 09:54:09 +1030
Message-ID: <50BD3499.3000509__7713.37583796612$1354577105$gmane$org@quantum.com>
References: <50B43D06.7020709@quantum.com> <20121203143421.GA4458@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=8684b8dd34=david.bryant@quantum.com>)
	id 1TffN3-0003tk-UU
	for lttng-dev@lists.lttng.org; Mon, 03 Dec 2012 18:24:18 -0500
In-Reply-To: <20121203143421.GA4458@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 04/12/12 01:04, Mathieu Desnoyers wrote:
> * David Bryant (david.bryant@quantum.com) wrote:
>> Hi all,
>>
>> Is it feasible to have an officially supported way of determining if a
>> tracepoint is currently enabled?
>>
>> In my code I would like to test if the tracepoint is enabled, and if it
>> isn't, avoid doing expensive setup work.
>>
>> I've been doing the following:
>>
>>    if
>> (__builtin_expect(!!(__tracepoint_sample_component___message.state), 0))
>> {
>>        /* setup work */
>>        tracepoint(sample_component, message);
>>        /* cleanup work */
>>    }
>>
>> But it's weak for two reasons:
>>
>>   * The 'state' attribute goes true when the tracepoint is enabled, but
>>     stays true after the tracepoint is disabled. It only goes false when
>>     the session is destroyed.
>>   * It uses a private / unofficial API
>>
>> What I'd like is an official API that correctly evaluates whether a
>> tracepoint is enabled or not?
>>
>> Is this possible?
> Something like:
>
>     tracepoint_cond(provider, name, cond, ...)
>
> might do it.
>
> Where "cond" would be an expression (could be a statement-expression),
> e.g.:
>
> tracepoint_cond(myprovider, myevent,
>          ({
>                  a = something;
>                  z = other;
>                  a == z;
>          }),
>          a, z);
>
> So we could, in addition to perform some setup, also evaluate a
> condition before calling the tracepoint. The macro might look like
> (without the '\' at EOL):
>
> #define tracepoint_cond(provider, name, cond, ...)
>          do {
>                  if (caa_unlikely(__tracepoint_##provider##___##name.state)) {
>                          if (cond)
>                                  __tracepoint_cb_##provider##___##name(__VA_ARGS__);
>                  }
>          } while (0)
Hi Mathieu,

Your proposal seems to introduce a way of providing an additional 
condition for whether to trigger the tracepoint, ie, not only would the 
tracepoint need to be enabled but also 'cond' must be satisfied. This is 
cool, but what I want right now is simply a way of determining whether a 
tracepoint is enabled. If it isn't enabled then I won't do the 
setup/cleanup work to prepare the arguments.

I've been consulting __tracepoint_##provider##___##name.state but am 
unsatisfied because it's unofficial API and it isn't quite the right test.

Thanks,
Dave
> So in your case, a statement-expression that evaluates to "true" would
> be fine.
>
> Note that adding support for STAP_PROBEV in there might be a bit less
> straightforward, because STAP_PROBEV don't depend on the tracepoint
> state.
>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
>
>> Thanks,
>> Dave
>>
>> ----------------------------------------------------------------------
>> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
