From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Fri, 14 Feb 2014 07:59:51 +0100
Message-ID: <52FDBEE7.8070909__42335.9595974491$1392361362$gmane$org@mentor.com>
References: <52F55511.2080309@mentor.com>
	<52FCCCD2.9050302@mentor.com>	<610029715.24333.1392300717731.JavaMail.zimbra@efficios.com>	<1692042945.24342.1392301795996.JavaMail.zimbra@efficios.com>	<1119459836.24348.1392302831554.JavaMail.zimbra@efficios.com>	<52FCE732.9090508@mentor.com>	<581364674.24417.1392309613306.JavaMail.zimbra@efficios.com>	<52FCF7F5.9070908@mentor.com>,
	<934762932.24558.1392317539645.JavaMail.zimbra@efficios.com>,
	<A30AF42E15BD64459E202697468DFFA77E387F33@EU-MBX-04.mgc.mentorg.com>
	<A30AF42E15BD64459E202697468DFFA77E389F61@EU-MBX-04.mgc.mentorg.com>
	<52FD4AB0.4060203@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WECmF-00083N-1q
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 02:01:36 -0500
In-Reply-To: <52FD4AB0.4060203@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Good Morning Stefan,

On 02/13/2014 11:44 PM, Stefan Seefeld wrote:
> On 02/13/2014 05:06 PM, Woegerer, Paul wrote:
>> Let me put it this way ...
>>
>> If (hypothetically, just for the sake of the argument) we would have dlsym with the following signature:
>>
>> void *dlsym(void *handle, const char *symbol, void *dummy);
>>
>> instead of:
>>
>> void *dlsym(void *handle, const char *symbol);
>>
>> and we would call it with:
>>
>> af.calloc = dlsym(RTLD_NEXT, "calloc", &cur_alloc);
>>
>> then (because of the aliasing of cur_alloc (caused by &cur_alloc) the compiler would be forced to store the effects done on cur_alloc into memory prior to calling dlsym.
> 
> Paul, I'm not convinced.
> 
> Our compilation unit defines a bunch of functions with external linkage,
> which access cur_alloc. And since gcc has no way to rule out that the
> call to dlsym() will not cause any of these functions to be called, it
> mustn't make any assumptions about whether or not the first
> initialization of cur_alloc is redundant or not, and thus shouldn't
> elide it.

Thinking about it again (with 7hrs of sleep in-between), I'm still not convinced that this is a compiler bug.

See: https://www.kernel.org/doc/Documentation/memory-barriers.txt
and search for "The compiler is within its rights to reorder memory accesses"
and "the compiler is within its rights to omit a store entirely"

Also related:
http://stackoverflow.com/questions/5693274/is-function-call-a-memory-barrier
http://stackoverflow.com/questions/10698253/is-function-call-an-effective-memory-barrier-for-modern-platforms

Nonetheless, I suggest to replace the volatile fields (see my first patch) with ACCESS_ONCE() barriers as described in:
https://www.kernel.org/doc/Documentation/memory-barriers.txt

diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
index 8296ae2..44ce933 100644
--- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
+++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
@@ -173,17 +173,17 @@ static
 void setup_static_allocator(void)
 {
        assert(cur_alloc.calloc == NULL);
-       cur_alloc.calloc = static_calloc;
+       CMM_ACCESS_ONCE(cur_alloc.calloc) = static_calloc;
        assert(cur_alloc.malloc == NULL);
-       cur_alloc.malloc = static_malloc;
+       CMM_ACCESS_ONCE(cur_alloc.malloc) = static_malloc;
        assert(cur_alloc.free == NULL);
-       cur_alloc.free = static_free;
+       CMM_ACCESS_ONCE(cur_alloc.free) = static_free;
        assert(cur_alloc.realloc == NULL);
-       cur_alloc.realloc = static_realloc;
+       CMM_ACCESS_ONCE(cur_alloc.realloc) = static_realloc;
        assert(cur_alloc.memalign == NULL);
-       cur_alloc.memalign = static_memalign;
+       CMM_ACCESS_ONCE(cur_alloc.memalign) = static_memalign;
        assert(cur_alloc.posix_memalign == NULL);
-       cur_alloc.posix_memalign = static_posix_memalign;
+       CMM_ACCESS_ONCE(cur_alloc.posix_memalign) = static_posix_memalign;
 }

 static
@@ -207,7 +207,7 @@ void lookup_all_symbols(void)
        af.posix_memalign = dlsym(RTLD_NEXT, "posix_memalign");

        /* Populate the new allocator functions */
-       memcpy(&cur_alloc, &af, sizeof(cur_alloc));
+       cur_alloc = af;
 }

 void *malloc(size_t size)


--
Many Thanks,
Paul



> 
> (The above is in fact quite a frequent idiom in C/C++ framework
> libraries. Just imagine dlsym() being a call into a GUI (such as an
> event loop), and the functions in this CU unit as callbacks.)
> 
>     Stefan
> 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
