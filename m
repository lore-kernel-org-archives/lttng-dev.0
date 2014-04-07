From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Internal compiler error with lttng-tools 2.4.0
Date: Mon, 7 Apr 2014 21:21:06 +0000 (UTC)
Message-ID: <1489310270.8338.1396905666517.JavaMail.zimbra__33175.2428123311$1396905727$gmane$org@efficios.com>
References: <53431505.9090306@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WXGyg-0002dp-1A
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 17:21:19 -0400
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
Cc: lttng-dev@lists.lttng.org, "Yann E. MORIN" <yann.morin.1998@free.fr>
List-Id: lttng-dev@lists.lttng.org

Let me guess... are you using a gcc 4.8.x on ARM ?

See http://bugs.lttng.org/issues/640

Thanks,

Mathieu


----- Original Message -----
> From: "Romain Naour" <romain.naour@openwide.fr>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Yann E. MORIN" <yann.morin.1998@free.fr>
> Sent: Monday, April 7, 2014 5:13:41 PM
> Subject: Internal compiler error with lttng-tools 2.4.0
> 
> Hi Mathieu,
> 
> We have another issue with lttng-tools in Buildroot, but I don't know
> what happens...
> see:
> http://autobuild.buildroot.net/results/c17/c17bdffb7c65312e8dc03acbc24b1f9b3171b00f/build-end.log
> 
> Thanks,
> Romain Naour
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
