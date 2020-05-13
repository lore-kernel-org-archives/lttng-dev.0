From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Need Help In trace generation for malloc(),
 free() calls etc
Date: Wed, 13 May 2020 14:04:04 -0400
Message-ID: <20200513180404.GB2381108@joraj-alpa>
References: <CAPC3ern8bkAJDnOwoYh2Om44Q2GWAPsh140FW_aPGVkdUmCwkw@mail.gmail.com>
 <CAPC3erkxTh9dSgahym7xsCjJXOV3D+kto-=UB-ApjSUOWYZVeA@mail.gmail.com>
 <20200513153312.GA2381108@joraj-alpa>
 <CAPC3erkfapoZu_WM=znEyj0ch1YiKeX7-JBiauoLh+Seee0TZA@mail.gmail.com>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49MjH117Gfz21s3
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 14:04:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5DBAF2BBE64
 for <lttng-dev@lists.lttng.org>; Wed, 13 May 2020 14:04:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAPC3erkfapoZu_WM=znEyj0ch1YiKeX7-JBiauoLh+Seee0TZA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Abhinav Ranjan <abhi.abhinav240@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Abhinav,

Please keep the mailing list in CC for all communication: lttng-dev@lists.lttng.org

If not, I am not interested in helping you further.

On Wed, May 13, 2020 at 09:26:52PM +0530, Abhinav Ranjan wrote:
> Hi! Jonathan thank you so much for your help and reply! Sure I'll not use
> snapshot from next time and follow your advice.
> In fact I figured out the issue, but Jonathan I have one specific doubt I
> wanted to trace malloc , free call from my app only  but after using lttng
> enable-event --userspace lttng_ust_libc:malloc I am seeing several malloc (
> in Trace Compass)   probably from different tracepoints from lttng_ust_libc.

You will see all malloc that the app does for its lifetime since you LD_PRELOAD
the wrapper including any allocation lttng-ust does. Keep in mind that lttng-ust
is not magic, lttng-ust spun threads and do some allocations to do its job.

What outcome do you expect? We might be able to at least get you on the right
path. In other word, what is your end goal?

Cheers
