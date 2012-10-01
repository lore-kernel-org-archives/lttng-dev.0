From: Paul Chavent <paul.chavent@fnac.net>
Subject: Re: Wich interface to use for lttng ust
Date: Mon, 01 Oct 2012 22:27:09 +0200
Message-ID: <5069FC9D.1070303__13210.0519528196$1349124781$gmane$org@fnac.net>
References: <14773128.185971349080793918.JavaMail.www@wsfrf1114>
	<20121001145925.GC13423@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp5-g21.free.fr ([212.27.42.5])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paul.chavent@fnac.net>) id 1TIma6-0001QS-1K
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 16:27:10 -0400
In-Reply-To: <20121001145925.GC13423@Krystal>
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

Thanks.

On 10/01/2012 04:59 PM, Mathieu Desnoyers wrote:
> * paul.chavent@fnac.net (paul.chavent@fnac.net) wrote:
>> Hi.
>>
>> I would like to try lttng user space traces. I've found two documentations :
>>   - manual : http://lttng.org/files/ust/manual/ust.html
>>   - man page : http://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html
>>
>> Is there any "prefered" choice for reference ?
>
> lttng-ust(3).
>
>> Should/Can i use
>> ust_marker, tracepoint ?
>
> ust_marker do not exist anymore.
>
> Alexandre, can you remove the old
> http://lttng.org/files/ust/manual/ust.html 0.x manpage ? Or make sure
> you move it somewhere that clearly states it is outdated ?
>
> Thanks,
>
> Mathieu
>
>>
>> Thank for your replies.
>>
>> Paul.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
