From: "Yann E. MORIN" <yann.morin.1998@free.fr>
Subject: Re: Internal compiler error with lttng-tools 2.4.0
Date: Mon, 7 Apr 2014 23:29:15 +0200
Message-ID: <20140407212915.GH3215__15137.7051872716$1396906682$gmane$org@free.fr>
References: <53431505.9090306@openwide.fr>
 <1489310270.8338.1396905666517.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <yann.morin.1998@gmail.com>) id 1WXH6a-0002iB-RU
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 17:29:27 -0400
Received: by mail-wi0-f176.google.com with SMTP id r20so5933755wiv.15
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 14:29:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1489310270.8338.1396905666517.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Romain Naour <romain.naour@openwide.fr>
List-Id: lttng-dev@lists.lttng.org

Matthieu, All,

On 2014-04-07 21:21 +0000, Mathieu Desnoyers spake thusly:
> Let me guess... are you using a gcc 4.8.x on ARM ?

Nope, that's a gcc-4.7.3.

> See http://bugs.lttng.org/issues/640

Ah, this is also valid for gcc-4.7.2.

The proposed fix is too recent to be in 4.7.3, so probably the same
issue, indeed.

Thanks! :-)

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 223 225 172 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
