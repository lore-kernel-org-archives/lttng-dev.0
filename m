From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH] Force static_alloc setup to be written into
 memory
Date: Fri, 14 Feb 2014 09:46:26 -0500
Message-ID: <52FE2C42.4030005__3472.38245090029$1392389240$gmane$org@mentor.com>
References: <alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>	<1392385505-13405-1-git-send-email-paul_woegerer@mentor.com>
	<alpine.LNX.2.00.1402141816441.24828@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WEK2D-0003Xp-CN
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 09:46:34 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1WEK27-0005qq-Tg from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 06:46:27 -0800
In-Reply-To: <alpine.LNX.2.00.1402141816441.24828@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 02/14/2014 09:23 AM, Alexander Monakov wrote:
>
> On Fri, 14 Feb 2014, Paul Woegerer wrote:
>
>> As explained by Alexander Monakov, dlsym() is defined to be pure, thus the
>> compiler is allowed to assume that there is no need to write the changes
>> performed by setup_static_allocator() into memory prior to calling dlsym().
>> The added cmm_barrier() forces the compiler to write the changes into memory.
>>
>> For more details refer to:
>> http://lists.lttng.org/pipermail/lttng-dev/2014-February/022389.html
> If everyone here agrees that this is a workaround for a glibc bug, please add
> a note to that effect in the patch and please notify glibc upstream (again).

I'v just submitted https://sourceware.org/bugzilla/show_bug.cgi?id=16585


> FWIW, when toying with a similar code I implemented a different workaround
> along the lines of
>
> #define dlsym glibc_dlsym_proto_lies_about_leafness
> #include <dlfcn.h>
> #undef dlsym
>
> extern void *dlsym(void *, const char *);
>
>
> Thus avoiding the need to sprinkle unneeded compiler memory barriers in code.

Right, this looks very clean indeed.

        Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
