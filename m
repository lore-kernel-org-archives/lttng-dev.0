From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [BABELTRACE PATCH v2] Add BT_SEEK_LAST type to
	bt_iter_pos
Date: Thu, 16 Aug 2012 18:25:11 -0400
Message-ID: <502D7347.4040000__19683.7829695598$1345155944$gmane$org@efficios.com>
References: <1345140842-21819-1-git-send-email-francis.deslauriers@polymtl.ca>
	<1345153687-15832-1-git-send-email-jdesfossez@efficios.com>
	<20120816215328.GA4864@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1T28VG-0006AB-9w
	for lttng-dev@lists.lttng.org; Thu, 16 Aug 2012 18:25:22 -0400
In-Reply-To: <20120816215328.GA4864@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 16/08/12 05:53 PM, Mathieu Desnoyers wrote:
> * Julien Desfossez (jdesfossez@efficios.com) wrote:
>> From: Francis Deslauriers <francis.deslauriers@polymtl.ca>
>>
> 
> something tells me it does not start from the last patch sent by
> Francis, am I correct ? A mixup maybe ?

No it's just a v2.
I fixed some formatting issues, the timestamp manipulation (was not
adapted to the new real/cycles timestamps) and an bug if the first
stream read contained the max timestamp.
