From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Internal compiler error with lttng-tools 2.4.0
Date: Mon, 7 Apr 2014 21:54:05 +0000 (UTC)
Message-ID: <1280242920.8364.1396907645887.JavaMail.zimbra__10531.5773319036$1396907736$gmane$org@efficios.com>
References: <53431505.9090306@openwide.fr>
 <1489310270.8338.1396905666517.JavaMail.zimbra@efficios.com>
 <20140407212915.GH3215@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WXHUp-0002tM-3g
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 17:54:33 -0400
In-Reply-To: <20140407212915.GH3215@free.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Yann E. MORIN" <yann.morin.1998@free.fr>
Cc: lttng-dev@lists.lttng.org, Romain Naour <romain.naour@openwide.fr>
List-Id: lttng-dev@lists.lttng.org

You might want to try compiling lttng-tools in O1 rather than O2
to work around the issue. I remember reading something about this
compiler issue only triggering in O2.

Thanks,

Mathieu

----- Original Message -----
> From: "Yann E. MORIN" <yann.morin.1998@free.fr>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Romain Naour" <romain.naour@openwide.fr>, lttng-dev@lists.lttng.org
> Sent: Monday, April 7, 2014 5:29:15 PM
> Subject: Re: Internal compiler error with lttng-tools 2.4.0
> 
> Matthieu, All,
> 
> On 2014-04-07 21:21 +0000, Mathieu Desnoyers spake thusly:
> > Let me guess... are you using a gcc 4.8.x on ARM ?
> 
> Nope, that's a gcc-4.7.3.
> 
> > See http://bugs.lttng.org/issues/640
> 
> Ah, this is also valid for gcc-4.7.2.
> 
> The proposed fix is too recent to be in 4.7.3, so probably the same
> issue, indeed.
> 
> Thanks! :-)
> 
> Regards,
> Yann E. MORIN.
> 
> --
> .-----------------.--------------------.------------------.--------------------.
> |  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics'
> |  conspiracy: |
> | +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___
> | |
> | +33 223 225 172 `------------.-------:  X  AGAINST      |  \e/  There is no
> | |
> | http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.
> | |
> '------------------------------^-------^------------------^--------------------'
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
