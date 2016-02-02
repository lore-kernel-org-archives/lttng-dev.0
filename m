From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH lttng-modules] Fix: Remove not used
 PREEMPT_ACTIVE in Linux 4.4
Date: Tue, 2 Feb 2016 14:22:22 +0000
Message-ID: <CAGrhNMz9ZOXTtTkMy8hxVQFyk6Kj3uWY2G4Ksfo2zfY5qGc_ow__765.515390276228$1454423015$gmane$org@mail.gmail.com>
References: <1454417813-19236-1-git-send-email-eu@felipetonello.com>
 <523443816.10171.1454420328647.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eu@felipetonello.com>) id 1aQbqe-0003Vr-KB
 for lttng-dev@lists.lttng.org; Tue, 02 Feb 2016 09:22:33 -0500
Received: by mail-lb0-f173.google.com with SMTP id x4so96523749lbm.0
 for <lttng-dev@lists.lttng.org>; Tue, 02 Feb 2016 06:22:28 -0800 (PST)
In-Reply-To: <523443816.10171.1454420328647.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

On Tue, Feb 2, 2016 at 1:38 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Hi,
>
> In instrumentation/events/lttng-module/sched.h, there are ifdefs
> checking the kernel version against which lttng-modules is build.
> Please ensure you don't remove this flag when building against
> older kernels.

Actually I just realized that this file is correct already.

>
> The mainline/sched.h file should be removed from lttng-modules,
> it's a leftover of initial porting of instrumentation from the
> kernel.

I will send another patch removing this file.

Felipe
