From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Sun, 9 Feb 2014 11:28:38 -0500
Message-ID: <52F7ACB6.4060907__2702.8723074638$1391963417$gmane$org@mentor.com>
References: <52F55511.2080309@mentor.com>
	<1380151240.21051.1391875592403.JavaMail.zimbra@efficios.com>
	<52F66118.5010003@mentor.com>
	<905376946.21151.1391898148330.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WCXFP-0005qy-3u
	for lttng-dev@lists.lttng.org; Sun, 09 Feb 2014 11:28:53 -0500
In-Reply-To: <905376946.21151.1391898148330.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 02/08/2014 05:22 PM, Mathieu Desnoyers wrote:

> Interesting approach.

I assume here you are referring to the temporary static allocator we use
during calloc initialization, not my initializing realloc at the same time ?

> Then I wonder if we couldn't simply lookup every symbol
> we're interested in whenever any of the overridden function is called and
> we notice a NULL pointer, and provide a simplistic "static" allocator for
> every function overridden.

While I agree that a consistent technique to solve the initialization
problem has a lot of appeal, I'm actually hesitant in this particular
case: One important limitation of the static allocator is that it
requires an upper bound for the buffer. This works fine if we know the
circumstance where it is used (I believe dlsym() itself calls calloc()
to allocate a global structure that requires 32 bytes).

The case I discovered on Friday, however, uses realloc() from within
vasprintf(), which needs to grow a buffer to hold an error message, and
I don't think the size of that is bounded. Therefore, using a static
allocator in that situation seems dangerous.

An entirely different argument is that you are suggesting to rewrite an
entire library (albeit a small one), when we are trying to get a bugfix
into a release even after code freeze. But who am I to tell you that. ;-)

Regards,
		Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
