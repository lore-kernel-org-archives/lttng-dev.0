From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: [Babeltrace PATCH] Add new option --clock-offset-ns
Date: Mon, 15 Apr 2013 05:28:28 +0000
Message-ID: <009B25148989C6458484484699278506E53720DA__8990.97668375379$1366003746$gmane$org@EU-MBX-03.mgc.mentorg.com>
References: <009B25148989C6458484484699278506E5371E30@EU-MBX-03.mgc.mentorg.com>
	<20130412132158.GA27890@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1URby1-0007KD-PA
	for lttng-dev@lists.lttng.org; Mon, 15 Apr 2013 01:28:37 -0400
In-Reply-To: <20130412132158.GA27890@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

you ponder:
> +			opt_clock_offset_ns = strtoull(str, &endptr, 0);
> +			if (*endptr != '\0' || str == endptr || errno != 0) {
>Why test *endptr != '\0' and str == endptr ?

This check has been copied verbatim from the similar handler for option OPT_CLOCK_ OFFSET.

To me, the check for *endptr != '\0' has some value. stroull(3) will report success if the argument
starts with a valid number, and the test makes sure that the entire argument was used in converting
the number (that is, there are no trailing bad characters).

Likewise, the check str==endptr checks if any conversion occurred at all,
although this should be covered by the error case of EINVAL.
However, the manual only treats this error case as a possibility ('may return'), 
so the check is necessary to make sure of the fact in all library implementations.

Cheers,

JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
