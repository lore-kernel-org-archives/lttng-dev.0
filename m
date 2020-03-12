From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: bt2 Python quick start/examples?
Date: Thu, 12 Mar 2020 10:18:41 -0400
Message-ID: <20200312141841.GB16241@joraj-alpa>
References: <CADtyBo5-2Dos_qAL=J3GjQReQ=e52U8sbUaN6-wx7kefaDZycA@mail.gmail.com>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48dWCX6FCZz1H80
 for <lttng-dev@lists.lttng.org>; Thu, 12 Mar 2020 10:18:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CCFBA28130A
 for <lttng-dev@lists.lttng.org>; Thu, 12 Mar 2020 10:18:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CADtyBo5-2Dos_qAL=J3GjQReQ=e52U8sbUaN6-wx7kefaDZycA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rocky Dunlap <dunlap@ucar.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On Wed, Mar 11, 2020 at 10:56:24PM -0400, Rocky Dunlap via lttng-dev wrote:
> I see that the bt2 Python documentation is not yet ready:
> https://babeltrace.org/docs/v2.0/python/bt2/

Slowly getting there.

> 
> In lieu of that, where is the best place to find at least a few examples of
> using the bt2 Python API for basic trace processing tasks?

Simon Marchi have some examples [1] that have been used in his talk [2][3].

Hope this helps a bit.


[1] https://github.com/simark/babeltrace-fun-plugins
[2] https://www.youtube.com/watch?v=P3cPISvW444&feature=youtu.be
[3] https://tracingsummit.org/ts/2019/files/Tracingsummit2019-babeltrace2-marchi.pdf


-- 
Jonathan Rajotte-Julien
EfficiOS
