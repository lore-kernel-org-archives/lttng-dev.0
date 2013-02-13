From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [RFC] on-disk multiple tracefiles circular buffer
Date: Wed, 13 Feb 2013 15:35:06 -0500 (EST)
Message-ID: <501458912.795461360787706118.JavaMail.root__2775.22063483975$1360787796$gmane$org@srv12.zimbra.polymtl.ca>
References: <511AA7AF.60102@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1U5j2q-0002Wu-OA
	for lttng-dev@lists.lttng.org; Wed, 13 Feb 2013 15:35:08 -0500
In-Reply-To: <511AA7AF.60102@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org


> -C limits the maximum file size and -W the amount of such files to
> keep on disk.

Do you round up to the next packet / subbuffer / event?

In the upcoming releases, there should be small indexes telling where each packet / subbuffer starts in each file. How are these index files affected by these switches?
