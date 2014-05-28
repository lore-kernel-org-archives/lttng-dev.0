From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Support for Linux 3.15 in lttng-modules 2.4 ?
Date: Wed, 28 May 2014 17:19:58 -0400
Message-ID: <538652FE.1010109__34829.2902498089$1401312067$gmane$org@voxpopuli.im>
References: <537DF25C.40500@voxpopuli.im>
 <2064406121.24244.1401292317212.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1WplGW-0004hb-Ci
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 17:20:09 -0400
In-Reply-To: <2064406121.24244.1401292317212.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 14-05-28 11:51 AM, Mathieu Desnoyers wrote:
>
> Hi Alexandre,
>
> Since there has been an important tracepoint module API change between 3.14
> and 3.15 in the Linux kernel, supporting 3.15 falls into the "new feature"
> category, so we don't plan to backport it to stable 2.4.
>
> lttng-modules 2.5.0 (currently at RC1) is what you need there.
>
> Thanks!
>
> Mathieu

Good to know, thanks!

Glad to see 2.5 came out so quickly then :)

Cheers,
Alex
