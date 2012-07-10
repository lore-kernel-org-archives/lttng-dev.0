From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Question: multiple cft_integer for one argument?
Date: Tue, 10 Jul 2012 09:32:52 -0400
Message-ID: <20120710133252.GB7267__35772.3993402489$1341927226$gmane$org@Krystal>
References: <4FFBE298.2070205@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SoaYg-000091-86
	for lttng-dev@lists.lttng.org; Tue, 10 Jul 2012 09:32:54 -0400
Content-Disposition: inline
In-Reply-To: <4FFBE298.2070205@emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: changz <zheng.chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* changz (zheng.chang@emc.com) wrote:
> Hi,
>
> I found an interesting thing when I went thru lttng-ust samples:
>
> In lttng-ust/tests/hello/ust_tests_hello.h, here is definition of an event:
>
>  28  TRACEPOINT_EVENT(ust_tests_hello, tptest,
>  29     TP_ARGS(int, anint, int, netint, long *, values,
>  30         char *, text, size_t, textlen,
>  31         double, doublearg, float, floatarg,
>  32         bool, boolarg),
>  33     TP_FIELDS(
>  34         ctf_integer(int, intfield, anint)

Here, "anint" (which is a C integer of type "int"), gets written into a
integer field into the event (type "int" too).

>  35         ctf_integer_hex(int, intfield2, anint)

This line writes "anint" into the integer (type int) field, just like
line 34. However, in the trace metadata, it will put a description
attribute that requires that this integer must be pretty-printed as
hexadecimal.

>  36         ctf_integer(long, longfield, anint)

Here, "anint" (again) gets cast into "long" type (either 32 or 64-bit
depending on the architecture), and the result gets written into the
trace. In this specific example, it serves no purpose, it' just there to
show what can be done with TRACEPOINT_EVENTs.

Best regards,

Mathieu

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
> Best Regards
> Zheng
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
