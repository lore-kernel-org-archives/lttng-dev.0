From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Wich interface to use for lttng ust
Date: Mon, 01 Oct 2012 11:28:36 -0400
Message-ID: <5069B6A4.9070001__45922.4499566064$1349105393$gmane$org@voxpopuli.im>
References: <14773128.185971349080793918.JavaMail.www@wsfrf1114>
	<20121001145925.GC13423@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1TIhva-0007B0-7y
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 11:29:02 -0400
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
Cc: lttng-dev@lists.lttng.org, paul.chavent@fnac.net
List-Id: lttng-dev@lists.lttng.org

On 12-10-01 10:59 AM, Mathieu Desnoyers wrote:
> * paul.chavent@fnac.net (paul.chavent@fnac.net) wrote:
>> Hi.
>>
>> I would like to try lttng user space traces. I've found two documentations :
>>  - manual : http://lttng.org/files/ust/manual/ust.html
>>  - man page : http://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html
>>
>> Is there any "prefered" choice for reference ?
> lttng-ust(3).
>
>> Should/Can i use
>> ust_marker, tracepoint ?
> ust_marker do not exist anymore.
>
> Alexandre, can you remove the old
> http://lttng.org/files/ust/manual/ust.html 0.x manpage ? Or make sure
> you move it somewhere that clearly states it is outdated ?

Done, deleted it since it's deprecated.

Alex

>
> Thanks,
>
> Mathieu
>
>> Thank for your replies.
>>
>> Paul.
