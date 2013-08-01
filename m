From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Thu, 1 Aug 2013 12:32:46 -0400
Message-ID: <51FA8DAE.3070409__26232.6967939318$1375374835$gmane$org@mentor.com>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V4vo8-0006Ep-Ox
	for lttng-dev@lists.lttng.org; Thu, 01 Aug 2013 12:33:02 -0400
In-Reply-To: <alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Monakov <amonakov@ispras.ru>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Alexander,

thanks for offering your advice.

On 08/01/2013 12:26 PM, Alexander Monakov wrote:
> Hi,
> 
> I can offer two more possible approaches:
> 
> 1.  Use posix_memalign to obtain free()'able memory for calloc without dlsym.
> Of course, when you want to override posix_memalign (and all of its synonyms)
> as well, you're again in the same trap.

Right. I do indeed expect the list of instrumented functions to grow and
eventually cover the above as well.

> 2.  Do not override malloc&co at all, but rather use malloc hooks (see "man
> malloc_hooks").

These hooks have been deprecated as they are not thread-safe. They might
become if the hooks would be stored in thread-local storage, but that
may incur runtime overhead. In any case, that would require glibc
hacking, which I think is outside the scope of this work.

Thanks,
		Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
