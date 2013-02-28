From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Babeltrace for MINGW32
Date: Thu, 28 Feb 2013 07:50:43 -0500
Message-ID: <20130228125043.GA25431__25936.7932951593$1362055903$gmane$org@Krystal>
References: <009B25148989C6458484484699278506985C19C1@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UB2wf-0006VL-Tt
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 07:50:46 -0500
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506985C19C1@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> Hi,
> 
> I am interested in building a statically linked 32-bit Windows
> executable of babeltrace.  For that purpose, I have taken a shot at
> building babeltrace 1.0.3 with MinGW.  As for now, I've managed to
> build the main executable, which is all I'm interested about.
> Babeltrace-log and the test suite will not build right now.
> 
> MinGW is missing many library functions that babeltrace uses. I have
> written replacements for many of these. The replacement functions are
> not fully compliant with the original specifications, but they work
> well enough under babeltrace. This required some changed in the
> configure.ac file as well, so that my versions of uuid, fmemopen and
> open_memstream are correctly detected.

Hopefully you use babeltrace master formats/ctf/memstream.h for fmemopen
and open_memstream, and include/babeltrace/uuid.h.

> 
> Occasionally, I have had to make changes to the babeltrace source
> code. As an example, MinGW cannot use directory file handles in any
> meaningful way, so functions such as openat() and dirfd() are out of
> the question. I have circumvented these problems by using open()
> instead of openat(). Also, MinGW seems to have a problem using pthread
> mutexes in a statically linked executable, so I'm just not using the
> float_mutex at all. I do not think that's a problem for me, as I'm
> using babeltrace as a single-threaded executable instead of a library.
> 
> I have flagged all source code changes with #ifdef __MINGW32__ .
> 
> Would these changes be of interest to the babeltrace community? How
> likely would they be accepted into the main sources?

In pretty much all lttng-related user-space projects, we have a
"compat/" directory that contains compatibility wrappers (for
kernel-related projects like lttng-modules, we call it "wrapper").
Please have a look at lttng-tools src/common/compat for examples. Adding
one to babeltrace seems like the way to go.

We already have wrappers like this under formats/ctf/memstream.h and
include/babeltrace/uuid.h in the babeltrace project. As we add more
compatibility layer headers, it would be good to move them all into the
same location.

This allows us to move the complexity of supporting multiple
environments into localized files. Therefore, as a general rule, I don't
want to see any #ifdef __MINGW32__ anywhere but within compat/ files. If
you need to change behavior specifically for mingw (or any
architecture), you will need to create a compatibility layer that hides
this from the generic code under a simple function call (or static
inline).

Thanks,

Mathieu

> 
> Thank you,
> 
> JP Ikaheimonen
> Mentor Graphics Embedded Systems Division
> Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
> 
> Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
