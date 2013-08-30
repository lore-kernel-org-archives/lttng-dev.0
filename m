From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [RELEASE] LTTng-UST 2.3.0-rc2
Date: Fri, 30 Aug 2013 15:01:33 -0400
Message-ID: <5220EC0D.1040301__36176.0744046935$1377889364$gmane$org@ericsson.com>
References: <20130830184103.GA12134@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VFTx0-0005nF-5z
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 15:01:47 -0400
In-Reply-To: <20130830184103.GA12134@Krystal>
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

I would like to highlight that this means you are releasing on a
statutory holiday in canada. Also, you are announcing this Friday
afternoon. :)


On 13-08-30 02:41 PM, Mathieu Desnoyers wrote:
> LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
> port of the low-overhead tracing capabilities of the LTTng kernel tracer
> to user-space. The library "liblttng-ust" enables tracing of
> applications and libraries.
>
> We plan a final release on Monday, September 1st. Please let us know
> quickly if you find issues!
>
> Changelog:
> 2013-08-30 lttng-ust 2.3.0-rc2
>         * doc/examples/gen-tp: pass automake CPPFLAGS/CFLAGS/LDFLAGS
>         * tools/lttng-gen-tp: honor CPPFLAGS and LDFLAGS
>         * Fix: doc/examples cross-build
>         * Fix: liblttng_ust.la should depend on liblttng-ust-tracepoint.la
>         * Introduce configure --with-lttng-system-rundir
>         * examples: tracepoint probes don't need extern C
>         * Tracepoint probes don't need extern C
>         * Add trace support for memalign and posix_memalign
>         * malloc instrumentation: remove dependency on pthread
>         * Add trace support for calloc and realloc.
>         * Fix: allow make check to run in VPATH build
>         * Update .gitignore
>         * Update obsolete benchmark test
>         * Cleanup tests (2nd commit)
>         * Cleanup tests
>         * Fix: doc/examples VPATH build
>
> Project website: http://lttng.org
> Download link: http://lttng.org/download
> (please refer to the README file for installation instructions)
>
