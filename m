From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Connect timeout
 arithmetic in inet/inet6 (v4)
Date: Tue, 13 Nov 2018 15:21:56 -0500
Message-ID: <20181113202156.GB11229__26013.7880257846$1542140403$gmane$org@joraj-alpa>
References: <20181113171221.2634-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42vfDQ3r50zs1W
 for <lttng-dev@lists.lttng.org>; Tue, 13 Nov 2018 15:21:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20181113171221.2634-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Acked-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>

On Tue, Nov 13, 2018 at 12:12:20PM -0500, Mathieu Desnoyers wrote:
> The nanoseconds part of the timespec struct time_a is not always
> bigger than time_b since it wrap around each seconds.
> 
> Use 64-bit arithmetic to perform the difference.
> 
> Merge/move duplicated code into utils.c.
> 
> This function is really doing two things. Split it into timespec_to_ms()
> and timespec_abs_diff().
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> Changes since v1:
> - Use NSEC_PER_SEC constant.
> 
> Changes since v2:
> - Move prototypes to time.h.
> - Adapt timespec_to_ms() range check to take into account tv_nsec beyond
>   1000000000-1.
> 
> Changes since v3:
> - Use remainer for detection of overflow.
> - set errno to EOVERFLOW in timespec_to_ms.
