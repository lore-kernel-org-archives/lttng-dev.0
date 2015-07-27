From: Eugene Ivanov <Eugene.Ivanov@orc-group.com>
Subject: Re: cds_lfht_resize() and QSBR
Date: Mon, 27 Jul 2015 20:20:25 +0300
Message-ID: <55B66859.6050300__14173.4404060573$1438017698$gmane$org@orc-group.com>
References: <55B65654.7030503@orc-group.com>
 <2071601215.2020.1438017123033.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx02.orcsoftware.com ([89.202.167.90]
 helo=ungol.ad.orcsoftware.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Eugene.Ivanov@orc-group.com>) id 1ZJm4p-0000gd-Sg
 for lttng-dev@lists.lttng.org; Mon, 27 Jul 2015 13:20:36 -0400
In-Reply-To: <2071601215.2020.1438017123033.JavaMail.zimbra@efficios.com>
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

Thank you, Mathieu!

On 07/27/2015 08:12 PM, Mathieu Desnoyers wrote:
> Hi Eugene,
>
> It's fine to use both lfht resize and destroy from URCU QSBR, because
> we explicitly mark the threads "offline" (saving the old state),
> and restore the original state, at the beginning and end of those
> functions.
>
> However, calls to cds_lfht_resize() and cds_lfht_destroy are considered
> as an explicit quiescent state in URCU QSBR, therefore, don't expect
> your RCU read-side critical section to extend across those 2 calls.
>
> Thanks,
>
> Mathieu
>
> ----- On Jul 27, 2015, at 12:03 PM, Eugene Ivanov Eugene.Ivanov@orc-group.com wrote:
>
>> Hi,
>>
>> According documentation "cds_lfht_resize should *not* be called from a
>> RCU read-side critical section", can I use this function with QSBR,
>> where almost everything is read-side CS? And cds_lfht_destroy()?
>>
>> --
>> Eugene Ivanov
>>
>>
>> ________________________________
>>
>> This e-mail is confidential and may contain legally privileged information. It
>> is intended only for the addressees. If you have received this e-mail in error,
>> kindly notify us immediately by telephone or e-mail and delete the message from
>> your system.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Eugene Ivanov


________________________________

This e-mail is confidential and may contain legally privileged information. It is intended only for the addressees. If you have received this e-mail in error, kindly notify us immediately by telephone or e-mail and delete the message from your system.
