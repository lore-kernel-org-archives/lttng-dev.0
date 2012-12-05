From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Test if tracepoint is enabled
Date: Wed, 5 Dec 2012 05:19:19 -0500
Message-ID: <20121205101919.GA29447__19562.2606239796$1354702800$gmane$org@Krystal>
References: <50B43D06.7020709@quantum.com> <20121203143421.GA4458@Krystal>
	<50BD3499.3000509@quantum.com> <20121204140244.GA5298@Krystal>
	<50BE8FF9.5010807@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TgC4X-0002nj-NG
	for lttng-dev@lists.lttng.org; Wed, 05 Dec 2012 05:19:21 -0500
Content-Disposition: inline
In-Reply-To: <50BE8FF9.5010807@quantum.com>
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
> On 05/12/12 00:32, Mathieu Desnoyers wrote:
>> Hrm. So what you would like is something like:
>>
>> int tracepoint_get_state(provider, name);
>>
>> So you could use it for your setup and cleanup. However, let's see the
>> possible use of this construct:
>>
>> 1 - this construct would be OK:
>>
>> if (tracepoint_get_state(myprovider, myname)) {
>>          setup();
>>          tracepoint(myprovider, myname, args...);
>>          cleanup();
>> }
>>
>> but we see that the state test would happen twice, which is somewhat
>> inefficient.
>>
>> But the actual problem comes from this construct, which is _not_ OK, and
>> racy:
>>
>> 2 -
>>
>> if (tracepoint_get_state(myprovider, myname))
>>          setup();
>> tracepoint(myprovider, myname, args...);
>> if (tracepoint_get_state(myprovider, myname))
>>          cleanup();
>>
>> The problem is that users would expect that some synchronization
>> magically happen when enabling/disabling tracepoints, but it's not the
>> case. So we could very well end up executing just the cleanup, or just
>> the tracepoint, or 2 of the 3, if we hit the tracepoint while it is
>> being enabled/disabled.
>>
>> Providing this level of deep access into the tracepoint structures seems
>> error-prone (as shown by construct #2), and inefficient (as shown by the
>> 2 tests performed by construct #1).
>>
>> This is why I am tempted to introduce a tracepoint_cond() or something
>> similar, to ensure that no racy construct can be created, and ensure
>> that we only test the tracepoint state once per site.
>>
>> Thoughts ?
> This construct avoids the inefficiency of checking tracepoint state twice:
>
> if (tracepoint_get_state(myprovider, myname) {
>     setup();
>     tracepoint_force(myprovider, myname, args...);
>     cleanup();
> }
>
> ie, tracepoint_force() doesn't re-check the state. However, it relies on  
> the user adhering to the pattern. tracepoint_force() could also be  
> misused, violating the state of enabled/disabled tracepoints.
>
> I take your point about the user being easily misled. It's not obvious  
> enough that tracepoints are enabled/disabled asynchronously and we  
> should only provide safe constructs that are compatible with that model.
>
> So, building on your example:
>
> #define tracepoint_cond(provider, name, pre, post, ...) \
>     do { \
>         if (caa_unlikely(__tracepoint_##provider##___##name.state)) { \
>             pre \
>             __tracepoint_cb_##provider##___##name(__VA_ARGS__); \
>             post \
>         } \
>     } \
>     while (0)
>
> And a contrived example:
>
> #include <stdio.h>
> #include <stdlib.h>
>
> int main() {
>     char * a;
>     tracepoint_cond(provider, name,
>                     { printf("pre\n");  a = malloc(16); },
>                     { printf("post\n"); free(a);        }
>                    );
>     return 0;
> }
>
> This is ok. But more work with the macro handling would be required to  
> get the pre/post code fragments through as parameters. The example only  
> compiles because its pre/post arguments don't contain any commas.
>
> What do you think?

I'm not sure what parameters would cause issues with commas. If they are
between parenthesis or brackets, it should be fine. Do you have an
example perhaps ?

While we are there, it would be good to make the "pre" handler test a
condition. For your use-case, you would just have to pass a pre :

 { printf("pre\n");  a = malloc(16); 1; }

So we could do:

   if (pre)
        __tracepoint_cb_##provider##___##name(__VA_ARGS__);
   (post)

and therefore support not only to setup something, but also to add an
extra check on whether tracing should be skipped or not. If someone
passes "1" as end of the compound statement, it will always evaluate to
1, and therefore the compiler will remove any extra branch in -O2.

One question stands though: how would we integrate this with sdt.h
STAP_PROVEV() ?

Thanks,

Mathieu

>
> Thanks,
> Dave
>
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
