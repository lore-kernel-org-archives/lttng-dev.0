From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Thu, 1 Aug 2013 21:08:27 +0400 (MSK)
Message-ID: <alpine.LNX.2.00.1308012045570.9574__16379.6774847016$1375376984$gmane$org@monopod.intra.ispras.ru>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ispras.ru ([83.149.199.79])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amonakov@ispras.ru>) id 1V4wMp-0006qD-SB
	for lttng-dev@lists.lttng.org; Thu, 01 Aug 2013 13:08:53 -0400
In-Reply-To: <51FA8DAE.3070409@mentor.com>
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

Okay, one more hack :)

Recurse *once* by calling dlsym inside your calloc, and terminate recursion by
obtaining memory from mmap.

dlsym calls your calloc
  your calloc calls dlsym
    dlsym calls your calloc, again, as it still needs to initialize
      your calloc obtains fresh memory from mmap, clears it and returns
    dlsym stores pointer to mmap'ed buffer, does its thing and returns
  your calloc now has a pointer to the real calloc, uses it, and returns
dlsym stores pointer to calloc'ed buffer, overwriting the pointer to mmap'ed
buffer, completing initialization for the second time and making the
subsequent free() safe.

You can even munmap the mmap'ed buffer in the outer calloc, avoiding leaks,
but you'd have to stash it in a thread-local storage.  You need a TLS flag to
detect recursion in calloc anyhow.

Instead of mmap you can use some other mechanism such as a static buffer, but
still you need to make it big enough, and thread-safe.

Alexander
