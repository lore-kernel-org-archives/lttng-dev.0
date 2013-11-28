From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH liburcu 2/5] Dont link pthread on Android
Date: Thu, 28 Nov 2013 10:30:24 +0100
Message-ID: <20131128103024.3341ccc8__28333.6416156546$1385631111$gmane$org@skate>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385567313-8138-2-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from top.free-electrons.com ([176.31.233.9]
	helo=mail.free-electrons.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thomas.petazzoni@free-electrons.com>)
	id 1Vlxvc-0001Tl-Cb
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 04:30:38 -0500
In-Reply-To: <1385567313-8138-2-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles Briere <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Dear Charles Briere,

On Wed, 27 Nov 2013 07:48:30 -0800, Charles Briere wrote:

>  #Add the -version-info directly here since we are only building
>  # library that use the version-info
> -AM_LDFLAGS=-lpthread -version-info $(URCU_LIBRARY_VERSION)
> +AM_LDFLAGS=-version-info $(URCU_LIBRARY_VERSION)
> +if !TARGET_IS_ANDROID
> +AM_LDFLAGS += -lpthread
> +endif

Instead of making that conditional on Android, wouldn't it make more
sense to make it conditional on whether linking with pthread is
necessary or not?

I can at least think of one other C library than Bionic that has
everything in libc instead of things split in several libraries: the
Musl C library (http://www.musl-libc.org).

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
