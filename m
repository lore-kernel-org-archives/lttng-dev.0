From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Thu, 1 Aug 2013 21:19:56 +0400 (MSK)
Message-ID: <alpine.LNX.2.00.1308012115300.9574__1156.65994021601$1375377673$gmane$org@monopod.intra.ispras.ru>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ispras.ru ([83.149.199.79])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amonakov@ispras.ru>) id 1V4wXw-00072t-JL
	for lttng-dev@lists.lttng.org; Thu, 01 Aug 2013 13:20:22 -0400
In-Reply-To: <alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
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



On Thu, 1 Aug 2013, Alexander Monakov wrote:

> Okay, one more hack :)
> 
> Recurse *once* by calling dlsym inside your calloc, and terminate recursion by
> obtaining memory from mmap.

Correction: since there's no guarantee that the very first calloc invocation
will happen from inside dlsym, you have to recurse twice, not once, to be sure
that there are two dlsyms on the stack.
