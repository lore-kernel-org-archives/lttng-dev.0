From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PULL REQUEST lttng-tools] please pull for
	compudj-pull
Date: Fri, 25 Jan 2013 10:48:50 -0500
Message-ID: <5102A962.4010105__11342.4834017225$1359128983$gmane$org@efficios.com>
References: <20130124234731.GA16402@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TylWP-0000mV-9w
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 10:48:53 -0500
In-Reply-To: <20130124234731.GA16402@Krystal>
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

Merged!

Note that commit ec1406acb4af789da299b4e81b3b7f5cc0057714 has been
backported to stable-2.1.

Thanks!

Mathieu Desnoyers:
> Hi David,
> 
> Please pull from my pull branch at:
> 
> git://git.dorsal.polymtl.ca/~compudj/lttng-tools
> branch: compudj-pull
> 
> It contains the following useful commits:
> 
> commit 9d623b7096efbd378f566c39e4c9ab91e21fb656
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Thu Jan 24 18:43:48 2013 -0500
> 
>     symbol prefixing: in-house copy of hash table
>     
>     Will ensure we don't clash with the real version in liburcu cds. It's
>     especially important since those symbols are exported globally by
>     liblttng-ctl.
>     
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> commit ec1406acb4af789da299b4e81b3b7f5cc0057714
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Thu Jan 24 18:34:44 2013 -0500
> 
>     Fix: add missing unistd.h include for fdatasync in compat-fcntl.c
>     
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> commit 73f94c074aa293f09e526c01ed262a1751e10523
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Thu Jan 24 18:33:41 2013 -0500
> 
>     namespace lttngctl filter flex/bison symbols
>     
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Thanks,
> 
> Mathieu
> 
