From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation for
 some pthread functions.
Date: Wed, 7 Aug 2013 12:01:06 -0400
Message-ID: <52026F42.4050005__21875.4506124698$1375891327$gmane$org@mentor.com>
References: <51F9A917.9010509@seefeld.name> <20130803012831.GH9033@Krystal>
	<51FFAAD7.3000705@seefeld.name>
	<20130807013159.GG19407@Krystal> <5202482B.2010705@mentor.com>
	<52025427.5080002@mentor.com> <20130807143346.GA542@Krystal>
	<520262E8.5010106@mentor.com> <20130807151903.GA1035@Krystal>
	<52026AD7.7000103@mentor.com> <20130807155228.GC1035@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V76Aj-0007vl-3k
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 12:01:18 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1V76Ad-00039O-N4 from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 09:01:07 -0700
In-Reply-To: <20130807155228.GC1035@Krystal>
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

On 08/07/2013 11:52 AM, Mathieu Desnoyers wrote:
> * Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
>> Sorry for the incomplete patch. Here is a corrected one.
>>
>> 	Stefan
> You can add my
>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> To you patch changelog.
>
> Can you keep it around and resubmit after we release 2.3-final in a few
> weeks ?

Why can't this be comitted to a devel branch, if it isn't fit to go into
master ? (Also, does this imply that the malloc patch made it into the
2.3 release ?)

    Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
