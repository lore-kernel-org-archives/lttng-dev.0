From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC patch 1/3] [Babeltrace python bindings]
	Added	missing call to _bt_ctf_get_decl_from_def() when
	calling	_bt_ctf_get_int_len().
Date: Mon, 26 Aug 2013 13:44:57 -0400
Message-ID: <20130826174456.GA18510__24520.5059567981$1377539153$gmane$org@Krystal>
References: <OF1E3FA7DB.5BECB4A4-ONC2257BCD.002A81AE-C2257BCD.002AA547@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VE0qa-0004oJ-5J
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 13:45:05 -0400
Content-Disposition: inline
In-Reply-To: <OF1E3FA7DB.5BECB4A4-ONC2257BCD.002A81AE-C2257BCD.002AA547@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

All 3 patches of this series merged. I applied the comments from Jeremie
myself. Please take them into consideration for future patches.

Thank you !

Mathieu

* Amit Margalit (AMITM@il.ibm.com) wrote:
> The python code that called _bt_ctf_get_int_len() failed to wrap self._d 
> with the call to _bt_ctf_get_decl_from_def.
> 
> 
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
