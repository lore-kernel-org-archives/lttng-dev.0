From: "Yann E. MORIN" <yann.morin.1998@free.fr>
Subject: Re: Internal compiler error with lttng-tools 2.4.0
Date: Mon, 7 Apr 2014 23:25:31 +0200
Message-ID: <20140407212531.GG3215__19126.108804676$1396906589$gmane$org@free.fr>
References: <53431505.9090306@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f182.google.com ([74.125.82.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <yann.morin.1998@gmail.com>) id 1WXH2z-0002gU-51
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 17:25:47 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so25392wes.41
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 14:25:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53431505.9090306@openwide.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Romain Naour <romain.naour@openwide.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Matthieu, All,

On 2014-04-07 23:13 +0200, Romain Naour spake thusly:
> We have another issue with lttng-tools in Buildroot, but I don't know what
> happens...
> see:
> http://autobuild.buildroot.net/results/c17/c17bdffb7c65312e8dc03acbc24b1f9b3171b00f/build-end.log

Here are a bit more details:
  - arm926t, little-endian, EABI, soft-float, uClibc

And here is the excerpt of the failure:

    ---8<---
      CC       consumer-timer.lo
    consumer-timer.c: In function 'consumer_timer_thread':
    consumer-timer.c:518:1: internal compiler error: in gen_movsi, at config/arm/arm.md:5452
    ---8<---

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 223 225 172 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
