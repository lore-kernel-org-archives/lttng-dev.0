From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH] Fix linker library order
Date: Tue, 14 May 2013 16:51:01 -0400
Message-ID: <5192A3B5.6080302__39577.5388730273$1368564714$gmane$org@voxpopuli.im>
References: <1368318333-31522-1-git-send-email-francis.giraldeau@gmail.com>
	<20130512025917.GB405@Krystal> <519161C8.5000305@voxpopuli.im>
	<20130514065244.GA5066@Krystal> <20130514123724.GA24238@Krystal>
	<CAFXXi0nvJhHiiMK_FE=_OMkT4yK+0_WLv8h=Nanvh3g0E1re3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1UcMBp-0005ND-4z
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 16:51:17 -0400
In-Reply-To: <CAFXXi0nvJhHiiMK_FE=_OMkT4yK+0_WLv8h=Nanvh3g0E1re3g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 13-05-14 01:38 PM, Simon Marchi wrote:
> [...]
>
> If you read carefully the log sent by Alexandre, you see that it is
> when building the shared libs in this directory
> (lttng-ust-provider-ust-tests-demo.so) that the build fails. I don't
> know why it fails, but Alexandre hinted that passing "-fPIE -pie" to
> build a shared library is weird (it is usually -fPIC -pic). I am not
> sure where that comes from. This behaviour only happens when building
> the package, not when building manually.

We build the daily packages with all Debian security options (this is
kind of a future-proofing to find problems like this one, I don't think
the "real" Debian packages use it).

See
http://wiki.debian.org/Hardening#DEB_BUILD_HARDENING_PIE_.28gcc.2Fg.2B-.2B-_-fPIE_-pie.29

So far it handled the autotools-powered Makefiles correctly (libraries
are built with -fPIC, binaries with -fPIE), but it seems to cause
problems with hand-written Makefiles like the one in doc/examples/demo.

We could fix it with a package-specific patch, either by using autotools
to build this directory, or maybe not building it at all, since it's
just an example that we don't install...


Thanks all,
Alex
