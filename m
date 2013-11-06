From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Unable to configure babeltrace, lttv
Date: Wed, 06 Nov 2013 13:36:38 -0500
Message-ID: <527A8C36.9070606__25529.5792747804$1383763176$gmane$org@gmail.com>
References: <F98AC8DFC04DC741915F3DFB00515DBEE8972716@Thetis.ISE-DOM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Ve7yA-0002l8-8B
	for lttng-dev@lists.lttng.org; Wed, 06 Nov 2013 13:36:51 -0500
Received: by mail-qa0-f44.google.com with SMTP id f11so2496681qae.17
	for <lttng-dev@lists.lttng.org>; Wed, 06 Nov 2013 10:36:40 -0800 (PST)
In-Reply-To: <F98AC8DFC04DC741915F3DFB00515DBEE8972716@Thetis.ISE-DOM.local>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Thomas <paul.thomas@ise.bc.ca>
Cc: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

You need to have the libgtk2.0-dev package installed.

Yannick

On 11/06/13 13:09, Paul Thomas wrote:
> Running ./bootstrap for babeltrace or lttv produces
> a fatal message, namely, 
>
> configure.ac:48: warning: macro `AM_PATH_GTK_2_0' not found in library
>
> I am running Debian:
> Linux debian-rt 2.6.31.51 #1 SMP PREEMPT i686 GNU/Linux
>
> Can you advise me about this problem, or what steps I should
> take to find an answer to this problem?
>
> Thanks,
>
> Paul
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
