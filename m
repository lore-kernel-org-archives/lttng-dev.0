From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: PERF PARAMETERS
Date: Wed, 27 Aug 2014 13:30:40 -0400
Message-ID: <53FE15C0.1010004__31746.1922103123$1409160705$gmane$org@efficios.com>
References: <CAPxN80B=S_dYb5kn_UA-sDyOZiMySrsvkWVtg5fDgdLd2V9z2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XMh3Y-0001VY-Aa
 for lttng-dev@lists.lttng.org; Wed, 27 Aug 2014 13:30:54 -0400
In-Reply-To: <CAPxN80B=S_dYb5kn_UA-sDyOZiMySrsvkWVtg5fDgdLd2V9z2Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jessica Foest <jessica.foest@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

On 14-08-26 11:21 PM, Jessica Foest wrote:
> Hi 
> 
> i tried to retrieve system calls traces with all perf context parameters
> . the problem is that only a few PERF counters are activated and lttng
> fails to activate  the other perf context parameters.
> how can i solve it ?

There is a hardware limit on the number perf PMU counters that can be
activated at the same time. It depends on the CPU and if you are on a
virtual machine.
If I remember correctly it is 3 or 4 on the i7.

Julien
