From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Need inputs on LTTng for ARM Linux-3.0.15
Date: Fri, 20 Jul 2012 14:27:06 -0400
Message-ID: <20120720182706.GA20397__33246.2420025424$1342808850$gmane$org@Krystal>
References: <CALDxG5j7VUTmSf6AYYg_+tTtzi3AbDGwGtCbuO-PPyDJUDkB-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Content-Disposition: inline
In-Reply-To: <CALDxG5j7VUTmSf6AYYg_+tTtzi3AbDGwGtCbuO-PPyDJUDkB-A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: srikanth krishnakar <skrishnakar@gmail.com>
Cc: ltt-dev <ltt-dev@lists.casi.polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Srikanth,

* srikanth krishnakar (skrishnakar@gmail.com) wrote:
> Hello Mathieu,
> 
> I am working on LTTng integration for *Linux-3.0.15* *ARM v7 Freescale
> i.MX6 SabreLite* target. I previously integrated lttng-modules into kernel
> with while I was working on Linux-2.6.38.
> 
> Now I would like to know is there any repository that you are maintaining
> to restore kernel patches for Linux kernel 3.x series ? If yes is there any
> documentation on using those patches against 3.x kernel Or should I go with
> building and installing lttng-modules-2.0.x as my only option ?

For kernel 2.6.38 and more recent, lttng-modules 2.0.x is your only
option. I don't maintain any lttng 0.x kernel tree for those newer
kernels anymore.

Best regards,

Mathieu

> 
> You inputs are appreciated !
> 
> Thanks in Advance !
> 
> -- 
> "The Good You Do, The Best You GET"
> 
> Regards
> Srikanth Krishnakar
> **********************

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
