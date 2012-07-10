From: changz <zheng.chang@emc.com>
Subject: Re: Question: multiple cft_integer for one argument?
Date: Tue, 10 Jul 2012 16:44:25 +0800
Message-ID: <4FFBEB69.1000804__113.585280678485$1341909967$gmane$org@emc.com>
References: <4FFBE298.2070205@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1SoW3p-0006FU-9f
	for lttng-dev@lists.lttng.org; Tue, 10 Jul 2012 04:44:45 -0400
Received: from hop04-l1d11-si04.isus.emc.com (HOP04-L1D11-SI04.isus.emc.com
	[10.254.111.24])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6A8idvl013634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Tue, 10 Jul 2012 04:44:40 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.222.130]) by
	hop04-l1d11-si04.isus.emc.com (RSA Interceptor) for
	<lttng-dev@lists.lttng.org>; Tue, 10 Jul 2012 04:44:29 -0400
Received: from corpussmtp3.corp.emc.com (corpussmtp3.corp.emc.com
	[10.254.169.196])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6A8iT1b031838
	for <lttng-dev@lists.lttng.org>; Tue, 10 Jul 2012 04:44:29 -0400
In-Reply-To: <4FFBE298.2070205@emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 7/10/2012 16:06 PM, changz wrote:
> Hi,
>
> I found an interesting thing when I went thru lttng-ust samples:
>
> In lttng-ust/tests/hello/ust_tests_hello.h, here is definition of an 
> event:
>
>  28  TRACEPOINT_EVENT(ust_tests_hello, tptest,
>  29     TP_ARGS(int, anint, int, netint, long *, values,
>  30         char *, text, size_t, textlen,
>  31         double, doublearg, float, floatarg,
>  32         bool, boolarg),
>  33     TP_FIELDS(
>  34         ctf_integer(int, intfield, anint)
>  35         ctf_integer_hex(int, intfield2, anint)
>  36         ctf_integer(long, longfield, anint)
>  37         ctf_integer_network(int, netintfield, netint)
>  38         ctf_integer_network_hex(int, netintfieldhex, netint)
>  39         ctf_array(long, arrfield1, values, 3)
>  40         ctf_array_text(char, arrfield2, text, 10)
>  41         ctf_sequence(char, seqfield1, text,
>  42                  size_t, textlen)
>  43         ctf_sequence_text(char, seqfield2, text,
>  44                  size_t, textlen)
>  45         ctf_string(stringfield, text)
>  46         ctf_float(float, floatfield, floatarg)
>  47         ctf_float(double, doublefield, doublearg)
>  48         ctf_integer(bool, boolfield, boolarg)
>  49     )
>  50 )
>
> Please notice line 34-36. With my understanding, it decides the output 
> format of each argument.
> Why does the argument anint  need three cft_integer with different types?
>
Got it. That means I can define the output format freely.

Thanks

> Best Regards
> Zheng
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
