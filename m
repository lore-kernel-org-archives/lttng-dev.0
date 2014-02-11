From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Tue, 11 Feb 2014 00:31:16 +0000 (UTC)
Message-ID: <1402132824.22511.1392078676053.JavaMail.zimbra__27265.5822489925$1392078742$gmane$org@efficios.com>
References: <52F55511.2080309@mentor.com>
	<1380151240.21051.1391875592403.JavaMail.zimbra@efficios.com>
	<52F66118.5010003@mentor.com>
	<905376946.21151.1391898148330.JavaMail.zimbra@efficios.com>
	<52F7ACB6.4060907@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WD1Fw-00041K-17
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 19:31:25 -0500
In-Reply-To: <52F7ACB6.4060907@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Stefan Seefeld" <stefan_seefeld@mentor.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Sunday, February 9, 2014 11:28:38 AM
> Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
> 
> On 02/08/2014 05:22 PM, Mathieu Desnoyers wrote:
> 
> > Interesting approach.
> 
> I assume here you are referring to the temporary static allocator we use
> during calloc initialization, not my initializing realloc at the same time ?

Actually, I'm referring to your idea of initializing more than just the
function we need whenever the allocator is first used.

> 
> > Then I wonder if we couldn't simply lookup every symbol
> > we're interested in whenever any of the overridden function is called and
> > we notice a NULL pointer, and provide a simplistic "static" allocator for
> > every function overridden.
> 
> While I agree that a consistent technique to solve the initialization
> problem has a lot of appeal, I'm actually hesitant in this particular
> case: One important limitation of the static allocator is that it
> requires an upper bound for the buffer. This works fine if we know the
> circumstance where it is used (I believe dlsym() itself calls calloc()
> to allocate a global structure that requires 32 bytes).
> 
> The case I discovered on Friday, however, uses realloc() from within
> vasprintf(), which needs to grow a buffer to hold an error message, and
> I don't think the size of that is bounded. Therefore, using a static
> allocator in that situation seems dangerous.

By inspecting the source, this error message is made of:

- objname (object/file name),
- errstring (error detail)

I understand your concern about unbounded size for those strings. Since the
statically allocated array is 4kB, one thing we could do is rely on a call
to mmap() to handle allocations that require more space than available.

> An entirely different argument is that you are suggesting to rewrite an
> entire library (albeit a small one), when we are trying to get a bugfix
> into a release even after code freeze. But who am I to tell you that. ;-)

The last thing I want is to start playing hide-and-seek with bugs resulting
from interactions between the lttng-ust malloc wrapper and libc. From my
point of view, anything we can do to minimize the risk of interaction issues
is a huge gain in maintainability, so I'd be OK with fixing things up all
throughout this library, rather than going case-by-case for each bug
encountered.

Thoughts ?

Thanks,

Mathieu

> 
> Regards,
> 		Stefan
> 
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
