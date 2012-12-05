From: David Bryant <david.bryant@quantum.com>
Subject: Re: Test if tracepoint is enabled
Date: Wed, 5 Dec 2012 10:36:17 +1030
Message-ID: <50BE8FF9.5010807__16901.6986423687$1354666029$gmane$org@quantum.com>
References: <50B43D06.7020709@quantum.com> <20121203143421.GA4458@Krystal>
	<50BD3499.3000509@quantum.com> <20121204140244.GA5298@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=868692a31f=david.bryant@quantum.com>)
	id 1Tg2VP-0006dk-BQ
	for lttng-dev@lists.lttng.org; Tue, 04 Dec 2012 19:06:27 -0500
In-Reply-To: <20121204140244.GA5298@Krystal>
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

On 05/12/12 00:32, Mathieu Desnoyers wrote:
> Hrm. So what you would like is something like:
>
> int tracepoint_get_state(provider, name);
>
> So you could use it for your setup and cleanup. However, let's see the
> possible use of this construct:
>
> 1 - this construct would be OK:
>
> if (tracepoint_get_state(myprovider, myname)) {
>          setup();
>          tracepoint(myprovider, myname, args...);
>          cleanup();
> }
>
> but we see that the state test would happen twice, which is somewhat
> inefficient.
>
> But the actual problem comes from this construct, which is _not_ OK, and
> racy:
>
> 2 -
>
> if (tracepoint_get_state(myprovider, myname))
>          setup();
> tracepoint(myprovider, myname, args...);
> if (tracepoint_get_state(myprovider, myname))
>          cleanup();
>
> The problem is that users would expect that some synchronization
> magically happen when enabling/disabling tracepoints, but it's not the
> case. So we could very well end up executing just the cleanup, or just
> the tracepoint, or 2 of the 3, if we hit the tracepoint while it is
> being enabled/disabled.
>
> Providing this level of deep access into the tracepoint structures seems
> error-prone (as shown by construct #2), and inefficient (as shown by the
> 2 tests performed by construct #1).
>
> This is why I am tempted to introduce a tracepoint_cond() or something
> similar, to ensure that no racy construct can be created, and ensure
> that we only test the tracepoint state once per site.
>
> Thoughts ?
This construct avoids the inefficiency of checking tracepoint state twice:

if (tracepoint_get_state(myprovider, myname) {
     setup();
     tracepoint_force(myprovider, myname, args...);
     cleanup();
}

ie, tracepoint_force() doesn't re-check the state. However, it relies on 
the user adhering to the pattern. tracepoint_force() could also be 
misused, violating the state of enabled/disabled tracepoints.

I take your point about the user being easily misled. It's not obvious 
enough that tracepoints are enabled/disabled asynchronously and we 
should only provide safe constructs that are compatible with that model.

So, building on your example:

#define tracepoint_cond(provider, name, pre, post, ...) \
     do { \
         if (caa_unlikely(__tracepoint_##provider##___##name.state)) { \
             pre \
             __tracepoint_cb_##provider##___##name(__VA_ARGS__); \
             post \
         } \
     } \
     while (0)

And a contrived example:

#include <stdio.h>
#include <stdlib.h>

int main() {
     char * a;
     tracepoint_cond(provider, name,
                     { printf("pre\n");  a = malloc(16); },
                     { printf("post\n"); free(a);        }
                    );
     return 0;
}

This is ok. But more work with the macro handling would be required to 
get the pre/post code fragments through as parameters. The example only 
compiles because its pre/post arguments don't contain any commas.

What do you think?

Thanks,
Dave

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
