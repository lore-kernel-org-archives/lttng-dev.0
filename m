From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Thu, 1 Aug 2013 20:26:44 +0400 (MSK)
Message-ID: <alpine.LNX.2.00.1308012013380.9574__8579.6881038279$1375374489$gmane$org@monopod.intra.ispras.ru>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ispras.ru ([83.149.199.79])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amonakov@ispras.ru>) id 1V4viT-000683-Rv
	for lttng-dev@lists.lttng.org; Thu, 01 Aug 2013 12:27:13 -0400
In-Reply-To: <CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-15?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: Stefan Seefeld <stefan_seefeld@mentor.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I can offer two more possible approaches:

1.  Use posix_memalign to obtain free()'able memory for calloc without dlsym.
Of course, when you want to override posix_memalign (and all of its synonyms)
as well, you're again in the same trap.

2.  Do not override malloc&co at all, but rather use malloc hooks (see "man
malloc_hooks").

Hope that helps,
Alexander
